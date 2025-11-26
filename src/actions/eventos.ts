"use server";

import { createClient } from "@/lib/supabase/server";
import { revalidatePath } from "next/cache";
import { eventoSchema, type EventoFormData } from "@/lib/validations/evento";
import {
  createGoogleCalendarEvent,
  updateGoogleCalendarEvent,
  deleteGoogleCalendarEvent,
} from "@/lib/google/calendar";
import type { TipoEvento, StatusEvento } from "@/types/database";

export interface EventosFilters {
  search?: string;
  tipo?: string;
  status?: string;
  page?: number;
  perPage?: number;
}

export async function getEventos(filters: EventosFilters = {}) {
  const supabase = await createClient();
  const { search, tipo, status, page = 1, perPage = 10 } = filters;

  let query = supabase
    .from("eventos")
    .select(
      `
      *,
      contatos!eventos_cliente_id_fkey(id, nome),
      organizacoes(id, nome),
      users!eventos_responsavel_id_fkey(id, nome, avatar_url)
    `,
      { count: "exact" }
    )
    .order("data_inicio", { ascending: true });

  if (search) {
    query = query.or(`nome.ilike.%${search}%,local.ilike.%${search}%`);
  }

  if (tipo && tipo !== "todos") {
    query = query.eq("tipo", tipo as TipoEvento);
  }

  if (status && status !== "todos") {
    query = query.eq("status", status as StatusEvento);
  }

  const from = (page - 1) * perPage;
  const to = from + perPage - 1;

  const { data, error, count } = await query.range(from, to);

  if (error) {
    console.error("Erro ao buscar eventos:", error);
    return { data: [], count: 0, error: error.message };
  }

  return { data: data || [], count: count || 0, error: null };
}

export async function getProximosEventos(limit = 5) {
  const supabase = await createClient();
  const today = new Date().toISOString().split("T")[0];

  const { data, error } = await supabase
    .from("eventos")
    .select(
      `
      id, nome, tipo, data_inicio, data_fim, local, status,
      contatos!eventos_cliente_id_fkey(id, nome),
      organizacoes(id, nome)
    `
    )
    .gte("data_inicio", today)
    .in("status", ["planejamento", "confirmado"])
    .order("data_inicio", { ascending: true })
    .limit(limit);

  if (error) {
    console.error("Erro ao buscar próximos eventos:", error);
    return { data: [], error: error.message };
  }

  return { data: data || [], error: null };
}

export async function getEventoById(id: string) {
  const supabase = await createClient();

  const { data, error } = await supabase
    .from("eventos")
    .select(
      `
      *,
      contatos!eventos_cliente_id_fkey(id, nome, telefone, email),
      organizacoes(id, nome),
      leads(id, titulo),
      users!eventos_responsavel_id_fkey(id, nome, avatar_url)
    `
    )
    .eq("id", id)
    .single();

  if (error) {
    console.error("Erro ao buscar evento:", error);
    return { data: null, error: error.message };
  }

  return { data, error: null };
}

export interface CreateEventoOptions {
  sincronizar_google?: boolean;
  criar_transacao_receita?: boolean;
}

export async function createEvento(formData: EventoFormData & CreateEventoOptions) {
  const supabase = await createClient();
  const { 
    sincronizar_google = true, 
    criar_transacao_receita = false,
    ...eventoData 
  } = formData;

  const validatedData = eventoSchema.safeParse(eventoData);
  if (!validatedData.success) {
    return { data: null, error: "Dados inválidos" };
  }

  const {
    data: { user },
  } = await supabase.auth.getUser();

  // Preparar dados para inserção
  const insertData = {
    ...validatedData.data,
    created_by: user?.id,
    responsavel_id: validatedData.data.responsavel_id || user?.id,
    google_calendar_id: null as string | null,
  };

  // Sincronizar com Google Calendar se solicitado
  if (sincronizar_google) {
    const googleResult = await createGoogleCalendarEvent({
      nome: validatedData.data.nome,
      descricao: validatedData.data.descricao,
      local: validatedData.data.local,
      endereco: validatedData.data.endereco_local,
      data_inicio: validatedData.data.data_inicio,
      data_fim: validatedData.data.data_fim,
      hora_inicio: validatedData.data.hora_inicio,
      hora_fim: validatedData.data.hora_fim,
      tipo: validatedData.data.tipo,
    });

    if (googleResult.id) {
      insertData.google_calendar_id = googleResult.id;
    } else if (googleResult.error) {
      console.warn("Aviso: Evento criado mas não sincronizado com Google Calendar:", googleResult.error);
    }
  }

  const { data, error } = await supabase
    .from("eventos")
    .insert(insertData)
    .select()
    .single();

  if (error) {
    console.error("Erro ao criar evento:", error);
    return { data: null, error: error.message };
  }

  let transacoesCriadas = 0;

  // Criar transação(ões) de receita automaticamente se solicitado e houver valor total
  if (criar_transacao_receita && validatedData.data.valor_total && validatedData.data.valor_total > 0) {
    // Buscar categorias de receita
    const { data: categorias } = await supabase
      .from("categorias_financeiras")
      .select("id, nome")
      .eq("tipo", "receita");

    const categoriaSinal = categorias?.find(c => c.nome === "Sinal")?.id || null;
    const categoriaPagamento = categorias?.find(c => c.nome === "Pagamento de Evento")?.id || null;

    const valorTotal = validatedData.data.valor_total;
    const valorSinal = validatedData.data.valor_sinal || 0;
    const formaPagamento = validatedData.data.forma_pagamento || null;

    // Se tem sinal, criar duas transações
    if (valorSinal > 0 && valorSinal < valorTotal) {
      const valorRestante = valorTotal - valorSinal;

      // Transação do Sinal
      const { error: erroSinal } = await supabase
        .from("transacoes_financeiras")
        .insert({
          descricao: `Sinal - ${validatedData.data.nome}`,
          tipo: "receita",
          valor: valorSinal,
          data_vencimento: validatedData.data.data_inicio,
          status: "pendente",
          forma_pagamento: formaPagamento,
          categoria_id: categoriaSinal,
          evento_id: data.id,
          contato_id: validatedData.data.cliente_id || null,
          created_by: user?.id,
        });

      if (!erroSinal) {
        transacoesCriadas++;
      } else {
        console.warn("Aviso: Erro ao criar transação de sinal:", erroSinal);
      }

      // Transação do Restante
      const { error: erroRestante } = await supabase
        .from("transacoes_financeiras")
        .insert({
          descricao: `Restante - ${validatedData.data.nome}`,
          tipo: "receita",
          valor: valorRestante,
          data_vencimento: validatedData.data.data_inicio,
          status: "pendente",
          forma_pagamento: formaPagamento,
          categoria_id: categoriaPagamento,
          evento_id: data.id,
          contato_id: validatedData.data.cliente_id || null,
          created_by: user?.id,
        });

      if (!erroRestante) {
        transacoesCriadas++;
      } else {
        console.warn("Aviso: Erro ao criar transação do restante:", erroRestante);
      }
    } else {
      // Criar transação única com valor total
      const { error: transacaoError } = await supabase
        .from("transacoes_financeiras")
        .insert({
          descricao: `Pagamento - ${validatedData.data.nome}`,
          tipo: "receita",
          valor: valorTotal,
          data_vencimento: validatedData.data.data_inicio,
          status: "pendente",
          forma_pagamento: formaPagamento,
          categoria_id: categoriaPagamento,
          evento_id: data.id,
          contato_id: validatedData.data.cliente_id || null,
          created_by: user?.id,
        });

      if (!transacaoError) {
        transacoesCriadas++;
      } else {
        console.warn("Aviso: Evento criado mas transação não foi criada:", transacaoError);
      }
    }
  }

  revalidatePath("/eventos");
  revalidatePath("/financeiro");
  revalidatePath("/");
  return { 
    data, 
    error: null, 
    googleSynced: !!insertData.google_calendar_id,
    transacoesCriadas,
  };
}

export async function updateEvento(id: string, formData: Partial<EventoFormData> & { sincronizar_google?: boolean }) {
  const supabase = await createClient();
  const { sincronizar_google = true, ...eventoData } = formData;

  // Buscar evento atual para pegar o google_calendar_id
  const { data: currentEvento } = await supabase
    .from("eventos")
    .select("google_calendar_id, nome, descricao, local, endereco_local, data_inicio, data_fim, hora_inicio, hora_fim, tipo")
    .eq("id", id)
    .single();

  // Atualizar no Google Calendar se houver ID e sincronização estiver habilitada
  if (sincronizar_google && currentEvento?.google_calendar_id) {
    const updatedEvento = { ...currentEvento, ...eventoData };
    await updateGoogleCalendarEvent(currentEvento.google_calendar_id, {
      nome: updatedEvento.nome,
      descricao: updatedEvento.descricao,
      local: updatedEvento.local,
      endereco: updatedEvento.endereco_local,
      data_inicio: updatedEvento.data_inicio,
      data_fim: updatedEvento.data_fim,
      hora_inicio: updatedEvento.hora_inicio,
      hora_fim: updatedEvento.hora_fim,
      tipo: updatedEvento.tipo,
    });
  }

  const { data, error } = await supabase
    .from("eventos")
    .update(eventoData)
    .eq("id", id)
    .select()
    .single();

  if (error) {
    console.error("Erro ao atualizar evento:", error);
    return { data: null, error: error.message };
  }

  revalidatePath("/eventos");
  revalidatePath(`/eventos/${id}`);
  revalidatePath("/");
  return { data, error: null };
}

export async function deleteEvento(id: string) {
  const supabase = await createClient();

  // Buscar evento para pegar o google_calendar_id
  const { data: evento } = await supabase
    .from("eventos")
    .select("google_calendar_id")
    .eq("id", id)
    .single();

  // Deletar do Google Calendar se houver ID
  if (evento?.google_calendar_id) {
    await deleteGoogleCalendarEvent(evento.google_calendar_id);
  }

  const { error } = await supabase.from("eventos").delete().eq("id", id);

  if (error) {
    console.error("Erro ao deletar evento:", error);
    return { success: false, error: error.message };
  }

  revalidatePath("/eventos");
  revalidatePath("/");
  return { success: true, error: null };
}

/**
 * Retorna lista simplificada de eventos para uso em selects/dropdowns
 */
export async function getEventosSimples() {
  const supabase = await createClient();

  const { data, error } = await supabase
    .from("eventos")
    .select("id, nome, data_inicio, status")
    .order("data_inicio", { ascending: false })
    .limit(100);

  if (error) {
    console.error("Erro ao buscar eventos:", error);
    return { data: [], error: error.message };
  }

  return { data: data || [], error: null };
}

/**
 * Sincroniza um evento existente com o Google Calendar
 * Útil para eventos criados antes da integração
 */
export async function syncEventoComGoogle(id: string) {
  const supabase = await createClient();

  const { data: evento } = await supabase
    .from("eventos")
    .select("*")
    .eq("id", id)
    .single();

  if (!evento) {
    return { success: false, error: "Evento não encontrado" };
  }

  if (evento.google_calendar_id) {
    return { success: false, error: "Evento já está sincronizado com Google Calendar" };
  }

  const googleResult = await createGoogleCalendarEvent({
    nome: evento.nome,
    descricao: evento.descricao,
    local: evento.local,
    endereco: evento.endereco_local,
    data_inicio: evento.data_inicio,
    data_fim: evento.data_fim,
    hora_inicio: evento.hora_inicio,
    hora_fim: evento.hora_fim,
    tipo: evento.tipo,
  });

  if (!googleResult.id) {
    return { success: false, error: googleResult.error || "Erro ao sincronizar" };
  }

  const { error } = await supabase
    .from("eventos")
    .update({ google_calendar_id: googleResult.id })
    .eq("id", id);

  if (error) {
    return { success: false, error: error.message };
  }

  revalidatePath("/eventos");
  revalidatePath(`/eventos/${id}`);
  return { success: true, error: null };
}

export interface RecriarTransacoesParams {
  valor_total: number;
  valor_sinal: number;
  forma_pagamento: string | null;
  cliente_id: string | null;
  nome_evento: string;
}

/**
 * Recria as transações de receita de um evento
 * Remove as transações existentes e cria novas com os valores atualizados
 */
export async function recriarTransacoesEvento(
  eventoId: string, 
  params: RecriarTransacoesParams
) {
  const supabase = await createClient();

  const {
    data: { user },
  } = await supabase.auth.getUser();

  // Buscar evento para pegar a data de início
  const { data: evento } = await supabase
    .from("eventos")
    .select("data_inicio")
    .eq("id", eventoId)
    .single();

  if (!evento) {
    return { success: false, error: "Evento não encontrado", transacoesCriadas: 0 };
  }

  // Deletar transações de receita existentes vinculadas ao evento
  const { error: deleteError } = await supabase
    .from("transacoes_financeiras")
    .delete()
    .eq("evento_id", eventoId)
    .eq("tipo", "receita");

  if (deleteError) {
    console.error("Erro ao deletar transações existentes:", deleteError);
    return { success: false, error: deleteError.message, transacoesCriadas: 0 };
  }

  // Buscar categorias de receita
  const { data: categorias } = await supabase
    .from("categorias_financeiras")
    .select("id, nome")
    .eq("tipo", "receita");

  const categoriaSinal = categorias?.find(c => c.nome === "Sinal")?.id || null;
  const categoriaPagamento = categorias?.find(c => c.nome === "Pagamento de Evento")?.id || null;

  let transacoesCriadas = 0;

  // Se tem sinal, criar duas transações
  if (params.valor_sinal > 0 && params.valor_sinal < params.valor_total) {
    const valorRestante = params.valor_total - params.valor_sinal;

    // Transação do Sinal
    const { error: erroSinal } = await supabase
      .from("transacoes_financeiras")
      .insert({
        descricao: `Sinal - ${params.nome_evento}`,
        tipo: "receita",
        valor: params.valor_sinal,
        data_vencimento: evento.data_inicio,
        status: "pendente",
        forma_pagamento: params.forma_pagamento,
        categoria_id: categoriaSinal,
        evento_id: eventoId,
        contato_id: params.cliente_id,
        created_by: user?.id,
      });

    if (!erroSinal) {
      transacoesCriadas++;
    }

    // Transação do Restante
    const { error: erroRestante } = await supabase
      .from("transacoes_financeiras")
      .insert({
        descricao: `Restante - ${params.nome_evento}`,
        tipo: "receita",
        valor: valorRestante,
        data_vencimento: evento.data_inicio,
        status: "pendente",
        forma_pagamento: params.forma_pagamento,
        categoria_id: categoriaPagamento,
        evento_id: eventoId,
        contato_id: params.cliente_id,
        created_by: user?.id,
      });

    if (!erroRestante) {
      transacoesCriadas++;
    }
  } else if (params.valor_total > 0) {
    // Criar transação única com valor total
    const { error: transacaoError } = await supabase
      .from("transacoes_financeiras")
      .insert({
        descricao: `Pagamento - ${params.nome_evento}`,
        tipo: "receita",
        valor: params.valor_total,
        data_vencimento: evento.data_inicio,
        status: "pendente",
        forma_pagamento: params.forma_pagamento,
        categoria_id: categoriaPagamento,
        evento_id: eventoId,
        contato_id: params.cliente_id,
        created_by: user?.id,
      });

    if (!transacaoError) {
      transacoesCriadas++;
    }
  }

  revalidatePath("/eventos");
  revalidatePath(`/eventos/${eventoId}`);
  revalidatePath("/financeiro");
  return { success: true, error: null, transacoesCriadas };
}

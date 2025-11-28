"use server";

import { createClient } from "@/lib/supabase/server";
import { revalidatePath } from "next/cache";
import { eventoSchema, type EventoFormData } from "@/lib/validations/evento";
import {
  createGoogleCalendarEvent,
  updateGoogleCalendarEvent,
  deleteGoogleCalendarEvent,
  addAttendeeToGoogleEvent,
} from "@/lib/google/calendar";
import type { StatusEvento } from "@/types/database";

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
      users!eventos_responsavel_id_fkey(id, nome, avatar_url),
      tipos_evento!eventos_tipo_id_fkey(id, nome, icone, cor)
    `,
      { count: "exact" }
    )
    .order("data_inicio", { ascending: false }); // Eventos mais recentes primeiro

  if (search) {
    query = query.or(`nome.ilike.%${search}%,local.ilike.%${search}%`);
  }

  if (tipo && tipo !== "todos") {
    query = query.eq("tipo_id", tipo);
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
      id, nome, tipo_id, data_inicio, data_fim, local, status,
      contatos!eventos_cliente_id_fkey(id, nome),
      tipos_evento!eventos_tipo_id_fkey(id, nome, icone, cor)
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

/**
 * Busca eventos de uma semana específica
 * Retorna eventos que ocorrem entre startDate e endDate (inclusive)
 * Inclui eventos que começam antes mas terminam dentro do período
 */
export async function getEventosSemana(startDate: string, endDate: string) {
  const supabase = await createClient();

  const { data, error } = await supabase
    .from("eventos")
    .select(
      `
      *,
      contatos!eventos_cliente_id_fkey(id, nome),
      users!eventos_responsavel_id_fkey(id, nome, avatar_url),
      tipos_evento!eventos_tipo_id_fkey(id, nome, icone, cor)
    `
    )
    .or(
      `and(data_inicio.gte.${startDate},data_inicio.lte.${endDate}),and(data_fim.gte.${startDate},data_fim.lte.${endDate}),and(data_inicio.lte.${startDate},data_fim.gte.${endDate})`
    )
    .order("data_inicio", { ascending: true });

  if (error) {
    console.error("Erro ao buscar eventos da semana:", error);
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
      leads(id, titulo),
      users!eventos_responsavel_id_fkey(id, nome, avatar_url),
      tipos_evento!eventos_tipo_id_fkey(id, nome, icone, cor)
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

  // Converter strings vazias em null para campos opcionais de data/hora
  const sanitizedData = {
    ...validatedData.data,
    data_fim: validatedData.data.data_fim || null,
    hora_inicio: validatedData.data.hora_inicio || null,
    hora_fim: validatedData.data.hora_fim || null,
  };

  // Preparar dados para inserção
  const insertData = {
    ...sanitizedData,
    created_by: user?.id,
    responsavel_id: sanitizedData.responsavel_id || user?.id,
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

  // Converter strings vazias em null para campos opcionais de data/hora
  const sanitizedData = {
    ...eventoData,
    data_fim: eventoData.data_fim || null,
    hora_inicio: eventoData.hora_inicio || null,
    hora_fim: eventoData.hora_fim || null,
  };

  // Buscar evento atual para pegar o google_calendar_id
  const { data: currentEvento } = await supabase
    .from("eventos")
    .select("google_calendar_id, nome, descricao, local, endereco_local, data_inicio, data_fim, hora_inicio, hora_fim, tipo")
    .eq("id", id)
    .single();

  // Atualizar no Google Calendar se houver ID e sincronização estiver habilitada
  if (sincronizar_google && currentEvento?.google_calendar_id) {
    const updatedEvento = { ...currentEvento, ...sanitizedData };
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
    .update(sanitizedData)
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

/**
 * Busca transações financeiras vinculadas a um evento
 */
export async function getTransacoesDoEvento(eventoId: string) {
  const supabase = await createClient();

  const { data, error, count } = await supabase
    .from("transacoes_financeiras")
    .select("id, descricao, valor, tipo, status", { count: "exact" })
    .eq("evento_id", eventoId);

  if (error) {
    console.error("Erro ao buscar transações do evento:", error);
    return { data: [], count: 0, error: error.message };
  }

  return { data: data || [], count: count || 0, error: null };
}

export async function deleteEvento(id: string, excluirTransacoes = false) {
  const supabase = await createClient();

  // Verificar se existem transações vinculadas
  const { count: transacoesCount } = await supabase
    .from("transacoes_financeiras")
    .select("id", { count: "exact", head: true })
    .eq("evento_id", id);

  if (transacoesCount && transacoesCount > 0 && !excluirTransacoes) {
    return { 
      success: false, 
      error: "TRANSACOES_VINCULADAS",
      transacoesCount,
    };
  }

  // Excluir transações vinculadas se solicitado
  if (excluirTransacoes && transacoesCount && transacoesCount > 0) {
    const { error: deleteTransacoesError } = await supabase
      .from("transacoes_financeiras")
      .delete()
      .eq("evento_id", id);

    if (deleteTransacoesError) {
      console.error("Erro ao deletar transações:", deleteTransacoesError);
      return { success: false, error: deleteTransacoesError.message };
    }
  }

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
  revalidatePath("/financeiro");
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

/**
 * Sincroniza os membros alocados de um evento com o Google Calendar
 * Envia convites por email para todos os membros que possuem email cadastrado
 */
// ==================== ESTATÍSTICAS DO DASHBOARD ====================

export interface EstatisticasEventosMes {
  total: number;
  porStatus: {
    planejamento: number;
    confirmado: number;
    realizado: number;
    cancelado: number;
  };
}

/**
 * Retorna estatísticas de eventos para um mês específico
 * Filtra por data_inicio do evento
 */
export async function getEstatisticasEventosMes(mes?: string): Promise<EstatisticasEventosMes> {
  const supabase = await createClient();

  // Calcula início e fim do mês de forma timezone-safe
  let ano: number;
  let mesNum: number;

  if (mes) {
    const [anoStr, mesStr] = mes.split("-");
    ano = parseInt(anoStr, 10);
    mesNum = parseInt(mesStr, 10);
  } else {
    const agora = new Date();
    ano = agora.getFullYear();
    mesNum = agora.getMonth() + 1;
  }

  const inicioMes = `${ano}-${String(mesNum).padStart(2, "0")}-01`;
  const ultimoDia = new Date(ano, mesNum, 0).getDate();
  const fimMes = `${ano}-${String(mesNum).padStart(2, "0")}-${String(ultimoDia).padStart(2, "0")}`;

  // Buscar todos os eventos do mês
  const { data: eventos } = await supabase
    .from("eventos")
    .select("status")
    .gte("data_inicio", inicioMes)
    .lte("data_inicio", fimMes);

  // Calcular estatísticas
  const stats: EstatisticasEventosMes = {
    total: eventos?.length || 0,
    porStatus: {
      planejamento: 0,
      confirmado: 0,
      realizado: 0,
      cancelado: 0,
    },
  };

  eventos?.forEach((evento) => {
    const status = evento.status as keyof typeof stats.porStatus;
    if (stats.porStatus[status] !== undefined) {
      stats.porStatus[status]++;
    }
  });

  return stats;
}

export async function syncParticipantesEvento(eventoId: string) {
  const supabase = await createClient();

  // Buscar evento com google_calendar_id
  const { data: evento } = await supabase
    .from("eventos")
    .select("id, nome, google_calendar_id")
    .eq("id", eventoId)
    .single();

  if (!evento) {
    return { success: false, error: "Evento não encontrado", participantesSincronizados: 0 };
  }

  if (!evento.google_calendar_id) {
    return { 
      success: false, 
      error: "Evento não está sincronizado com Google Calendar. Sincronize o evento primeiro.", 
      participantesSincronizados: 0 
    };
  }

  // Buscar alocações do evento com emails dos membros
  const { data: alocacoes, error: alocacoesError } = await supabase
    .from("alocacao_equipe")
    .select(`
      id,
      equipe(id, nome, email)
    `)
    .eq("evento_id", eventoId);

  if (alocacoesError) {
    console.error("Erro ao buscar alocações:", alocacoesError);
    return { success: false, error: alocacoesError.message, participantesSincronizados: 0 };
  }

  let participantesSincronizados = 0;
  const erros: string[] = [];

  // Adicionar cada membro com email como participante
  for (const alocacao of alocacoes || []) {
    const membro = alocacao.equipe as { id: string; nome: string; email: string | null } | null;
    
    if (membro?.email) {
      const { success, error } = await addAttendeeToGoogleEvent(
        evento.google_calendar_id,
        {
          email: membro.email,
          displayName: membro.nome,
        }
      );

      if (success) {
        participantesSincronizados++;
      } else if (error) {
        erros.push(`${membro.nome}: ${error}`);
      }
    }
  }

  const totalMembros = alocacoes?.length || 0;
  const membrosComEmail = alocacoes?.filter(
    a => (a.equipe as { email?: string | null } | null)?.email
  ).length || 0;

  return { 
    success: true, 
    error: erros.length > 0 ? erros.join("; ") : null,
    participantesSincronizados,
    totalMembros,
    membrosComEmail,
    membrosSemEmail: totalMembros - membrosComEmail,
  };
}

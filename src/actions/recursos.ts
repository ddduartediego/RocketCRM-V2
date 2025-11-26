"use server";

import { createClient } from "@/lib/supabase/server";
import { revalidatePath } from "next/cache";
import {
  recursoSchema,
  alocacaoRecursoSchema,
  type RecursoFormData,
  type AlocacaoRecursoFormData,
} from "@/lib/validations/recurso";
import type { TipoRecurso } from "@/types/database";

export interface RecursosFilters {
  search?: string;
  tipo?: string;
  ativo?: boolean;
  page?: number;
  perPage?: number;
}

// ==================== RECURSOS ====================

export async function getRecursos(filters: RecursosFilters = {}) {
  const supabase = await createClient();
  const { search, tipo, ativo, page = 1, perPage = 10 } = filters;

  let query = supabase
    .from("recursos")
    .select("*", { count: "exact" })
    .order("nome", { ascending: true });

  if (search) {
    query = query.or(`nome.ilike.%${search}%,descricao.ilike.%${search}%`);
  }

  if (tipo && tipo !== "todos") {
    query = query.eq("tipo", tipo as TipoRecurso);
  }

  if (ativo !== undefined) {
    query = query.eq("ativo", ativo);
  }

  const from = (page - 1) * perPage;
  const to = from + perPage - 1;

  const { data, error, count } = await query.range(from, to);

  if (error) {
    console.error("Erro ao buscar recursos:", error);
    return { data: [], count: 0, error: error.message };
  }

  return { data: data || [], count: count || 0, error: null };
}

export async function getRecursosDisponiveis(
  dataInicio: string,
  dataFim: string,
  tipo?: string
) {
  const supabase = await createClient();

  // Buscar recursos ativos
  let query = supabase
    .from("recursos")
    .select("*")
    .eq("ativo", true)
    .order("nome", { ascending: true });

  if (tipo && tipo !== "todos") {
    query = query.eq("tipo", tipo as TipoRecurso);
  }

  const { data: recursos, error: recursosError } = await query;

  if (recursosError) {
    console.error("Erro ao buscar recursos:", recursosError);
    return { data: [], error: recursosError.message };
  }

  // Buscar alocações que conflitam com o período
  const { data: alocacoes, error: alocacoesError } = await supabase
    .from("alocacao_recursos")
    .select("recurso_id, quantidade")
    .or(`data_inicio.lte.${dataFim},data_fim.gte.${dataInicio}`)
    .overlaps("data_inicio", [dataInicio, dataFim]);

  if (alocacoesError) {
    // Se não conseguir verificar alocações, retorna todos os recursos
    console.warn("Aviso: Não foi possível verificar alocações:", alocacoesError);
    return { data: recursos || [], error: null };
  }

  // Calcular quantidade disponível
  const alocadoPorRecurso = new Map<string, number>();
  alocacoes?.forEach((a) => {
    const atual = alocadoPorRecurso.get(a.recurso_id) || 0;
    alocadoPorRecurso.set(a.recurso_id, atual + a.quantidade);
  });

  const recursosComDisponibilidade = recursos?.map((recurso) => {
    const alocado = alocadoPorRecurso.get(recurso.id) || 0;
    const disponivel = recurso.quantidade - alocado;
    return {
      ...recurso,
      quantidade_alocada: alocado,
      quantidade_disponivel: Math.max(0, disponivel),
    };
  });

  return { data: recursosComDisponibilidade || [], error: null };
}

export async function getRecursoById(id: string) {
  const supabase = await createClient();

  const { data, error } = await supabase
    .from("recursos")
    .select("*")
    .eq("id", id)
    .single();

  if (error) {
    console.error("Erro ao buscar recurso:", error);
    return { data: null, error: error.message };
  }

  return { data, error: null };
}

export async function createRecurso(formData: RecursoFormData) {
  const supabase = await createClient();

  const validatedData = recursoSchema.safeParse(formData);
  if (!validatedData.success) {
    return { data: null, error: "Dados inválidos" };
  }

  const { data, error } = await supabase
    .from("recursos")
    .insert(validatedData.data)
    .select()
    .single();

  if (error) {
    console.error("Erro ao criar recurso:", error);
    return { data: null, error: error.message };
  }

  revalidatePath("/recursos");
  return { data, error: null };
}

export async function updateRecurso(id: string, formData: Partial<RecursoFormData>) {
  const supabase = await createClient();

  const { data, error } = await supabase
    .from("recursos")
    .update(formData)
    .eq("id", id)
    .select()
    .single();

  if (error) {
    console.error("Erro ao atualizar recurso:", error);
    return { data: null, error: error.message };
  }

  revalidatePath("/recursos");
  revalidatePath(`/recursos/${id}`);
  return { data, error: null };
}

export async function deleteRecurso(id: string) {
  const supabase = await createClient();

  // Verificar se há alocações ativas
  const { count } = await supabase
    .from("alocacao_recursos")
    .select("*", { count: "exact", head: true })
    .eq("recurso_id", id);

  if (count && count > 0) {
    return {
      success: false,
      error: "Este recurso possui alocações e não pode ser excluído. Desative-o em vez disso.",
    };
  }

  const { error } = await supabase.from("recursos").delete().eq("id", id);

  if (error) {
    console.error("Erro ao deletar recurso:", error);
    return { success: false, error: error.message };
  }

  revalidatePath("/recursos");
  return { success: true, error: null };
}

// ==================== ALOCAÇÕES ====================

export async function getAlocacoesRecurso(recursoId: string) {
  const supabase = await createClient();

  const { data, error } = await supabase
    .from("alocacao_recursos")
    .select(
      `
      *,
      eventos(id, nome, data_inicio, data_fim, status)
    `
    )
    .eq("recurso_id", recursoId)
    .order("data_inicio", { ascending: true });

  if (error) {
    console.error("Erro ao buscar alocações:", error);
    return { data: [], error: error.message };
  }

  return { data: data || [], error: null };
}

export async function getAlocacoesEvento(eventoId: string) {
  const supabase = await createClient();

  const { data, error } = await supabase
    .from("alocacao_recursos")
    .select(
      `
      *,
      recursos(id, nome, tipo, quantidade, custo_unitario)
    `
    )
    .eq("evento_id", eventoId)
    .order("created_at", { ascending: true });

  if (error) {
    console.error("Erro ao buscar alocações do evento:", error);
    return { data: [], error: error.message };
  }

  return { data: data || [], error: null };
}

export async function createAlocacaoRecurso(formData: AlocacaoRecursoFormData) {
  const supabase = await createClient();

  const validatedData = alocacaoRecursoSchema.safeParse(formData);
  if (!validatedData.success) {
    return { data: null, error: "Dados inválidos" };
  }

  // Verificar disponibilidade
  const { data: recurso } = await supabase
    .from("recursos")
    .select("quantidade, nome")
    .eq("id", validatedData.data.recurso_id)
    .single();

  if (!recurso) {
    return { data: null, error: "Recurso não encontrado" };
  }

  // Verificar conflitos de data
  const { data: alocacoesConflito } = await supabase
    .from("alocacao_recursos")
    .select("quantidade")
    .eq("recurso_id", validatedData.data.recurso_id)
    .lte("data_inicio", validatedData.data.data_fim)
    .gte("data_fim", validatedData.data.data_inicio);

  const totalAlocado =
    alocacoesConflito?.reduce((acc, a) => acc + a.quantidade, 0) || 0;
  const disponivel = recurso.quantidade - totalAlocado;

  if (validatedData.data.quantidade > disponivel) {
    return {
      data: null,
      error: `Quantidade indisponível. Disponível: ${disponivel}`,
    };
  }

  // Buscar dados do evento para a transação
  const { data: evento } = await supabase
    .from("eventos")
    .select("nome")
    .eq("id", validatedData.data.evento_id)
    .single();

  // Buscar categoria "Materiais" para despesa de recursos
  const { data: categoriaMateriais } = await supabase
    .from("categorias_financeiras")
    .select("id")
    .eq("nome", "Materiais")
    .eq("tipo", "despesa")
    .single();

  let transacaoId: string | null = null;

  // Criar transação de despesa se houver valor
  if (validatedData.data.valor && validatedData.data.valor > 0) {
    const descricaoTransacao = `${recurso.nome} (${validatedData.data.quantidade}x) - ${evento?.nome || "Evento"}`;

    const { data: transacao, error: transacaoError } = await supabase
      .from("transacoes_financeiras")
      .insert({
        descricao: descricaoTransacao,
        tipo: "despesa",
        valor: validatedData.data.valor,
        data_vencimento: validatedData.data.data_inicio,
        status: "pendente",
        categoria_id: categoriaMateriais?.id || null,
        evento_id: validatedData.data.evento_id,
      })
      .select("id")
      .single();

    if (transacaoError) {
      console.error("Erro ao criar transação:", transacaoError);
    } else {
      transacaoId = transacao.id;
    }
  }

  // Criar alocação com referência à transação
  const { data, error } = await supabase
    .from("alocacao_recursos")
    .insert({
      ...validatedData.data,
      transacao_id: transacaoId,
    })
    .select()
    .single();

  if (error) {
    console.error("Erro ao criar alocação:", error);
    // Se criou transação mas falhou a alocação, excluir transação
    if (transacaoId) {
      await supabase.from("transacoes_financeiras").delete().eq("id", transacaoId);
    }
    return { data: null, error: error.message };
  }

  revalidatePath("/recursos");
  revalidatePath("/eventos");
  revalidatePath("/financeiro");
  return { data, error: null };
}

export async function updateAlocacaoRecurso(
  id: string,
  formData: Partial<AlocacaoRecursoFormData>
) {
  const supabase = await createClient();

  const { data, error } = await supabase
    .from("alocacao_recursos")
    .update(formData)
    .eq("id", id)
    .select()
    .single();

  if (error) {
    console.error("Erro ao atualizar alocação:", error);
    return { data: null, error: error.message };
  }

  revalidatePath("/recursos");
  revalidatePath("/eventos");
  return { data, error: null };
}

export async function deleteAlocacaoRecurso(id: string, excluirTransacao: boolean = true) {
  const supabase = await createClient();

  // Buscar alocação para obter transacao_id
  const { data: alocacao } = await supabase
    .from("alocacao_recursos")
    .select("transacao_id")
    .eq("id", id)
    .single();

  const { error } = await supabase
    .from("alocacao_recursos")
    .delete()
    .eq("id", id);

  if (error) {
    console.error("Erro ao deletar alocação:", error);
    return { success: false, error: error.message };
  }

  // Excluir transação vinculada se solicitado
  if (excluirTransacao && alocacao?.transacao_id) {
    const { error: transacaoError } = await supabase
      .from("transacoes_financeiras")
      .delete()
      .eq("id", alocacao.transacao_id);

    if (transacaoError) {
      console.warn("Aviso: Não foi possível excluir a transação vinculada:", transacaoError);
    }
  }

  revalidatePath("/recursos");
  revalidatePath("/eventos");
  revalidatePath("/financeiro");
  return { success: true, error: null };
}


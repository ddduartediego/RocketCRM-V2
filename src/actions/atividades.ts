"use server";

import { createClient } from "@/lib/supabase/server";
import { revalidatePath } from "next/cache";
import {
  atividadeSchema,
  type AtividadeFormData,
} from "@/lib/validations/atividade";
import type { StatusAtividade } from "@/types/database";

export interface AtividadesFilters {
  search?: string;
  status?: string;
  prioridade?: number;
  responsavel_id?: string;
  evento_id?: string;
  lead_id?: string;
  contato_id?: string;
  data_inicio?: string;
  data_fim?: string;
  page?: number;
  perPage?: number;
}

export async function getAtividades(filters: AtividadesFilters = {}) {
  const supabase = await createClient();
  const {
    search,
    status,
    prioridade,
    responsavel_id,
    evento_id,
    lead_id,
    contato_id,
    data_inicio,
    data_fim,
    page = 1,
    perPage = 20,
  } = filters;

  let query = supabase
    .from("atividades")
    .select(
      `
      *,
      users:responsavel_id(id, nome, avatar_url),
      eventos(id, nome),
      leads(id, titulo),
      contatos(id, nome)
    `,
      { count: "exact" }
    )
    .order("prioridade", { ascending: false })
    .order("data_vencimento", { ascending: true, nullsFirst: false });

  if (search) {
    query = query.ilike("titulo", `%${search}%`);
  }

  if (status && status !== "todos") {
    query = query.eq("status", status as StatusAtividade);
  }

  if (prioridade) {
    query = query.eq("prioridade", prioridade);
  }

  if (responsavel_id) {
    query = query.eq("responsavel_id", responsavel_id);
  }

  if (evento_id) {
    query = query.eq("evento_id", evento_id);
  }

  if (lead_id) {
    query = query.eq("lead_id", lead_id);
  }

  if (contato_id) {
    query = query.eq("contato_id", contato_id);
  }

  if (data_inicio) {
    query = query.gte("data_vencimento", data_inicio);
  }

  if (data_fim) {
    query = query.lte("data_vencimento", data_fim);
  }

  const from = (page - 1) * perPage;
  const to = from + perPage - 1;

  const { data, error, count } = await query.range(from, to);

  if (error) {
    console.error("Erro ao buscar atividades:", error);
    return { data: [], count: 0, error: error.message };
  }

  return { data: data || [], count: count || 0, error: null };
}

export async function getAtividadeById(id: string) {
  const supabase = await createClient();

  const { data, error } = await supabase
    .from("atividades")
    .select(
      `
      *,
      users:responsavel_id(id, nome, avatar_url),
      eventos(id, nome),
      leads(id, titulo),
      contatos(id, nome)
    `
    )
    .eq("id", id)
    .single();

  if (error) {
    console.error("Erro ao buscar atividade:", error);
    return { data: null, error: error.message };
  }

  return { data, error: null };
}

export async function createAtividade(formData: AtividadeFormData) {
  const supabase = await createClient();

  const validatedData = atividadeSchema.safeParse(formData);
  if (!validatedData.success) {
    return { data: null, error: "Dados inválidos" };
  }

  const {
    data: { user },
  } = await supabase.auth.getUser();

  const { data, error } = await supabase
    .from("atividades")
    .insert({
      ...validatedData.data,
      created_by: user?.id,
    })
    .select()
    .single();

  if (error) {
    console.error("Erro ao criar atividade:", error);
    return { data: null, error: error.message };
  }

  revalidatePath("/tarefas");
  if (formData.evento_id) revalidatePath(`/eventos/${formData.evento_id}`);
  revalidatePath("/");
  return { data, error: null };
}

export async function updateAtividade(id: string, formData: Partial<AtividadeFormData>) {
  const supabase = await createClient();

  const updateData: Record<string, unknown> = { ...formData };
  
  // Se estiver marcando como concluída, adicionar a data de conclusão
  if (formData.status === "concluida") {
    updateData.concluida_em = new Date().toISOString();
  } else if (formData.status) {
    // Se mudou para qualquer outro status que não seja concluída
    updateData.concluida_em = null;
  }

  const { data, error } = await supabase
    .from("atividades")
    .update(updateData)
    .eq("id", id)
    .select()
    .single();

  if (error) {
    console.error("Erro ao atualizar atividade:", error);
    return { data: null, error: error.message };
  }

  revalidatePath("/tarefas");
  revalidatePath("/");
  return { data, error: null };
}

export async function deleteAtividade(id: string) {
  const supabase = await createClient();

  const { error } = await supabase.from("atividades").delete().eq("id", id);

  if (error) {
    console.error("Erro ao deletar atividade:", error);
    return { success: false, error: error.message };
  }

  revalidatePath("/tarefas");
  revalidatePath("/");
  return { success: true, error: null };
}

export async function toggleAtividade(id: string) {
  const supabase = await createClient();

  // Buscar status atual
  const { data: atividade } = await supabase
    .from("atividades")
    .select("status")
    .eq("id", id)
    .single();

  if (!atividade) {
    return { data: null, error: "Atividade não encontrada" };
  }

  const novoStatus = atividade.status === "concluida" ? "pendente" : "concluida";
  
  const { data, error } = await supabase
    .from("atividades")
    .update({
      status: novoStatus,
      concluida_em: novoStatus === "concluida" ? new Date().toISOString() : null,
    })
    .eq("id", id)
    .select()
    .single();

  if (error) {
    console.error("Erro ao alternar status:", error);
    return { data: null, error: error.message };
  }

  revalidatePath("/tarefas");
  revalidatePath("/");
  return { data, error: null };
}

// ==================== ESTATÍSTICAS ====================

export async function getResumoAtividades() {
  const supabase = await createClient();

  const [
    { count: total },
    { count: pendentes },
    { count: emAndamento },
    { count: concluidas },
    { count: vencidas },
  ] = await Promise.all([
    supabase.from("atividades").select("*", { count: "exact", head: true }),
    supabase
      .from("atividades")
      .select("*", { count: "exact", head: true })
      .eq("status", "pendente"),
    supabase
      .from("atividades")
      .select("*", { count: "exact", head: true })
      .eq("status", "em_andamento"),
    supabase
      .from("atividades")
      .select("*", { count: "exact", head: true })
      .eq("status", "concluida"),
    supabase
      .from("atividades")
      .select("*", { count: "exact", head: true })
      .eq("status", "pendente")
      .lt("data_vencimento", new Date().toISOString().split("T")[0]),
  ]);

  return {
    total: total || 0,
    pendentes: pendentes || 0,
    emAndamento: emAndamento || 0,
    concluidas: concluidas || 0,
    vencidas: vencidas || 0,
  };
}

export async function getAtividadesEvento(eventoId: string) {
  const supabase = await createClient();

  const { data, error } = await supabase
    .from("atividades")
    .select(
      `
      *,
      users:responsavel_id(id, nome, avatar_url)
    `
    )
    .eq("evento_id", eventoId)
    .order("prioridade", { ascending: false })
    .order("data_vencimento", { ascending: true, nullsFirst: false });

  if (error) {
    console.error("Erro ao buscar atividades do evento:", error);
    return { data: [], error: error.message };
  }

  return { data: data || [], error: null };
}

export async function getAtividadesHoje() {
  const supabase = await createClient();
  const hoje = new Date().toISOString().split("T")[0];

  const { data, error } = await supabase
    .from("atividades")
    .select(
      `
      id,
      titulo,
      descricao,
      status,
      prioridade,
      data_vencimento,
      responsavel_id,
      evento_id,
      eventos(id, nome)
    `
    )
    .or(`status.eq.pendente,status.eq.em_andamento`)
    .lte("data_vencimento", hoje)
    .order("prioridade", { ascending: false })
    .limit(10);

  if (error) {
    console.error("Erro ao buscar atividades de hoje:", error);
    return { data: [], error: error.message };
  }

  return { data: data || [], error: null };
}

// ==================== ESTATÍSTICAS DO DASHBOARD ====================

export interface EstatisticasTarefasMes {
  total: number;
  porStatus: {
    pendente: number;
    em_andamento: number;
    concluida: number;
  };
  vencidas: number;
}

/**
 * Retorna estatísticas de tarefas para um mês específico
 * Filtra por data_vencimento da tarefa
 */
export async function getEstatisticasTarefasMes(mes?: string): Promise<EstatisticasTarefasMes> {
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
  const hoje = new Date().toISOString().split("T")[0];

  // Buscar todas as tarefas do mês
  const { data: tarefas } = await supabase
    .from("atividades")
    .select("status, data_vencimento")
    .gte("data_vencimento", inicioMes)
    .lte("data_vencimento", fimMes);

  // Calcular estatísticas
  const stats: EstatisticasTarefasMes = {
    total: tarefas?.length || 0,
    porStatus: {
      pendente: 0,
      em_andamento: 0,
      concluida: 0,
    },
    vencidas: 0,
  };

  tarefas?.forEach((tarefa) => {
    const status = tarefa.status as keyof typeof stats.porStatus;
    if (stats.porStatus[status] !== undefined) {
      stats.porStatus[status]++;
    }
    
    // Contar vencidas (pendentes ou em andamento com data passada)
    if (
      tarefa.data_vencimento && 
      tarefa.data_vencimento < hoje && 
      (tarefa.status === "pendente" || tarefa.status === "em_andamento")
    ) {
      stats.vencidas++;
    }
  });

  return stats;
}


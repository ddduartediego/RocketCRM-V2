"use server";

import { createClient } from "@/lib/supabase/server";
import { revalidatePath } from "next/cache";
import {
  membroEquipeSchema,
  alocacaoEquipeSchema,
  type MembroEquipeFormData,
  type AlocacaoEquipeFormData,
} from "@/lib/validations/equipe";
import type { FuncaoEquipe, TipoContratoEquipe } from "@/types/database";

export interface EquipeFilters {
  search?: string;
  funcao?: string;
  tipo_contrato?: string;
  ativo?: boolean;
  page?: number;
  perPage?: number;
}

// ==================== MEMBROS EQUIPE ====================

export async function getMembrosEquipe(filters: EquipeFilters = {}) {
  const supabase = await createClient();
  const { search, funcao, tipo_contrato, ativo, page = 1, perPage = 10 } = filters;

  let query = supabase
    .from("equipe")
    .select("*", { count: "exact" })
    .order("nome", { ascending: true });

  if (search) {
    query = query.or(`nome.ilike.%${search}%,email.ilike.%${search}%`);
  }

  if (funcao && funcao !== "todos") {
    query = query.eq("funcao", funcao as FuncaoEquipe);
  }

  if (tipo_contrato && tipo_contrato !== "todos") {
    query = query.eq("tipo_contrato", tipo_contrato as TipoContratoEquipe);
  }

  if (ativo !== undefined) {
    query = query.eq("ativo", ativo);
  }

  const from = (page - 1) * perPage;
  const to = from + perPage - 1;

  const { data, error, count } = await query.range(from, to);

  if (error) {
    console.error("Erro ao buscar equipe:", error);
    return { data: [], count: 0, error: error.message };
  }

  return { data: data || [], count: count || 0, error: null };
}

export async function getMembrosDisponiveis(data: string, funcao?: string) {
  const supabase = await createClient();

  // Buscar membros ativos
  let query = supabase
    .from("equipe")
    .select("*")
    .eq("ativo", true)
    .order("nome", { ascending: true });

  if (funcao && funcao !== "todos") {
    query = query.eq("funcao", funcao as FuncaoEquipe);
  }

  const { data: membros, error: membrosError } = await query;

  if (membrosError) {
    console.error("Erro ao buscar membros:", membrosError);
    return { data: [], error: membrosError.message };
  }

  // Buscar alocações para a data
  const { data: alocacoes, error: alocacoesError } = await supabase
    .from("alocacao_equipe")
    .select("membro_id")
    .eq("data", data);

  if (alocacoesError) {
    console.warn("Aviso: Não foi possível verificar alocações:", alocacoesError);
    return { data: membros || [], error: null };
  }

  // Marcar membros ocupados
  const membrosOcupados = new Set(alocacoes?.map((a) => a.membro_id));
  const membrosComDisponibilidade = membros?.map((membro) => ({
    ...membro,
    ocupado: membrosOcupados.has(membro.id),
  }));

  return { data: membrosComDisponibilidade || [], error: null };
}

export async function getMembroById(id: string) {
  const supabase = await createClient();

  const { data, error } = await supabase
    .from("equipe")
    .select("*")
    .eq("id", id)
    .single();

  if (error) {
    console.error("Erro ao buscar membro:", error);
    return { data: null, error: error.message };
  }

  return { data, error: null };
}

export async function createMembro(formData: MembroEquipeFormData) {
  const supabase = await createClient();

  const validatedData = membroEquipeSchema.safeParse(formData);
  if (!validatedData.success) {
    return { data: null, error: "Dados inválidos" };
  }

  // Limpar email vazio
  const dataToInsert = {
    ...validatedData.data,
    email: validatedData.data.email || null,
  };

  const { data, error } = await supabase
    .from("equipe")
    .insert(dataToInsert)
    .select()
    .single();

  if (error) {
    console.error("Erro ao criar membro:", error);
    return { data: null, error: error.message };
  }

  revalidatePath("/equipe");
  return { data, error: null };
}

export async function updateMembro(id: string, formData: Partial<MembroEquipeFormData>) {
  const supabase = await createClient();

  // Limpar email vazio
  const dataToUpdate = {
    ...formData,
    email: formData.email || null,
  };

  const { data, error } = await supabase
    .from("equipe")
    .update(dataToUpdate)
    .eq("id", id)
    .select()
    .single();

  if (error) {
    console.error("Erro ao atualizar membro:", error);
    return { data: null, error: error.message };
  }

  revalidatePath("/equipe");
  revalidatePath(`/equipe/${id}`);
  return { data, error: null };
}

export async function deleteMembro(id: string) {
  const supabase = await createClient();

  // Verificar se há alocações ativas
  const { count } = await supabase
    .from("alocacao_equipe")
    .select("*", { count: "exact", head: true })
    .eq("membro_id", id);

  if (count && count > 0) {
    return {
      success: false,
      error: "Este membro possui alocações e não pode ser excluído. Desative-o em vez disso.",
    };
  }

  const { error } = await supabase.from("equipe").delete().eq("id", id);

  if (error) {
    console.error("Erro ao deletar membro:", error);
    return { success: false, error: error.message };
  }

  revalidatePath("/equipe");
  return { success: true, error: null };
}

// ==================== ALOCAÇÕES ====================

export async function getAlocacoesMembro(membroId: string) {
  const supabase = await createClient();

  const { data, error } = await supabase
    .from("alocacao_equipe")
    .select(
      `
      *,
      eventos(id, nome, data_inicio, data_fim, status, local)
    `
    )
    .eq("membro_id", membroId)
    .order("data", { ascending: false });

  if (error) {
    console.error("Erro ao buscar alocações:", error);
    return { data: [], error: error.message };
  }

  return { data: data || [], error: null };
}

export async function getAlocacoesEvento(eventoId: string) {
  const supabase = await createClient();

  const { data, error } = await supabase
    .from("alocacao_equipe")
    .select(
      `
      *,
      equipe(id, nome, funcao, telefone, whatsapp)
    `
    )
    .eq("evento_id", eventoId)
    .order("data", { ascending: true });

  if (error) {
    console.error("Erro ao buscar alocações do evento:", error);
    return { data: [], error: error.message };
  }

  return { data: data || [], error: null };
}

export async function getAgendaMembro(membroId: string, mes?: string) {
  const supabase = await createClient();

  // Se não passar mês, usa o mês atual
  const dataAtual = mes ? new Date(`${mes}-01`) : new Date();
  const inicioMes = new Date(dataAtual.getFullYear(), dataAtual.getMonth(), 1)
    .toISOString()
    .split("T")[0];
  const fimMes = new Date(dataAtual.getFullYear(), dataAtual.getMonth() + 1, 0)
    .toISOString()
    .split("T")[0];

  const { data, error } = await supabase
    .from("alocacao_equipe")
    .select(
      `
      *,
      eventos(id, nome, tipo, local, status)
    `
    )
    .eq("membro_id", membroId)
    .gte("data", inicioMes)
    .lte("data", fimMes)
    .order("data", { ascending: true });

  if (error) {
    console.error("Erro ao buscar agenda:", error);
    return { data: [], error: error.message };
  }

  return { data: data || [], error: null };
}

export async function createAlocacaoEquipe(formData: AlocacaoEquipeFormData) {
  const supabase = await createClient();

  const validatedData = alocacaoEquipeSchema.safeParse(formData);
  if (!validatedData.success) {
    return { data: null, error: "Dados inválidos" };
  }

  // Verificar se já está alocado nesta data
  const { data: alocacaoExistente } = await supabase
    .from("alocacao_equipe")
    .select("id")
    .eq("membro_id", validatedData.data.membro_id)
    .eq("data", validatedData.data.data)
    .single();

  if (alocacaoExistente) {
    return { data: null, error: "Este membro já está alocado nesta data" };
  }

  const { data, error } = await supabase
    .from("alocacao_equipe")
    .insert(validatedData.data)
    .select()
    .single();

  if (error) {
    console.error("Erro ao criar alocação:", error);
    return { data: null, error: error.message };
  }

  revalidatePath("/equipe");
  revalidatePath("/eventos");
  return { data, error: null };
}

export async function updateAlocacaoEquipe(
  id: string,
  formData: Partial<AlocacaoEquipeFormData>
) {
  const supabase = await createClient();

  const { data, error } = await supabase
    .from("alocacao_equipe")
    .update(formData)
    .eq("id", id)
    .select()
    .single();

  if (error) {
    console.error("Erro ao atualizar alocação:", error);
    return { data: null, error: error.message };
  }

  revalidatePath("/equipe");
  revalidatePath("/eventos");
  return { data, error: null };
}

export async function deleteAlocacaoEquipe(id: string) {
  const supabase = await createClient();

  const { error } = await supabase
    .from("alocacao_equipe")
    .delete()
    .eq("id", id);

  if (error) {
    console.error("Erro ao deletar alocação:", error);
    return { success: false, error: error.message };
  }

  revalidatePath("/equipe");
  revalidatePath("/eventos");
  return { success: true, error: null };
}


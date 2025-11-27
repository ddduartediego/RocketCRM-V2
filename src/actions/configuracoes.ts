"use server";

import { createClient } from "@/lib/supabase/server";
import { revalidatePath } from "next/cache";

export async function updatePerfil(userId: string, data: { nome: string }) {
  const supabase = await createClient();

  const { error } = await supabase
    .from("users")
    .update({ nome: data.nome })
    .eq("id", userId);

  if (error) {
    console.error("Erro ao atualizar perfil:", error);
    return { success: false, error: error.message };
  }

  revalidatePath("/configuracoes/perfil");
  revalidatePath("/");
  return { success: true, error: null };
}

// ==================== ETAPAS DO FUNIL ====================

export async function getEtapasFunil() {
  const supabase = await createClient();

  const { data, error } = await supabase
    .from("etapas_funil")
    .select("*")
    .order("ordem", { ascending: true });

  if (error) {
    console.error("Erro ao buscar etapas:", error);
    return { data: [], error: error.message };
  }

  return { data: data || [], error: null };
}

export async function createEtapaFunil(data: {
  nome: string;
  cor: string;
  is_final?: boolean;
  is_perdido?: boolean;
}) {
  const supabase = await createClient();

  // Buscar a maior ordem atual
  const { data: maxOrdem } = await supabase
    .from("etapas_funil")
    .select("ordem")
    .order("ordem", { ascending: false })
    .limit(1)
    .single();

  const novaOrdem = (maxOrdem?.ordem || 0) + 1;

  const { data: etapa, error } = await supabase
    .from("etapas_funil")
    .insert({
      ...data,
      ordem: novaOrdem,
    })
    .select()
    .single();

  if (error) {
    console.error("Erro ao criar etapa:", error);
    return { data: null, error: error.message };
  }

  revalidatePath("/configuracoes/funil");
  revalidatePath("/leads");
  return { data: etapa, error: null };
}

export async function updateEtapaFunil(
  id: string,
  data: Partial<{
    nome: string;
    cor: string;
    is_final: boolean;
    is_perdido: boolean;
    ativo: boolean;
  }>
) {
  const supabase = await createClient();

  const { error } = await supabase
    .from("etapas_funil")
    .update(data)
    .eq("id", id);

  if (error) {
    console.error("Erro ao atualizar etapa:", error);
    return { success: false, error: error.message };
  }

  revalidatePath("/configuracoes/funil");
  revalidatePath("/leads");
  return { success: true, error: null };
}

export async function deleteEtapaFunil(id: string) {
  const supabase = await createClient();

  // Verificar se há leads usando esta etapa
  const { count } = await supabase
    .from("leads")
    .select("*", { count: "exact", head: true })
    .eq("etapa_id", id);

  if (count && count > 0) {
    return {
      success: false,
      error: "Esta etapa possui leads associados. Mova os leads para outra etapa antes de excluir.",
    };
  }

  const { error } = await supabase
    .from("etapas_funil")
    .delete()
    .eq("id", id);

  if (error) {
    console.error("Erro ao deletar etapa:", error);
    return { success: false, error: error.message };
  }

  revalidatePath("/configuracoes/funil");
  revalidatePath("/leads");
  return { success: true, error: null };
}

export async function reorderEtapasFunil(etapas: { id: string; ordem: number }[]) {
  const supabase = await createClient();

  // Atualizar ordem de cada etapa
  const updates = etapas.map((etapa) =>
    supabase
      .from("etapas_funil")
      .update({ ordem: etapa.ordem })
      .eq("id", etapa.id)
  );

  const results = await Promise.all(updates);
  const hasError = results.some((r) => r.error);

  if (hasError) {
    return { success: false, error: "Erro ao reordenar etapas" };
  }

  revalidatePath("/configuracoes/funil");
  revalidatePath("/leads");
  return { success: true, error: null };
}

// ==================== CATEGORIAS FINANCEIRAS ====================

export async function getCategoriasFinanceiras() {
  const supabase = await createClient();

  const { data, error } = await supabase
    .from("categorias_financeiras")
    .select("*")
    .order("tipo")
    .order("nome");

  if (error) {
    console.error("Erro ao buscar categorias:", error);
    return { data: [], error: error.message };
  }

  return { data: data || [], error: null };
}

export async function createCategoriaFinanceira(data: {
  nome: string;
  tipo: "receita" | "despesa";
  cor?: string;
}) {
  const supabase = await createClient();

  const { data: categoria, error } = await supabase
    .from("categorias_financeiras")
    .insert(data)
    .select()
    .single();

  if (error) {
    console.error("Erro ao criar categoria:", error);
    return { data: null, error: error.message };
  }

  revalidatePath("/configuracoes/categorias");
  revalidatePath("/financeiro");
  return { data: categoria, error: null };
}

export async function updateCategoriaFinanceira(
  id: string,
  data: Partial<{
    nome: string;
    cor: string;
    ativo: boolean;
  }>
) {
  const supabase = await createClient();

  const { error } = await supabase
    .from("categorias_financeiras")
    .update(data)
    .eq("id", id);

  if (error) {
    console.error("Erro ao atualizar categoria:", error);
    return { success: false, error: error.message };
  }

  revalidatePath("/configuracoes/categorias");
  revalidatePath("/financeiro");
  return { success: true, error: null };
}

export async function deleteCategoriaFinanceira(id: string) {
  const supabase = await createClient();

  // Verificar se há transações usando esta categoria
  const { count } = await supabase
    .from("transacoes_financeiras")
    .select("*", { count: "exact", head: true })
    .eq("categoria_id", id);

  if (count && count > 0) {
    return {
      success: false,
      error: "Esta categoria possui transações. Desative-a em vez de excluir.",
    };
  }

  const { error } = await supabase
    .from("categorias_financeiras")
    .delete()
    .eq("id", id);

  if (error) {
    console.error("Erro ao deletar categoria:", error);
    return { success: false, error: error.message };
  }

  revalidatePath("/configuracoes/categorias");
  revalidatePath("/financeiro");
  return { success: true, error: null };
}

// ==================== TIPOS DE EVENTO ====================

export async function getTiposEvento() {
  const supabase = await createClient();

  const { data, error } = await supabase
    .from("tipos_evento")
    .select("*")
    .order("ordem", { ascending: true });

  if (error) {
    console.error("Erro ao buscar tipos de evento:", error);
    return { data: [], error: error.message };
  }

  return { data: data || [], error: null };
}

export async function createTipoEvento(data: {
  nome: string;
  icone?: string;
  cor?: string;
}) {
  const supabase = await createClient();

  // Buscar a maior ordem atual
  const { data: maxOrdem } = await supabase
    .from("tipos_evento")
    .select("ordem")
    .order("ordem", { ascending: false })
    .limit(1)
    .single();

  const novaOrdem = (maxOrdem?.ordem || 0) + 1;

  const { data: tipo, error } = await supabase
    .from("tipos_evento")
    .insert({
      ...data,
      ordem: novaOrdem,
    })
    .select()
    .single();

  if (error) {
    console.error("Erro ao criar tipo de evento:", error);
    return { data: null, error: error.message };
  }

  revalidatePath("/configuracoes");
  revalidatePath("/eventos");
  revalidatePath("/leads");
  return { data: tipo, error: null };
}

export async function updateTipoEvento(
  id: string,
  data: Partial<{
    nome: string;
    icone: string;
    cor: string;
    ativo: boolean;
  }>
) {
  const supabase = await createClient();

  const { error } = await supabase
    .from("tipos_evento")
    .update(data)
    .eq("id", id);

  if (error) {
    console.error("Erro ao atualizar tipo de evento:", error);
    return { success: false, error: error.message };
  }

  revalidatePath("/configuracoes");
  revalidatePath("/eventos");
  revalidatePath("/leads");
  return { success: true, error: null };
}

export async function deleteTipoEvento(id: string) {
  const supabase = await createClient();

  // Verificar se há eventos usando este tipo
  const { count: eventosCount } = await supabase
    .from("eventos")
    .select("*", { count: "exact", head: true })
    .eq("tipo_id", id);

  if (eventosCount && eventosCount > 0) {
    return {
      success: false,
      error: "Este tipo possui eventos associados. Desative-o em vez de excluir.",
    };
  }

  // Verificar se há leads usando este tipo
  const { count: leadsCount } = await supabase
    .from("leads")
    .select("*", { count: "exact", head: true })
    .eq("tipo_servico_id", id);

  if (leadsCount && leadsCount > 0) {
    return {
      success: false,
      error: "Este tipo possui leads associados. Desative-o em vez de excluir.",
    };
  }

  const { error } = await supabase
    .from("tipos_evento")
    .delete()
    .eq("id", id);

  if (error) {
    console.error("Erro ao deletar tipo de evento:", error);
    return { success: false, error: error.message };
  }

  revalidatePath("/configuracoes");
  revalidatePath("/eventos");
  revalidatePath("/leads");
  return { success: true, error: null };
}

export async function reorderTiposEvento(tipos: { id: string; ordem: number }[]) {
  const supabase = await createClient();

  const updates = tipos.map((tipo) =>
    supabase
      .from("tipos_evento")
      .update({ ordem: tipo.ordem })
      .eq("id", tipo.id)
  );

  const results = await Promise.all(updates);
  const hasError = results.some((r) => r.error);

  if (hasError) {
    return { success: false, error: "Erro ao reordenar tipos de evento" };
  }

  revalidatePath("/configuracoes");
  revalidatePath("/eventos");
  return { success: true, error: null };
}


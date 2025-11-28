"use server";

import { createClient } from "@/lib/supabase/server";
import { revalidatePath } from "next/cache";
import { leadSchema, type LeadFormData } from "@/lib/validations/lead";

export async function getEtapasFunil() {
  const supabase = await createClient();

  const { data, error } = await supabase
    .from("etapas_funil")
    .select("*")
    .eq("ativo", true)
    .order("ordem", { ascending: true });

  if (error) {
    console.error("Erro ao buscar etapas:", error);
    return { data: [], error: error.message };
  }

  return { data: data || [], error: null };
}

export async function getLeadsByEtapa() {
  const supabase = await createClient();

  const { data: etapas } = await getEtapasFunil();

  const { data: leads, error } = await supabase
    .from("leads")
    .select(`
      *,
      contatos(id, nome),
      etapas_funil(id, nome, cor, ordem, is_final, is_perdido),
      users!leads_responsavel_id_fkey(id, nome, avatar_url)
    `)
    .order("created_at", { ascending: false });

  if (error) {
    console.error("Erro ao buscar leads:", error);
    return { etapas: [], leadsByEtapa: {}, error: error.message };
  }

  // Agrupar leads por etapa
  const leadsByEtapa: Record<string, typeof leads> = {};
  etapas.forEach((etapa) => {
    leadsByEtapa[etapa.id] = [];
  });

  leads?.forEach((lead) => {
    if (leadsByEtapa[lead.etapa_id]) {
      leadsByEtapa[lead.etapa_id].push(lead);
    }
  });

  return { etapas, leadsByEtapa, error: null };
}

export async function getLeadById(id: string) {
  const supabase = await createClient();

  const { data, error } = await supabase
    .from("leads")
    .select(`
      *,
      contatos(id, nome, telefone, email),
      etapas_funil(id, nome, cor),
      users!leads_responsavel_id_fkey(id, nome, avatar_url)
    `)
    .eq("id", id)
    .single();

  if (error) {
    console.error("Erro ao buscar lead:", error);
    return { data: null, error: error.message };
  }

  return { data, error: null };
}

export async function createLead(formData: LeadFormData) {
  const supabase = await createClient();

  const validatedData = leadSchema.safeParse(formData);
  if (!validatedData.success) {
    return { data: null, error: "Dados inválidos" };
  }

  const { data: { user } } = await supabase.auth.getUser();

  const { data, error } = await supabase
    .from("leads")
    .insert({
      ...validatedData.data,
      created_by: user?.id,
      responsavel_id: validatedData.data.responsavel_id || user?.id,
    })
    .select()
    .single();

  if (error) {
    console.error("Erro ao criar lead:", error);
    return { data: null, error: error.message };
  }

  revalidatePath("/leads");
  return { data, error: null };
}

export async function updateLead(id: string, formData: Partial<LeadFormData>) {
  const supabase = await createClient();

  const { data, error } = await supabase
    .from("leads")
    .update(formData)
    .eq("id", id)
    .select()
    .single();

  if (error) {
    console.error("Erro ao atualizar lead:", error);
    return { data: null, error: error.message };
  }

  revalidatePath("/leads");
  return { data, error: null };
}

export async function updateLeadEtapa(id: string, etapaId: string, motivoPerda?: string) {
  const supabase = await createClient();

  const updateData: { etapa_id: string; motivo_perda?: string } = {
    etapa_id: etapaId,
  };

  if (motivoPerda) {
    updateData.motivo_perda = motivoPerda;
  }

  const { data, error } = await supabase
    .from("leads")
    .update(updateData)
    .eq("id", id)
    .select()
    .single();

  if (error) {
    console.error("Erro ao atualizar etapa do lead:", error);
    return { data: null, error: error.message };
  }

  revalidatePath("/leads");
  return { data, error: null };
}

export async function deleteLead(id: string) {
  const supabase = await createClient();

  const { error } = await supabase.from("leads").delete().eq("id", id);

  if (error) {
    console.error("Erro ao deletar lead:", error);
    return { success: false, error: error.message };
  }

  revalidatePath("/leads");
  return { success: true, error: null };
}

export async function getContatos() {
  const supabase = await createClient();

  const { data, error } = await supabase
    .from("contatos")
    .select("id, nome, tipo")
    .order("nome", { ascending: true });

  if (error) {
    return { data: [], error: error.message };
  }

  return { data: data || [], error: null };
}

export async function getUsers() {
  const supabase = await createClient();

  const { data, error } = await supabase
    .from("users")
    .select("id, nome, avatar_url")
    .eq("ativo", true)
    .order("nome", { ascending: true });

  if (error) {
    return { data: [], error: error.message };
  }

  return { data: data || [], error: null };
}

// ==================== ESTATÍSTICAS DO DASHBOARD ====================

export interface EtapaEstatistica {
  id: string;
  nome: string;
  cor: string;
  quantidade: number;
}

export interface EstatisticasLeadsMes {
  total: number;
  valorTotal: number;
  porEtapa: EtapaEstatistica[];
}

/**
 * Retorna estatísticas de leads criados em um mês específico
 * Filtra por created_at do lead
 */
export async function getEstatisticasLeadsMes(mes?: string): Promise<EstatisticasLeadsMes> {
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

  const inicioMes = `${ano}-${String(mesNum).padStart(2, "0")}-01T00:00:00`;
  const ultimoDia = new Date(ano, mesNum, 0).getDate();
  const fimMes = `${ano}-${String(mesNum).padStart(2, "0")}-${String(ultimoDia).padStart(2, "0")}T23:59:59`;

  // Buscar leads do mês com etapa
  const { data: leads } = await supabase
    .from("leads")
    .select(`
      id,
      valor_estimado,
      etapa_id,
      etapas_funil(id, nome, cor)
    `)
    .gte("created_at", inicioMes)
    .lte("created_at", fimMes);

  // Buscar todas as etapas ativas para ter a lista completa
  const { data: etapas } = await supabase
    .from("etapas_funil")
    .select("id, nome, cor, ordem")
    .eq("ativo", true)
    .order("ordem", { ascending: true });

  // Calcular estatísticas
  let valorTotal = 0;
  const contagemPorEtapa: Record<string, number> = {};

  leads?.forEach((lead) => {
    valorTotal += lead.valor_estimado || 0;
    if (lead.etapa_id) {
      contagemPorEtapa[lead.etapa_id] = (contagemPorEtapa[lead.etapa_id] || 0) + 1;
    }
  });

  // Montar array de etapas com contagem
  const porEtapa: EtapaEstatistica[] = (etapas || []).map((etapa) => ({
    id: etapa.id,
    nome: etapa.nome,
    cor: etapa.cor,
    quantidade: contagemPorEtapa[etapa.id] || 0,
  }));

  return {
    total: leads?.length || 0,
    valorTotal,
    porEtapa,
  };
}


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


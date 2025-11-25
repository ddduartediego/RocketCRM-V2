"use server";

import { createClient } from "@/lib/supabase/server";
import { revalidatePath } from "next/cache";
import { contatoSchema, type ContatoFormData } from "@/lib/validations/contato";
import type { TipoContato } from "@/types/database";

export interface ContatosFilters {
  search?: string;
  tipo?: string;
  page?: number;
  perPage?: number;
}

export async function getContatos(filters: ContatosFilters = {}) {
  const supabase = await createClient();
  const { search, tipo, page = 1, perPage = 10 } = filters;

  let query = supabase
    .from("contatos")
    .select("*, organizacoes!contatos_organizacao_id_fkey(nome)", { count: "exact" })
    .order("nome", { ascending: true });

  if (search) {
    query = query.or(
      `nome.ilike.%${search}%,email.ilike.%${search}%,telefone.ilike.%${search}%,whatsapp.ilike.%${search}%`
    );
  }

  if (tipo && tipo !== "todos") {
    query = query.eq("tipo", tipo as TipoContato);
  }

  const from = (page - 1) * perPage;
  const to = from + perPage - 1;

  const { data, error, count } = await query.range(from, to);

  if (error) {
    console.error("Erro ao buscar contatos:", error);
    return { data: [], count: 0, error: error.message };
  }

  return { data: data || [], count: count || 0, error: null };
}

export async function getContatoById(id: string) {
  const supabase = await createClient();

  const { data, error } = await supabase
    .from("contatos")
    .select("*, organizacoes!contatos_organizacao_id_fkey(id, nome)")
    .eq("id", id)
    .single();

  if (error) {
    console.error("Erro ao buscar contato:", error);
    return { data: null, error: error.message };
  }

  return { data, error: null };
}

export async function createContato(formData: ContatoFormData) {
  const supabase = await createClient();

  const validatedData = contatoSchema.safeParse(formData);
  if (!validatedData.success) {
    return { data: null, error: "Dados inválidos" };
  }

  const { data: { user } } = await supabase.auth.getUser();

  const { data, error } = await supabase
    .from("contatos")
    .insert({
      ...validatedData.data,
      created_by: user?.id,
    })
    .select()
    .single();

  if (error) {
    console.error("Erro ao criar contato:", error);
    return { data: null, error: error.message };
  }

  revalidatePath("/contatos");
  return { data, error: null };
}

export async function updateContato(id: string, formData: ContatoFormData) {
  const supabase = await createClient();

  const validatedData = contatoSchema.safeParse(formData);
  if (!validatedData.success) {
    return { data: null, error: "Dados inválidos" };
  }

  const { data, error } = await supabase
    .from("contatos")
    .update(validatedData.data)
    .eq("id", id)
    .select()
    .single();

  if (error) {
    console.error("Erro ao atualizar contato:", error);
    return { data: null, error: error.message };
  }

  revalidatePath("/contatos");
  revalidatePath(`/contatos/${id}`);
  return { data, error: null };
}

export async function deleteContato(id: string) {
  const supabase = await createClient();

  const { error } = await supabase.from("contatos").delete().eq("id", id);

  if (error) {
    console.error("Erro ao deletar contato:", error);
    return { success: false, error: error.message };
  }

  revalidatePath("/contatos");
  return { success: true, error: null };
}

export async function getOrganizacoes() {
  const supabase = await createClient();

  const { data, error } = await supabase
    .from("organizacoes")
    .select("id, nome, tipo")
    .order("nome", { ascending: true });

  if (error) {
    console.error("Erro ao buscar organizações:", error);
    return { data: [], error: error.message };
  }

  return { data: data || [], error: null };
}


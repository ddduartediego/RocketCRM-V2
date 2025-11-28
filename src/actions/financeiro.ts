"use server";

import { createClient } from "@/lib/supabase/server";
import { revalidatePath } from "next/cache";
import {
  categoriaFinanceiraSchema,
  transacaoSchema,
  type CategoriaFinanceiraFormData,
  type TransacaoFormData,
} from "@/lib/validations/financeiro";
import type { TipoTransacao, StatusPagamento } from "@/types/database";

export interface TransacoesFilters {
  search?: string;
  tipo?: string;
  status?: string;
  categoria_id?: string;
  evento_id?: string;
  data_inicio?: string;
  data_fim?: string;
  page?: number;
  perPage?: number;
}

// ==================== CATEGORIAS ====================

export async function getCategorias(tipo?: string) {
  const supabase = await createClient();

  let query = supabase
    .from("categorias_financeiras")
    .select("*")
    .eq("ativo", true)
    .order("nome", { ascending: true });

  if (tipo && tipo !== "todos") {
    query = query.eq("tipo", tipo as TipoTransacao);
  }

  const { data, error } = await query;

  if (error) {
    console.error("Erro ao buscar categorias:", error);
    return { data: [], error: error.message };
  }

  return { data: data || [], error: null };
}

export async function createCategoria(formData: CategoriaFinanceiraFormData) {
  const supabase = await createClient();

  const validatedData = categoriaFinanceiraSchema.safeParse(formData);
  if (!validatedData.success) {
    return { data: null, error: "Dados inválidos" };
  }

  const { data, error } = await supabase
    .from("categorias_financeiras")
    .insert(validatedData.data)
    .select()
    .single();

  if (error) {
    console.error("Erro ao criar categoria:", error);
    return { data: null, error: error.message };
  }

  revalidatePath("/financeiro");
  return { data, error: null };
}

export async function updateCategoria(id: string, formData: Partial<CategoriaFinanceiraFormData>) {
  const supabase = await createClient();

  const { data, error } = await supabase
    .from("categorias_financeiras")
    .update(formData)
    .eq("id", id)
    .select()
    .single();

  if (error) {
    console.error("Erro ao atualizar categoria:", error);
    return { data: null, error: error.message };
  }

  revalidatePath("/financeiro");
  return { data, error: null };
}

export async function deleteCategoria(id: string) {
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

  revalidatePath("/financeiro");
  return { success: true, error: null };
}

// ==================== TRANSAÇÕES ====================

export async function getTransacoes(filters: TransacoesFilters = {}) {
  const supabase = await createClient();
  const {
    search,
    tipo,
    status,
    categoria_id,
    evento_id,
    data_inicio,
    data_fim,
    page = 1,
    perPage = 20,
  } = filters;

  let query = supabase
    .from("transacoes_financeiras")
    .select(
      `
      *,
      categorias_financeiras(id, nome, cor),
      eventos(id, nome),
      contatos(id, nome)
    `,
      { count: "exact" }
    )
    .order("data_vencimento", { ascending: false });

  if (search) {
    query = query.ilike("descricao", `%${search}%`);
  }

  if (tipo && tipo !== "todos") {
    query = query.eq("tipo", tipo as TipoTransacao);
  }

  if (status && status !== "todos") {
    query = query.eq("status", status as StatusPagamento);
  }

  if (categoria_id) {
    query = query.eq("categoria_id", categoria_id);
  }

  if (evento_id) {
    query = query.eq("evento_id", evento_id);
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
    console.error("Erro ao buscar transações:", error);
    return { data: [], count: 0, error: error.message };
  }

  return { data: data || [], count: count || 0, error: null };
}

export async function getTransacaoById(id: string) {
  const supabase = await createClient();

  const { data, error } = await supabase
    .from("transacoes_financeiras")
    .select(
      `
      *,
      categorias_financeiras(id, nome, cor),
      eventos(id, nome),
      contatos(id, nome)
    `
    )
    .eq("id", id)
    .single();

  if (error) {
    console.error("Erro ao buscar transação:", error);
    return { data: null, error: error.message };
  }

  return { data, error: null };
}

export async function createTransacao(formData: TransacaoFormData) {
  const supabase = await createClient();

  const validatedData = transacaoSchema.safeParse(formData);
  if (!validatedData.success) {
    return { data: null, error: "Dados inválidos" };
  }

  const {
    data: { user },
  } = await supabase.auth.getUser();

  const { data, error } = await supabase
    .from("transacoes_financeiras")
    .insert({
      ...validatedData.data,
      created_by: user?.id,
    })
    .select()
    .single();

  if (error) {
    console.error("Erro ao criar transação:", error);
    return { data: null, error: error.message };
  }

  revalidatePath("/financeiro");
  revalidatePath("/");
  return { data, error: null };
}

export async function updateTransacao(id: string, formData: Partial<TransacaoFormData>) {
  const supabase = await createClient();

  const { data, error } = await supabase
    .from("transacoes_financeiras")
    .update(formData)
    .eq("id", id)
    .select()
    .single();

  if (error) {
    console.error("Erro ao atualizar transação:", error);
    return { data: null, error: error.message };
  }

  revalidatePath("/financeiro");
  revalidatePath(`/financeiro/${id}`);
  revalidatePath("/");
  return { data, error: null };
}

export async function deleteTransacao(id: string) {
  const supabase = await createClient();

  const { error } = await supabase
    .from("transacoes_financeiras")
    .delete()
    .eq("id", id);

  if (error) {
    console.error("Erro ao deletar transação:", error);
    return { success: false, error: error.message };
  }

  revalidatePath("/financeiro");
  revalidatePath("/");
  return { success: true, error: null };
}

export async function marcarComoPago(id: string, dataPagamento?: string) {
  const supabase = await createClient();

  const { data, error } = await supabase
    .from("transacoes_financeiras")
    .update({
      status: "pago",
      data_pagamento: dataPagamento || new Date().toISOString().split("T")[0],
    })
    .eq("id", id)
    .select()
    .single();

  if (error) {
    console.error("Erro ao marcar como pago:", error);
    return { data: null, error: error.message };
  }

  revalidatePath("/financeiro");
  revalidatePath("/");
  return { data, error: null };
}

// ==================== RESUMOS E ESTATÍSTICAS ====================

export async function getResumoFinanceiro(mes?: string) {
  const supabase = await createClient();

  // Se não passar mês, usa o mês atual
  // Usa abordagem timezone-safe para evitar problemas com UTC
  let ano: number;
  let mesNum: number;
  
  if (mes) {
    // Formato esperado: "YYYY-MM"
    const [anoStr, mesStr] = mes.split("-");
    ano = parseInt(anoStr, 10);
    mesNum = parseInt(mesStr, 10);
  } else {
    // Usa a data atual no timezone local do servidor
    const agora = new Date();
    ano = agora.getFullYear();
    mesNum = agora.getMonth() + 1; // getMonth() retorna 0-11
  }
  
  // Constrói as datas como strings para evitar conversões de timezone
  const inicioMes = `${ano}-${String(mesNum).padStart(2, "0")}-01`;
  // Último dia do mês: cria uma data do próximo mês e subtrai um dia
  const ultimoDia = new Date(ano, mesNum, 0).getDate();
  const fimMes = `${ano}-${String(mesNum).padStart(2, "0")}-${String(ultimoDia).padStart(2, "0")}`;

  // Buscar todas as transações do mês
  const { data: transacoes } = await supabase
    .from("transacoes_financeiras")
    .select("tipo, valor, status")
    .gte("data_vencimento", inicioMes)
    .lte("data_vencimento", fimMes);

  // Calcular totais
  let receitasRealizadas = 0;
  let receitasPendentes = 0;
  let despesasRealizadas = 0;
  let despesasPendentes = 0;

  transacoes?.forEach((t) => {
    if (t.tipo === "receita") {
      if (t.status === "pago") {
        receitasRealizadas += t.valor;
      } else if (t.status === "pendente") {
        receitasPendentes += t.valor;
      }
    } else {
      if (t.status === "pago") {
        despesasRealizadas += t.valor;
      } else if (t.status === "pendente") {
        despesasPendentes += t.valor;
      }
    }
  });

  // Buscar transações em atraso
  const hoje = new Date().toISOString().split("T")[0];
  const { count: emAtraso } = await supabase
    .from("transacoes_financeiras")
    .select("*", { count: "exact", head: true })
    .eq("status", "pendente")
    .lt("data_vencimento", hoje);

  return {
    receitasRealizadas,
    receitasPendentes,
    despesasRealizadas,
    despesasPendentes,
    saldoRealizado: receitasRealizadas - despesasRealizadas,
    saldoPrevisto:
      receitasRealizadas +
      receitasPendentes -
      despesasRealizadas -
      despesasPendentes,
    emAtraso: emAtraso || 0,
  };
}

export async function getTransacoesPorCategoria(mes?: string, tipo?: string) {
  const supabase = await createClient();

  // Usa abordagem timezone-safe para evitar problemas com UTC
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

  let query = supabase
    .from("transacoes_financeiras")
    .select(
      `
      valor,
      categorias_financeiras(id, nome, cor)
    `
    )
    .gte("data_vencimento", inicioMes)
    .lte("data_vencimento", fimMes)
    .eq("status", "pago");

  if (tipo && tipo !== "todos") {
    query = query.eq("tipo", tipo as TipoTransacao);
  }

  const { data } = await query;

  // Agrupar por categoria
  const porCategoria: Record<string, { nome: string; cor: string; valor: number }> = {};
  
  data?.forEach((t) => {
    const catId = (t.categorias_financeiras as { id: string; nome: string; cor: string } | null)?.id || "sem_categoria";
    const catNome = (t.categorias_financeiras as { id: string; nome: string; cor: string } | null)?.nome || "Sem Categoria";
    const catCor = (t.categorias_financeiras as { id: string; nome: string; cor: string } | null)?.cor || "#6b7280";
    
    if (!porCategoria[catId]) {
      porCategoria[catId] = { nome: catNome, cor: catCor, valor: 0 };
    }
    porCategoria[catId].valor += t.valor;
  });

  return Object.values(porCategoria).sort((a, b) => b.valor - a.valor);
}

export async function getFluxoCaixaMensal(ano?: number) {
  const supabase = await createClient();
  const anoAtual = ano || new Date().getFullYear();

  const { data } = await supabase
    .from("transacoes_financeiras")
    .select("tipo, valor, data_vencimento")
    .gte("data_vencimento", `${anoAtual}-01-01`)
    .lte("data_vencimento", `${anoAtual}-12-31`)
    .eq("status", "pago");

  // Agrupar por mês
  const meses = [
    "Jan", "Fev", "Mar", "Abr", "Mai", "Jun",
    "Jul", "Ago", "Set", "Out", "Nov", "Dez",
  ];

  const fluxo = meses.map((mes, index) => ({
    mes,
    receitas: 0,
    despesas: 0,
  }));

  data?.forEach((t) => {
    const mesIndex = new Date(t.data_vencimento).getMonth();
    if (t.tipo === "receita") {
      fluxo[mesIndex].receitas += t.valor;
    } else {
      fluxo[mesIndex].despesas += t.valor;
    }
  });

  return fluxo;
}

export async function getTransacoesEvento(eventoId: string) {
  const supabase = await createClient();

  const { data, error } = await supabase
    .from("transacoes_financeiras")
    .select(
      `
      *,
      categorias_financeiras(id, nome, cor)
    `
    )
    .eq("evento_id", eventoId)
    .order("data_vencimento", { ascending: true });

  if (error) {
    console.error("Erro ao buscar transações do evento:", error);
    return { data: [], error: error.message };
  }

  // Calcular totais
  let totalReceitas = 0;
  let totalDespesas = 0;

  data?.forEach((t) => {
    if (t.tipo === "receita") {
      totalReceitas += t.valor;
    } else {
      totalDespesas += t.valor;
    }
  });

  return {
    data: data || [],
    totalReceitas,
    totalDespesas,
    lucro: totalReceitas - totalDespesas,
    error: null,
  };
}

export interface ResumoFinanceiroEvento {
  evento_id: string;
  totalReceitas: number;
  totalDespesas: number;
  receitasPagas: number;
  receitasPendentes: number;
}

/**
 * Retorna resumo financeiro para múltiplos eventos de uma vez
 * Usado para mostrar indicadores na lista de eventos
 */
export async function getResumosFinanceirosEventos(eventoIds: string[]): Promise<{
  data: Record<string, ResumoFinanceiroEvento>;
  error: string | null;
}> {
  if (eventoIds.length === 0) {
    return { data: {}, error: null };
  }

  const supabase = await createClient();

  const { data, error } = await supabase
    .from("transacoes_financeiras")
    .select("evento_id, tipo, valor, status")
    .in("evento_id", eventoIds);

  if (error) {
    console.error("Erro ao buscar resumos financeiros:", error);
    return { data: {}, error: error.message };
  }

  // Agrupar por evento
  const resumos: Record<string, ResumoFinanceiroEvento> = {};

  // Inicializar todos os eventos com valores zero
  eventoIds.forEach((id) => {
    resumos[id] = {
      evento_id: id,
      totalReceitas: 0,
      totalDespesas: 0,
      receitasPagas: 0,
      receitasPendentes: 0,
    };
  });

  // Processar transações
  data?.forEach((t) => {
    if (!t.evento_id) return;
    
    const resumo = resumos[t.evento_id];
    if (!resumo) return;

    if (t.tipo === "receita") {
      resumo.totalReceitas += t.valor;
      if (t.status === "pago") {
        resumo.receitasPagas += t.valor;
      } else if (t.status === "pendente") {
        resumo.receitasPendentes += t.valor;
      }
    } else {
      resumo.totalDespesas += t.valor;
    }
  });

  return { data: resumos, error: null };
}


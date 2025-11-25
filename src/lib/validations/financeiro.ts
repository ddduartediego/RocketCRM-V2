import { z } from "zod";

export const tiposTransacao = [
  { value: "receita", label: "Receita", color: "#22c55e" },
  { value: "despesa", label: "Despesa", color: "#dc2626" },
] as const;

export const statusPagamento = [
  { value: "pendente", label: "Pendente", color: "#eab308" },
  { value: "pago", label: "Pago", color: "#22c55e" },
  { value: "em_atraso", label: "Em Atraso", color: "#dc2626" },
  { value: "cancelado", label: "Cancelado", color: "#6b7280" },
] as const;

export const formasPagamento = [
  { value: "pix", label: "PIX" },
  { value: "dinheiro", label: "Dinheiro" },
  { value: "cartao_credito", label: "Cartão de Crédito" },
  { value: "cartao_debito", label: "Cartão de Débito" },
  { value: "boleto", label: "Boleto" },
  { value: "transferencia", label: "Transferência" },
  { value: "cheque", label: "Cheque" },
  { value: "outro", label: "Outro" },
] as const;

export const categoriaFinanceiraSchema = z.object({
  nome: z.string().min(2, "Nome deve ter no mínimo 2 caracteres"),
  tipo: z.enum(["receita", "despesa"]),
  cor: z.string().optional().nullable(),
  ativo: z.boolean().optional(),
});

export type CategoriaFinanceiraFormData = z.infer<typeof categoriaFinanceiraSchema>;

export const transacaoSchema = z.object({
  descricao: z.string().min(2, "Descrição deve ter no mínimo 2 caracteres"),
  tipo: z.enum(["receita", "despesa"]),
  valor: z.coerce.number().min(0.01, "Valor deve ser maior que zero"),
  data_vencimento: z.string().min(1, "Data de vencimento é obrigatória"),
  data_pagamento: z.string().optional().nullable(),
  status: z.enum(["pendente", "pago", "em_atraso", "cancelado"]).optional(),
  forma_pagamento: z.string().optional().nullable(),
  categoria_id: z.string().uuid().optional().nullable(),
  evento_id: z.string().uuid().optional().nullable(),
  contato_id: z.string().uuid().optional().nullable(),
  observacoes: z.string().optional().nullable(),
  comprovante_url: z.string().optional().nullable(),
});

export type TransacaoFormData = z.infer<typeof transacaoSchema>;


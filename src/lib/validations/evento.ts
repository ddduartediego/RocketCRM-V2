import { z } from "zod";

export const eventoSchema = z.object({
  nome: z.string().min(2, "Nome deve ter pelo menos 2 caracteres"),
  tipo_id: z.string().uuid("Tipo de evento é obrigatório"),
  descricao: z.string().optional().nullable(),
  cliente_id: z.string().uuid().optional().nullable(),
  lead_id: z.string().uuid().optional().nullable(),
  data_inicio: z.string().min(1, "Data de início é obrigatória"),
  data_fim: z.string().optional().nullable(),
  hora_inicio: z.string().optional().nullable(),
  hora_fim: z.string().optional().nullable(),
  local: z.string().optional().nullable(),
  endereco_local: z.string().optional().nullable(),
  status: z.enum([
    "planejamento",
    "confirmado",
    "em_andamento",
    "realizado",
    "cancelado",
  ]).optional(),
  valor_total: z.union([z.number().min(0), z.null()]).optional(),
  valor_sinal: z.union([z.number().min(0), z.null()]).optional(),
  forma_pagamento: z.string().optional().nullable(),
  condicoes_pagamento: z.string().optional().nullable(),
  observacoes: z.string().optional().nullable(),
  responsavel_id: z.string().uuid().optional().nullable(),
});

export type EventoFormData = z.infer<typeof eventoSchema>;

export const statusEventoOptions = [
  { value: "planejamento", label: "Planejamento", color: "#0ea5e9" },
  { value: "confirmado", label: "Confirmado", color: "#22c55e" },
  { value: "em_andamento", label: "Em Andamento", color: "#eab308" },
  { value: "realizado", label: "Realizado", color: "#8b5cf6" },
  { value: "cancelado", label: "Cancelado", color: "#dc2626" },
] as const;

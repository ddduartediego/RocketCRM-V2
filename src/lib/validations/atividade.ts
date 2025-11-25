import { z } from "zod";

export const statusAtividade = [
  { value: "pendente", label: "Pendente", color: "#eab308" },
  { value: "em_andamento", label: "Em Andamento", color: "#0ea5e9" },
  { value: "concluida", label: "Concluída", color: "#22c55e" },
  { value: "cancelada", label: "Cancelada", color: "#6b7280" },
] as const;

export const prioridadeAtividade = [
  { value: 1, label: "Baixa", color: "#22c55e" },
  { value: 2, label: "Média", color: "#eab308" },
  { value: 3, label: "Alta", color: "#f97316" },
  { value: 4, label: "Urgente", color: "#dc2626" },
] as const;

export const atividadeSchema = z.object({
  titulo: z.string().min(2, "Título deve ter no mínimo 2 caracteres"),
  descricao: z.string().optional().nullable(),
  status: z.enum(["pendente", "em_andamento", "concluida", "cancelada"]).default("pendente"),
  prioridade: z.coerce.number().min(1).max(4).default(2),
  data_vencimento: z.string().optional().nullable(),
  responsavel_id: z.string().uuid().optional().nullable(),
  evento_id: z.string().uuid().optional().nullable(),
  lead_id: z.string().uuid().optional().nullable(),
  contato_id: z.string().uuid().optional().nullable(),
});

export type AtividadeFormData = z.infer<typeof atividadeSchema>;


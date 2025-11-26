import { z } from "zod";

export const funcoesEquipe = [
  { value: "monitor", label: "Monitor" },
  { value: "recreador", label: "Recreador" },
  { value: "coordenador", label: "Coordenador" },
  { value: "motorista", label: "Motorista" },
  { value: "outro", label: "Outro" },
] as const;

export const tiposContrato = [
  { value: "fixo", label: "Fixo" },
  { value: "freelancer", label: "Freelancer" },
] as const;

export const membroEquipeSchema = z.object({
  nome: z.string().min(2, "Nome deve ter no mínimo 2 caracteres"),
  funcao: z.enum(["monitor", "recreador", "coordenador", "motorista", "outro"]),
  tipo_contrato: z.enum(["fixo", "freelancer"]),
  telefone: z.string().optional().nullable(),
  whatsapp: z.string().optional().nullable(),
  email: z.string().email("E-mail inválido").optional().nullable().or(z.literal("")),
  documento: z.string().optional().nullable(),
  valor_diaria: z.union([z.number().min(0), z.null()]).optional(),
  observacoes: z.string().optional().nullable(),
  ativo: z.boolean().optional(),
});

export type MembroEquipeFormData = z.infer<typeof membroEquipeSchema>;

export const alocacaoEquipeSchema = z.object({
  membro_id: z.string().uuid("Selecione um membro"),
  evento_id: z.string().uuid("Selecione um evento"),
  data: z.string().min(1, "Data é obrigatória"),
  hora_inicio: z.string().optional().nullable(),
  hora_fim: z.string().optional().nullable(),
  funcao_evento: z.string().optional().nullable(),
  valor_pago: z.union([z.number().min(0), z.null()]).optional(),
  observacoes: z.string().optional().nullable(),
});

export type AlocacaoEquipeFormData = z.infer<typeof alocacaoEquipeSchema>;


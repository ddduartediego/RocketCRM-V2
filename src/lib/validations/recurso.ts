import { z } from "zod";

export const tiposRecurso = [
  { value: "brinquedo", label: "Brinquedo" },
  { value: "veiculo", label: "Veículo" },
  { value: "espaco", label: "Espaço" },
  { value: "equipamento", label: "Equipamento" },
  { value: "outro", label: "Outro" },
] as const;

export const recursoSchema = z.object({
  nome: z.string().min(2, "Nome deve ter no mínimo 2 caracteres"),
  tipo: z.enum(["brinquedo", "veiculo", "espaco", "equipamento", "outro"]),
  descricao: z.string().optional().nullable(),
  quantidade: z.coerce.number().min(1, "Quantidade mínima é 1").optional(),
  capacidade: z.coerce.number().min(0).optional().nullable(),
  custo_unitario: z.coerce.number().min(0).optional().nullable(),
  observacoes: z.string().optional().nullable(),
  ativo: z.boolean().optional(),
});

export type RecursoFormData = z.infer<typeof recursoSchema>;

export const alocacaoRecursoSchema = z.object({
  recurso_id: z.string().uuid("Selecione um recurso"),
  evento_id: z.string().uuid("Selecione um evento"),
  quantidade: z.coerce.number().min(1, "Quantidade mínima é 1"),
  valor: z.coerce.number().min(0, "Valor deve ser positivo").optional().nullable(),
  data_inicio: z.string().min(1, "Data de início é obrigatória"),
  data_fim: z.string().min(1, "Data de fim é obrigatória"),
  observacoes: z.string().optional().nullable(),
});

export type AlocacaoRecursoFormData = z.infer<typeof alocacaoRecursoSchema>;


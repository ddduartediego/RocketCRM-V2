import { z } from "zod";

export const leadSchema = z.object({
  titulo: z.string().min(2, "Título deve ter pelo menos 2 caracteres"),
  descricao: z.string().optional().nullable(),
  valor_estimado: z.coerce.number().min(0, "Valor deve ser maior ou igual a 0").default(0),
  etapa_id: z.string().uuid("Selecione uma etapa"),
  contato_id: z.string().uuid().optional().nullable(),
  organizacao_id: z.string().uuid().optional().nullable(),
  tipo_servico: z.enum([
    "colonia_ferias",
    "festa_infantil",
    "gincana",
    "outro",
  ]).optional().nullable(),
  origem: z.string().optional().nullable(),
  data_prevista: z.string().optional().nullable(),
  motivo_perda: z.string().optional().nullable(),
  responsavel_id: z.string().uuid().optional().nullable(),
});

export type LeadFormData = z.infer<typeof leadSchema>;

export const tipoServicoOptions = [
  { value: "colonia_ferias", label: "Colônia de Férias" },
  { value: "festa_infantil", label: "Festa Infantil" },
  { value: "gincana", label: "Gincana" },
  { value: "outro", label: "Outro" },
] as const;

export const origemOptions = [
  { value: "whatsapp", label: "WhatsApp" },
  { value: "instagram", label: "Instagram" },
  { value: "facebook", label: "Facebook" },
  { value: "indicacao", label: "Indicação" },
  { value: "feira", label: "Feira/Evento" },
  { value: "site", label: "Site" },
  { value: "telefone", label: "Telefone" },
  { value: "outro", label: "Outro" },
] as const;


"use client";

import { useEffect, useState } from "react";
import { useForm, type Resolver } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import {
  Form,
  FormControl,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from "@/components/ui/form";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import { Textarea } from "@/components/ui/textarea";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import {
  leadSchema,
  type LeadFormData,
  tipoServicoOptions,
  origemOptions,
} from "@/lib/validations/lead";
import { createLead, updateLead, getContatos } from "@/actions/leads";
import { toast } from "sonner";
import { Plus } from "lucide-react";
import type { Contato, EtapaFunil, Lead } from "@/types/database";
import { ContatoForm } from "@/components/modules/contatos/contato-form";

interface LeadFormProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  lead?: Lead | null;
  etapas: EtapaFunil[];
}

export function LeadForm({ open, onOpenChange, lead, etapas }: LeadFormProps) {
  const isEditing = !!lead;
  const [contatos, setContatos] = useState<{ id: string; nome: string }[]>([]);
  const [contatoFormOpen, setContatoFormOpen] = useState(false);

  const form = useForm<LeadFormData>({
    resolver: zodResolver(leadSchema) as Resolver<LeadFormData>,
    defaultValues: {
      titulo: "",
      descricao: "",
      valor_estimado: 0,
      etapa_id: etapas[0]?.id || "",
      contato_id: null,
      tipo_servico: null,
      origem: null,
      data_prevista: "",
    },
  });

  useEffect(() => {
    const loadData = async () => {
      const contatosRes = await getContatos();
      setContatos(contatosRes.data);
    };
    if (open) {
      loadData();
    }
  }, [open]);

  useEffect(() => {
    if (lead) {
      form.reset({
        titulo: lead.titulo,
        descricao: lead.descricao || "",
        valor_estimado: lead.valor_estimado || 0,
        etapa_id: lead.etapa_id,
        contato_id: lead.contato_id,
        tipo_servico: lead.tipo_servico,
        origem: lead.origem || "",
        data_prevista: lead.data_prevista || "",
      });
    } else {
      form.reset({
        titulo: "",
        descricao: "",
        valor_estimado: 0,
        etapa_id: etapas[0]?.id || "",
        contato_id: null,
        tipo_servico: null,
        origem: null,
        data_prevista: "",
      });
    }
  }, [lead, form, etapas]);

  const onSubmit = async (data: LeadFormData) => {
    try {
      const result = isEditing
        ? await updateLead(lead!.id, data)
        : await createLead(data);

      if (result.error) {
        toast.error(isEditing ? "Erro ao atualizar" : "Erro ao criar", {
          description: result.error,
        });
        return;
      }

      toast.success(isEditing ? "Lead atualizado!" : "Lead criado!", {
        description: `${data.titulo} foi ${isEditing ? "atualizado" : "adicionado"} com sucesso.`,
      });

      onOpenChange(false);
    } catch {
      toast.error("Erro inesperado", {
        description: "Tente novamente mais tarde.",
      });
    }
  };

  const handleContatoCreated = (novoContato: Contato) => {
    setContatos((prev) => [...prev, { id: novoContato.id, nome: novoContato.nome }]);
    form.setValue("contato_id", novoContato.id);
  };

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="max-w-2xl max-h-[90vh] overflow-y-auto">
        <DialogHeader>
          <DialogTitle>{isEditing ? "Editar Lead" : "Novo Lead"}</DialogTitle>
          <DialogDescription>
            {isEditing
              ? "Atualize as informações do lead"
              : "Preencha os dados para criar um novo lead"}
          </DialogDescription>
        </DialogHeader>

        <Form {...form}>
          <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-4">
            <div className="grid grid-cols-2 gap-4">
              <FormField
                control={form.control}
                name="titulo"
                render={({ field }) => (
                  <FormItem className="col-span-2">
                    <FormLabel>Título *</FormLabel>
                    <FormControl>
                      <Input placeholder="Ex: Recreação Encerramento 2025" {...field} />
                    </FormControl>
                    <FormMessage />
                  </FormItem>
                )}
              />

              <FormField
                control={form.control}
                name="etapa_id"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>Etapa *</FormLabel>
                    <Select onValueChange={field.onChange} value={field.value}>
                      <FormControl>
                        <SelectTrigger>
                          <SelectValue placeholder="Selecione a etapa" />
                        </SelectTrigger>
                      </FormControl>
                      <SelectContent>
                        {etapas.map((etapa) => (
                          <SelectItem key={etapa.id} value={etapa.id}>
                            <div className="flex items-center gap-2">
                              <div
                                className="w-2 h-2 rounded-full"
                                style={{ backgroundColor: etapa.cor }}
                              />
                              {etapa.nome}
                            </div>
                          </SelectItem>
                        ))}
                      </SelectContent>
                    </Select>
                    <FormMessage />
                  </FormItem>
                )}
              />

              <FormField
                control={form.control}
                name="valor_estimado"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>Valor Estimado (R$)</FormLabel>
                    <FormControl>
                      <Input
                        type="number"
                        step="0.01"
                        placeholder="0,00"
                        {...field}
                      />
                    </FormControl>
                    <FormMessage />
                  </FormItem>
                )}
              />

              <FormField
                control={form.control}
                name="tipo_servico"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>Tipo de Serviço</FormLabel>
                    <Select
                      onValueChange={field.onChange}
                      value={field.value || ""}
                    >
                      <FormControl>
                        <SelectTrigger>
                          <SelectValue placeholder="Selecione" />
                        </SelectTrigger>
                      </FormControl>
                      <SelectContent>
                        {tipoServicoOptions.map((option) => (
                          <SelectItem key={option.value} value={option.value}>
                            {option.label}
                          </SelectItem>
                        ))}
                      </SelectContent>
                    </Select>
                    <FormMessage />
                  </FormItem>
                )}
              />

              <FormField
                control={form.control}
                name="origem"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>Origem</FormLabel>
                    <Select
                      onValueChange={field.onChange}
                      value={field.value || ""}
                    >
                      <FormControl>
                        <SelectTrigger>
                          <SelectValue placeholder="Selecione" />
                        </SelectTrigger>
                      </FormControl>
                      <SelectContent>
                        {origemOptions.map((option) => (
                          <SelectItem key={option.value} value={option.value}>
                            {option.label}
                          </SelectItem>
                        ))}
                      </SelectContent>
                    </Select>
                    <FormMessage />
                  </FormItem>
                )}
              />

              <FormField
                control={form.control}
                name="contato_id"
                render={({ field }) => (
                  <FormItem className="flex-1">
                    <FormLabel>Contato</FormLabel>
                    <div className="flex gap-2">
                      <Select
                        onValueChange={field.onChange}
                        value={field.value || ""}
                      >
                        <FormControl>
                          <SelectTrigger>
                            <SelectValue placeholder="Selecione" />
                          </SelectTrigger>
                        </FormControl>
                        <SelectContent>
                          {contatos.map((contato) => (
                            <SelectItem key={contato.id} value={contato.id}>
                              {contato.nome}
                            </SelectItem>
                          ))}
                        </SelectContent>
                      </Select>
                      <Button
                        type="button"
                        variant="outline"
                        size="icon"
                        onClick={() => setContatoFormOpen(true)}
                        title="Novo contato"
                      >
                        <Plus className="w-4 h-4" />
                      </Button>
                    </div>
                    <FormMessage />
                  </FormItem>
                )}
              />

              <FormField
                control={form.control}
                name="data_prevista"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>Data Prevista</FormLabel>
                    <FormControl>
                      <Input type="date" {...field} value={field.value || ""} />
                    </FormControl>
                    <FormMessage />
                  </FormItem>
                )}
              />

              <FormField
                control={form.control}
                name="descricao"
                render={({ field }) => (
                  <FormItem className="col-span-2">
                    <FormLabel>Descrição</FormLabel>
                    <FormControl>
                      <Textarea
                        placeholder="Detalhes sobre o lead..."
                        className="min-h-[80px]"
                        {...field}
                        value={field.value || ""}
                      />
                    </FormControl>
                    <FormMessage />
                  </FormItem>
                )}
              />
            </div>

            <div className="flex justify-end gap-3 pt-4 border-t">
              <Button
                type="button"
                variant="outline"
                onClick={() => onOpenChange(false)}
              >
                Cancelar
              </Button>
              <Button type="submit" disabled={form.formState.isSubmitting}>
                {form.formState.isSubmitting
                  ? "Salvando..."
                  : isEditing
                    ? "Salvar alterações"
                    : "Criar lead"}
              </Button>
            </div>
          </form>
        </Form>
      </DialogContent>

      <ContatoForm
        open={contatoFormOpen}
        onOpenChange={setContatoFormOpen}
        onCreated={handleContatoCreated}
      />
    </Dialog>
  );
}


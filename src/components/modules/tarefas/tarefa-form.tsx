"use client";

import { useEffect, useState } from "react";
import { useForm, type Resolver } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import {
  Dialog,
  DialogContent,
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
import { toast } from "sonner";
import {
  atividadeSchema,
  statusAtividade,
  prioridadeAtividade,
  type AtividadeFormData,
} from "@/lib/validations/atividade";
import { createAtividade, updateAtividade } from "@/actions/atividades";
import { getEventos } from "@/actions/eventos";
import type { Atividade } from "@/types/database";
import type { Evento } from "@/types/database";

interface TarefaFormProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  tarefa?: Atividade | null;
  eventoId?: string;
}

export function TarefaForm({
  open,
  onOpenChange,
  tarefa,
  eventoId,
}: TarefaFormProps) {
  const isEditing = !!tarefa;
  const [eventos, setEventos] = useState<Evento[]>([]);

  const form = useForm<AtividadeFormData>({
    resolver: zodResolver(atividadeSchema) as Resolver<AtividadeFormData>,
    defaultValues: {
      titulo: "",
      descricao: "",
      status: "pendente",
      prioridade: 2,
      data_vencimento: null,
      responsavel_id: null,
      evento_id: eventoId || null,
      lead_id: null,
      contato_id: null,
    },
  });

  useEffect(() => {
    if (open) {
      getEventos().then((result) => {
        if (result.data) {
          setEventos(result.data);
        }
      });
    }
  }, [open]);

  useEffect(() => {
    if (tarefa) {
      form.reset({
        titulo: tarefa.titulo,
        descricao: tarefa.descricao || "",
        status: tarefa.status,
        prioridade: tarefa.prioridade || 2,
        data_vencimento: tarefa.data_vencimento,
        responsavel_id: tarefa.responsavel_id,
        evento_id: tarefa.evento_id || eventoId || null,
        lead_id: tarefa.lead_id,
        contato_id: tarefa.contato_id,
      });
    } else {
      form.reset({
        titulo: "",
        descricao: "",
        status: "pendente",
        prioridade: 2,
        data_vencimento: null,
        responsavel_id: null,
        evento_id: eventoId || null,
        lead_id: null,
        contato_id: null,
      });
    }
  }, [tarefa, eventoId, form]);

  async function onSubmit(data: AtividadeFormData) {
    try {
      const result = isEditing
        ? await updateAtividade(tarefa.id, data)
        : await createAtividade(data);

      if (result.error) {
        toast.error(result.error);
        return;
      }

      toast.success(
        isEditing
          ? "Tarefa atualizada com sucesso!"
          : "Tarefa criada com sucesso!"
      );
      onOpenChange(false);
      form.reset();
    } catch {
      toast.error("Ocorreu um erro. Tente novamente.");
    }
  }

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="max-w-lg">
        <DialogHeader>
          <DialogTitle>{isEditing ? "Editar Tarefa" : "Nova Tarefa"}</DialogTitle>
        </DialogHeader>

        <Form {...form}>
          <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-4">
            <FormField
              control={form.control}
              name="titulo"
              render={({ field }) => (
                <FormItem>
                  <FormLabel>Título *</FormLabel>
                  <FormControl>
                    <Input placeholder="Ex: Confirmar reserva do ônibus" {...field} />
                  </FormControl>
                  <FormMessage />
                </FormItem>
              )}
            />

            <FormField
              control={form.control}
              name="descricao"
              render={({ field }) => (
                <FormItem>
                  <FormLabel>Descrição</FormLabel>
                  <FormControl>
                    <Textarea
                      placeholder="Detalhes da tarefa..."
                      className="resize-none"
                      rows={3}
                      {...field}
                      value={field.value || ""}
                    />
                  </FormControl>
                  <FormMessage />
                </FormItem>
              )}
            />

            <div className="grid grid-cols-2 gap-4">
              <FormField
                control={form.control}
                name="prioridade"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>Prioridade</FormLabel>
                    <Select
                      onValueChange={(value) => field.onChange(Number(value))}
                      defaultValue={field.value?.toString()}
                    >
                      <FormControl>
                        <SelectTrigger>
                          <SelectValue placeholder="Selecione" />
                        </SelectTrigger>
                      </FormControl>
                      <SelectContent>
                        {prioridadeAtividade.map((p) => (
                          <SelectItem key={p.value} value={p.value.toString()}>
                            <div className="flex items-center gap-2">
                              <div
                                className="w-2 h-2 rounded-full"
                                style={{ backgroundColor: p.color }}
                              />
                              {p.label}
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
                name="status"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>Status</FormLabel>
                    <Select onValueChange={field.onChange} defaultValue={field.value}>
                      <FormControl>
                        <SelectTrigger>
                          <SelectValue placeholder="Selecione" />
                        </SelectTrigger>
                      </FormControl>
                      <SelectContent>
                        {statusAtividade.map((s) => (
                          <SelectItem key={s.value} value={s.value}>
                            <div className="flex items-center gap-2">
                              <div
                                className="w-2 h-2 rounded-full"
                                style={{ backgroundColor: s.color }}
                              />
                              {s.label}
                            </div>
                          </SelectItem>
                        ))}
                      </SelectContent>
                    </Select>
                    <FormMessage />
                  </FormItem>
                )}
              />
            </div>

            <FormField
              control={form.control}
              name="data_vencimento"
              render={({ field }) => (
                <FormItem>
                  <FormLabel>Data de Vencimento</FormLabel>
                  <FormControl>
                    <Input type="date" {...field} value={field.value || ""} />
                  </FormControl>
                  <FormMessage />
                </FormItem>
              )}
            />

            {!eventoId && (
              <FormField
                control={form.control}
                name="evento_id"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>Evento Relacionado</FormLabel>
                    <Select
                      onValueChange={field.onChange}
                      value={field.value || undefined}
                    >
                      <FormControl>
                        <SelectTrigger>
                          <SelectValue placeholder="Selecione (opcional)" />
                        </SelectTrigger>
                      </FormControl>
                      <SelectContent>
                        {eventos.map((evento) => (
                          <SelectItem key={evento.id} value={evento.id}>
                            {evento.nome}
                          </SelectItem>
                        ))}
                      </SelectContent>
                    </Select>
                    <FormMessage />
                  </FormItem>
                )}
              />
            )}

            <div className="flex justify-end gap-3 pt-4">
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
                  ? "Atualizar"
                  : "Criar Tarefa"}
              </Button>
            </div>
          </form>
        </Form>
      </DialogContent>
    </Dialog>
  );
}


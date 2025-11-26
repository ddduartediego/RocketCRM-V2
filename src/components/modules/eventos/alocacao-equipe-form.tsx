"use client";

import { useState, useEffect, useTransition } from "react";
import { useForm } from "react-hook-form";
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
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";
import { Button } from "@/components/ui/button";
import { toast } from "sonner";
import {
  alocacaoEquipeSchema,
  type AlocacaoEquipeFormData,
  funcoesEquipe,
} from "@/lib/validations/equipe";
import { getMembrosEquipe, createAlocacaoEquipe, updateAlocacaoEquipe } from "@/actions/equipe";
import type { MembroEquipe, AlocacaoEquipe } from "@/types/database";

interface AlocacaoEquipeWithMembro extends AlocacaoEquipe {
  equipe?: {
    id: string;
    nome: string;
    funcao: string;
    telefone: string | null;
    whatsapp: string | null;
    valor_diaria: number | null;
  } | null;
}

interface AlocacaoEquipeFormProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  eventoId: string;
  eventoDataInicio: string;
  eventoDataFim?: string | null;
  alocacao?: AlocacaoEquipeWithMembro | null;
  onSuccess?: () => void;
}

export function AlocacaoEquipeForm({
  open,
  onOpenChange,
  eventoId,
  eventoDataInicio,
  eventoDataFim,
  alocacao,
  onSuccess,
}: AlocacaoEquipeFormProps) {
  const [isPending, startTransition] = useTransition();
  const [membros, setMembros] = useState<MembroEquipe[]>([]);
  const [loadingMembros, setLoadingMembros] = useState(false);

  const isEditing = !!alocacao;

  const form = useForm<AlocacaoEquipeFormData>({
    resolver: zodResolver(alocacaoEquipeSchema),
    defaultValues: {
      membro_id: "",
      evento_id: eventoId,
      data: eventoDataInicio,
      hora_inicio: null,
      hora_fim: null,
      funcao_evento: null,
      valor_pago: null,
      observacoes: null,
    },
  });

  // Buscar membros ativos
  useEffect(() => {
    if (open) {
      setLoadingMembros(true);
      getMembrosEquipe({ ativo: true, perPage: 100 })
        .then((result) => {
          if (result.data) {
            setMembros(result.data);
          }
        })
        .finally(() => setLoadingMembros(false));
    }
  }, [open]);

  // Resetar form quando abrir/fechar ou mudar alocação
  useEffect(() => {
    if (open) {
      if (alocacao) {
        form.reset({
          membro_id: alocacao.membro_id,
          evento_id: eventoId,
          data: alocacao.data,
          hora_inicio: alocacao.hora_inicio,
          hora_fim: alocacao.hora_fim,
          funcao_evento: alocacao.funcao_evento,
          valor_pago: alocacao.valor_pago,
          observacoes: alocacao.observacoes,
        });
      } else {
        form.reset({
          membro_id: "",
          evento_id: eventoId,
          data: eventoDataInicio,
          hora_inicio: null,
          hora_fim: null,
          funcao_evento: null,
          valor_pago: null,
          observacoes: null,
        });
      }
    }
  }, [open, alocacao, eventoId, eventoDataInicio, form]);

  // Ao selecionar um membro, preencher valor_pago com valor_diaria
  const handleMembroChange = (membroId: string) => {
    form.setValue("membro_id", membroId);
    const membroSelecionado = membros.find((m) => m.id === membroId);
    if (membroSelecionado?.valor_diaria && !isEditing) {
      form.setValue("valor_pago", membroSelecionado.valor_diaria);
    }
    // Preencher função padrão
    if (membroSelecionado?.funcao && !form.getValues("funcao_evento")) {
      const funcaoLabel = funcoesEquipe.find(f => f.value === membroSelecionado.funcao)?.label;
      form.setValue("funcao_evento", funcaoLabel || membroSelecionado.funcao);
    }
  };

  const onSubmit = (data: AlocacaoEquipeFormData) => {
    startTransition(async () => {
      const result = isEditing
        ? await updateAlocacaoEquipe(alocacao.id, data)
        : await createAlocacaoEquipe(data);

      if (result.error) {
        toast.error(isEditing ? "Erro ao atualizar alocação" : "Erro ao criar alocação", {
          description: result.error,
        });
      } else {
        toast.success(isEditing ? "Alocação atualizada" : "Membro alocado com sucesso");
        onOpenChange(false);
        onSuccess?.();
      }
    });
  };

  const membroSelecionado = membros.find((m) => m.id === form.watch("membro_id"));

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="max-w-md">
        <DialogHeader>
          <DialogTitle>
            {isEditing ? "Editar Alocação" : "Alocar Membro da Equipe"}
          </DialogTitle>
        </DialogHeader>

        <Form {...form}>
          <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-4">
            <FormField
              control={form.control}
              name="membro_id"
              render={({ field }) => (
                <FormItem>
                  <FormLabel>Membro</FormLabel>
                  <Select
                    disabled={loadingMembros || isEditing}
                    onValueChange={handleMembroChange}
                    value={field.value}
                  >
                    <FormControl>
                      <SelectTrigger>
                        <SelectValue placeholder="Selecione um membro" />
                      </SelectTrigger>
                    </FormControl>
                    <SelectContent>
                      {membros.map((membro) => (
                        <SelectItem key={membro.id} value={membro.id}>
                          <div className="flex items-center justify-between w-full gap-4">
                            <span>{membro.nome}</span>
                            <span className="text-xs text-muted-foreground">
                              {funcoesEquipe.find((f) => f.value === membro.funcao)?.label}
                            </span>
                          </div>
                        </SelectItem>
                      ))}
                    </SelectContent>
                  </Select>
                  <FormMessage />
                </FormItem>
              )}
            />

            {membroSelecionado && (
              <div className="text-sm text-muted-foreground bg-muted/50 p-3 rounded-md">
                <p><strong>Função:</strong> {funcoesEquipe.find(f => f.value === membroSelecionado.funcao)?.label}</p>
                {membroSelecionado.valor_diaria && (
                  <p><strong>Diária padrão:</strong> {new Intl.NumberFormat("pt-BR", { style: "currency", currency: "BRL" }).format(membroSelecionado.valor_diaria)}</p>
                )}
              </div>
            )}

            <FormField
              control={form.control}
              name="data"
              render={({ field }) => (
                <FormItem>
                  <FormLabel>Data</FormLabel>
                  <FormControl>
                    <Input type="date" {...field} value={field.value || ""} />
                  </FormControl>
                  <FormMessage />
                </FormItem>
              )}
            />

            <div className="grid grid-cols-2 gap-4">
              <FormField
                control={form.control}
                name="hora_inicio"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>Hora Início</FormLabel>
                    <FormControl>
                      <Input
                        type="time"
                        {...field}
                        value={field.value || ""}
                        onChange={(e) => field.onChange(e.target.value || null)}
                      />
                    </FormControl>
                    <FormMessage />
                  </FormItem>
                )}
              />

              <FormField
                control={form.control}
                name="hora_fim"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>Hora Fim</FormLabel>
                    <FormControl>
                      <Input
                        type="time"
                        {...field}
                        value={field.value || ""}
                        onChange={(e) => field.onChange(e.target.value || null)}
                      />
                    </FormControl>
                    <FormMessage />
                  </FormItem>
                )}
              />
            </div>

            <FormField
              control={form.control}
              name="funcao_evento"
              render={({ field }) => (
                <FormItem>
                  <FormLabel>Função no Evento</FormLabel>
                  <FormControl>
                    <Input
                      placeholder="Ex: Monitor principal, Coordenador..."
                      {...field}
                      value={field.value || ""}
                      onChange={(e) => field.onChange(e.target.value || null)}
                    />
                  </FormControl>
                  <FormMessage />
                </FormItem>
              )}
            />

            <FormField
              control={form.control}
              name="valor_pago"
              render={({ field }) => (
                <FormItem>
                  <FormLabel>Valor a Pagar (R$)</FormLabel>
                  <FormControl>
                    <Input
                      type="number"
                      step="0.01"
                      min="0"
                      placeholder="0,00"
                      {...field}
                      value={field.value ?? ""}
                      onChange={(e) => field.onChange(e.target.value ? parseFloat(e.target.value) : null)}
                    />
                  </FormControl>
                  <FormMessage />
                </FormItem>
              )}
            />

            <FormField
              control={form.control}
              name="observacoes"
              render={({ field }) => (
                <FormItem>
                  <FormLabel>Observações</FormLabel>
                  <FormControl>
                    <Textarea
                      placeholder="Observações sobre a alocação..."
                      className="resize-none"
                      {...field}
                      value={field.value || ""}
                      onChange={(e) => field.onChange(e.target.value || null)}
                    />
                  </FormControl>
                  <FormMessage />
                </FormItem>
              )}
            />

            <div className="flex justify-end gap-2 pt-4">
              <Button
                type="button"
                variant="outline"
                onClick={() => onOpenChange(false)}
                disabled={isPending}
              >
                Cancelar
              </Button>
              <Button type="submit" disabled={isPending}>
                {isPending ? "Salvando..." : isEditing ? "Salvar" : "Alocar"}
              </Button>
            </div>
          </form>
        </Form>
      </DialogContent>
    </Dialog>
  );
}


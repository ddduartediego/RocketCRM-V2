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
  alocacaoRecursoSchema,
  type AlocacaoRecursoFormData,
  tiposRecurso,
} from "@/lib/validations/recurso";
import { getRecursos, createAlocacaoRecurso, updateAlocacaoRecurso } from "@/actions/recursos";
import type { Recurso, AlocacaoRecurso } from "@/types/database";

interface AlocacaoRecursoWithRecurso extends AlocacaoRecurso {
  recursos?: {
    id: string;
    nome: string;
    tipo: string;
    quantidade: number;
    custo_unitario: number | null;
  } | null;
}

interface AlocacaoRecursoFormProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  eventoId: string;
  eventoDataInicio: string;
  eventoDataFim?: string | null;
  alocacao?: AlocacaoRecursoWithRecurso | null;
  onSuccess?: () => void;
}

export function AlocacaoRecursoForm({
  open,
  onOpenChange,
  eventoId,
  eventoDataInicio,
  eventoDataFim,
  alocacao,
  onSuccess,
}: AlocacaoRecursoFormProps) {
  const [isPending, startTransition] = useTransition();
  const [recursos, setRecursos] = useState<Recurso[]>([]);
  const [loadingRecursos, setLoadingRecursos] = useState(false);

  const isEditing = !!alocacao;

  const form = useForm<AlocacaoRecursoFormData>({
    resolver: zodResolver(alocacaoRecursoSchema),
    defaultValues: {
      recurso_id: "",
      evento_id: eventoId,
      quantidade: 1,
      valor: null,
      data_inicio: eventoDataInicio,
      data_fim: eventoDataFim || eventoDataInicio,
      observacoes: null,
    },
  });

  // Buscar recursos ativos
  useEffect(() => {
    if (open) {
      setLoadingRecursos(true);
      getRecursos({ ativo: true, perPage: 100 })
        .then((result) => {
          if (result.data) {
            setRecursos(result.data);
          }
        })
        .finally(() => setLoadingRecursos(false));
    }
  }, [open]);

  // Resetar form quando abrir/fechar ou mudar alocação
  useEffect(() => {
    if (open) {
      if (alocacao) {
        form.reset({
          recurso_id: alocacao.recurso_id,
          evento_id: eventoId,
          quantidade: alocacao.quantidade,
          valor: alocacao.valor,
          data_inicio: alocacao.data_inicio,
          data_fim: alocacao.data_fim,
          observacoes: alocacao.observacoes,
        });
      } else {
        form.reset({
          recurso_id: "",
          evento_id: eventoId,
          quantidade: 1,
          valor: null,
          data_inicio: eventoDataInicio,
          data_fim: eventoDataFim || eventoDataInicio,
          observacoes: null,
        });
      }
    }
  }, [open, alocacao, eventoId, eventoDataInicio, eventoDataFim, form]);

  // Ao selecionar um recurso, sugerir valor baseado no custo unitário
  const handleRecursoChange = (recursoId: string) => {
    form.setValue("recurso_id", recursoId);
    const recursoSelecionado = recursos.find((r) => r.id === recursoId);
    if (recursoSelecionado?.custo_unitario && !isEditing) {
      const quantidade = form.getValues("quantidade") || 1;
      form.setValue("valor", recursoSelecionado.custo_unitario * quantidade);
    }
  };

  // Ao mudar quantidade, recalcular valor sugerido
  const handleQuantidadeChange = (quantidade: number) => {
    form.setValue("quantidade", quantidade);
    const recursoId = form.getValues("recurso_id");
    const recursoSelecionado = recursos.find((r) => r.id === recursoId);
    if (recursoSelecionado?.custo_unitario && !isEditing) {
      form.setValue("valor", recursoSelecionado.custo_unitario * quantidade);
    }
  };

  const onSubmit = (data: AlocacaoRecursoFormData) => {
    startTransition(async () => {
      const result = isEditing
        ? await updateAlocacaoRecurso(alocacao.id, data)
        : await createAlocacaoRecurso(data);

      if (result.error) {
        toast.error(isEditing ? "Erro ao atualizar alocação" : "Erro ao criar alocação", {
          description: result.error,
        });
      } else {
        toast.success(isEditing ? "Alocação atualizada" : "Recurso alocado com sucesso");
        onOpenChange(false);
        onSuccess?.();
      }
    });
  };

  const recursoSelecionado = recursos.find((r) => r.id === form.watch("recurso_id"));

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="max-w-md">
        <DialogHeader>
          <DialogTitle>
            {isEditing ? "Editar Alocação" : "Alocar Recurso"}
          </DialogTitle>
        </DialogHeader>

        <Form {...form}>
          <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-4">
            <FormField
              control={form.control}
              name="recurso_id"
              render={({ field }) => (
                <FormItem>
                  <FormLabel>Recurso</FormLabel>
                  <Select
                    disabled={loadingRecursos || isEditing}
                    onValueChange={handleRecursoChange}
                    value={field.value}
                  >
                    <FormControl>
                      <SelectTrigger>
                        <SelectValue placeholder="Selecione um recurso" />
                      </SelectTrigger>
                    </FormControl>
                    <SelectContent>
                      {recursos.map((recurso) => (
                        <SelectItem key={recurso.id} value={recurso.id}>
                          <div className="flex items-center justify-between w-full gap-4">
                            <span>{recurso.nome}</span>
                            <span className="text-xs text-muted-foreground">
                              {tiposRecurso.find((t) => t.value === recurso.tipo)?.label} 
                              {recurso.quantidade > 1 && ` (${recurso.quantidade} disp.)`}
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

            {recursoSelecionado && (
              <div className="text-sm text-muted-foreground bg-muted/50 p-3 rounded-md">
                <p><strong>Tipo:</strong> {tiposRecurso.find(t => t.value === recursoSelecionado.tipo)?.label}</p>
                <p><strong>Disponível:</strong> {recursoSelecionado.quantidade} unidade(s)</p>
                {recursoSelecionado.custo_unitario && (
                  <p><strong>Custo unitário:</strong> {new Intl.NumberFormat("pt-BR", { style: "currency", currency: "BRL" }).format(recursoSelecionado.custo_unitario)}</p>
                )}
              </div>
            )}

            <FormField
              control={form.control}
              name="quantidade"
              render={({ field }) => (
                <FormItem>
                  <FormLabel>Quantidade</FormLabel>
                  <FormControl>
                    <Input
                      type="number"
                      min="1"
                      max={recursoSelecionado?.quantidade || 999}
                      {...field}
                      onChange={(e) => handleQuantidadeChange(parseInt(e.target.value) || 1)}
                    />
                  </FormControl>
                  <FormMessage />
                </FormItem>
              )}
            />

            <FormField
              control={form.control}
              name="valor"
              render={({ field }) => (
                <FormItem>
                  <FormLabel>Valor Total (R$)</FormLabel>
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

            <div className="grid grid-cols-2 gap-4">
              <FormField
                control={form.control}
                name="data_inicio"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>Data Início</FormLabel>
                    <FormControl>
                      <Input type="date" {...field} />
                    </FormControl>
                    <FormMessage />
                  </FormItem>
                )}
              />

              <FormField
                control={form.control}
                name="data_fim"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>Data Fim</FormLabel>
                    <FormControl>
                      <Input type="date" {...field} />
                    </FormControl>
                    <FormMessage />
                  </FormItem>
                )}
              />
            </div>

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


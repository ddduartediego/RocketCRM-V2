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
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { toast } from "sonner";
import {
  transacaoSchema,
  tiposTransacao,
  statusPagamento,
  formasPagamento,
  type TransacaoFormData,
} from "@/lib/validations/financeiro";
import {
  createTransacao,
  updateTransacao,
  getCategorias,
} from "@/actions/financeiro";
import { getContatos } from "@/actions/leads";
import { getEventosSimples } from "@/actions/eventos";
import type { TransacaoFinanceira, CategoriaFinanceira } from "@/types/database";
import { DollarSign, FileText, Calendar, CalendarDays } from "lucide-react";

interface TransacaoFormProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  transacao?: TransacaoFinanceira | null;
  eventoId?: string;
}

export function TransacaoForm({
  open,
  onOpenChange,
  transacao,
  eventoId,
}: TransacaoFormProps) {
  const isEditing = !!transacao;
  const [categorias, setCategorias] = useState<CategoriaFinanceira[]>([]);
  const [contatos, setContatos] = useState<{ id: string; nome: string }[]>([]);
  const [eventos, setEventos] = useState<{ id: string; nome: string; data_inicio: string; status: string }[]>([]);

  const form = useForm<TransacaoFormData>({
    resolver: zodResolver(transacaoSchema) as Resolver<TransacaoFormData>,
    defaultValues: {
      descricao: "",
      tipo: "receita",
      valor: 0,
      data_vencimento: "",
      data_pagamento: null,
      status: "pendente",
      forma_pagamento: null,
      categoria_id: null,
      evento_id: eventoId || null,
      contato_id: null,
      observacoes: "",
    },
  });

  const tipoSelecionado = form.watch("tipo");

  useEffect(() => {
    if (open) {
      // Carregar categorias filtradas pelo tipo
      getCategorias(tipoSelecionado).then((result) => {
        setCategorias(result.data);
      });

      // Carregar contatos
      getContatos().then((result) => {
        setContatos(result.data);
      });

      // Carregar eventos (apenas se não tiver eventoId já definido)
      if (!eventoId) {
        getEventosSimples().then((result) => {
          setEventos(result.data);
        });
      }
    }
  }, [open, tipoSelecionado, eventoId]);

  useEffect(() => {
    if (transacao) {
      form.reset({
        descricao: transacao.descricao,
        tipo: transacao.tipo,
        valor: transacao.valor,
        data_vencimento: transacao.data_vencimento,
        data_pagamento: transacao.data_pagamento,
        status: transacao.status,
        forma_pagamento: transacao.forma_pagamento,
        categoria_id: transacao.categoria_id,
        evento_id: transacao.evento_id || eventoId || null,
        contato_id: transacao.contato_id,
        observacoes: transacao.observacoes,
      });
    } else {
      form.reset({
        descricao: "",
        tipo: "receita",
        valor: 0,
        data_vencimento: new Date().toISOString().split("T")[0],
        data_pagamento: null,
        status: "pendente",
        forma_pagamento: null,
        categoria_id: null,
        evento_id: eventoId || null,
        contato_id: null,
        observacoes: "",
      });
    }
  }, [transacao, eventoId, form]);

  async function onSubmit(data: TransacaoFormData) {
    try {
      const result = isEditing
        ? await updateTransacao(transacao.id, data)
        : await createTransacao(data);

      if (result.error) {
        toast.error(result.error);
        return;
      }

      toast.success(
        isEditing
          ? "Transação atualizada com sucesso!"
          : "Transação criada com sucesso!"
      );
      onOpenChange(false);
      form.reset();
    } catch {
      toast.error("Ocorreu um erro. Tente novamente.");
    }
  }

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="max-w-2xl max-h-[90vh] overflow-y-auto">
        <DialogHeader>
          <DialogTitle>
            {isEditing ? "Editar Transação" : "Nova Transação"}
          </DialogTitle>
        </DialogHeader>

        <Form {...form}>
          <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-6">
            <Tabs defaultValue="geral" className="w-full">
              <TabsList className="grid w-full grid-cols-3">
                <TabsTrigger value="geral" className="flex items-center gap-2">
                  <FileText className="h-4 w-4" />
                  Geral
                </TabsTrigger>
                <TabsTrigger value="datas" className="flex items-center gap-2">
                  <Calendar className="h-4 w-4" />
                  Datas
                </TabsTrigger>
                <TabsTrigger value="valores" className="flex items-center gap-2">
                  <DollarSign className="h-4 w-4" />
                  Valores
                </TabsTrigger>
              </TabsList>

              <TabsContent value="geral" className="space-y-4 pt-4">
                <div className="grid grid-cols-2 gap-4">
                  <FormField
                    control={form.control}
                    name="tipo"
                    render={({ field }) => (
                      <FormItem>
                        <FormLabel>Tipo *</FormLabel>
                        <Select
                          onValueChange={field.onChange}
                          defaultValue={field.value}
                        >
                          <FormControl>
                            <SelectTrigger>
                              <SelectValue placeholder="Selecione o tipo" />
                            </SelectTrigger>
                          </FormControl>
                          <SelectContent>
                            {tiposTransacao.map((tipo) => (
                              <SelectItem key={tipo.value} value={tipo.value}>
                                {tipo.label}
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
                    name="categoria_id"
                    render={({ field }) => (
                      <FormItem>
                        <FormLabel>Categoria</FormLabel>
                        <Select
                          onValueChange={field.onChange}
                          value={field.value || undefined}
                        >
                          <FormControl>
                            <SelectTrigger>
                              <SelectValue placeholder="Selecione a categoria" />
                            </SelectTrigger>
                          </FormControl>
                          <SelectContent>
                            {categorias.map((cat) => (
                              <SelectItem key={cat.id} value={cat.id}>
                                {cat.nome}
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
                    name="descricao"
                    render={({ field }) => (
                      <FormItem className="col-span-2">
                        <FormLabel>Descrição *</FormLabel>
                        <FormControl>
                          <Input
                            placeholder="Ex: Pagamento evento X"
                            {...field}
                          />
                        </FormControl>
                        <FormMessage />
                      </FormItem>
                    )}
                  />

                  <FormField
                    control={form.control}
                    name="contato_id"
                    render={({ field }) => (
                      <FormItem>
                        <FormLabel>Cliente/Fornecedor</FormLabel>
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
                            {contatos.map((contato) => (
                              <SelectItem key={contato.id} value={contato.id}>
                                {contato.nome}
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
                    name="evento_id"
                    render={({ field }) => (
                      <FormItem>
                        <FormLabel>
                          <span className="flex items-center gap-1.5">
                            <CalendarDays className="h-3.5 w-3.5" />
                            Evento Vinculado
                          </span>
                        </FormLabel>
                        <Select
                          onValueChange={field.onChange}
                          value={field.value || undefined}
                          disabled={!!eventoId}
                        >
                          <FormControl>
                            <SelectTrigger>
                              <SelectValue placeholder={eventoId ? "Evento já vinculado" : "Selecione (opcional)"} />
                            </SelectTrigger>
                          </FormControl>
                          <SelectContent>
                            {eventos.map((evento) => (
                              <SelectItem key={evento.id} value={evento.id}>
                                <span className="flex items-center gap-2">
                                  <span>{evento.nome}</span>
                                  <span className="text-xs text-muted-foreground">
                                    ({new Date(evento.data_inicio).toLocaleDateString("pt-BR")})
                                  </span>
                                </span>
                              </SelectItem>
                            ))}
                          </SelectContent>
                        </Select>
                        <FormMessage />
                      </FormItem>
                    )}
                  />
                </div>
              </TabsContent>

              <TabsContent value="datas" className="space-y-4 pt-4">
                <div className="grid grid-cols-2 gap-4">
                  <FormField
                    control={form.control}
                    name="data_vencimento"
                    render={({ field }) => (
                      <FormItem>
                        <FormLabel>Data de Vencimento *</FormLabel>
                        <FormControl>
                          <Input type="date" {...field} />
                        </FormControl>
                        <FormMessage />
                      </FormItem>
                    )}
                  />

                  <FormField
                    control={form.control}
                    name="data_pagamento"
                    render={({ field }) => (
                      <FormItem>
                        <FormLabel>Data de Pagamento</FormLabel>
                        <FormControl>
                          <Input
                            type="date"
                            {...field}
                            value={field.value || ""}
                          />
                        </FormControl>
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
                        <Select
                          onValueChange={field.onChange}
                          defaultValue={field.value}
                        >
                          <FormControl>
                            <SelectTrigger>
                              <SelectValue placeholder="Status" />
                            </SelectTrigger>
                          </FormControl>
                          <SelectContent>
                            {statusPagamento.map((s) => (
                              <SelectItem key={s.value} value={s.value}>
                                {s.label}
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
                    name="forma_pagamento"
                    render={({ field }) => (
                      <FormItem>
                        <FormLabel>Forma de Pagamento</FormLabel>
                        <Select
                          onValueChange={field.onChange}
                          value={field.value || undefined}
                        >
                          <FormControl>
                            <SelectTrigger>
                              <SelectValue placeholder="Selecione" />
                            </SelectTrigger>
                          </FormControl>
                          <SelectContent>
                            {formasPagamento.map((f) => (
                              <SelectItem key={f.value} value={f.value}>
                                {f.label}
                              </SelectItem>
                            ))}
                          </SelectContent>
                        </Select>
                        <FormMessage />
                      </FormItem>
                    )}
                  />
                </div>
              </TabsContent>

              <TabsContent value="valores" className="space-y-4 pt-4">
                <div className="grid grid-cols-2 gap-4">
                  <FormField
                    control={form.control}
                    name="valor"
                    render={({ field }) => (
                      <FormItem>
                        <FormLabel>Valor (R$) *</FormLabel>
                        <FormControl>
                          <Input
                            type="number"
                            step="0.01"
                            min="0"
                            placeholder="0,00"
                            {...field}
                            onChange={(e) =>
                              field.onChange(Number(e.target.value))
                            }
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
                      <FormItem className="col-span-2">
                        <FormLabel>Observações</FormLabel>
                        <FormControl>
                          <Textarea
                            placeholder="Observações adicionais..."
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
                </div>
              </TabsContent>
            </Tabs>

            <div className="flex justify-end gap-3">
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
                  : "Criar Transação"}
              </Button>
            </div>
          </form>
        </Form>
      </DialogContent>
    </Dialog>
  );
}


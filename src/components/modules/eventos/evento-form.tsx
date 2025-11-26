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
  FormDescription,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from "@/components/ui/form";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import { Textarea } from "@/components/ui/textarea";
import { Checkbox } from "@/components/ui/checkbox";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import {
  AlertDialog,
  AlertDialogAction,
  AlertDialogCancel,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogFooter,
  AlertDialogHeader,
  AlertDialogTitle,
} from "@/components/ui/alert-dialog";
import {
  eventoSchema,
  type EventoFormData,
  tipoEventoOptions,
  statusEventoOptions,
} from "@/lib/validations/evento";
import { formasPagamento } from "@/lib/validations/financeiro";
import { createEvento, updateEvento, recriarTransacoesEvento } from "@/actions/eventos";
import { getContatos, getOrganizacoes } from "@/actions/leads";
import { toast } from "sonner";
import { Calendar, DollarSign, Info, AlertTriangle } from "lucide-react";
import type { Evento } from "@/types/database";

interface EventoFormProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  evento?: Evento | null;
}

export function EventoForm({ open, onOpenChange, evento }: EventoFormProps) {
  const isEditing = !!evento;
  const [contatos, setContatos] = useState<{ id: string; nome: string }[]>([]);
  const [organizacoes, setOrganizacoes] = useState<{ id: string; nome: string }[]>([]);
  const [criarTransacao, setCriarTransacao] = useState(true);
  const [showRecreateDialog, setShowRecreateDialog] = useState(false);
  const [pendingFormData, setPendingFormData] = useState<EventoFormData | null>(null);
  const [recreateTransacoes, setRecreateTransacoes] = useState(false);

  const form = useForm<EventoFormData>({
    resolver: zodResolver(eventoSchema) as Resolver<EventoFormData>,
    defaultValues: {
      nome: "",
      tipo: "viagem_pedagogica",
      descricao: "",
      cliente_id: null,
      organizacao_id: null,
      turma_serie: "",
      data_inicio: "",
      data_fim: "",
      hora_inicio: "",
      hora_fim: "",
      local: "",
      endereco_local: "",
      status: "planejamento",
      num_participantes: 0,
      valor_total: 0,
      valor_sinal: 0,
      forma_pagamento: "",
      condicoes_pagamento: "",
      observacoes: "",
    },
  });

  useEffect(() => {
    const loadData = async () => {
      const [contatosRes, organizacoesRes] = await Promise.all([
        getContatos(),
        getOrganizacoes(),
      ]);
      setContatos(contatosRes.data);
      setOrganizacoes(organizacoesRes.data);
    };
    if (open) {
      loadData();
    }
  }, [open]);

  useEffect(() => {
    if (evento) {
      form.reset({
        nome: evento.nome,
        tipo: evento.tipo,
        descricao: evento.descricao || "",
        cliente_id: evento.cliente_id,
        organizacao_id: evento.organizacao_id,
        turma_serie: evento.turma_serie || "",
        data_inicio: evento.data_inicio,
        data_fim: evento.data_fim || "",
        hora_inicio: evento.hora_inicio || "",
        hora_fim: evento.hora_fim || "",
        local: evento.local || "",
        endereco_local: evento.endereco_local || "",
        status: evento.status,
        num_participantes: evento.num_participantes || 0,
        valor_total: evento.valor_total || 0,
        valor_sinal: evento.valor_sinal || 0,
        forma_pagamento: evento.forma_pagamento || "",
        condicoes_pagamento: evento.condicoes_pagamento || "",
        observacoes: evento.observacoes || "",
      });
    } else {
      form.reset({
        nome: "",
        tipo: "viagem_pedagogica",
        descricao: "",
        cliente_id: null,
        organizacao_id: null,
        turma_serie: "",
        data_inicio: "",
        data_fim: "",
        hora_inicio: "",
        hora_fim: "",
        local: "",
        endereco_local: "",
        status: "planejamento",
        num_participantes: 0,
        valor_total: 0,
        valor_sinal: 0,
        forma_pagamento: "",
        condicoes_pagamento: "",
        observacoes: "",
      });
    }
  }, [evento, form]);

  // Verifica se valores financeiros mudaram
  const financeirosAlterados = (data: EventoFormData) => {
    if (!evento) return false;
    return (
      (data.valor_total || 0) !== (evento.valor_total || 0) ||
      (data.valor_sinal || 0) !== (evento.valor_sinal || 0) ||
      (data.forma_pagamento || "") !== (evento.forma_pagamento || "")
    );
  };

  const onSubmit = async (data: EventoFormData) => {
    // Se editando e valores financeiros mudaram, perguntar se quer recriar transações
    if (isEditing && financeirosAlterados(data) && !recreateTransacoes) {
      setPendingFormData(data);
      setShowRecreateDialog(true);
      return;
    }

    try {
      let result;
      
      if (isEditing) {
        result = await updateEvento(evento!.id, data);
        
        // Se usuário confirmou recriar transações
        if (recreateTransacoes && (data.valor_total || 0) > 0) {
          const recreateResult = await recriarTransacoesEvento(evento!.id, {
            valor_total: data.valor_total || 0,
            valor_sinal: data.valor_sinal || 0,
            forma_pagamento: data.forma_pagamento || null,
            cliente_id: data.cliente_id || null,
            nome_evento: data.nome,
          });
          
          if (recreateResult.error) {
            toast.error("Evento atualizado, mas erro ao recriar transações", {
              description: recreateResult.error,
            });
          } else {
            toast.success("Evento atualizado!", {
              description: `Transações financeiras recriadas (${recreateResult.transacoesCriadas} transação(ões)).`,
            });
          }
          
          setRecreateTransacoes(false);
          setPendingFormData(null);
          onOpenChange(false);
          return;
        }
      } else {
        result = await createEvento({
          ...data,
          criar_transacao_receita: criarTransacao && (data.valor_total || 0) > 0,
        });
      }

      if (result.error) {
        toast.error(isEditing ? "Erro ao atualizar" : "Erro ao criar", {
          description: result.error,
        });
        return;
      }

      let successMessage = `${data.nome} foi ${isEditing ? "atualizado" : "criado"} com sucesso.`;
      
      if (!isEditing && "transacoesCriadas" in result && result.transacoesCriadas) {
        const qtd = result.transacoesCriadas;
        successMessage += qtd === 1 
          ? " Transação de receita criada automaticamente."
          : ` ${qtd} transações de receita criadas automaticamente.`;
      }

      toast.success(isEditing ? "Evento atualizado!" : "Evento criado!", {
        description: successMessage,
      });

      onOpenChange(false);
      setCriarTransacao(true);
      setRecreateTransacoes(false);
      setPendingFormData(null);
    } catch {
      toast.error("Erro inesperado", {
        description: "Tente novamente mais tarde.",
      });
    }
  };

  const handleConfirmRecreate = async () => {
    setShowRecreateDialog(false);
    setRecreateTransacoes(true);
    if (pendingFormData) {
      await onSubmit(pendingFormData);
    }
  };

  const handleCancelRecreate = async () => {
    setShowRecreateDialog(false);
    setRecreateTransacoes(false);
    // Salvar sem recriar transações
    if (pendingFormData) {
      try {
        const result = await updateEvento(evento!.id, pendingFormData);
        if (result.error) {
          toast.error("Erro ao atualizar", { description: result.error });
        } else {
          toast.success("Evento atualizado!", {
            description: "Transações financeiras mantidas.",
          });
          onOpenChange(false);
        }
      } catch {
        toast.error("Erro inesperado");
      }
    }
    setPendingFormData(null);
  };

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="max-w-3xl max-h-[90vh] overflow-y-auto">
        <DialogHeader>
          <DialogTitle>{isEditing ? "Editar Evento" : "Novo Evento"}</DialogTitle>
          <DialogDescription>
            {isEditing
              ? "Atualize as informações do evento"
              : "Preencha os dados para criar um novo evento"}
          </DialogDescription>
        </DialogHeader>

        <Form {...form}>
          <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-6">
            <Tabs defaultValue="info" className="w-full">
              <TabsList className="grid w-full grid-cols-3">
                <TabsTrigger value="info" className="flex items-center gap-2">
                  <Info className="w-4 h-4" />
                  Informações
                </TabsTrigger>
                <TabsTrigger value="data" className="flex items-center gap-2">
                  <Calendar className="w-4 h-4" />
                  Data e Local
                </TabsTrigger>
                <TabsTrigger value="financeiro" className="flex items-center gap-2">
                  <DollarSign className="w-4 h-4" />
                  Financeiro
                </TabsTrigger>
              </TabsList>

              <TabsContent value="info" className="space-y-4 pt-4">
                <div className="grid grid-cols-2 gap-4">
                  <FormField
                    control={form.control}
                    name="nome"
                    render={({ field }) => (
                      <FormItem className="col-span-2">
                        <FormLabel>Nome do Evento *</FormLabel>
                        <FormControl>
                          <Input placeholder="Ex: Viagem Escola ABC - 9º ano" {...field} />
                        </FormControl>
                        <FormMessage />
                      </FormItem>
                    )}
                  />

                  <FormField
                    control={form.control}
                    name="tipo"
                    render={({ field }) => (
                      <FormItem>
                        <FormLabel>Tipo *</FormLabel>
                        <Select onValueChange={field.onChange} value={field.value}>
                          <FormControl>
                            <SelectTrigger>
                              <SelectValue placeholder="Selecione" />
                            </SelectTrigger>
                          </FormControl>
                          <SelectContent>
                            {tipoEventoOptions.map((option) => (
                              <SelectItem key={option.value} value={option.value}>
                                <span className="flex items-center gap-2">
                                  {option.icon} {option.label}
                                </span>
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
                        <Select onValueChange={field.onChange} value={field.value}>
                          <FormControl>
                            <SelectTrigger>
                              <SelectValue placeholder="Selecione" />
                            </SelectTrigger>
                          </FormControl>
                          <SelectContent>
                            {statusEventoOptions.map((option) => (
                              <SelectItem key={option.value} value={option.value}>
                                <span className="flex items-center gap-2">
                                  <span
                                    className="w-2 h-2 rounded-full"
                                    style={{ backgroundColor: option.color }}
                                  />
                                  {option.label}
                                </span>
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
                    name="organizacao_id"
                    render={({ field }) => (
                      <FormItem>
                        <FormLabel>Organização/Escola</FormLabel>
                        <Select onValueChange={field.onChange} value={field.value || ""}>
                          <FormControl>
                            <SelectTrigger>
                              <SelectValue placeholder="Selecione" />
                            </SelectTrigger>
                          </FormControl>
                          <SelectContent>
                            {organizacoes.map((org) => (
                              <SelectItem key={org.id} value={org.id}>
                                {org.nome}
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
                    name="cliente_id"
                    render={({ field }) => (
                      <FormItem>
                        <FormLabel>Cliente/Contato</FormLabel>
                        <Select onValueChange={field.onChange} value={field.value || ""}>
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
                        <FormMessage />
                      </FormItem>
                    )}
                  />

                  <FormField
                    control={form.control}
                    name="turma_serie"
                    render={({ field }) => (
                      <FormItem>
                        <FormLabel>Turma/Série</FormLabel>
                        <FormControl>
                          <Input placeholder="Ex: 9º ano" {...field} value={field.value || ""} />
                        </FormControl>
                        <FormMessage />
                      </FormItem>
                    )}
                  />

                  <FormField
                    control={form.control}
                    name="num_participantes"
                    render={({ field }) => (
                      <FormItem>
                        <FormLabel>Nº de Participantes</FormLabel>
                        <FormControl>
                          <Input 
                            type="number" 
                            {...field} 
                            value={field.value ?? ""} 
                            onChange={(e) => field.onChange(e.target.value ? Number(e.target.value) : null)}
                          />
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
                            placeholder="Detalhes do evento..."
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

              <TabsContent value="data" className="space-y-4 pt-4">
                <div className="grid grid-cols-2 gap-4">
                  <FormField
                    control={form.control}
                    name="data_inicio"
                    render={({ field }) => (
                      <FormItem>
                        <FormLabel>Data de Início *</FormLabel>
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
                        <FormLabel>Data de Fim</FormLabel>
                        <FormControl>
                          <Input type="date" {...field} value={field.value || ""} />
                        </FormControl>
                        <FormMessage />
                      </FormItem>
                    )}
                  />

                  <FormField
                    control={form.control}
                    name="hora_inicio"
                    render={({ field }) => (
                      <FormItem>
                        <FormLabel>Hora de Início</FormLabel>
                        <FormControl>
                          <Input type="time" {...field} value={field.value || ""} />
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
                        <FormLabel>Hora de Fim</FormLabel>
                        <FormControl>
                          <Input type="time" {...field} value={field.value || ""} />
                        </FormControl>
                        <FormMessage />
                      </FormItem>
                    )}
                  />

                  <FormField
                    control={form.control}
                    name="local"
                    render={({ field }) => (
                      <FormItem className="col-span-2">
                        <FormLabel>Local</FormLabel>
                        <FormControl>
                          <Input placeholder="Nome do local" {...field} value={field.value || ""} />
                        </FormControl>
                        <FormMessage />
                      </FormItem>
                    )}
                  />

                  <FormField
                    control={form.control}
                    name="endereco_local"
                    render={({ field }) => (
                      <FormItem className="col-span-2">
                        <FormLabel>Endereço</FormLabel>
                        <FormControl>
                          <Input
                            placeholder="Endereço completo"
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

              <TabsContent value="financeiro" className="space-y-4 pt-4">
                <div className="grid grid-cols-2 gap-4">
                  <FormField
                    control={form.control}
                    name="valor_total"
                    render={({ field }) => (
                      <FormItem>
                        <FormLabel>Valor Total (R$)</FormLabel>
                        <FormControl>
                          <Input 
                            type="number" 
                            step="0.01" 
                            {...field} 
                            value={field.value ?? ""} 
                            onChange={(e) => field.onChange(e.target.value ? Number(e.target.value) : null)}
                          />
                        </FormControl>
                        <FormMessage />
                      </FormItem>
                    )}
                  />

                  <FormField
                    control={form.control}
                    name="valor_sinal"
                    render={({ field }) => (
                      <FormItem>
                        <FormLabel>Valor do Sinal (R$)</FormLabel>
                        <FormControl>
                          <Input 
                            type="number" 
                            step="0.01" 
                            {...field} 
                            value={field.value ?? ""} 
                            onChange={(e) => field.onChange(e.target.value ? Number(e.target.value) : null)}
                          />
                        </FormControl>
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
                            {formasPagamento.map((forma) => (
                              <SelectItem key={forma.value} value={forma.value}>
                                {forma.label}
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
                    name="condicoes_pagamento"
                    render={({ field }) => (
                      <FormItem>
                        <FormLabel>Condições</FormLabel>
                        <FormControl>
                          <Input
                            placeholder="Ex: 3x sem juros"
                            {...field}
                            value={field.value || ""}
                          />
                        </FormControl>
                        <FormMessage />
                      </FormItem>
                    )}
                  />

                  {!isEditing && (
                    <div className="col-span-2 flex items-start space-x-3 rounded-lg border p-4 bg-muted/30">
                      <Checkbox
                        id="criar-transacao"
                        checked={criarTransacao}
                        onCheckedChange={(checked) => setCriarTransacao(checked === true)}
                      />
                      <div className="space-y-1 leading-none">
                        <label
                          htmlFor="criar-transacao"
                          className="text-sm font-medium cursor-pointer"
                        >
                          Criar transação financeira automaticamente
                        </label>
                        <p className="text-xs text-muted-foreground">
                          Uma receita pendente será criada com o valor total do evento
                        </p>
                      </div>
                    </div>
                  )}

                  <FormField
                    control={form.control}
                    name="observacoes"
                    render={({ field }) => (
                      <FormItem className="col-span-2">
                        <FormLabel>Observações</FormLabel>
                        <FormControl>
                          <Textarea
                            placeholder="Anotações adicionais..."
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

            <div className="flex justify-end gap-3 pt-4 border-t">
              <Button type="button" variant="outline" onClick={() => onOpenChange(false)}>
                Cancelar
              </Button>
              <Button type="submit" disabled={form.formState.isSubmitting}>
                {form.formState.isSubmitting
                  ? "Salvando..."
                  : isEditing
                    ? "Salvar alterações"
                    : "Criar evento"}
              </Button>
            </div>
          </form>
        </Form>
      </DialogContent>

      {/* Dialog de confirmação para recriar transações */}
      <AlertDialog open={showRecreateDialog} onOpenChange={setShowRecreateDialog}>
        <AlertDialogContent>
          <AlertDialogHeader>
            <AlertDialogTitle className="flex items-center gap-2">
              <AlertTriangle className="h-5 w-5 text-amber-500" />
              Valores financeiros alterados
            </AlertDialogTitle>
            <AlertDialogDescription className="space-y-2">
              <p>
                Você alterou os valores financeiros do evento. Deseja recriar as transações
                financeiras com os novos valores?
              </p>
              <p className="text-amber-600 font-medium">
                As transações de receita existentes vinculadas a este evento serão excluídas
                e novas transações serão criadas.
              </p>
            </AlertDialogDescription>
          </AlertDialogHeader>
          <AlertDialogFooter>
            <AlertDialogCancel onClick={handleCancelRecreate}>
              Manter transações atuais
            </AlertDialogCancel>
            <AlertDialogAction onClick={handleConfirmRecreate}>
              Recriar transações
            </AlertDialogAction>
          </AlertDialogFooter>
        </AlertDialogContent>
      </AlertDialog>
    </Dialog>
  );
}


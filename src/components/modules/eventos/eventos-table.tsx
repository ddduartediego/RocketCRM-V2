"use client";

import { useState } from "react";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
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
  Tooltip,
  TooltipContent,
  TooltipProvider,
  TooltipTrigger,
} from "@/components/ui/tooltip";
import { MoreHorizontal, Pencil, Trash2, Eye, Calendar, MapPin, CheckCircle2, Clock, AlertTriangle } from "lucide-react";
import { deleteEvento, getTransacoesDoEvento } from "@/actions/eventos";
import { toast } from "sonner";
import type { Evento } from "@/types/database";
import type { ResumoFinanceiroEvento } from "@/actions/financeiro";

interface EventoWithRelations extends Evento {
  contatos?: { id: string; nome: string } | null;
  users?: { id: string; nome: string; avatar_url: string | null } | null;
}

interface EventosTableProps {
  eventos: EventoWithRelations[];
  onEdit: (evento: Evento) => void;
  onView: (evento: Evento) => void;
  resumosFinanceiros?: Record<string, ResumoFinanceiroEvento>;
}

const tipoLabels: Record<string, { label: string; icon: string }> = {
  colonia_ferias: { label: "Colônia", icon: "🏕️" },
  festa_infantil: { label: "Festa", icon: "🎈" },
  gincana: { label: "Gincana", icon: "🏃" },
  outro: { label: "Outro", icon: "📅" },
};

const statusConfig: Record<string, { label: string; color: string }> = {
  planejamento: { label: "Planejamento", color: "#0ea5e9" },
  confirmado: { label: "Confirmado", color: "#22c55e" },
  em_andamento: { label: "Em Andamento", color: "#eab308" },
  realizado: { label: "Realizado", color: "#8b5cf6" },
  cancelado: { label: "Cancelado", color: "#dc2626" },
};

export function EventosTable({ eventos, onEdit, onView, resumosFinanceiros = {} }: EventosTableProps) {
  const [deleteId, setDeleteId] = useState<string | null>(null);
  const [deleteWithTransacoesId, setDeleteWithTransacoesId] = useState<string | null>(null);
  const [transacoesVinculadas, setTransacoesVinculadas] = useState(0);
  const [isDeleting, setIsDeleting] = useState(false);
  const [checkingTransacoes, setCheckingTransacoes] = useState<string | null>(null);

  const getStatusFinanceiro = (evento: Evento) => {
    const resumo = resumosFinanceiros[evento.id];
    const valorTotal = evento.valor_total || 0;
    
    if (!resumo || valorTotal === 0) {
      return { status: "sem_dados", icon: null, color: "#6b7280", label: "" };
    }

    const percentualPago = (resumo.receitasPagas / valorTotal) * 100;
    
    if (percentualPago >= 100) {
      return { 
        status: "pago", 
        icon: CheckCircle2, 
        color: "#22c55e", 
        label: "Pago integralmente" 
      };
    } else if (percentualPago > 0) {
      return { 
        status: "parcial", 
        icon: Clock, 
        color: "#eab308", 
        label: `${percentualPago.toFixed(0)}% recebido` 
      };
    } else if (resumo.receitasPendentes > 0) {
      return { 
        status: "pendente", 
        icon: Clock, 
        color: "#f97316", 
        label: "Pagamento pendente" 
      };
    } else {
      return { 
        status: "sem_transacao", 
        icon: AlertTriangle, 
        color: "#dc2626", 
        label: "Sem transações" 
      };
    }
  };

  const handleOpenDeleteDialog = async (eventoId: string) => {
    setCheckingTransacoes(eventoId);
    const { count } = await getTransacoesDoEvento(eventoId);
    setCheckingTransacoes(null);

    if (count && count > 0) {
      setTransacoesVinculadas(count);
      setDeleteWithTransacoesId(eventoId);
    } else {
      setDeleteId(eventoId);
    }
  };

  const handleDelete = async (excluirTransacoes = false) => {
    const id = excluirTransacoes ? deleteWithTransacoesId : deleteId;
    if (!id) return;

    setIsDeleting(true);
    const result = await deleteEvento(id, excluirTransacoes);
    setIsDeleting(false);

    if (result.error && result.error !== "TRANSACOES_VINCULADAS") {
      toast.error("Erro ao excluir evento", { description: result.error });
    } else if (result.success) {
      toast.success("Evento excluído com sucesso", {
        description: excluirTransacoes
          ? `${transacoesVinculadas} transação(ões) também foram excluídas.`
          : undefined,
      });
    }

    setDeleteId(null);
    setDeleteWithTransacoesId(null);
  };

  const formatDate = (date: string) => {
    return new Date(date).toLocaleDateString("pt-BR", {
      day: "2-digit",
      month: "short",
      year: "numeric",
    });
  };

  const formatCurrency = (value: number) => {
    return new Intl.NumberFormat("pt-BR", {
      style: "currency",
      currency: "BRL",
    }).format(value);
  };

  if (eventos.length === 0) {
    return (
      <div className="flex flex-col items-center justify-center py-12 text-center">
        <div className="w-16 h-16 rounded-full bg-muted flex items-center justify-center mb-4">
          <Calendar className="w-8 h-8 text-muted-foreground" />
        </div>
        <h3 className="text-lg font-medium text-foreground">
          Nenhum evento encontrado
        </h3>
        <p className="text-sm text-muted-foreground mt-1">
          Comece criando seu primeiro evento
        </p>
      </div>
    );
  }

  return (
    <>
      <div className="rounded-lg border border-border overflow-hidden">
        <Table>
          <TableHeader>
            <TableRow className="bg-muted/50">
              <TableHead className="font-semibold">Evento</TableHead>
              <TableHead className="font-semibold">Tipo</TableHead>
              <TableHead className="font-semibold">Data</TableHead>
              <TableHead className="font-semibold">Cliente</TableHead>
              <TableHead className="font-semibold">Status</TableHead>
              <TableHead className="font-semibold text-right">Valor</TableHead>
              <TableHead className="w-[50px]"></TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {eventos.map((evento) => (
              <TableRow
                key={evento.id}
                className="cursor-pointer hover:bg-accent/50"
                onClick={() => onView(evento)}
              >
                <TableCell>
                  <div className="flex flex-col">
                    <span className="font-medium">{evento.nome}</span>
                    {evento.local && (
                      <span className="text-xs text-muted-foreground flex items-center gap-1 mt-0.5">
                        <MapPin className="w-3 h-3" />
                        {evento.local}
                      </span>
                    )}
                  </div>
                </TableCell>
                <TableCell>
                  <div className="flex items-center gap-2">
                    <span>{tipoLabels[evento.tipo]?.icon || "📅"}</span>
                    <span className="text-sm">
                      {tipoLabels[evento.tipo]?.label || evento.tipo}
                    </span>
                  </div>
                </TableCell>
                <TableCell>
                  <div className="flex flex-col">
                    <span className="text-sm">{formatDate(evento.data_inicio)}</span>
                    {evento.data_fim && evento.data_fim !== evento.data_inicio && (
                      <span className="text-xs text-muted-foreground">
                        até {formatDate(evento.data_fim)}
                      </span>
                    )}
                  </div>
                </TableCell>
                <TableCell>
                  <div className="flex flex-col">
                    <span className="text-sm">
                      {evento.contatos?.nome || "-"}
                    </span>
                  </div>
                </TableCell>
                <TableCell>
                  <Badge
                    variant="outline"
                    style={{
                      backgroundColor: `${statusConfig[evento.status]?.color}15`,
                      color: statusConfig[evento.status]?.color,
                      borderColor: `${statusConfig[evento.status]?.color}30`,
                    }}
                  >
                    {statusConfig[evento.status]?.label || evento.status}
                  </Badge>
                </TableCell>
                <TableCell className="text-right">
                  <div className="flex items-center justify-end gap-2">
                    <span className="font-medium text-primary">
                      {formatCurrency(evento.valor_total || 0)}
                    </span>
                    {(() => {
                      const statusFin = getStatusFinanceiro(evento);
                      if (statusFin.icon && evento.valor_total && evento.valor_total > 0) {
                        const Icon = statusFin.icon;
                        return (
                          <TooltipProvider>
                            <Tooltip>
                              <TooltipTrigger asChild>
                                <Icon 
                                  className="h-4 w-4" 
                                  style={{ color: statusFin.color }}
                                />
                              </TooltipTrigger>
                              <TooltipContent>
                                <p>{statusFin.label}</p>
                              </TooltipContent>
                            </Tooltip>
                          </TooltipProvider>
                        );
                      }
                      return null;
                    })()}
                  </div>
                </TableCell>
                <TableCell onClick={(e) => e.stopPropagation()}>
                  <DropdownMenu>
                    <DropdownMenuTrigger asChild>
                      <Button variant="ghost" size="icon" className="h-8 w-8">
                        <MoreHorizontal className="h-4 w-4" />
                      </Button>
                    </DropdownMenuTrigger>
                    <DropdownMenuContent align="end">
                      <DropdownMenuItem onClick={() => onView(evento)}>
                        <Eye className="w-4 h-4 mr-2" />
                        Visualizar
                      </DropdownMenuItem>
                      <DropdownMenuItem onClick={() => onEdit(evento)}>
                        <Pencil className="w-4 h-4 mr-2" />
                        Editar
                      </DropdownMenuItem>
                      <DropdownMenuSeparator />
                      <DropdownMenuItem
                        onClick={() => handleOpenDeleteDialog(evento.id)}
                        disabled={checkingTransacoes === evento.id}
                        className="text-destructive focus:text-destructive"
                      >
                        <Trash2 className="w-4 h-4 mr-2" />
                        {checkingTransacoes === evento.id ? "Verificando..." : "Excluir"}
                      </DropdownMenuItem>
                    </DropdownMenuContent>
                  </DropdownMenu>
                </TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </div>

      {/* Delete Dialog - Sem transações */}
      <AlertDialog open={!!deleteId} onOpenChange={() => setDeleteId(null)}>
        <AlertDialogContent>
          <AlertDialogHeader>
            <AlertDialogTitle>Excluir evento?</AlertDialogTitle>
            <AlertDialogDescription>
              Esta ação não pode ser desfeita. O evento será permanentemente
              removido do sistema.
            </AlertDialogDescription>
          </AlertDialogHeader>
          <AlertDialogFooter>
            <AlertDialogCancel disabled={isDeleting}>Cancelar</AlertDialogCancel>
            <AlertDialogAction
              onClick={() => handleDelete(false)}
              disabled={isDeleting}
              className="bg-destructive text-destructive-foreground hover:bg-destructive/90"
            >
              {isDeleting ? "Excluindo..." : "Excluir"}
            </AlertDialogAction>
          </AlertDialogFooter>
        </AlertDialogContent>
      </AlertDialog>

      {/* Delete Dialog - Com transações vinculadas */}
      <AlertDialog open={!!deleteWithTransacoesId} onOpenChange={() => setDeleteWithTransacoesId(null)}>
        <AlertDialogContent>
          <AlertDialogHeader>
            <AlertDialogTitle className="flex items-center gap-2">
              <AlertTriangle className="h-5 w-5 text-amber-500" />
              Evento possui transações vinculadas
            </AlertDialogTitle>
            <AlertDialogDescription asChild>
              <div className="space-y-3 text-muted-foreground text-sm">
                <p>
                  Este evento possui <strong className="text-foreground">{transacoesVinculadas}</strong> transação(ões)
                  financeira(s) vinculada(s).
                </p>
                <p className="text-amber-600 font-medium">
                  Para excluir o evento, as transações também precisam ser excluídas.
                  Esta ação não pode ser desfeita.
                </p>
              </div>
            </AlertDialogDescription>
          </AlertDialogHeader>
          <AlertDialogFooter>
            <AlertDialogCancel disabled={isDeleting}>Cancelar</AlertDialogCancel>
            <AlertDialogAction
              onClick={() => handleDelete(true)}
              disabled={isDeleting}
              className="bg-destructive text-destructive-foreground hover:bg-destructive/90"
            >
              {isDeleting ? "Excluindo..." : "Excluir evento e transações"}
            </AlertDialogAction>
          </AlertDialogFooter>
        </AlertDialogContent>
      </AlertDialog>
    </>
  );
}


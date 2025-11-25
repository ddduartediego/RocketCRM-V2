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
import { MoreHorizontal, Pencil, Trash2, Eye, Calendar, MapPin } from "lucide-react";
import { deleteEvento } from "@/actions/eventos";
import { toast } from "sonner";
import type { Evento } from "@/types/database";

interface EventoWithRelations extends Evento {
  contatos?: { id: string; nome: string } | null;
  organizacoes?: { id: string; nome: string } | null;
  users?: { id: string; nome: string; avatar_url: string | null } | null;
}

interface EventosTableProps {
  eventos: EventoWithRelations[];
  onEdit: (evento: Evento) => void;
  onView: (evento: Evento) => void;
}

const tipoLabels: Record<string, { label: string; icon: string }> = {
  viagem_pedagogica: { label: "Viagem Pedagógica", icon: "🚌" },
  viagem_formatura: { label: "Formatura", icon: "🎓" },
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

export function EventosTable({ eventos, onEdit, onView }: EventosTableProps) {
  const [deleteId, setDeleteId] = useState<string | null>(null);
  const [isDeleting, setIsDeleting] = useState(false);

  const handleDelete = async () => {
    if (!deleteId) return;

    setIsDeleting(true);
    const result = await deleteEvento(deleteId);
    setIsDeleting(false);

    if (result.error) {
      toast.error("Erro ao excluir evento", { description: result.error });
    } else {
      toast.success("Evento excluído com sucesso");
    }

    setDeleteId(null);
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
                      {evento.organizacoes?.nome || evento.contatos?.nome || "-"}
                    </span>
                    {evento.turma_serie && (
                      <span className="text-xs text-muted-foreground">
                        {evento.turma_serie}
                      </span>
                    )}
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
                  <span className="font-medium text-primary">
                    {formatCurrency(evento.valor_total || 0)}
                  </span>
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
                        onClick={() => setDeleteId(evento.id)}
                        className="text-destructive focus:text-destructive"
                      >
                        <Trash2 className="w-4 h-4 mr-2" />
                        Excluir
                      </DropdownMenuItem>
                    </DropdownMenuContent>
                  </DropdownMenu>
                </TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </div>

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
              onClick={handleDelete}
              disabled={isDeleting}
              className="bg-destructive text-destructive-foreground hover:bg-destructive/90"
            >
              {isDeleting ? "Excluindo..." : "Excluir"}
            </AlertDialogAction>
          </AlertDialogFooter>
        </AlertDialogContent>
      </AlertDialog>
    </>
  );
}


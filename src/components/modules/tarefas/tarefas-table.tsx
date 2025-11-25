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
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Checkbox } from "@/components/ui/checkbox";
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
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import {
  MoreHorizontal,
  Pencil,
  Trash2,
  CheckSquare,
  Calendar,
  Flag,
} from "lucide-react";
import { toast } from "sonner";
import { format, isPast, isToday } from "date-fns";
import { ptBR } from "date-fns/locale";
import { deleteAtividade, toggleAtividade } from "@/actions/atividades";
import { statusAtividade, prioridadeAtividade } from "@/lib/validations/atividade";
import { cn } from "@/lib/utils";

interface Atividade {
  id: string;
  titulo: string;
  descricao: string | null;
  status: string;
  prioridade: number | null;
  data_vencimento: string | null;
  evento_id: string | null;
  lead_id: string | null;
  contato_id: string | null;
  users: { id: string; nome: string; avatar_url: string | null } | null;
  eventos: { id: string; nome: string } | null;
  leads: { id: string; titulo: string } | null;
  contatos: { id: string; nome: string } | null;
}

interface TarefasTableProps {
  tarefas: Atividade[];
  onEdit: (tarefa: Atividade) => void;
}

export function TarefasTable({ tarefas, onEdit }: TarefasTableProps) {
  const [deleteId, setDeleteId] = useState<string | null>(null);
  const [isDeleting, setIsDeleting] = useState(false);
  const [togglingId, setTogglingId] = useState<string | null>(null);

  async function handleDelete() {
    if (!deleteId) return;

    setIsDeleting(true);
    const result = await deleteAtividade(deleteId);

    if (result.error) {
      toast.error(result.error);
    } else {
      toast.success("Tarefa excluída com sucesso!");
    }

    setIsDeleting(false);
    setDeleteId(null);
  }

  async function handleToggle(id: string) {
    setTogglingId(id);
    const result = await toggleAtividade(id);

    if (result.error) {
      toast.error(result.error);
    } else {
      toast.success(
        result.data?.status === "concluida"
          ? "Tarefa concluída!"
          : "Tarefa reaberta!"
      );
    }

    setTogglingId(null);
  }

  function getStatusInfo(status: string) {
    return statusAtividade.find((s) => s.value === status) || statusAtividade[0];
  }

  function getPrioridadeInfo(prioridade: number | null) {
    return prioridadeAtividade.find((p) => p.value === prioridade) || prioridadeAtividade[1];
  }

  function getVencimentoInfo(data: string | null) {
    if (!data) return null;
    const date = new Date(data);
    const isVencida = isPast(date) && !isToday(date);
    const isHoje = isToday(date);

    return {
      texto: format(date, "dd/MM/yyyy", { locale: ptBR }),
      isVencida,
      isHoje,
    };
  }

  if (tarefas.length === 0) {
    return (
      <div className="flex flex-col items-center justify-center py-12 text-center">
        <CheckSquare className="h-12 w-12 text-muted-foreground mb-4" />
        <h3 className="text-lg font-semibold">Nenhuma tarefa encontrada</h3>
        <p className="text-muted-foreground mt-1">
          Comece adicionando uma nova tarefa.
        </p>
      </div>
    );
  }

  return (
    <>
      <div className="rounded-md border">
        <Table>
          <TableHeader>
            <TableRow>
              <TableHead className="w-[50px]"></TableHead>
              <TableHead>Tarefa</TableHead>
              <TableHead>Prioridade</TableHead>
              <TableHead>Vencimento</TableHead>
              <TableHead>Responsável</TableHead>
              <TableHead>Relacionado</TableHead>
              <TableHead className="w-[80px]"></TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {tarefas.map((tarefa) => {
              const statusInfo = getStatusInfo(tarefa.status);
              const prioridadeInfo = getPrioridadeInfo(tarefa.prioridade);
              const vencimentoInfo = getVencimentoInfo(tarefa.data_vencimento);
              const isConcluida = tarefa.status === "concluida";

              return (
                <TableRow
                  key={tarefa.id}
                  className={cn(isConcluida && "opacity-60")}
                >
                  <TableCell>
                    <Checkbox
                      checked={isConcluida}
                      disabled={togglingId === tarefa.id}
                      onCheckedChange={() => handleToggle(tarefa.id)}
                      className="data-[state=checked]:bg-success data-[state=checked]:border-success"
                    />
                  </TableCell>
                  <TableCell>
                    <div>
                      <p
                        className={cn(
                          "font-medium",
                          isConcluida && "line-through text-muted-foreground"
                        )}
                      >
                        {tarefa.titulo}
                      </p>
                      {tarefa.descricao && (
                        <p className="text-sm text-muted-foreground line-clamp-1">
                          {tarefa.descricao}
                        </p>
                      )}
                    </div>
                  </TableCell>
                  <TableCell>
                    <Badge
                      variant="outline"
                      className="gap-1"
                      style={{
                        borderColor: prioridadeInfo.color,
                        color: prioridadeInfo.color,
                      }}
                    >
                      <Flag className="h-3 w-3" />
                      {prioridadeInfo.label}
                    </Badge>
                  </TableCell>
                  <TableCell>
                    {vencimentoInfo ? (
                      <div
                        className={cn(
                          "flex items-center gap-1 text-sm",
                          vencimentoInfo.isVencida &&
                            !isConcluida &&
                            "text-destructive font-medium",
                          vencimentoInfo.isHoje &&
                            !isConcluida &&
                            "text-warning font-medium"
                        )}
                      >
                        <Calendar className="h-4 w-4" />
                        {vencimentoInfo.texto}
                        {vencimentoInfo.isVencida && !isConcluida && (
                          <span className="text-xs">(atrasada)</span>
                        )}
                        {vencimentoInfo.isHoje && !isConcluida && (
                          <span className="text-xs">(hoje)</span>
                        )}
                      </div>
                    ) : (
                      <span className="text-muted-foreground">-</span>
                    )}
                  </TableCell>
                  <TableCell>
                    {tarefa.users ? (
                      <div className="flex items-center gap-2">
                        <Avatar className="h-6 w-6">
                          <AvatarImage src={tarefa.users.avatar_url || undefined} />
                          <AvatarFallback className="text-xs">
                            {tarefa.users.nome?.charAt(0).toUpperCase()}
                          </AvatarFallback>
                        </Avatar>
                        <span className="text-sm">{tarefa.users.nome}</span>
                      </div>
                    ) : (
                      <span className="text-muted-foreground">-</span>
                    )}
                  </TableCell>
                  <TableCell>
                    {tarefa.eventos && (
                      <Badge variant="outline" className="text-xs">
                        Evento: {tarefa.eventos.nome}
                      </Badge>
                    )}
                    {tarefa.leads && (
                      <Badge variant="outline" className="text-xs">
                        Lead: {tarefa.leads.titulo}
                      </Badge>
                    )}
                    {tarefa.contatos && (
                      <Badge variant="outline" className="text-xs">
                        Contato: {tarefa.contatos.nome}
                      </Badge>
                    )}
                    {!tarefa.eventos && !tarefa.leads && !tarefa.contatos && (
                      <span className="text-muted-foreground">-</span>
                    )}
                  </TableCell>
                  <TableCell>
                    <DropdownMenu>
                      <DropdownMenuTrigger asChild>
                        <Button variant="ghost" size="icon">
                          <MoreHorizontal className="h-4 w-4" />
                          <span className="sr-only">Ações</span>
                        </Button>
                      </DropdownMenuTrigger>
                      <DropdownMenuContent align="end">
                        <DropdownMenuItem onClick={() => onEdit(tarefa)}>
                          <Pencil className="mr-2 h-4 w-4" />
                          Editar
                        </DropdownMenuItem>
                        <DropdownMenuSeparator />
                        <DropdownMenuItem
                          className="text-destructive"
                          onClick={() => setDeleteId(tarefa.id)}
                        >
                          <Trash2 className="mr-2 h-4 w-4" />
                          Excluir
                        </DropdownMenuItem>
                      </DropdownMenuContent>
                    </DropdownMenu>
                  </TableCell>
                </TableRow>
              );
            })}
          </TableBody>
        </Table>
      </div>

      <AlertDialog open={!!deleteId} onOpenChange={() => setDeleteId(null)}>
        <AlertDialogContent>
          <AlertDialogHeader>
            <AlertDialogTitle>Confirmar exclusão</AlertDialogTitle>
            <AlertDialogDescription>
              Tem certeza que deseja excluir esta tarefa? Esta ação não pode ser
              desfeita.
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


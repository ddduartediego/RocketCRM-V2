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
import { Avatar, AvatarFallback } from "@/components/ui/avatar";
import {
  MoreHorizontal,
  Pencil,
  Trash2,
  Calendar,
  Phone,
  UserCog,
} from "lucide-react";
import { toast } from "sonner";
import type { MembroEquipe } from "@/types/database";
import { deleteMembro } from "@/actions/equipe";

interface EquipeTableProps {
  membros: MembroEquipe[];
  onEdit: (membro: MembroEquipe) => void;
  onViewAgenda: (membro: MembroEquipe) => void;
}

const funcaoLabels: Record<string, string> = {
  monitor: "Monitor",
  recreador: "Recreador",
  coordenador: "Coordenador",
  motorista: "Motorista",
  outro: "Outro",
};

const funcaoColors: Record<string, string> = {
  monitor: "bg-blue-500/10 text-blue-500",
  recreador: "bg-green-500/10 text-green-500",
  coordenador: "bg-purple-500/10 text-purple-500",
  motorista: "bg-orange-500/10 text-orange-500",
  outro: "bg-gray-500/10 text-gray-500",
};

const tipoContratoLabels: Record<string, string> = {
  fixo: "Fixo",
  freelancer: "Freelancer",
};

export function EquipeTable({
  membros,
  onEdit,
  onViewAgenda,
}: EquipeTableProps) {
  const [deleteId, setDeleteId] = useState<string | null>(null);
  const [isDeleting, setIsDeleting] = useState(false);

  async function handleDelete() {
    if (!deleteId) return;

    setIsDeleting(true);
    const result = await deleteMembro(deleteId);

    if (result.error) {
      toast.error(result.error);
    } else {
      toast.success("Membro excluído com sucesso!");
    }

    setIsDeleting(false);
    setDeleteId(null);
  }

  function formatCurrency(value: number | null) {
    if (value === null || value === undefined) return "-";
    return new Intl.NumberFormat("pt-BR", {
      style: "currency",
      currency: "BRL",
    }).format(value);
  }

  function getInitials(name: string) {
    return name
      .split(" ")
      .map((n) => n[0])
      .join("")
      .toUpperCase()
      .slice(0, 2);
  }

  if (membros.length === 0) {
    return (
      <div className="flex flex-col items-center justify-center py-12 text-center">
        <UserCog className="h-12 w-12 text-muted-foreground mb-4" />
        <h3 className="text-lg font-semibold">Nenhum membro encontrado</h3>
        <p className="text-muted-foreground mt-1">
          Comece adicionando um novo membro à equipe.
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
              <TableHead>Nome</TableHead>
              <TableHead>Função</TableHead>
              <TableHead>Contrato</TableHead>
              <TableHead>Contato</TableHead>
              <TableHead className="text-right">Diária</TableHead>
              <TableHead className="text-center">Status</TableHead>
              <TableHead className="w-[80px]"></TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {membros.map((membro) => (
              <TableRow key={membro.id}>
                <TableCell>
                  <div className="flex items-center gap-3">
                    <Avatar className="h-9 w-9">
                      <AvatarFallback className="bg-primary/10 text-primary text-sm">
                        {getInitials(membro.nome)}
                      </AvatarFallback>
                    </Avatar>
                    <div>
                      <p className="font-medium">{membro.nome}</p>
                      {membro.email && (
                        <p className="text-sm text-muted-foreground">
                          {membro.email}
                        </p>
                      )}
                    </div>
                  </div>
                </TableCell>
                <TableCell>
                  <Badge className={funcaoColors[membro.funcao]} variant="outline">
                    {funcaoLabels[membro.funcao]}
                  </Badge>
                </TableCell>
                <TableCell>
                  <Badge variant="secondary">
                    {tipoContratoLabels[membro.tipo_contrato]}
                  </Badge>
                </TableCell>
                <TableCell>
                  {membro.whatsapp || membro.telefone ? (
                    <div className="flex items-center gap-1.5 text-sm">
                      <Phone className="h-3.5 w-3.5 text-muted-foreground" />
                      {membro.whatsapp || membro.telefone}
                    </div>
                  ) : (
                    <span className="text-muted-foreground">-</span>
                  )}
                </TableCell>
                <TableCell className="text-right">
                  {formatCurrency(membro.valor_diaria)}
                </TableCell>
                <TableCell className="text-center">
                  <Badge variant={membro.ativo ? "default" : "secondary"}>
                    {membro.ativo ? "Ativo" : "Inativo"}
                  </Badge>
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
                      <DropdownMenuItem onClick={() => onEdit(membro)}>
                        <Pencil className="mr-2 h-4 w-4" />
                        Editar
                      </DropdownMenuItem>
                      <DropdownMenuItem onClick={() => onViewAgenda(membro)}>
                        <Calendar className="mr-2 h-4 w-4" />
                        Ver Agenda
                      </DropdownMenuItem>
                      <DropdownMenuSeparator />
                      <DropdownMenuItem
                        className="text-destructive"
                        onClick={() => setDeleteId(membro.id)}
                      >
                        <Trash2 className="mr-2 h-4 w-4" />
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
            <AlertDialogTitle>Confirmar exclusão</AlertDialogTitle>
            <AlertDialogDescription>
              Tem certeza que deseja excluir este membro da equipe? Esta ação não
              pode ser desfeita.
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


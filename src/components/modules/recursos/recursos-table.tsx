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
import {
  MoreHorizontal,
  Pencil,
  Trash2,
  Package,
  Car,
  Home,
  Wrench,
  Box,
  Calendar,
} from "lucide-react";
import { toast } from "sonner";
import type { Recurso } from "@/types/database";
import { deleteRecurso } from "@/actions/recursos";

interface RecursosTableProps {
  recursos: Recurso[];
  onEdit: (recurso: Recurso) => void;
  onViewAlocacoes: (recurso: Recurso) => void;
}

const tipoIcons: Record<string, React.ElementType> = {
  brinquedo: Package,
  veiculo: Car,
  espaco: Home,
  equipamento: Wrench,
  outro: Box,
};

const tipoLabels: Record<string, string> = {
  brinquedo: "Brinquedo",
  veiculo: "Veículo",
  espaco: "Espaço",
  equipamento: "Equipamento",
  outro: "Outro",
};

export function RecursosTable({
  recursos,
  onEdit,
  onViewAlocacoes,
}: RecursosTableProps) {
  const [deleteId, setDeleteId] = useState<string | null>(null);
  const [isDeleting, setIsDeleting] = useState(false);

  async function handleDelete() {
    if (!deleteId) return;

    setIsDeleting(true);
    const result = await deleteRecurso(deleteId);

    if (result.error) {
      toast.error(result.error);
    } else {
      toast.success("Recurso excluído com sucesso!");
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

  if (recursos.length === 0) {
    return (
      <div className="flex flex-col items-center justify-center py-12 text-center">
        <Package className="h-12 w-12 text-muted-foreground mb-4" />
        <h3 className="text-lg font-semibold">Nenhum recurso encontrado</h3>
        <p className="text-muted-foreground mt-1">
          Comece adicionando um novo recurso.
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
              <TableHead>Tipo</TableHead>
              <TableHead className="text-center">Quantidade</TableHead>
              <TableHead className="text-center">Capacidade</TableHead>
              <TableHead className="text-right">Custo Unit.</TableHead>
              <TableHead className="text-center">Status</TableHead>
              <TableHead className="w-[80px]"></TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {recursos.map((recurso) => {
              const Icon = tipoIcons[recurso.tipo] || Box;

              return (
                <TableRow key={recurso.id}>
                  <TableCell>
                    <div className="flex items-center gap-3">
                      <div className="h-9 w-9 rounded-lg bg-primary/10 flex items-center justify-center">
                        <Icon className="h-4 w-4 text-primary" />
                      </div>
                      <div>
                        <p className="font-medium">{recurso.nome}</p>
                        {recurso.descricao && (
                          <p className="text-sm text-muted-foreground line-clamp-1">
                            {recurso.descricao}
                          </p>
                        )}
                      </div>
                    </div>
                  </TableCell>
                  <TableCell>
                    <Badge variant="outline">{tipoLabels[recurso.tipo]}</Badge>
                  </TableCell>
                  <TableCell className="text-center font-medium">
                    {recurso.quantidade}
                  </TableCell>
                  <TableCell className="text-center">
                    {recurso.capacidade || "-"}
                  </TableCell>
                  <TableCell className="text-right">
                    {formatCurrency(recurso.custo_unitario)}
                  </TableCell>
                  <TableCell className="text-center">
                    <Badge variant={recurso.ativo ? "default" : "secondary"}>
                      {recurso.ativo ? "Ativo" : "Inativo"}
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
                        <DropdownMenuItem onClick={() => onEdit(recurso)}>
                          <Pencil className="mr-2 h-4 w-4" />
                          Editar
                        </DropdownMenuItem>
                        <DropdownMenuItem onClick={() => onViewAlocacoes(recurso)}>
                          <Calendar className="mr-2 h-4 w-4" />
                          Ver Alocações
                        </DropdownMenuItem>
                        <DropdownMenuSeparator />
                        <DropdownMenuItem
                          className="text-destructive"
                          onClick={() => setDeleteId(recurso.id)}
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
              Tem certeza que deseja excluir este recurso? Esta ação não pode ser
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


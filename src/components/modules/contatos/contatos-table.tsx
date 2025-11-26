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
import { MoreHorizontal, Pencil, Trash2, Eye, Phone, Mail } from "lucide-react";
import { deleteContato } from "@/actions/contatos";
import { toast } from "sonner";
import type { Contato } from "@/types/database";

interface ContatosTableProps {
  contatos: (Contato & { organizacoes?: { nome: string } | null })[];
  onEdit: (contato: Contato) => void;
  onView: (contato: Contato) => void;
}

const tipoLabels: Record<string, string> = {
  pessoa_fisica: "Pessoa Física",
  empresa: "Empresa",
  fornecedor: "Fornecedor",
};

const tipoBadgeColors: Record<string, string> = {
  pessoa_fisica: "bg-info/10 text-info border-info/20",
  empresa: "bg-warning/10 text-warning border-warning/20",
  fornecedor: "bg-secondary-soft/10 text-secondary-soft border-secondary-soft/20",
};

export function ContatosTable({ contatos, onEdit, onView }: ContatosTableProps) {
  const [deleteId, setDeleteId] = useState<string | null>(null);
  const [isDeleting, setIsDeleting] = useState(false);

  const handleDelete = async () => {
    if (!deleteId) return;

    setIsDeleting(true);
    const result = await deleteContato(deleteId);
    setIsDeleting(false);

    if (result.error) {
      toast.error("Erro ao excluir contato", {
        description: result.error,
      });
    } else {
      toast.success("Contato excluído com sucesso");
    }

    setDeleteId(null);
  };

  if (contatos.length === 0) {
    return (
      <div className="flex flex-col items-center justify-center py-12 text-center">
        <div className="w-16 h-16 rounded-full bg-muted flex items-center justify-center mb-4">
          <Phone className="w-8 h-8 text-muted-foreground" />
        </div>
        <h3 className="text-lg font-medium text-foreground">
          Nenhum contato encontrado
        </h3>
        <p className="text-sm text-muted-foreground mt-1">
          Comece adicionando seu primeiro contato
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
              <TableHead className="font-semibold">Nome</TableHead>
              <TableHead className="font-semibold">Tipo</TableHead>
              <TableHead className="font-semibold">Contato</TableHead>
              <TableHead className="font-semibold">Organização</TableHead>
              <TableHead className="font-semibold">Cidade</TableHead>
              <TableHead className="w-[50px]"></TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {contatos.map((contato) => (
              <TableRow
                key={contato.id}
                className="cursor-pointer hover:bg-accent/50"
                onClick={() => onView(contato)}
              >
                <TableCell>
                  <div className="flex flex-col">
                    <span className="font-medium">{contato.nome}</span>
                    {contato.tags && contato.tags.length > 0 && (
                      <div className="flex gap-1 mt-1">
                        {contato.tags.slice(0, 2).map((tag) => (
                          <Badge
                            key={tag}
                            variant="outline"
                            className="text-[10px] px-1.5 py-0 bg-primary-soft/10 text-primary border-primary/20"
                          >
                            {tag}
                          </Badge>
                        ))}
                        {contato.tags.length > 2 && (
                          <Badge variant="outline" className="text-[10px] px-1.5 py-0">
                            +{contato.tags.length - 2}
                          </Badge>
                        )}
                      </div>
                    )}
                  </div>
                </TableCell>
                <TableCell>
                  <Badge
                    variant="outline"
                    className={tipoBadgeColors[contato.tipo] || ""}
                  >
                    {tipoLabels[contato.tipo] || contato.tipo}
                  </Badge>
                </TableCell>
                <TableCell>
                  <div className="flex flex-col gap-0.5 text-sm">
                    {contato.whatsapp && (
                      <span className="flex items-center gap-1.5 text-muted-foreground">
                        <Phone className="w-3 h-3" />
                        {contato.whatsapp}
                      </span>
                    )}
                    {contato.email && (
                      <span className="flex items-center gap-1.5 text-muted-foreground">
                        <Mail className="w-3 h-3" />
                        {contato.email}
                      </span>
                    )}
                    {!contato.whatsapp && !contato.email && (
                      <span className="text-muted-foreground/50">-</span>
                    )}
                  </div>
                </TableCell>
                <TableCell>
                  <span className="text-sm text-muted-foreground">
                    {contato.organizacoes?.nome || "-"}
                  </span>
                </TableCell>
                <TableCell>
                  <span className="text-sm text-muted-foreground">
                    {contato.cidade
                      ? `${contato.cidade}${contato.estado ? `/${contato.estado}` : ""}`
                      : "-"}
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
                      <DropdownMenuItem onClick={() => onView(contato)}>
                        <Eye className="w-4 h-4 mr-2" />
                        Visualizar
                      </DropdownMenuItem>
                      <DropdownMenuItem onClick={() => onEdit(contato)}>
                        <Pencil className="w-4 h-4 mr-2" />
                        Editar
                      </DropdownMenuItem>
                      <DropdownMenuSeparator />
                      <DropdownMenuItem
                        onClick={() => setDeleteId(contato.id)}
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
            <AlertDialogTitle>Excluir contato?</AlertDialogTitle>
            <AlertDialogDescription>
              Esta ação não pode ser desfeita. O contato será permanentemente
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


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
  CheckCircle,
  ArrowUpCircle,
  ArrowDownCircle,
  DollarSign,
} from "lucide-react";
import { toast } from "sonner";
import { format } from "date-fns";
import { ptBR } from "date-fns/locale";
import { deleteTransacao, marcarComoPago } from "@/actions/financeiro";

interface Transacao {
  id: string;
  descricao: string;
  tipo: string;
  valor: number;
  data_vencimento: string;
  data_pagamento: string | null;
  status: string;
  forma_pagamento: string | null;
  categorias_financeiras: { id: string; nome: string; cor: string } | null;
  eventos: { id: string; nome: string } | null;
  contatos: { id: string; nome: string } | null;
}

interface TransacoesTableProps {
  transacoes: Transacao[];
  onEdit: (transacao: Transacao) => void;
}

const statusConfig: Record<string, { label: string; color: string }> = {
  pendente: { label: "Pendente", color: "bg-yellow-500/10 text-yellow-600" },
  pago: { label: "Pago", color: "bg-green-500/10 text-green-600" },
  em_atraso: { label: "Em Atraso", color: "bg-red-500/10 text-red-600" },
  cancelado: { label: "Cancelado", color: "bg-gray-500/10 text-gray-600" },
};

export function TransacoesTable({ transacoes, onEdit }: TransacoesTableProps) {
  const [deleteId, setDeleteId] = useState<string | null>(null);
  const [isDeleting, setIsDeleting] = useState(false);
  const [markingPaid, setMarkingPaid] = useState<string | null>(null);

  async function handleDelete() {
    if (!deleteId) return;

    setIsDeleting(true);
    const result = await deleteTransacao(deleteId);

    if (result.error) {
      toast.error(result.error);
    } else {
      toast.success("Transação excluída com sucesso!");
    }

    setIsDeleting(false);
    setDeleteId(null);
  }

  async function handleMarcarPago(id: string) {
    setMarkingPaid(id);
    const result = await marcarComoPago(id);

    if (result.error) {
      toast.error(result.error);
    } else {
      toast.success("Transação marcada como paga!");
    }

    setMarkingPaid(null);
  }

  function formatCurrency(value: number) {
    return new Intl.NumberFormat("pt-BR", {
      style: "currency",
      currency: "BRL",
    }).format(value);
  }

  if (transacoes.length === 0) {
    return (
      <div className="flex flex-col items-center justify-center py-12 text-center">
        <DollarSign className="h-12 w-12 text-muted-foreground mb-4" />
        <h3 className="text-lg font-semibold">Nenhuma transação encontrada</h3>
        <p className="text-muted-foreground mt-1">
          Comece adicionando uma nova transação.
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
              <TableHead>Descrição</TableHead>
              <TableHead>Categoria</TableHead>
              <TableHead>Vencimento</TableHead>
              <TableHead className="text-right">Valor</TableHead>
              <TableHead className="text-center">Status</TableHead>
              <TableHead className="w-[80px]"></TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {transacoes.map((transacao) => {
              const isReceita = transacao.tipo === "receita";
              const statusInfo = statusConfig[transacao.status] || statusConfig.pendente;

              return (
                <TableRow key={transacao.id}>
                  <TableCell>
                    <div className="flex items-center gap-3">
                      <div
                        className={`h-9 w-9 rounded-lg flex items-center justify-center ${
                          isReceita
                            ? "bg-green-500/10 text-green-600"
                            : "bg-red-500/10 text-red-600"
                        }`}
                      >
                        {isReceita ? (
                          <ArrowUpCircle className="h-4 w-4" />
                        ) : (
                          <ArrowDownCircle className="h-4 w-4" />
                        )}
                      </div>
                      <div>
                        <p className="font-medium">{transacao.descricao}</p>
                        {transacao.eventos && (
                          <p className="text-sm text-muted-foreground">
                            {transacao.eventos.nome}
                          </p>
                        )}
                      </div>
                    </div>
                  </TableCell>
                  <TableCell>
                    {transacao.categorias_financeiras ? (
                      <Badge
                        variant="outline"
                        style={{
                          borderColor: transacao.categorias_financeiras.cor || undefined,
                          color: transacao.categorias_financeiras.cor || undefined,
                        }}
                      >
                        {transacao.categorias_financeiras.nome}
                      </Badge>
                    ) : (
                      <span className="text-muted-foreground">-</span>
                    )}
                  </TableCell>
                  <TableCell>
                    <div>
                      <p>
                        {format(new Date(transacao.data_vencimento), "dd/MM/yyyy", {
                          locale: ptBR,
                        })}
                      </p>
                      {transacao.data_pagamento && (
                        <p className="text-xs text-muted-foreground">
                          Pago em{" "}
                          {format(new Date(transacao.data_pagamento), "dd/MM/yyyy", {
                            locale: ptBR,
                          })}
                        </p>
                      )}
                    </div>
                  </TableCell>
                  <TableCell
                    className={`text-right font-semibold ${
                      isReceita ? "text-green-600" : "text-red-600"
                    }`}
                  >
                    {isReceita ? "+" : "-"} {formatCurrency(transacao.valor)}
                  </TableCell>
                  <TableCell className="text-center">
                    <Badge className={statusInfo.color} variant="outline">
                      {statusInfo.label}
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
                        <DropdownMenuItem onClick={() => onEdit(transacao)}>
                          <Pencil className="mr-2 h-4 w-4" />
                          Editar
                        </DropdownMenuItem>
                        {transacao.status === "pendente" && (
                          <DropdownMenuItem
                            onClick={() => handleMarcarPago(transacao.id)}
                            disabled={markingPaid === transacao.id}
                          >
                            <CheckCircle className="mr-2 h-4 w-4" />
                            Marcar como Pago
                          </DropdownMenuItem>
                        )}
                        <DropdownMenuSeparator />
                        <DropdownMenuItem
                          className="text-destructive"
                          onClick={() => setDeleteId(transacao.id)}
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
              Tem certeza que deseja excluir esta transação? Esta ação não pode
              ser desfeita.
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


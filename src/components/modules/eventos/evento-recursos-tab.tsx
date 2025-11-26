"use client";

import { useState, useTransition, useCallback } from "react";
import { useRouter } from "next/navigation";
import {
  Package,
  Plus,
  Pencil,
  Trash2,
  Calendar,
} from "lucide-react";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
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
import { Checkbox } from "@/components/ui/checkbox";
import { AlocacaoRecursoForm } from "./alocacao-recurso-form";
import { deleteAlocacaoRecurso } from "@/actions/recursos";
import { toast } from "sonner";
import { format } from "date-fns";
import { ptBR } from "date-fns/locale";
import { tiposRecurso } from "@/lib/validations/recurso";
import type { AlocacaoRecurso } from "@/types/database";

interface AlocacaoRecursoWithRecurso extends AlocacaoRecurso {
  recursos?: {
    id: string;
    nome: string;
    tipo: string;
    quantidade: number;
    custo_unitario: number | null;
  } | null;
}

interface EventoRecursosTabProps {
  eventoId: string;
  eventoNome: string;
  eventoDataInicio: string;
  eventoDataFim?: string | null;
  alocacoes: AlocacaoRecursoWithRecurso[];
}

export function EventoRecursosTab({
  eventoId,
  eventoNome,
  eventoDataInicio,
  eventoDataFim,
  alocacoes,
}: EventoRecursosTabProps) {
  const router = useRouter();
  const [isPending, startTransition] = useTransition();
  const [formOpen, setFormOpen] = useState(false);
  const [selectedAlocacao, setSelectedAlocacao] = useState<AlocacaoRecursoWithRecurso | null>(null);
  const [deleteDialogOpen, setDeleteDialogOpen] = useState(false);
  const [alocacaoToDelete, setAlocacaoToDelete] = useState<AlocacaoRecursoWithRecurso | null>(null);
  const [excluirTransacao, setExcluirTransacao] = useState(true);

  const formatCurrency = useCallback((value: number | null) => {
    if (value === null || value === undefined) return "-";
    return new Intl.NumberFormat("pt-BR", {
      style: "currency",
      currency: "BRL",
    }).format(value);
  }, []);

  const handleAdd = () => {
    setSelectedAlocacao(null);
    setFormOpen(true);
  };

  const handleEdit = (alocacao: AlocacaoRecursoWithRecurso) => {
    setSelectedAlocacao(alocacao);
    setFormOpen(true);
  };

  const handleDeleteClick = (alocacao: AlocacaoRecursoWithRecurso) => {
    setAlocacaoToDelete(alocacao);
    setExcluirTransacao(true);
    setDeleteDialogOpen(true);
  };

  const handleDeleteConfirm = () => {
    if (!alocacaoToDelete) return;

    startTransition(async () => {
      const result = await deleteAlocacaoRecurso(alocacaoToDelete.id, excluirTransacao);

      if (result.error) {
        toast.error("Erro ao excluir alocação", { description: result.error });
      } else {
        toast.success("Alocação excluída com sucesso");
        router.refresh();
      }
      setDeleteDialogOpen(false);
      setAlocacaoToDelete(null);
    });
  };

  const handleFormSuccess = () => {
    router.refresh();
  };

  const totalValor = alocacoes.reduce((acc, a) => acc + (a.valor || 0), 0);

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div className="flex items-center gap-2">
          <Package className="h-5 w-5 text-muted-foreground" />
          <h3 className="text-lg font-semibold">Recursos Alocados</h3>
          <Badge variant="secondary">{alocacoes.length}</Badge>
        </div>
        <Button onClick={handleAdd}>
          <Plus className="h-4 w-4 mr-2" />
          Adicionar Recurso
        </Button>
      </div>

      {/* Resumo */}
      {alocacoes.length > 0 && (
        <Card>
          <CardHeader className="pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              Total de Custos com Recursos
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-primary">
              {formatCurrency(totalValor)}
            </div>
            <p className="text-xs text-muted-foreground">
              {alocacoes.length} recurso(s) alocado(s)
            </p>
          </CardContent>
        </Card>
      )}

      {/* Lista de Alocações */}
      {alocacoes.length === 0 ? (
        <Card>
          <CardContent className="flex flex-col items-center justify-center py-12">
            <Package className="h-12 w-12 text-muted-foreground mb-4" />
            <h3 className="text-lg font-semibold">Nenhum recurso alocado</h3>
            <p className="text-muted-foreground text-center mt-1">
              Adicione recursos (brinquedos, veículos, etc) para este evento.
            </p>
            <Button onClick={handleAdd} className="mt-4">
              <Plus className="h-4 w-4 mr-2" />
              Adicionar Recurso
            </Button>
          </CardContent>
        </Card>
      ) : (
        <Card>
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>Recurso</TableHead>
                <TableHead>Tipo</TableHead>
                <TableHead className="text-center">Qtd</TableHead>
                <TableHead>Período</TableHead>
                <TableHead className="text-right">Valor</TableHead>
                <TableHead className="w-[100px]"></TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {alocacoes.map((alocacao) => (
                <TableRow key={alocacao.id}>
                  <TableCell>
                    <p className="font-medium">{alocacao.recursos?.nome || "N/A"}</p>
                    {alocacao.observacoes && (
                      <p className="text-xs text-muted-foreground truncate max-w-[200px]">
                        {alocacao.observacoes}
                      </p>
                    )}
                  </TableCell>
                  <TableCell>
                    <Badge variant="outline">
                      {tiposRecurso.find((t) => t.value === alocacao.recursos?.tipo)?.label || alocacao.recursos?.tipo}
                    </Badge>
                  </TableCell>
                  <TableCell className="text-center">
                    <Badge variant="secondary">{alocacao.quantidade}</Badge>
                  </TableCell>
                  <TableCell>
                    <div className="flex items-center gap-1 text-sm">
                      <Calendar className="h-3.5 w-3.5 text-muted-foreground" />
                      <span>
                        {format(new Date(alocacao.data_inicio), "dd/MM", { locale: ptBR })}
                        {alocacao.data_fim !== alocacao.data_inicio && (
                          <> - {format(new Date(alocacao.data_fim), "dd/MM", { locale: ptBR })}</>
                        )}
                      </span>
                    </div>
                  </TableCell>
                  <TableCell className="text-right font-medium">
                    {formatCurrency(alocacao.valor)}
                  </TableCell>
                  <TableCell>
                    <div className="flex items-center justify-end gap-1">
                      <Button
                        variant="ghost"
                        size="icon"
                        onClick={() => handleEdit(alocacao)}
                      >
                        <Pencil className="h-4 w-4" />
                      </Button>
                      <Button
                        variant="ghost"
                        size="icon"
                        className="text-destructive hover:text-destructive"
                        onClick={() => handleDeleteClick(alocacao)}
                      >
                        <Trash2 className="h-4 w-4" />
                      </Button>
                    </div>
                  </TableCell>
                </TableRow>
              ))}
            </TableBody>
          </Table>
        </Card>
      )}

      {/* Form Modal */}
      <AlocacaoRecursoForm
        open={formOpen}
        onOpenChange={setFormOpen}
        eventoId={eventoId}
        eventoDataInicio={eventoDataInicio}
        eventoDataFim={eventoDataFim}
        alocacao={selectedAlocacao}
        onSuccess={handleFormSuccess}
      />

      {/* Delete Dialog */}
      <AlertDialog open={deleteDialogOpen} onOpenChange={setDeleteDialogOpen}>
        <AlertDialogContent>
          <AlertDialogHeader>
            <AlertDialogTitle>Excluir alocação?</AlertDialogTitle>
            <AlertDialogDescription>
              Deseja excluir a alocação de{" "}
              <strong>{alocacaoToDelete?.recursos?.nome}</strong> deste evento?
            </AlertDialogDescription>
          </AlertDialogHeader>

          {alocacaoToDelete?.transacao_id && (
            <div className="flex items-center space-x-2 py-4">
              <Checkbox
                id="excluir-transacao-recurso"
                checked={excluirTransacao}
                onCheckedChange={(checked) => setExcluirTransacao(checked === true)}
              />
              <label
                htmlFor="excluir-transacao-recurso"
                className="text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70"
              >
                Excluir também a transação financeira vinculada
              </label>
            </div>
          )}

          <AlertDialogFooter>
            <AlertDialogCancel disabled={isPending}>Cancelar</AlertDialogCancel>
            <AlertDialogAction
              onClick={handleDeleteConfirm}
              disabled={isPending}
              className="bg-destructive text-destructive-foreground hover:bg-destructive/90"
            >
              {isPending ? "Excluindo..." : "Excluir"}
            </AlertDialogAction>
          </AlertDialogFooter>
        </AlertDialogContent>
      </AlertDialog>
    </div>
  );
}


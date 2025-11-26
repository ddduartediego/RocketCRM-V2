"use client";

import { useState, useTransition, useCallback } from "react";
import { useRouter } from "next/navigation";
import {
  Users,
  Plus,
  Pencil,
  Trash2,
  Phone,
  Clock,
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
import { AlocacaoEquipeForm } from "./alocacao-equipe-form";
import { deleteAlocacaoEquipe } from "@/actions/equipe";
import { toast } from "sonner";
import { format } from "date-fns";
import { ptBR } from "date-fns/locale";
import { funcoesEquipe } from "@/lib/validations/equipe";
import type { AlocacaoEquipe } from "@/types/database";

interface AlocacaoEquipeWithMembro extends AlocacaoEquipe {
  equipe?: {
    id: string;
    nome: string;
    funcao: string;
    telefone: string | null;
    whatsapp: string | null;
    valor_diaria: number | null;
  } | null;
}

interface EventoEquipeTabProps {
  eventoId: string;
  eventoNome: string;
  eventoDataInicio: string;
  eventoDataFim?: string | null;
  alocacoes: AlocacaoEquipeWithMembro[];
}

export function EventoEquipeTab({
  eventoId,
  eventoNome,
  eventoDataInicio,
  eventoDataFim,
  alocacoes,
}: EventoEquipeTabProps) {
  const router = useRouter();
  const [isPending, startTransition] = useTransition();
  const [formOpen, setFormOpen] = useState(false);
  const [selectedAlocacao, setSelectedAlocacao] = useState<AlocacaoEquipeWithMembro | null>(null);
  const [deleteDialogOpen, setDeleteDialogOpen] = useState(false);
  const [alocacaoToDelete, setAlocacaoToDelete] = useState<AlocacaoEquipeWithMembro | null>(null);
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

  const handleEdit = (alocacao: AlocacaoEquipeWithMembro) => {
    setSelectedAlocacao(alocacao);
    setFormOpen(true);
  };

  const handleDeleteClick = (alocacao: AlocacaoEquipeWithMembro) => {
    setAlocacaoToDelete(alocacao);
    setExcluirTransacao(true);
    setDeleteDialogOpen(true);
  };

  const handleDeleteConfirm = () => {
    if (!alocacaoToDelete) return;

    startTransition(async () => {
      const result = await deleteAlocacaoEquipe(alocacaoToDelete.id, excluirTransacao);

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

  const totalValor = alocacoes.reduce((acc, a) => acc + (a.valor_pago || 0), 0);

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div className="flex items-center gap-2">
          <Users className="h-5 w-5 text-muted-foreground" />
          <h3 className="text-lg font-semibold">Equipe Alocada</h3>
          <Badge variant="secondary">{alocacoes.length}</Badge>
        </div>
        <Button onClick={handleAdd}>
          <Plus className="h-4 w-4 mr-2" />
          Adicionar Membro
        </Button>
      </div>

      {/* Resumo */}
      {alocacoes.length > 0 && (
        <Card>
          <CardHeader className="pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              Total de Custos com Equipe
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-primary">
              {formatCurrency(totalValor)}
            </div>
            <p className="text-xs text-muted-foreground">
              {alocacoes.length} membro(s) alocado(s)
            </p>
          </CardContent>
        </Card>
      )}

      {/* Lista de Alocações */}
      {alocacoes.length === 0 ? (
        <Card>
          <CardContent className="flex flex-col items-center justify-center py-12">
            <Users className="h-12 w-12 text-muted-foreground mb-4" />
            <h3 className="text-lg font-semibold">Nenhum membro alocado</h3>
            <p className="text-muted-foreground text-center mt-1">
              Adicione membros da equipe para este evento.
            </p>
            <Button onClick={handleAdd} className="mt-4">
              <Plus className="h-4 w-4 mr-2" />
              Adicionar Membro
            </Button>
          </CardContent>
        </Card>
      ) : (
        <Card>
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>Membro</TableHead>
                <TableHead>Função</TableHead>
                <TableHead>Data</TableHead>
                <TableHead>Horário</TableHead>
                <TableHead className="text-right">Valor</TableHead>
                <TableHead className="w-[100px]"></TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {alocacoes.map((alocacao) => (
                <TableRow key={alocacao.id}>
                  <TableCell>
                    <div>
                      <p className="font-medium">{alocacao.equipe?.nome || "N/A"}</p>
                      {alocacao.equipe?.telefone && (
                        <p className="text-xs text-muted-foreground flex items-center gap-1">
                          <Phone className="h-3 w-3" />
                          {alocacao.equipe.telefone}
                        </p>
                      )}
                    </div>
                  </TableCell>
                  <TableCell>
                    <div>
                      <Badge variant="outline">
                        {funcoesEquipe.find((f) => f.value === alocacao.equipe?.funcao)?.label || alocacao.equipe?.funcao}
                      </Badge>
                      {alocacao.funcao_evento && (
                        <p className="text-xs text-muted-foreground mt-1">
                          {alocacao.funcao_evento}
                        </p>
                      )}
                    </div>
                  </TableCell>
                  <TableCell>
                    <div className="flex items-center gap-1 text-sm">
                      <Calendar className="h-3.5 w-3.5 text-muted-foreground" />
                      {format(new Date(alocacao.data), "dd/MM/yyyy", { locale: ptBR })}
                    </div>
                  </TableCell>
                  <TableCell>
                    {alocacao.hora_inicio || alocacao.hora_fim ? (
                      <div className="flex items-center gap-1 text-sm">
                        <Clock className="h-3.5 w-3.5 text-muted-foreground" />
                        {alocacao.hora_inicio || "?"} - {alocacao.hora_fim || "?"}
                      </div>
                    ) : (
                      <span className="text-muted-foreground">-</span>
                    )}
                  </TableCell>
                  <TableCell className="text-right font-medium">
                    {formatCurrency(alocacao.valor_pago)}
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
      <AlocacaoEquipeForm
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
              <strong>{alocacaoToDelete?.equipe?.nome}</strong> deste evento?
            </AlertDialogDescription>
          </AlertDialogHeader>

          {alocacaoToDelete?.transacao_id && (
            <div className="flex items-center space-x-2 py-4">
              <Checkbox
                id="excluir-transacao"
                checked={excluirTransacao}
                onCheckedChange={(checked) => setExcluirTransacao(checked === true)}
              />
              <label
                htmlFor="excluir-transacao"
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


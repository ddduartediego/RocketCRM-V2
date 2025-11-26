"use client";

import { useState } from "react";
import { Plus, AlertTriangle, TrendingUp, TrendingDown } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import { TransacaoForm } from "@/components/modules/financeiro/transacao-form";
import { marcarComoPago } from "@/actions/financeiro";
import { toast } from "sonner";
import type { TransacaoFinanceira } from "@/types/database";

interface TransacaoWithRelations extends TransacaoFinanceira {
  categorias_financeiras?: { id: string; nome: string; cor: string | null } | null;
}

interface EventoFinanceiroTabProps {
  eventoId: string;
  transacoes: TransacaoWithRelations[];
  resumoFinanceiro: {
    totalReceitas: number;
    totalDespesas: number;
    lucro: number;
  };
  valorTotalEvento: number;
}

const statusConfig: Record<string, { label: string; color: string }> = {
  pendente: { label: "Pendente", color: "#eab308" },
  pago: { label: "Pago", color: "#22c55e" },
  em_atraso: { label: "Em Atraso", color: "#dc2626" },
  cancelado: { label: "Cancelado", color: "#6b7280" },
};

export function EventoFinanceiroTab({
  eventoId,
  transacoes,
  resumoFinanceiro,
  valorTotalEvento,
}: EventoFinanceiroTabProps) {
  const [formOpen, setFormOpen] = useState(false);
  const [selectedTransacao, setSelectedTransacao] = useState<TransacaoFinanceira | null>(null);

  const formatCurrency = (value: number) => {
    return new Intl.NumberFormat("pt-BR", {
      style: "currency",
      currency: "BRL",
    }).format(value);
  };

  const formatDate = (date: string) => {
    return new Date(date).toLocaleDateString("pt-BR", {
      day: "2-digit",
      month: "short",
      year: "numeric",
    });
  };

  const handleMarcarPago = async (id: string) => {
    const result = await marcarComoPago(id);
    if (result.error) {
      toast.error("Erro ao marcar como pago", { description: result.error });
    } else {
      toast.success("Transação marcada como paga!");
    }
  };

  const handleEdit = (transacao: TransacaoFinanceira) => {
    setSelectedTransacao(transacao);
    setFormOpen(true);
  };

  const handleFormClose = (open: boolean) => {
    setFormOpen(open);
    if (!open) {
      setSelectedTransacao(null);
    }
  };

  const diferencaValorTotal = valorTotalEvento - resumoFinanceiro.totalReceitas;
  const temDiscrepancia = valorTotalEvento > 0 && Math.abs(diferencaValorTotal) > 0.01;

  const receitas = transacoes.filter((t) => t.tipo === "receita");
  const despesas = transacoes.filter((t) => t.tipo === "despesa");

  return (
    <div className="space-y-6">
      {/* Alerta de Discrepância */}
      {temDiscrepancia && (
        <Card className="border-amber-500/50 bg-amber-500/5">
          <CardContent className="flex items-center gap-4 py-4">
            <AlertTriangle className="h-5 w-5 text-amber-500 shrink-0" />
            <div className="flex-1">
              <p className="text-sm font-medium text-amber-700 dark:text-amber-400">
                Atenção: Divergência de valores
              </p>
              <p className="text-sm text-muted-foreground">
                O valor total do evento ({formatCurrency(valorTotalEvento)}) difere das
                receitas registradas ({formatCurrency(resumoFinanceiro.totalReceitas)}).{" "}
                {diferencaValorTotal > 0 ? (
                  <>Faltam {formatCurrency(diferencaValorTotal)} em receitas.</>
                ) : (
                  <>Há {formatCurrency(Math.abs(diferencaValorTotal))} a mais em receitas.</>
                )}
              </p>
            </div>
            <Button size="sm" onClick={() => setFormOpen(true)}>
              <Plus className="h-4 w-4 mr-2" />
              Adicionar Receita
            </Button>
          </CardContent>
        </Card>
      )}

      {/* Header com botão */}
      <div className="flex items-center justify-between">
        <div>
          <h3 className="text-lg font-semibold">Transações do Evento</h3>
          <p className="text-sm text-muted-foreground">
            {transacoes.length} transação(ões) vinculada(s)
          </p>
        </div>
        <Button onClick={() => setFormOpen(true)}>
          <Plus className="h-4 w-4 mr-2" />
          Nova Transação
        </Button>
      </div>

      {/* Receitas */}
      <Card>
        <CardHeader className="pb-3">
          <div className="flex items-center gap-2">
            <TrendingUp className="h-5 w-5 text-green-500" />
            <CardTitle className="text-base">
              Receitas ({receitas.length})
            </CardTitle>
            <span className="ml-auto text-lg font-bold text-green-600">
              {formatCurrency(resumoFinanceiro.totalReceitas)}
            </span>
          </div>
        </CardHeader>
        <CardContent>
          {receitas.length === 0 ? (
            <p className="text-sm text-muted-foreground text-center py-4">
              Nenhuma receita registrada para este evento
            </p>
          ) : (
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>Descrição</TableHead>
                  <TableHead>Categoria</TableHead>
                  <TableHead>Vencimento</TableHead>
                  <TableHead>Status</TableHead>
                  <TableHead className="text-right">Valor</TableHead>
                  <TableHead className="w-[100px]"></TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {receitas.map((transacao) => (
                  <TableRow key={transacao.id}>
                    <TableCell className="font-medium">{transacao.descricao}</TableCell>
                    <TableCell>
                      {transacao.categorias_financeiras ? (
                        <Badge
                          variant="outline"
                          style={{
                            backgroundColor: `${transacao.categorias_financeiras.cor ?? "#888888"}15`,
                            color: transacao.categorias_financeiras.cor ?? "#888888",
                            borderColor: `${transacao.categorias_financeiras.cor ?? "#888888"}30`,
                          }}
                        >
                          {transacao.categorias_financeiras.nome}
                        </Badge>
                      ) : (
                        <span className="text-muted-foreground">-</span>
                      )}
                    </TableCell>
                    <TableCell>{formatDate(transacao.data_vencimento)}</TableCell>
                    <TableCell>
                      <Badge
                        variant="outline"
                        style={{
                          backgroundColor: `${statusConfig[transacao.status]?.color}15`,
                          color: statusConfig[transacao.status]?.color,
                          borderColor: `${statusConfig[transacao.status]?.color}30`,
                        }}
                      >
                        {statusConfig[transacao.status]?.label || transacao.status}
                      </Badge>
                    </TableCell>
                    <TableCell className="text-right font-medium text-green-600">
                      {formatCurrency(transacao.valor)}
                    </TableCell>
                    <TableCell>
                      <div className="flex gap-1 justify-end">
                        <Button
                          variant="ghost"
                          size="sm"
                          onClick={() => handleEdit(transacao)}
                        >
                          Editar
                        </Button>
                        {transacao.status === "pendente" && (
                          <Button
                            variant="outline"
                            size="sm"
                            onClick={() => handleMarcarPago(transacao.id)}
                          >
                            Pagar
                          </Button>
                        )}
                      </div>
                    </TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          )}
        </CardContent>
      </Card>

      {/* Despesas */}
      <Card>
        <CardHeader className="pb-3">
          <div className="flex items-center gap-2">
            <TrendingDown className="h-5 w-5 text-red-500" />
            <CardTitle className="text-base">
              Despesas ({despesas.length})
            </CardTitle>
            <span className="ml-auto text-lg font-bold text-red-600">
              {formatCurrency(resumoFinanceiro.totalDespesas)}
            </span>
          </div>
        </CardHeader>
        <CardContent>
          {despesas.length === 0 ? (
            <p className="text-sm text-muted-foreground text-center py-4">
              Nenhuma despesa registrada para este evento
            </p>
          ) : (
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>Descrição</TableHead>
                  <TableHead>Categoria</TableHead>
                  <TableHead>Vencimento</TableHead>
                  <TableHead>Status</TableHead>
                  <TableHead className="text-right">Valor</TableHead>
                  <TableHead className="w-[100px]"></TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {despesas.map((transacao) => (
                  <TableRow key={transacao.id}>
                    <TableCell className="font-medium">{transacao.descricao}</TableCell>
                    <TableCell>
                      {transacao.categorias_financeiras ? (
                        <Badge
                          variant="outline"
                          style={{
                            backgroundColor: `${transacao.categorias_financeiras.cor ?? "#888888"}15`,
                            color: transacao.categorias_financeiras.cor ?? "#888888",
                            borderColor: `${transacao.categorias_financeiras.cor ?? "#888888"}30`,
                          }}
                        >
                          {transacao.categorias_financeiras.nome}
                        </Badge>
                      ) : (
                        <span className="text-muted-foreground">-</span>
                      )}
                    </TableCell>
                    <TableCell>{formatDate(transacao.data_vencimento)}</TableCell>
                    <TableCell>
                      <Badge
                        variant="outline"
                        style={{
                          backgroundColor: `${statusConfig[transacao.status]?.color}15`,
                          color: statusConfig[transacao.status]?.color,
                          borderColor: `${statusConfig[transacao.status]?.color}30`,
                        }}
                      >
                        {statusConfig[transacao.status]?.label || transacao.status}
                      </Badge>
                    </TableCell>
                    <TableCell className="text-right font-medium text-red-600">
                      {formatCurrency(transacao.valor)}
                    </TableCell>
                    <TableCell>
                      <div className="flex gap-1 justify-end">
                        <Button
                          variant="ghost"
                          size="sm"
                          onClick={() => handleEdit(transacao)}
                        >
                          Editar
                        </Button>
                        {transacao.status === "pendente" && (
                          <Button
                            variant="outline"
                            size="sm"
                            onClick={() => handleMarcarPago(transacao.id)}
                          >
                            Pagar
                          </Button>
                        )}
                      </div>
                    </TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          )}
        </CardContent>
      </Card>

      {/* Resumo */}
      <Card className="bg-muted/50">
        <CardContent className="pt-6">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm font-medium text-muted-foreground">
                Resultado Financeiro do Evento
              </p>
              <p className="text-xs text-muted-foreground">
                Receitas - Despesas
              </p>
            </div>
            <div
              className={`text-2xl font-bold ${
                resumoFinanceiro.lucro >= 0 ? "text-green-600" : "text-red-600"
              }`}
            >
              {formatCurrency(resumoFinanceiro.lucro)}
            </div>
          </div>
        </CardContent>
      </Card>

      {/* Form Modal */}
      <TransacaoForm
        open={formOpen}
        onOpenChange={handleFormClose}
        transacao={selectedTransacao}
        eventoId={eventoId}
      />
    </div>
  );
}


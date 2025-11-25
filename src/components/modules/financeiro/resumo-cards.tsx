"use client";

import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import {
  ArrowUpCircle,
  ArrowDownCircle,
  Wallet,
  AlertTriangle,
  TrendingUp,
  TrendingDown,
} from "lucide-react";
import { cn } from "@/lib/utils";

interface ResumoCardsProps {
  receitasRealizadas: number;
  receitasPendentes: number;
  despesasRealizadas: number;
  despesasPendentes: number;
  saldoRealizado: number;
  saldoPrevisto: number;
  emAtraso: number;
}

export function ResumoCards({
  receitasRealizadas,
  receitasPendentes,
  despesasRealizadas,
  despesasPendentes,
  saldoRealizado,
  saldoPrevisto,
  emAtraso,
}: ResumoCardsProps) {
  function formatCurrency(value: number) {
    return new Intl.NumberFormat("pt-BR", {
      style: "currency",
      currency: "BRL",
    }).format(value);
  }

  return (
    <div className="grid gap-4 grid-cols-2 lg:grid-cols-4">
      {/* Receitas */}
      <Card className="border-green-200 dark:border-green-900">
        <CardHeader className="flex flex-row items-center justify-between pb-2">
          <CardTitle className="text-sm font-medium text-muted-foreground">
            Receitas
          </CardTitle>
          <ArrowUpCircle className="h-4 w-4 text-green-600" />
        </CardHeader>
        <CardContent>
          <div className="text-2xl font-bold text-green-600">
            {formatCurrency(receitasRealizadas)}
          </div>
          <p className="text-xs text-muted-foreground">
            + {formatCurrency(receitasPendentes)} pendentes
          </p>
        </CardContent>
      </Card>

      {/* Despesas */}
      <Card className="border-red-200 dark:border-red-900">
        <CardHeader className="flex flex-row items-center justify-between pb-2">
          <CardTitle className="text-sm font-medium text-muted-foreground">
            Despesas
          </CardTitle>
          <ArrowDownCircle className="h-4 w-4 text-red-600" />
        </CardHeader>
        <CardContent>
          <div className="text-2xl font-bold text-red-600">
            {formatCurrency(despesasRealizadas)}
          </div>
          <p className="text-xs text-muted-foreground">
            + {formatCurrency(despesasPendentes)} pendentes
          </p>
        </CardContent>
      </Card>

      {/* Saldo */}
      <Card
        className={cn(
          "border",
          saldoRealizado >= 0
            ? "border-blue-200 dark:border-blue-900"
            : "border-orange-200 dark:border-orange-900"
        )}
      >
        <CardHeader className="flex flex-row items-center justify-between pb-2">
          <CardTitle className="text-sm font-medium text-muted-foreground">
            Saldo Realizado
          </CardTitle>
          <Wallet
            className={cn(
              "h-4 w-4",
              saldoRealizado >= 0 ? "text-blue-600" : "text-orange-600"
            )}
          />
        </CardHeader>
        <CardContent>
          <div
            className={cn(
              "text-2xl font-bold",
              saldoRealizado >= 0 ? "text-blue-600" : "text-orange-600"
            )}
          >
            {formatCurrency(saldoRealizado)}
          </div>
          <div className="flex items-center gap-1 text-xs text-muted-foreground">
            {saldoPrevisto >= saldoRealizado ? (
              <TrendingUp className="h-3 w-3 text-green-500" />
            ) : (
              <TrendingDown className="h-3 w-3 text-red-500" />
            )}
            <span>Previsto: {formatCurrency(saldoPrevisto)}</span>
          </div>
        </CardContent>
      </Card>

      {/* Em Atraso */}
      <Card
        className={cn(
          "border",
          emAtraso > 0
            ? "border-yellow-200 dark:border-yellow-900"
            : "border-green-200 dark:border-green-900"
        )}
      >
        <CardHeader className="flex flex-row items-center justify-between pb-2">
          <CardTitle className="text-sm font-medium text-muted-foreground">
            Em Atraso
          </CardTitle>
          <AlertTriangle
            className={cn(
              "h-4 w-4",
              emAtraso > 0 ? "text-yellow-600" : "text-green-600"
            )}
          />
        </CardHeader>
        <CardContent>
          <div
            className={cn(
              "text-2xl font-bold",
              emAtraso > 0 ? "text-yellow-600" : "text-green-600"
            )}
          >
            {emAtraso}
          </div>
          <p className="text-xs text-muted-foreground">
            {emAtraso === 0
              ? "Nenhuma pendência"
              : emAtraso === 1
              ? "transação vencida"
              : "transações vencidas"}
          </p>
        </CardContent>
      </Card>
    </div>
  );
}


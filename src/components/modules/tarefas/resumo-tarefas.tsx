"use client";

import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import {
  CheckCircle2,
  Clock,
  AlertTriangle,
  ListTodo,
  PlayCircle,
} from "lucide-react";
import { cn } from "@/lib/utils";

interface ResumoTarefasProps {
  total: number;
  pendentes: number;
  emAndamento: number;
  concluidas: number;
  vencidas: number;
}

export function ResumoTarefas({
  total,
  pendentes,
  emAndamento,
  concluidas,
  vencidas,
}: ResumoTarefasProps) {
  const percentualConcluidas = total > 0 ? Math.round((concluidas / total) * 100) : 0;

  return (
    <div className="grid gap-4 grid-cols-2 lg:grid-cols-5">
      <Card>
        <CardHeader className="flex flex-row items-center justify-between pb-2">
          <CardTitle className="text-sm font-medium text-muted-foreground">
            Total
          </CardTitle>
          <ListTodo className="h-4 w-4 text-muted-foreground" />
        </CardHeader>
        <CardContent>
          <div className="text-2xl font-bold">{total}</div>
          <p className="text-xs text-muted-foreground">tarefas cadastradas</p>
        </CardContent>
      </Card>

      <Card className="border-yellow-200 dark:border-yellow-900">
        <CardHeader className="flex flex-row items-center justify-between pb-2">
          <CardTitle className="text-sm font-medium text-muted-foreground">
            Pendentes
          </CardTitle>
          <Clock className="h-4 w-4 text-yellow-600" />
        </CardHeader>
        <CardContent>
          <div className="text-2xl font-bold text-yellow-600">{pendentes}</div>
          <p className="text-xs text-muted-foreground">aguardando início</p>
        </CardContent>
      </Card>

      <Card className="border-blue-200 dark:border-blue-900">
        <CardHeader className="flex flex-row items-center justify-between pb-2">
          <CardTitle className="text-sm font-medium text-muted-foreground">
            Em Andamento
          </CardTitle>
          <PlayCircle className="h-4 w-4 text-blue-600" />
        </CardHeader>
        <CardContent>
          <div className="text-2xl font-bold text-blue-600">{emAndamento}</div>
          <p className="text-xs text-muted-foreground">em execução</p>
        </CardContent>
      </Card>

      <Card className="border-green-200 dark:border-green-900">
        <CardHeader className="flex flex-row items-center justify-between pb-2">
          <CardTitle className="text-sm font-medium text-muted-foreground">
            Concluídas
          </CardTitle>
          <CheckCircle2 className="h-4 w-4 text-green-600" />
        </CardHeader>
        <CardContent>
          <div className="text-2xl font-bold text-green-600">{concluidas}</div>
          <p className="text-xs text-muted-foreground">{percentualConcluidas}% do total</p>
        </CardContent>
      </Card>

      <Card
        className={cn(
          "border",
          vencidas > 0
            ? "border-red-200 dark:border-red-900"
            : "border-green-200 dark:border-green-900"
        )}
      >
        <CardHeader className="flex flex-row items-center justify-between pb-2">
          <CardTitle className="text-sm font-medium text-muted-foreground">
            Atrasadas
          </CardTitle>
          <AlertTriangle
            className={cn(
              "h-4 w-4",
              vencidas > 0 ? "text-red-600" : "text-green-600"
            )}
          />
        </CardHeader>
        <CardContent>
          <div
            className={cn(
              "text-2xl font-bold",
              vencidas > 0 ? "text-red-600" : "text-green-600"
            )}
          >
            {vencidas}
          </div>
          <p className="text-xs text-muted-foreground">
            {vencidas === 0 ? "nenhuma atrasada" : "precisam de atenção"}
          </p>
        </CardContent>
      </Card>
    </div>
  );
}


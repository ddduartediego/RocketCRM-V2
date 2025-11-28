"use client";

import { useState, useEffect, useTransition } from "react";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { 
  Target, 
  Calendar, 
  DollarSign, 
  Users,
  TrendingUp,
  Clock,
  CheckCircle2,
  AlertCircle,
  ArrowUpCircle,
  ArrowDownCircle,
  ChevronLeft,
  ChevronRight,
  Loader2,
} from "lucide-react";
import Link from "next/link";
import { getResumoFinanceiro } from "@/actions/financeiro";
import { getEstatisticasEventosMes, type EstatisticasEventosMes } from "@/actions/eventos";
import { getEstatisticasLeadsMes, type EstatisticasLeadsMes } from "@/actions/leads";
import { getEstatisticasTarefasMes, type EstatisticasTarefasMes } from "@/actions/atividades";

interface DashboardData {
  totalLeads: number;
  totalEventos: number;
  totalContatos: number;
  resumoFinanceiro: {
    receitasRealizadas: number;
    receitasPendentes: number;
    despesasRealizadas: number;
    despesasPendentes: number;
    saldoRealizado: number;
    saldoPrevisto: number;
    emAtraso: number;
  };
  estatisticasEventos: EstatisticasEventosMes;
  estatisticasLeads: EstatisticasLeadsMes;
  estatisticasTarefas: EstatisticasTarefasMes;
}

interface DashboardClientProps {
  initialData: DashboardData;
  initialMes: string;
}

const MESES = [
  "Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho",
  "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"
];

export function DashboardClient({ initialData, initialMes }: DashboardClientProps) {
  const [mesSelecionado, setMesSelecionado] = useState(initialMes);
  const [data, setData] = useState<DashboardData>(initialData);
  const [isPending, startTransition] = useTransition();

  const [ano, mes] = mesSelecionado.split("-").map(Number);

  const formatCurrency = (value: number) => {
    return new Intl.NumberFormat("pt-BR", {
      style: "currency",
      currency: "BRL",
    }).format(value);
  };

  const handlePrevMonth = () => {
    const newDate = new Date(ano, mes - 2, 1);
    const newMes = `${newDate.getFullYear()}-${String(newDate.getMonth() + 1).padStart(2, "0")}`;
    setMesSelecionado(newMes);
  };

  const handleNextMonth = () => {
    const newDate = new Date(ano, mes, 1);
    const newMes = `${newDate.getFullYear()}-${String(newDate.getMonth() + 1).padStart(2, "0")}`;
    setMesSelecionado(newMes);
  };

  // Recarregar dados quando o mês mudar
  useEffect(() => {
    if (mesSelecionado === initialMes) return;

    startTransition(async () => {
      const [resumoFinanceiro, estatisticasEventos, estatisticasLeads, estatisticasTarefas] = 
        await Promise.all([
          getResumoFinanceiro(mesSelecionado),
          getEstatisticasEventosMes(mesSelecionado),
          getEstatisticasLeadsMes(mesSelecionado),
          getEstatisticasTarefasMes(mesSelecionado),
        ]);

      setData((prev) => ({
        ...prev,
        resumoFinanceiro,
        estatisticasEventos,
        estatisticasLeads,
        estatisticasTarefas,
      }));
    });
  }, [mesSelecionado, initialMes]);

  const { resumoFinanceiro, estatisticasEventos, estatisticasLeads, estatisticasTarefas } = data;

  return (
    <div className="space-y-6">
      {/* Header da página */}
      <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-foreground">Dashboard</h1>
          <p className="text-muted-foreground">
            Visão geral do seu negócio
          </p>
        </div>
        
        {/* Filtro de Mês Minimalista */}
        <div className="flex items-center gap-1 bg-muted/50 rounded-lg p-1">
          <Button 
            variant="ghost" 
            size="icon"
            className="h-8 w-8"
            onClick={handlePrevMonth}
            disabled={isPending}
          >
            <ChevronLeft className="h-4 w-4" />
          </Button>
          <div className="flex items-center gap-2 px-3 min-w-[160px] justify-center">
            {isPending && <Loader2 className="h-4 w-4 animate-spin" />}
            <span className="font-medium text-sm">
              {MESES[mes - 1]} {ano}
            </span>
          </div>
          <Button 
            variant="ghost" 
            size="icon"
            className="h-8 w-8"
            onClick={handleNextMonth}
            disabled={isPending}
          >
            <ChevronRight className="h-4 w-4" />
          </Button>
        </div>
      </div>

      {/* Cards de métricas gerais */}
      <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-4">
        <Card>
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              Leads Ativos
            </CardTitle>
            <Target className="h-5 w-5 text-primary" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{data.totalLeads || 0}</div>
            <p className="text-xs text-muted-foreground mt-1">
              <TrendingUp className="inline h-3 w-3 text-success mr-1" />
              Em acompanhamento
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              Eventos Confirmados
            </CardTitle>
            <Calendar className="h-5 w-5 text-info" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{data.totalEventos || 0}</div>
            <p className="text-xs text-muted-foreground mt-1">
              <Clock className="inline h-3 w-3 text-warning mr-1" />
              Total no sistema
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              Total de Contatos
            </CardTitle>
            <Users className="h-5 w-5 text-secondary-soft" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{data.totalContatos || 0}</div>
            <p className="text-xs text-muted-foreground mt-1">
              Clientes e organizações
            </p>
          </CardContent>
        </Card>

        <Card className="border-green-200 dark:border-green-900">
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              Receitas do Mês
            </CardTitle>
            <ArrowUpCircle className="h-5 w-5 text-success" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-green-600">
              {formatCurrency(resumoFinanceiro.receitasRealizadas)}
            </div>
            <p className="text-xs text-muted-foreground mt-1">
              + {formatCurrency(resumoFinanceiro.receitasPendentes)} pendentes
            </p>
          </CardContent>
        </Card>
      </div>

      {/* Métricas financeiras adicionais */}
      <div className="grid gap-4 md:grid-cols-3">
        <Card className="border-red-200 dark:border-red-900">
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              Despesas do Mês
            </CardTitle>
            <ArrowDownCircle className="h-5 w-5 text-destructive" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-red-600">
              {formatCurrency(resumoFinanceiro.despesasRealizadas)}
            </div>
            <p className="text-xs text-muted-foreground mt-1">
              + {formatCurrency(resumoFinanceiro.despesasPendentes)} pendentes
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              Saldo do Mês
            </CardTitle>
            <DollarSign className="h-5 w-5 text-info" />
          </CardHeader>
          <CardContent>
            <div className={`text-2xl font-bold ${resumoFinanceiro.saldoRealizado >= 0 ? 'text-green-600' : 'text-red-600'}`}>
              {formatCurrency(resumoFinanceiro.saldoRealizado)}
            </div>
            <p className="text-xs text-muted-foreground mt-1">
              Previsto: {formatCurrency(resumoFinanceiro.saldoPrevisto)}
            </p>
          </CardContent>
        </Card>

        <Card className={resumoFinanceiro.emAtraso > 0 ? "border-yellow-200 dark:border-yellow-900" : ""}>
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              Pagamentos em Atraso
            </CardTitle>
            <AlertCircle className={`h-5 w-5 ${resumoFinanceiro.emAtraso > 0 ? 'text-warning' : 'text-success'}`} />
          </CardHeader>
          <CardContent>
            <div className={`text-2xl font-bold ${resumoFinanceiro.emAtraso > 0 ? 'text-yellow-600' : 'text-green-600'}`}>
              {resumoFinanceiro.emAtraso}
            </div>
            <p className="text-xs text-muted-foreground mt-1">
              {resumoFinanceiro.emAtraso === 0 ? 'Nenhum atraso' : 'transações vencidas'}
            </p>
          </CardContent>
        </Card>
      </div>

      {/* Cards de Estatísticas do Mês */}
      <div className="grid gap-6 lg:grid-cols-3">
        {/* Eventos do Mês */}
        <Card>
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <Calendar className="h-5 w-5 text-primary" />
              Eventos do Mês
            </CardTitle>
            <CardDescription>
              Estatísticas de eventos em {MESES[mes - 1]}
            </CardDescription>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              <div className="text-center py-4 bg-muted/50 rounded-lg">
                <div className="text-3xl font-bold text-primary">
                  {estatisticasEventos.total}
                </div>
                <p className="text-sm text-muted-foreground">Total de eventos</p>
              </div>
              
              <div className="grid grid-cols-2 gap-2">
                <div className="p-3 rounded-lg bg-blue-50 dark:bg-blue-950/30">
                  <div className="text-lg font-semibold text-blue-600">
                    {estatisticasEventos.porStatus.planejamento}
                  </div>
                  <p className="text-xs text-muted-foreground">Em planejamento</p>
                </div>
                <div className="p-3 rounded-lg bg-green-50 dark:bg-green-950/30">
                  <div className="text-lg font-semibold text-green-600">
                    {estatisticasEventos.porStatus.confirmado}
                  </div>
                  <p className="text-xs text-muted-foreground">Confirmados</p>
                </div>
                <div className="p-3 rounded-lg bg-purple-50 dark:bg-purple-950/30">
                  <div className="text-lg font-semibold text-purple-600">
                    {estatisticasEventos.porStatus.realizado}
                  </div>
                  <p className="text-xs text-muted-foreground">Realizados</p>
                </div>
                <div className="p-3 rounded-lg bg-red-50 dark:bg-red-950/30">
                  <div className="text-lg font-semibold text-red-600">
                    {estatisticasEventos.porStatus.cancelado}
                  </div>
                  <p className="text-xs text-muted-foreground">Cancelados</p>
                </div>
              </div>

              <Link 
                href="/eventos" 
                className="block text-center text-sm text-primary hover:underline pt-2"
              >
                Ver todos os eventos
              </Link>
            </div>
          </CardContent>
        </Card>

        {/* Leads do Mês */}
        <Card>
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <Target className="h-5 w-5 text-primary" />
              Leads do Mês
            </CardTitle>
            <CardDescription>
              Leads criados em {MESES[mes - 1]}
            </CardDescription>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              <div className="text-center py-4 bg-muted/50 rounded-lg">
                <div className="text-3xl font-bold text-primary">
                  {estatisticasLeads.total}
                </div>
                <p className="text-sm text-muted-foreground">Novos leads</p>
                {estatisticasLeads.valorTotal > 0 && (
                  <p className="text-xs text-success mt-1">
                    {formatCurrency(estatisticasLeads.valorTotal)} em potencial
                  </p>
                )}
              </div>
              
              <div className="space-y-2">
                <p className="text-xs font-medium text-muted-foreground uppercase tracking-wide">
                  Por Etapa do Funil
                </p>
                {estatisticasLeads.porEtapa.length > 0 ? (
                  <div className="space-y-1.5">
                    {estatisticasLeads.porEtapa.map((etapa) => (
                      <div 
                        key={etapa.id}
                        className="flex items-center justify-between p-2 rounded-md"
                        style={{ backgroundColor: `${etapa.cor}15` }}
                      >
                        <span className="text-sm flex items-center gap-2">
                          <span 
                            className="w-2 h-2 rounded-full" 
                            style={{ backgroundColor: etapa.cor }}
                          />
                          {etapa.nome}
                        </span>
                        <span 
                          className="font-semibold text-sm"
                          style={{ color: etapa.cor }}
                        >
                          {etapa.quantidade}
                        </span>
                      </div>
                    ))}
                  </div>
                ) : (
                  <p className="text-sm text-muted-foreground text-center py-2">
                    Nenhuma etapa configurada
                  </p>
                )}
              </div>

              <Link 
                href="/leads" 
                className="block text-center text-sm text-primary hover:underline pt-2"
              >
                Ver todos os leads
              </Link>
            </div>
          </CardContent>
        </Card>

        {/* Tarefas do Mês */}
        <Card>
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <CheckCircle2 className="h-5 w-5 text-primary" />
              Tarefas do Mês
            </CardTitle>
            <CardDescription>
              Tarefas com vencimento em {MESES[mes - 1]}
            </CardDescription>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              <div className="text-center py-4 bg-muted/50 rounded-lg">
                <div className="text-3xl font-bold text-primary">
                  {estatisticasTarefas.total}
                </div>
                <p className="text-sm text-muted-foreground">Total de tarefas</p>
              </div>
              
              <div className="grid grid-cols-2 gap-2">
                <div className="p-3 rounded-lg bg-yellow-50 dark:bg-yellow-950/30">
                  <div className="text-lg font-semibold text-yellow-600">
                    {estatisticasTarefas.porStatus.pendente}
                  </div>
                  <p className="text-xs text-muted-foreground">Pendentes</p>
                </div>
                <div className="p-3 rounded-lg bg-blue-50 dark:bg-blue-950/30">
                  <div className="text-lg font-semibold text-blue-600">
                    {estatisticasTarefas.porStatus.em_andamento}
                  </div>
                  <p className="text-xs text-muted-foreground">Em andamento</p>
                </div>
                <div className="p-3 rounded-lg bg-green-50 dark:bg-green-950/30">
                  <div className="text-lg font-semibold text-green-600">
                    {estatisticasTarefas.porStatus.concluida}
                  </div>
                  <p className="text-xs text-muted-foreground">Concluídas</p>
                </div>
                <div className="p-3 rounded-lg bg-red-50 dark:bg-red-950/30">
                  <div className="text-lg font-semibold text-red-600">
                    {estatisticasTarefas.vencidas}
                  </div>
                  <p className="text-xs text-muted-foreground">Vencidas</p>
                </div>
              </div>

              {/* Barra de progresso */}
              {estatisticasTarefas.total > 0 && (
                <div className="space-y-1">
                  <div className="flex justify-between text-xs text-muted-foreground">
                    <span>Progresso</span>
                    <span>
                      {Math.round((estatisticasTarefas.porStatus.concluida / estatisticasTarefas.total) * 100)}%
                    </span>
                  </div>
                  <div className="h-2 bg-muted rounded-full overflow-hidden">
                    <div 
                      className="h-full bg-green-500 transition-all duration-300"
                      style={{ 
                        width: `${(estatisticasTarefas.porStatus.concluida / estatisticasTarefas.total) * 100}%` 
                      }}
                    />
                  </div>
                </div>
              )}

              <Link 
                href="/tarefas" 
                className="block text-center text-sm text-primary hover:underline pt-2"
              >
                Ver todas as tarefas
              </Link>
            </div>
          </CardContent>
        </Card>
      </div>
    </div>
  );
}


export const dynamic = "force-dynamic";

import { createClient } from "@/lib/supabase/server";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
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
} from "lucide-react";
import { getResumoFinanceiro } from "@/actions/financeiro";
import { getAtividadesHoje } from "@/actions/atividades";
import { Checkbox } from "@/components/ui/checkbox";
import Link from "next/link";

export default async function DashboardPage() {
  const supabase = await createClient();

  // Buscar dados para o dashboard
  const [
    { count: totalLeads },
    { count: totalEventos },
    { count: totalContatos },
    { data: proximosEventos },
    { data: leadsRecentes },
    resumoFinanceiro,
    { data: tarefasHoje },
  ] = await Promise.all([
    supabase.from("leads").select("*", { count: "exact", head: true }),
    supabase.from("eventos").select("*", { count: "exact", head: true }).eq("status", "confirmado"),
    supabase.from("contatos").select("*", { count: "exact", head: true }),
    supabase
      .from("eventos")
      .select("id, nome, tipo, data_inicio, local, status")
      .gte("data_inicio", new Date().toISOString().split("T")[0])
      .order("data_inicio", { ascending: true })
      .limit(5),
    supabase
      .from("leads")
      .select("id, titulo, valor_estimado, created_at, etapas_funil(nome, cor)")
      .order("created_at", { ascending: false })
      .limit(5),
    getResumoFinanceiro(),
    getAtividadesHoje(),
  ]);

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
    });
  };

  const tipoEventoLabels: Record<string, string> = {
    viagem_pedagogica: "Viagem Pedagógica",
    viagem_formatura: "Viagem de Formatura",
    colonia_ferias: "Colônia de Férias",
    festa_infantil: "Festa Infantil",
    gincana: "Gincana",
    outro: "Outro",
  };

  return (
    <div className="space-y-6">
      {/* Header da página */}
      <div>
        <h1 className="text-2xl font-bold text-foreground">Dashboard</h1>
        <p className="text-muted-foreground">
          Visão geral do seu negócio
        </p>
      </div>

      {/* Cards de métricas */}
      <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-4">
        <Card>
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              Leads Ativos
            </CardTitle>
            <Target className="h-5 w-5 text-primary" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{totalLeads || 0}</div>
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
            <div className="text-2xl font-bold">{totalEventos || 0}</div>
            <p className="text-xs text-muted-foreground mt-1">
              <Clock className="inline h-3 w-3 text-warning mr-1" />
              Próximos eventos
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
            <div className="text-2xl font-bold">{totalContatos || 0}</div>
            <p className="text-xs text-muted-foreground mt-1">
              Clientes e escolas
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
              Saldo Atual
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

      {/* Conteúdo principal */}
      <div className="grid gap-6 lg:grid-cols-2">
        {/* Próximos Eventos */}
        <Card>
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <Calendar className="h-5 w-5 text-primary" />
              Próximos Eventos
            </CardTitle>
            <CardDescription>
              Eventos confirmados para os próximos dias
            </CardDescription>
          </CardHeader>
          <CardContent>
            {proximosEventos && proximosEventos.length > 0 ? (
              <div className="space-y-3">
                {proximosEventos.map((evento) => (
                  <div
                    key={evento.id}
                    className="flex items-center justify-between p-3 rounded-lg bg-muted/50 hover:bg-muted transition-colors"
                  >
                    <div className="flex items-center gap-3">
                      <div className="w-12 h-12 rounded-lg bg-primary/10 flex flex-col items-center justify-center">
                        <span className="text-xs font-medium text-primary">
                          {formatDate(evento.data_inicio).split(" ")[0]}
                        </span>
                        <span className="text-[10px] text-primary uppercase">
                          {formatDate(evento.data_inicio).split(" ")[1]}
                        </span>
                      </div>
                      <div>
                        <p className="font-medium text-sm">{evento.nome}</p>
                        <p className="text-xs text-muted-foreground">
                          {tipoEventoLabels[evento.tipo] || evento.tipo}
                          {evento.local && ` • ${evento.local}`}
                        </p>
                      </div>
                    </div>
                    <div className="flex items-center gap-2">
                      {evento.status === "confirmado" ? (
                        <CheckCircle2 className="h-4 w-4 text-success" />
                      ) : (
                        <AlertCircle className="h-4 w-4 text-warning" />
                      )}
                    </div>
                  </div>
                ))}
              </div>
            ) : (
              <div className="text-center py-8 text-muted-foreground">
                <Calendar className="h-12 w-12 mx-auto mb-3 opacity-50" />
                <p>Nenhum evento confirmado</p>
                <p className="text-sm">Os próximos eventos aparecerão aqui</p>
              </div>
            )}
          </CardContent>
        </Card>

        {/* Leads Recentes */}
        <Card>
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <Target className="h-5 w-5 text-primary" />
              Leads Recentes
            </CardTitle>
            <CardDescription>
              Últimas oportunidades cadastradas
            </CardDescription>
          </CardHeader>
          <CardContent>
            {leadsRecentes && leadsRecentes.length > 0 ? (
              <div className="space-y-3">
                {leadsRecentes.map((lead) => (
                  <div
                    key={lead.id}
                    className="flex items-center justify-between p-3 rounded-lg bg-muted/50 hover:bg-muted transition-colors"
                  >
                    <div>
                      <p className="font-medium text-sm">{lead.titulo}</p>
                      <div className="flex items-center gap-2 mt-1">
                        {lead.etapas_funil && (
                          <span
                            className="text-xs px-2 py-0.5 rounded-full"
                            style={{
                              backgroundColor: `${(lead.etapas_funil as { cor: string }).cor}20`,
                              color: (lead.etapas_funil as { cor: string }).cor,
                            }}
                          >
                            {(lead.etapas_funil as { nome: string }).nome}
                          </span>
                        )}
                      </div>
                    </div>
                    <div className="text-right">
                      <p className="font-semibold text-sm text-primary">
                        {formatCurrency(lead.valor_estimado || 0)}
                      </p>
                      <p className="text-xs text-muted-foreground">
                        {formatDate(lead.created_at)}
                      </p>
                    </div>
                  </div>
                ))}
              </div>
            ) : (
              <div className="text-center py-8 text-muted-foreground">
                <Target className="h-12 w-12 mx-auto mb-3 opacity-50" />
                <p>Nenhum lead cadastrado</p>
                <p className="text-sm">Comece adicionando seus primeiros leads</p>
              </div>
            )}
          </CardContent>
        </Card>
      </div>

      {/* Tarefas de Hoje */}
      <Card>
        <CardHeader>
          <div className="flex items-center justify-between">
            <div>
              <CardTitle className="flex items-center gap-2">
                <CheckCircle2 className="h-5 w-5 text-primary" />
                Tarefas Pendentes
              </CardTitle>
              <CardDescription>
                Tarefas que precisam de atenção
              </CardDescription>
            </div>
            <Link
              href="/tarefas"
              className="text-sm text-primary hover:underline"
            >
              Ver todas
            </Link>
          </div>
        </CardHeader>
        <CardContent>
          {tarefasHoje && tarefasHoje.length > 0 ? (
            <div className="space-y-2">
              {tarefasHoje.map((tarefa) => {
                const isVencida = tarefa.data_vencimento && 
                  new Date(tarefa.data_vencimento) < new Date(new Date().toISOString().split("T")[0]);
                
                return (
                  <div
                    key={tarefa.id}
                    className={`flex items-center gap-3 p-3 rounded-lg border ${
                      isVencida ? "border-destructive/50 bg-destructive/5" : "bg-muted/50"
                    }`}
                  >
                    <Checkbox disabled className="data-[state=checked]:bg-success" />
                    <div className="flex-1">
                      <p className="font-medium text-sm">{tarefa.titulo}</p>
                      <div className="flex items-center gap-2 text-xs text-muted-foreground">
                        {tarefa.eventos && (
                          <span>Evento: {(tarefa.eventos as { nome: string }).nome}</span>
                        )}
                        {tarefa.data_vencimento && (
                          <span className={isVencida ? "text-destructive font-medium" : ""}>
                            {isVencida ? "Atrasada" : "Vence"}: {formatDate(tarefa.data_vencimento)}
                          </span>
                        )}
                      </div>
                    </div>
                  </div>
                );
              })}
            </div>
          ) : (
            <div className="text-center py-8 text-muted-foreground">
              <CheckCircle2 className="h-12 w-12 mx-auto mb-3 opacity-50" />
              <p>Nenhuma tarefa pendente</p>
              <p className="text-sm">Você está em dia!</p>
            </div>
          )}
        </CardContent>
      </Card>
    </div>
  );
}


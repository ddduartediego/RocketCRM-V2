"use client";

import { useState } from "react";
import Link from "next/link";
import { useRouter } from "next/navigation";
import {
  ArrowLeft,
  Calendar,
  MapPin,
  Users,
  User,
  Clock,
  Pencil,
  Trash2,
  DollarSign,
  FileText,
  CheckCircle,
  Package,
} from "lucide-react";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
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
import { EventoForm } from "./evento-form";
import { EventoFinanceiroTab } from "./evento-financeiro-tab";
import { EventoEquipeTab } from "./evento-equipe-tab";
import { EventoRecursosTab } from "./evento-recursos-tab";
import { deleteEvento } from "@/actions/eventos";
import { toast } from "sonner";
import type { Evento, TransacaoFinanceira, AlocacaoEquipe, AlocacaoRecurso } from "@/types/database";

interface EventoWithRelations extends Evento {
  contatos?: { id: string; nome: string; telefone?: string | null; email?: string | null } | null;
  leads?: { id: string; titulo: string } | null;
  users?: { id: string; nome: string; avatar_url: string | null } | null;
}

interface TransacaoWithRelations extends TransacaoFinanceira {
  categorias_financeiras?: { id: string; nome: string; cor: string | null } | null;
}

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

interface AlocacaoRecursoWithRecurso extends AlocacaoRecurso {
  recursos?: {
    id: string;
    nome: string;
    tipo: string;
    quantidade: number;
    custo_unitario: number | null;
  } | null;
}

interface EventoDetailProps {
  evento: EventoWithRelations;
  transacoes: TransacaoWithRelations[];
  resumoFinanceiro: {
    totalReceitas: number;
    totalDespesas: number;
    lucro: number;
  };
  alocacoesEquipe: AlocacaoEquipeWithMembro[];
  alocacoesRecursos: AlocacaoRecursoWithRecurso[];
}

const tipoLabels: Record<string, { label: string; icon: string }> = {
  colonia_ferias: { label: "Colônia de Férias", icon: "🏕️" },
  festa_infantil: { label: "Festa Infantil", icon: "🎈" },
  gincana: { label: "Gincana", icon: "🏃" },
  outro: { label: "Outro", icon: "📅" },
};

const statusConfig: Record<string, { label: string; color: string }> = {
  planejamento: { label: "Planejamento", color: "#0ea5e9" },
  confirmado: { label: "Confirmado", color: "#22c55e" },
  em_andamento: { label: "Em Andamento", color: "#eab308" },
  realizado: { label: "Realizado", color: "#8b5cf6" },
  cancelado: { label: "Cancelado", color: "#dc2626" },
};

export function EventoDetail({
  evento,
  transacoes,
  resumoFinanceiro,
  alocacoesEquipe,
  alocacoesRecursos,
}: EventoDetailProps) {
  const router = useRouter();
  const [editFormOpen, setEditFormOpen] = useState(false);
  const [deleteDialogOpen, setDeleteDialogOpen] = useState(false);
  const [isDeleting, setIsDeleting] = useState(false);

  const formatDate = (date: string) => {
    return new Date(date).toLocaleDateString("pt-BR", {
      weekday: "long",
      day: "2-digit",
      month: "long",
      year: "numeric",
    });
  };

  const formatCurrency = (value: number) => {
    return new Intl.NumberFormat("pt-BR", {
      style: "currency",
      currency: "BRL",
    }).format(value);
  };

  const handleDelete = async () => {
    setIsDeleting(true);
    const result = await deleteEvento(evento.id);
    setIsDeleting(false);

    if (result.error) {
      toast.error("Erro ao excluir evento", { description: result.error });
    } else {
      toast.success("Evento excluído com sucesso");
      router.push("/eventos");
    }
    setDeleteDialogOpen(false);
  };

  const totalReceitasRegistradas = resumoFinanceiro.totalReceitas;
  const valorTotal = evento.valor_total || 0;
  const percentualRegistrado = valorTotal > 0 ? (totalReceitasRegistradas / valorTotal) * 100 : 0;

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex flex-col sm:flex-row sm:items-start sm:justify-between gap-4">
        <div className="flex items-start gap-4">
          <Link href="/eventos">
            <Button variant="ghost" size="icon" className="shrink-0">
              <ArrowLeft className="h-5 w-5" />
            </Button>
          </Link>
          <div>
            <div className="flex items-center gap-3">
              <span className="text-3xl">{tipoLabels[evento.tipo]?.icon || "📅"}</span>
              <div>
                <h1 className="text-2xl font-bold text-foreground">{evento.nome}</h1>
                <div className="flex items-center gap-2 mt-1">
                  <Badge
                    variant="outline"
                    style={{
                      backgroundColor: `${statusConfig[evento.status]?.color}15`,
                      color: statusConfig[evento.status]?.color,
                      borderColor: `${statusConfig[evento.status]?.color}30`,
                    }}
                  >
                    {statusConfig[evento.status]?.label || evento.status}
                  </Badge>
                  <span className="text-sm text-muted-foreground">
                    {tipoLabels[evento.tipo]?.label || evento.tipo}
                  </span>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div className="flex gap-2">
          <Button variant="outline" onClick={() => setEditFormOpen(true)}>
            <Pencil className="h-4 w-4 mr-2" />
            Editar
          </Button>
          <Button
            variant="outline"
            className="text-destructive hover:text-destructive"
            onClick={() => setDeleteDialogOpen(true)}
          >
            <Trash2 className="h-4 w-4 mr-2" />
            Excluir
          </Button>
        </div>
      </div>

      {/* Cards de Resumo */}
      <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              Valor Total
            </CardTitle>
            <DollarSign className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-primary">
              {formatCurrency(valorTotal)}
            </div>
            {evento.valor_sinal && evento.valor_sinal > 0 && (
              <p className="text-xs text-muted-foreground">
                Sinal: {formatCurrency(evento.valor_sinal)}
              </p>
            )}
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              Receitas Registradas
            </CardTitle>
            <CheckCircle className="h-4 w-4 text-green-500" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-green-600">
              {formatCurrency(totalReceitasRegistradas)}
            </div>
            <p className="text-xs text-muted-foreground">
              {percentualRegistrado.toFixed(0)}% do valor do evento
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              Despesas
            </CardTitle>
            <DollarSign className="h-4 w-4 text-red-500" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-red-600">
              {formatCurrency(resumoFinanceiro.totalDespesas)}
            </div>
            <p className="text-xs text-muted-foreground">
              {transacoes.filter((t) => t.tipo === "despesa").length} transações
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              Lucro Estimado
            </CardTitle>
            <FileText className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div
              className={`text-2xl font-bold ${
                resumoFinanceiro.lucro >= 0 ? "text-green-600" : "text-red-600"
              }`}
            >
              {formatCurrency(resumoFinanceiro.lucro)}
            </div>
            <p className="text-xs text-muted-foreground">
              Receitas - Despesas
            </p>
          </CardContent>
        </Card>
      </div>

      {/* Tabs */}
      <Tabs defaultValue="info" className="w-full">
        <TabsList>
          <TabsTrigger value="info" className="flex items-center gap-2">
            <FileText className="h-4 w-4" />
            Informações
          </TabsTrigger>
          <TabsTrigger value="financeiro" className="flex items-center gap-2">
            <DollarSign className="h-4 w-4" />
            Financeiro
          </TabsTrigger>
          <TabsTrigger value="equipe" className="flex items-center gap-2">
            <Users className="h-4 w-4" />
            Equipe
          </TabsTrigger>
          <TabsTrigger value="recursos" className="flex items-center gap-2">
            <Package className="h-4 w-4" />
            Recursos
          </TabsTrigger>
        </TabsList>

        <TabsContent value="info" className="mt-4">
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            {/* Info do Evento */}
            <Card>
              <CardHeader>
                <CardTitle className="text-base">Detalhes do Evento</CardTitle>
              </CardHeader>
              <CardContent className="space-y-4">
                <div className="flex items-start gap-3">
                  <Calendar className="h-5 w-5 text-muted-foreground mt-0.5" />
                  <div>
                    <p className="text-sm font-medium">Data</p>
                    <p className="text-sm text-muted-foreground">
                      {formatDate(evento.data_inicio)}
                      {evento.data_fim && evento.data_fim !== evento.data_inicio && (
                        <> até {formatDate(evento.data_fim)}</>
                      )}
                    </p>
                  </div>
                </div>

                {(evento.hora_inicio || evento.hora_fim) && (
                  <div className="flex items-start gap-3">
                    <Clock className="h-5 w-5 text-muted-foreground mt-0.5" />
                    <div>
                      <p className="text-sm font-medium">Horário</p>
                      <p className="text-sm text-muted-foreground">
                        {evento.hora_inicio || "--:--"} - {evento.hora_fim || "--:--"}
                      </p>
                    </div>
                  </div>
                )}

                {evento.local && (
                  <div className="flex items-start gap-3">
                    <MapPin className="h-5 w-5 text-muted-foreground mt-0.5" />
                    <div>
                      <p className="text-sm font-medium">Local</p>
                      <p className="text-sm text-muted-foreground">{evento.local}</p>
                      {evento.endereco_local && (
                        <p className="text-xs text-muted-foreground">
                          {evento.endereco_local}
                        </p>
                      )}
                    </div>
                  </div>
                )}
              </CardContent>
            </Card>

            {/* Cliente/Contato */}
            <Card>
              <CardHeader>
                <CardTitle className="text-base">Cliente</CardTitle>
              </CardHeader>
              <CardContent className="space-y-4">
                {evento.contatos && (
                  <div className="flex items-start gap-3">
                    <User className="h-5 w-5 text-muted-foreground mt-0.5" />
                    <div>
                      <p className="text-sm font-medium">Contato</p>
                      <p className="text-sm text-muted-foreground">
                        {evento.contatos.nome}
                      </p>
                      {evento.contatos.telefone && (
                        <p className="text-xs text-muted-foreground">
                          {evento.contatos.telefone}
                        </p>
                      )}
                      {evento.contatos.email && (
                        <p className="text-xs text-muted-foreground">
                          {evento.contatos.email}
                        </p>
                      )}
                    </div>
                  </div>
                )}

                {evento.users && (
                  <div className="flex items-start gap-3">
                    <User className="h-5 w-5 text-muted-foreground mt-0.5" />
                    <div>
                      <p className="text-sm font-medium">Responsável</p>
                      <p className="text-sm text-muted-foreground">
                        {evento.users.nome}
                      </p>
                    </div>
                  </div>
                )}

                {!evento.contatos && (
                  <p className="text-sm text-muted-foreground">
                    Nenhum cliente vinculado
                  </p>
                )}
              </CardContent>
            </Card>

            {/* Descrição e Observações */}
            {(evento.descricao || evento.observacoes) && (
              <Card className="md:col-span-2">
                <CardHeader>
                  <CardTitle className="text-base">Descrição</CardTitle>
                </CardHeader>
                <CardContent className="space-y-4">
                  {evento.descricao && (
                    <div>
                      <p className="text-sm text-muted-foreground whitespace-pre-wrap">
                        {evento.descricao}
                      </p>
                    </div>
                  )}
                  {evento.observacoes && (
                    <div>
                      <p className="text-sm font-medium mb-1">Observações</p>
                      <p className="text-sm text-muted-foreground whitespace-pre-wrap">
                        {evento.observacoes}
                      </p>
                    </div>
                  )}
                </CardContent>
              </Card>
            )}
          </div>
        </TabsContent>

        <TabsContent value="financeiro" className="mt-4">
          <EventoFinanceiroTab
            eventoId={evento.id}
            transacoes={transacoes}
            resumoFinanceiro={resumoFinanceiro}
            valorTotalEvento={valorTotal}
          />
        </TabsContent>

        <TabsContent value="equipe" className="mt-4">
          <EventoEquipeTab
            eventoId={evento.id}
            eventoNome={evento.nome}
            eventoDataInicio={evento.data_inicio}
            eventoDataFim={evento.data_fim}
            alocacoes={alocacoesEquipe}
          />
        </TabsContent>

        <TabsContent value="recursos" className="mt-4">
          <EventoRecursosTab
            eventoId={evento.id}
            eventoNome={evento.nome}
            eventoDataInicio={evento.data_inicio}
            eventoDataFim={evento.data_fim}
            alocacoes={alocacoesRecursos}
          />
        </TabsContent>
      </Tabs>

      {/* Edit Form Dialog */}
      <EventoForm
        open={editFormOpen}
        onOpenChange={setEditFormOpen}
        evento={evento}
      />

      {/* Delete Dialog */}
      <AlertDialog open={deleteDialogOpen} onOpenChange={setDeleteDialogOpen}>
        <AlertDialogContent>
          <AlertDialogHeader>
            <AlertDialogTitle>Excluir evento?</AlertDialogTitle>
            <AlertDialogDescription>
              Esta ação não pode ser desfeita. O evento &quot;{evento.nome}&quot; será
              permanentemente removido do sistema.
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
    </div>
  );
}


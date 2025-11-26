"use client";

import { useState, useTransition, useCallback, useEffect } from "react";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { Badge } from "@/components/ui/badge";
import { ScrollArea } from "@/components/ui/scroll-area";
import { Button } from "@/components/ui/button";
import { Calendar, MapPin, Clock, ChevronLeft, ChevronRight } from "lucide-react";
import { format, addMonths, subMonths } from "date-fns";
import { ptBR } from "date-fns/locale";
import type { MembroEquipe } from "@/types/database";
import { getAgendaMembro } from "@/actions/equipe";

interface AlocacaoComEvento {
  id: string;
  data: string;
  hora_inicio: string | null;
  hora_fim: string | null;
  funcao_evento: string | null;
  valor_pago: number | null;
  observacoes: string | null;
  eventos: {
    id: string;
    nome: string;
    tipo: string;
    local: string | null;
    status: string;
  } | null;
}

interface AgendaModalProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  membro: MembroEquipe | null;
}

const statusColors: Record<string, string> = {
  planejamento: "bg-blue-500/10 text-blue-500",
  confirmado: "bg-green-500/10 text-green-500",
  em_andamento: "bg-yellow-500/10 text-yellow-500",
  realizado: "bg-gray-500/10 text-gray-500",
  cancelado: "bg-red-500/10 text-red-500",
};

const statusLabels: Record<string, string> = {
  planejamento: "Planejamento",
  confirmado: "Confirmado",
  em_andamento: "Em andamento",
  realizado: "Realizado",
  cancelado: "Cancelado",
};

const tipoLabels: Record<string, string> = {
  colonia_ferias: "Colônia de Férias",
  festa_infantil: "Festa Infantil",
  gincana: "Gincana",
  outro: "Outro",
};

export function AgendaModal({ open, onOpenChange, membro }: AgendaModalProps) {
  const [alocacoes, setAlocacoes] = useState<AlocacaoComEvento[]>([]);
  const [isPending, startTransition] = useTransition();
  const [mesAtual, setMesAtual] = useState(new Date());

  const fetchAgenda = useCallback(async () => {
    if (!membro) return;
    const mesStr = format(mesAtual, "yyyy-MM");
    const result = await getAgendaMembro(membro.id, mesStr);
    setAlocacoes(result.data as AlocacaoComEvento[]);
  }, [membro, mesAtual]);

  useEffect(() => {
    if (open && membro) {
      startTransition(() => {
        fetchAgenda();
      });
    }
  }, [open, membro, fetchAgenda]);

  function handlePrevMonth() {
    setMesAtual(subMonths(mesAtual, 1));
  }

  function handleNextMonth() {
    setMesAtual(addMonths(mesAtual, 1));
  }

  function formatCurrency(value: number | null) {
    if (value === null || value === undefined) return "-";
    return new Intl.NumberFormat("pt-BR", {
      style: "currency",
      currency: "BRL",
    }).format(value);
  }

  if (!membro) return null;

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="max-w-2xl">
        <DialogHeader>
          <DialogTitle>Agenda de {membro.nome}</DialogTitle>
        </DialogHeader>

        {/* Navegação do mês */}
        <div className="flex items-center justify-between mb-4">
          <Button variant="outline" size="icon" onClick={handlePrevMonth}>
            <ChevronLeft className="h-4 w-4" />
          </Button>
          <span className="font-medium">
            {format(mesAtual, "MMMM yyyy", { locale: ptBR })}
          </span>
          <Button variant="outline" size="icon" onClick={handleNextMonth}>
            <ChevronRight className="h-4 w-4" />
          </Button>
        </div>

        {isPending ? (
          <div className="flex items-center justify-center py-12">
            <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-primary" />
          </div>
        ) : alocacoes.length === 0 ? (
          <div className="flex flex-col items-center justify-center py-12 text-center">
            <Calendar className="h-12 w-12 text-muted-foreground mb-4" />
            <h3 className="text-lg font-semibold">Nenhuma alocação</h3>
            <p className="text-muted-foreground mt-1">
              Este membro não tem eventos agendados para este mês.
            </p>
          </div>
        ) : (
          <ScrollArea className="max-h-[400px] pr-4">
            <div className="space-y-4">
              {alocacoes.map((alocacao) => (
                <div
                  key={alocacao.id}
                  className="rounded-lg border p-4 space-y-3"
                >
                  <div className="flex items-start justify-between">
                    <div>
                      <h4 className="font-semibold">
                        {alocacao.eventos?.nome || "Evento"}
                      </h4>
                      <Badge variant="outline" className="mt-1">
                        {tipoLabels[alocacao.eventos?.tipo || "outro"]}
                      </Badge>
                    </div>
                    {alocacao.eventos?.status && (
                      <Badge
                        className={statusColors[alocacao.eventos.status]}
                        variant="outline"
                      >
                        {statusLabels[alocacao.eventos.status]}
                      </Badge>
                    )}
                  </div>

                  <div className="flex flex-wrap items-center gap-4 text-sm">
                    <div className="flex items-center gap-1.5">
                      <Calendar className="h-3.5 w-3.5 text-muted-foreground" />
                      <span>
                        {format(new Date(alocacao.data), "dd MMM yyyy", {
                          locale: ptBR,
                        })}
                      </span>
                    </div>

                    {(alocacao.hora_inicio || alocacao.hora_fim) && (
                      <div className="flex items-center gap-1.5">
                        <Clock className="h-3.5 w-3.5 text-muted-foreground" />
                        <span>
                          {alocacao.hora_inicio || "?"} -{" "}
                          {alocacao.hora_fim || "?"}
                        </span>
                      </div>
                    )}

                    {alocacao.eventos?.local && (
                      <div className="flex items-center gap-1.5">
                        <MapPin className="h-3.5 w-3.5 text-muted-foreground" />
                        <span>{alocacao.eventos.local}</span>
                      </div>
                    )}
                  </div>

                  <div className="flex items-center justify-between pt-2 border-t">
                    {alocacao.funcao_evento && (
                      <span className="text-sm text-muted-foreground">
                        Função: <strong>{alocacao.funcao_evento}</strong>
                      </span>
                    )}
                    <span className="text-sm font-medium">
                      {formatCurrency(alocacao.valor_pago)}
                    </span>
                  </div>

                  {alocacao.observacoes && (
                    <p className="text-sm text-muted-foreground">
                      {alocacao.observacoes}
                    </p>
                  )}
                </div>
              ))}
            </div>
          </ScrollArea>
        )}
      </DialogContent>
    </Dialog>
  );
}


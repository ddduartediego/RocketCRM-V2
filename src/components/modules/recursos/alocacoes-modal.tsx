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
import { Calendar, MapPin } from "lucide-react";
import { format } from "date-fns";
import { ptBR } from "date-fns/locale";
import type { Recurso } from "@/types/database";
import { getAlocacoesRecurso } from "@/actions/recursos";

interface AlocacaoComEvento {
  id: string;
  data_inicio: string;
  data_fim: string;
  quantidade: number;
  observacoes: string | null;
  eventos: {
    id: string;
    nome: string;
    data_inicio: string;
    data_fim: string | null;
    status: string;
  } | null;
}

interface AlocacoesModalProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  recurso: Recurso | null;
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

export function AlocacoesModal({
  open,
  onOpenChange,
  recurso,
}: AlocacoesModalProps) {
  const [alocacoes, setAlocacoes] = useState<AlocacaoComEvento[]>([]);
  const [isPending, startTransition] = useTransition();

  const fetchAlocacoes = useCallback(async () => {
    if (!recurso) return;
    const result = await getAlocacoesRecurso(recurso.id);
    setAlocacoes(result.data as AlocacaoComEvento[]);
  }, [recurso]);

  useEffect(() => {
    if (open && recurso) {
      startTransition(() => {
        fetchAlocacoes();
      });
    }
  }, [open, recurso, fetchAlocacoes]);

  if (!recurso) return null;

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="max-w-2xl">
        <DialogHeader>
          <DialogTitle>Alocações de {recurso.nome}</DialogTitle>
        </DialogHeader>

        {isPending ? (
          <div className="flex items-center justify-center py-12">
            <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-primary" />
          </div>
        ) : alocacoes.length === 0 ? (
          <div className="flex flex-col items-center justify-center py-12 text-center">
            <Calendar className="h-12 w-12 text-muted-foreground mb-4" />
            <h3 className="text-lg font-semibold">Nenhuma alocação</h3>
            <p className="text-muted-foreground mt-1">
              Este recurso ainda não foi alocado para nenhum evento.
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
                      <div className="flex items-center gap-2 text-sm text-muted-foreground mt-1">
                        <Calendar className="h-3.5 w-3.5" />
                        <span>
                          {format(new Date(alocacao.data_inicio), "dd MMM yyyy", {
                            locale: ptBR,
                          })}
                          {alocacao.data_fim &&
                            alocacao.data_fim !== alocacao.data_inicio && (
                              <>
                                {" "}
                                -{" "}
                                {format(
                                  new Date(alocacao.data_fim),
                                  "dd MMM yyyy",
                                  { locale: ptBR }
                                )}
                              </>
                            )}
                        </span>
                      </div>
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

                  <div className="flex items-center gap-4 text-sm">
                    <div className="flex items-center gap-1.5">
                      <MapPin className="h-3.5 w-3.5 text-muted-foreground" />
                      <span>
                        Quantidade: <strong>{alocacao.quantidade}</strong>
                      </span>
                    </div>
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


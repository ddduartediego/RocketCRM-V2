"use client";

import { useState, useEffect, useCallback } from "react";
import { useRouter } from "next/navigation";
import { EventosTable } from "./eventos-table";
import { EventoForm } from "./evento-form";
import { EventosWeekView } from "./eventos-week-view";
import { EventosViewToggle, type EventosViewMode } from "./eventos-view-toggle";
import { getEventosSemana } from "@/actions/eventos";
import type { Evento } from "@/types/database";
import type { ResumoFinanceiroEvento } from "@/actions/financeiro";

interface EventoWithRelations extends Evento {
  contatos?: { id: string; nome: string } | null;
  users?: { id: string; nome: string; avatar_url: string | null } | null;
}

interface EventosClientProps {
  eventos: EventoWithRelations[];
  resumosFinanceiros?: Record<string, ResumoFinanceiroEvento>;
}

function getInitialWeekStart(): Date {
  const today = new Date();
  const dayOfWeek = today.getDay();
  const diff = dayOfWeek === 0 ? -6 : 1 - dayOfWeek; // Ajusta para segunda-feira
  const monday = new Date(today);
  monday.setDate(today.getDate() + diff);
  monday.setHours(0, 0, 0, 0);
  return monday;
}

function formatDateForQuery(date: Date): string {
  const year = date.getFullYear();
  const month = String(date.getMonth() + 1).padStart(2, "0");
  const day = String(date.getDate()).padStart(2, "0");
  return `${year}-${month}-${day}`;
}

export function EventosClient({ eventos, resumosFinanceiros = {} }: EventosClientProps) {
  const router = useRouter();
  const [formOpen, setFormOpen] = useState(false);
  const [selectedEvento, setSelectedEvento] = useState<Evento | null>(null);
  const [viewMode, setViewMode] = useState<EventosViewMode>("table");
  const [currentWeekStart, setCurrentWeekStart] = useState<Date>(getInitialWeekStart);
  const [weekEventos, setWeekEventos] = useState<EventoWithRelations[]>([]);
  const [isLoadingWeek, setIsLoadingWeek] = useState(false);

  const fetchWeekEventos = useCallback(async (weekStart: Date) => {
    setIsLoadingWeek(true);
    const startDate = formatDateForQuery(weekStart);
    const endDate = formatDateForQuery(
      new Date(weekStart.getTime() + 6 * 24 * 60 * 60 * 1000)
    );

    const { data } = await getEventosSemana(startDate, endDate);
    setWeekEventos(data as EventoWithRelations[]);
    setIsLoadingWeek(false);
  }, []);

  useEffect(() => {
    if (viewMode === "week") {
      fetchWeekEventos(currentWeekStart);
    }
  }, [viewMode, currentWeekStart, fetchWeekEventos]);

  const handleEdit = (evento: Evento) => {
    setSelectedEvento(evento);
    setFormOpen(true);
  };

  const handleView = (evento: Evento) => {
    router.push(`/eventos/${evento.id}`);
  };

  const handleFormClose = (open: boolean) => {
    setFormOpen(open);
    if (!open) {
      setSelectedEvento(null);
      // Recarrega eventos da semana após fechar o form
      if (viewMode === "week") {
        fetchWeekEventos(currentWeekStart);
      }
    }
  };

  const handleWeekChange = (newWeekStart: Date) => {
    setCurrentWeekStart(newWeekStart);
  };

  return (
    <div className="space-y-4">
      {/* Toggle de visualização */}
      <div className="flex justify-end">
        <EventosViewToggle viewMode={viewMode} onViewModeChange={setViewMode} />
      </div>

      {/* Visualização baseada no modo */}
      {viewMode === "table" ? (
        <EventosTable
          eventos={eventos}
          onEdit={handleEdit}
          onView={handleView}
          resumosFinanceiros={resumosFinanceiros}
        />
      ) : (
        <div className="relative">
          {isLoadingWeek && (
            <div className="absolute inset-0 bg-background/50 flex items-center justify-center z-10 rounded-lg">
              <div className="text-sm text-muted-foreground">Carregando...</div>
            </div>
          )}
          <EventosWeekView
            eventos={weekEventos}
            currentWeekStart={currentWeekStart}
            onWeekChange={handleWeekChange}
          />
        </div>
      )}

      <EventoForm
        open={formOpen}
        onOpenChange={handleFormClose}
        evento={selectedEvento}
      />
    </div>
  );
}

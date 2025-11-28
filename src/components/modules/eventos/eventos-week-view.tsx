"use client";

import { useMemo } from "react";
import { useRouter } from "next/navigation";
import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { ChevronLeft, ChevronRight, Calendar } from "lucide-react";
import type { Evento } from "@/types/database";

interface EventoWithRelations extends Evento {
  contatos?: { id: string; nome: string } | null;
  users?: { id: string; nome: string; avatar_url: string | null } | null;
  tipos_evento?: { id: string; nome: string; icone: string | null; cor: string | null } | null;
}

interface EventosWeekViewProps {
  eventos: EventoWithRelations[];
  currentWeekStart: Date;
  onWeekChange: (newWeekStart: Date) => void;
}

const DIAS_SEMANA = ["Seg", "Ter", "Qua", "Qui", "Sex", "Sáb", "Dom"];

const statusColors: Record<string, string> = {
  planejamento: "#0ea5e9",
  confirmado: "#22c55e",
  em_andamento: "#eab308",
  realizado: "#8b5cf6",
  cancelado: "#dc2626",
};

const tipoIcons: Record<string, string> = {
  colonia_ferias: "🏕️",
  festa_infantil: "🎈",
  gincana: "🏃",
  outro: "📅",
};

export function EventosWeekView({
  eventos,
  currentWeekStart,
  onWeekChange,
}: EventosWeekViewProps) {
  const router = useRouter();

  // Gera os 7 dias da semana a partir de currentWeekStart
  const weekDays = useMemo(() => {
    const days: Date[] = [];
    for (let i = 0; i < 7; i++) {
      const day = new Date(currentWeekStart);
      day.setDate(currentWeekStart.getDate() + i);
      days.push(day);
    }
    return days;
  }, [currentWeekStart]);

  // Mapeia eventos para cada dia da semana
  const eventosPorDia = useMemo(() => {
    const map: Record<string, EventoWithRelations[]> = {};

    weekDays.forEach((day) => {
      const dayKey = formatDateKey(day);
      map[dayKey] = [];
    });

    eventos.forEach((evento) => {
      const dataInicio = new Date(evento.data_inicio + "T00:00:00");
      const dataFim = evento.data_fim
        ? new Date(evento.data_fim + "T00:00:00")
        : dataInicio;

      // Percorre todos os dias do evento
      const currentDate = new Date(dataInicio);
      while (currentDate <= dataFim) {
        const dayKey = formatDateKey(currentDate);
        if (map[dayKey]) {
          map[dayKey].push(evento);
        }
        currentDate.setDate(currentDate.getDate() + 1);
      }
    });

    // Ordena eventos por hora de início em cada dia
    Object.keys(map).forEach((dayKey) => {
      map[dayKey].sort((a, b) => {
        const horaA = a.hora_inicio || "00:00";
        const horaB = b.hora_inicio || "00:00";
        return horaA.localeCompare(horaB);
      });
    });

    return map;
  }, [eventos, weekDays]);

  const handlePreviousWeek = () => {
    const newWeekStart = new Date(currentWeekStart);
    newWeekStart.setDate(currentWeekStart.getDate() - 7);
    onWeekChange(newWeekStart);
  };

  const handleNextWeek = () => {
    const newWeekStart = new Date(currentWeekStart);
    newWeekStart.setDate(currentWeekStart.getDate() + 7);
    onWeekChange(newWeekStart);
  };

  const handleToday = () => {
    const today = new Date();
    const dayOfWeek = today.getDay();
    const diff = dayOfWeek === 0 ? -6 : 1 - dayOfWeek; // Ajusta para segunda-feira
    const monday = new Date(today);
    monday.setDate(today.getDate() + diff);
    monday.setHours(0, 0, 0, 0);
    onWeekChange(monday);
  };

  const handleEventClick = (eventoId: string) => {
    router.push(`/eventos/${eventoId}`);
  };

  const formatWeekRange = () => {
    const start = weekDays[0];
    const end = weekDays[6];
    const startMonth = start.toLocaleDateString("pt-BR", { month: "short" });
    const endMonth = end.toLocaleDateString("pt-BR", { month: "short" });
    const year = end.getFullYear();

    if (startMonth === endMonth) {
      return `${start.getDate()} - ${end.getDate()} ${startMonth} ${year}`;
    }
    return `${start.getDate()} ${startMonth} - ${end.getDate()} ${endMonth} ${year}`;
  };

  const isToday = (date: Date) => {
    const today = new Date();
    return (
      date.getDate() === today.getDate() &&
      date.getMonth() === today.getMonth() &&
      date.getFullYear() === today.getFullYear()
    );
  };

  return (
    <div className="space-y-4">
      {/* Header com navegação */}
      <div className="flex items-center justify-between">
        <div className="flex items-center gap-2">
          <Button variant="outline" size="icon" onClick={handlePreviousWeek}>
            <ChevronLeft className="h-4 w-4" />
          </Button>
          <Button variant="outline" size="icon" onClick={handleNextWeek}>
            <ChevronRight className="h-4 w-4" />
          </Button>
          <Button variant="outline" size="sm" onClick={handleToday}>
            Hoje
          </Button>
        </div>
        <h3 className="text-lg font-semibold text-foreground">
          {formatWeekRange()}
        </h3>
        <div className="w-[140px]" /> {/* Espaçador para centralizar o título */}
      </div>

      {/* Grade da semana */}
      <div className="grid grid-cols-7 gap-2">
        {weekDays.map((day, index) => {
          const dayKey = formatDateKey(day);
          const dayEvents = eventosPorDia[dayKey] || [];
          const dayIsToday = isToday(day);

          return (
            <div
              key={dayKey}
              className={`min-h-[200px] rounded-lg border ${
                dayIsToday
                  ? "border-primary bg-primary/5"
                  : "border-border bg-card"
              }`}
            >
              {/* Cabeçalho do dia */}
              <div
                className={`p-2 border-b text-center ${
                  dayIsToday ? "border-primary/30" : "border-border"
                }`}
              >
                <div className="text-xs font-medium text-muted-foreground">
                  {DIAS_SEMANA[index]}
                </div>
                <div
                  className={`text-lg font-bold ${
                    dayIsToday ? "text-primary" : "text-foreground"
                  }`}
                >
                  {day.getDate()}
                </div>
              </div>

              {/* Lista de eventos */}
              <div className="p-1.5 space-y-1.5 max-h-[300px] overflow-y-auto">
                {dayEvents.length === 0 ? (
                  <div className="text-center py-4 text-xs text-muted-foreground">
                    <Calendar className="h-4 w-4 mx-auto mb-1 opacity-50" />
                    Sem eventos
                  </div>
                ) : (
                  dayEvents.map((evento) => (
                    <EventoCard
                      key={`${evento.id}-${dayKey}`}
                      evento={evento}
                      onClick={() => handleEventClick(evento.id)}
                    />
                  ))
                )}
              </div>
            </div>
          );
        })}
      </div>
    </div>
  );
}

interface EventoCardProps {
  evento: EventoWithRelations;
  onClick: () => void;
}

function EventoCard({ evento, onClick }: EventoCardProps) {
  const statusColor = statusColors[evento.status] || "#6b7280";
  const tipoIcon = evento.tipos_evento?.icone || tipoIcons[evento.tipo as string] || "📅";

  return (
    <Card
      className="p-2 cursor-pointer transition-all hover:shadow-md hover:scale-[1.02] active:scale-[0.98]"
      style={{
        borderLeftWidth: "3px",
        borderLeftColor: statusColor,
      }}
      onClick={onClick}
    >
      <div className="space-y-1">
        {/* Horário e tipo */}
        <div className="flex items-center justify-between gap-1">
          {evento.hora_inicio && (
            <Badge variant="secondary" className="text-[10px] px-1.5 py-0 font-mono">
              {evento.hora_inicio.slice(0, 5)}
            </Badge>
          )}
          <span className="text-xs">{tipoIcon}</span>
        </div>

        {/* Nome do evento */}
        <div className="text-xs font-medium text-foreground line-clamp-2 leading-tight">
          {evento.nome}
        </div>

        {/* Cliente */}
        {evento.contatos?.nome && (
          <div className="text-[10px] text-muted-foreground truncate">
            {evento.contatos.nome}
          </div>
        )}
      </div>
    </Card>
  );
}

function formatDateKey(date: Date): string {
  const year = date.getFullYear();
  const month = String(date.getMonth() + 1).padStart(2, "0");
  const day = String(date.getDate()).padStart(2, "0");
  return `${year}-${month}-${day}`;
}


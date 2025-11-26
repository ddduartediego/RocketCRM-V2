"use client";

import { useSortable } from "@dnd-kit/sortable";
import { CSS } from "@dnd-kit/utilities";
import { Card, CardContent } from "@/components/ui/card";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Badge } from "@/components/ui/badge";
import { GripVertical, User, Calendar } from "lucide-react";
import { cn } from "@/lib/utils";
import type { Lead } from "@/types/database";

interface LeadWithRelations extends Lead {
  contatos?: { id: string; nome: string } | null;
  etapas_funil?: {
    id: string;
    nome: string;
    cor: string;
    ordem: number;
    is_final: boolean;
    is_perdido: boolean;
  } | null;
  users?: { id: string; nome: string; avatar_url: string | null } | null;
}

interface LeadCardProps {
  lead: LeadWithRelations;
  isDragging?: boolean;
  onClick?: () => void;
}

const tipoServicoLabels: Record<string, string> = {
  colonia_ferias: "Colônia",
  festa_infantil: "Festa",
  gincana: "Gincana",
  outro: "Outro",
};

export function LeadCard({ lead, isDragging, onClick }: LeadCardProps) {
  const {
    attributes,
    listeners,
    setNodeRef,
    transform,
    transition,
    isDragging: isSortableDragging,
  } = useSortable({ id: lead.id });

  const style = {
    transform: CSS.Transform.toString(transform),
    transition,
  };

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

  const getInitials = (name: string) => {
    return name
      .split(" ")
      .map((n) => n[0])
      .join("")
      .toUpperCase()
      .slice(0, 2);
  };

  return (
    <Card
      ref={setNodeRef}
      style={style}
      className={cn(
        "cursor-pointer transition-all hover:shadow-md border-border/50",
        isDragging && "opacity-50 shadow-lg rotate-2",
        isSortableDragging && "opacity-50"
      )}
      onClick={onClick}
    >
      <CardContent className="p-3">
        {/* Header com grip e título */}
        <div className="flex items-start gap-2 mb-2">
          <div
            {...attributes}
            {...listeners}
            className="cursor-grab active:cursor-grabbing p-1 -ml-1 text-muted-foreground hover:text-foreground"
            onClick={(e) => e.stopPropagation()}
          >
            <GripVertical className="w-4 h-4" />
          </div>
          <div className="flex-1 min-w-0">
            <h4 className="font-medium text-sm truncate">{lead.titulo}</h4>
            {lead.tipo_servico && (
              <Badge
                variant="outline"
                className="mt-1 text-[10px] px-1.5 py-0 bg-accent/50"
              >
                {tipoServicoLabels[lead.tipo_servico] || lead.tipo_servico}
              </Badge>
            )}
          </div>
        </div>

        {/* Contato */}
        {lead.contatos?.nome && (
          <div className="mb-3">
            <div className="flex items-center gap-1.5 text-xs text-muted-foreground">
              <User className="w-3 h-3" />
              <span className="truncate">{lead.contatos.nome}</span>
            </div>
          </div>
        )}

        {/* Footer */}
        <div className="flex items-center justify-between pt-2 border-t border-border/50">
          <span className="text-sm font-semibold text-primary">
            {formatCurrency(lead.valor_estimado || 0)}
          </span>

          <div className="flex items-center gap-2">
            {lead.data_prevista && (
              <div className="flex items-center gap-1 text-xs text-muted-foreground">
                <Calendar className="w-3 h-3" />
                {formatDate(lead.data_prevista)}
              </div>
            )}

            {lead.users && (
              <Avatar className="w-6 h-6">
                <AvatarImage src={lead.users.avatar_url || undefined} />
                <AvatarFallback className="text-[10px] bg-secondary text-secondary-foreground">
                  {getInitials(lead.users.nome)}
                </AvatarFallback>
              </Avatar>
            )}
          </div>
        </div>
      </CardContent>
    </Card>
  );
}


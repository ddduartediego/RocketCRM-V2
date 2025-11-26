"use client";

import { useDroppable } from "@dnd-kit/core";
import { SortableContext, verticalListSortingStrategy } from "@dnd-kit/sortable";
import { Button } from "@/components/ui/button";
import { ScrollArea } from "@/components/ui/scroll-area";
import { Plus } from "lucide-react";
import { LeadCard } from "./lead-card";
import { cn } from "@/lib/utils";
import type { EtapaFunil, Lead } from "@/types/database";

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

interface KanbanColumnProps {
  etapa: EtapaFunil;
  leads: LeadWithRelations[];
  total: { count: number; valor: number };
  onAddLead: () => void;
  onEditLead: (lead: LeadWithRelations) => void;
}

export function KanbanColumn({
  etapa,
  leads,
  total,
  onAddLead,
  onEditLead,
}: KanbanColumnProps) {
  const { setNodeRef, isOver } = useDroppable({
    id: etapa.id,
  });

  const formatCurrency = (value: number) => {
    return new Intl.NumberFormat("pt-BR", {
      style: "currency",
      currency: "BRL",
      notation: "compact",
    }).format(value);
  };

  return (
    <div
      ref={setNodeRef}
      className={cn(
        "flex flex-col w-80 min-w-[320px] bg-muted/30 rounded-lg",
        isOver && "ring-2 ring-primary ring-offset-2"
      )}
    >
      {/* Header da coluna */}
      <div
        className="p-3 rounded-t-lg"
        style={{ backgroundColor: `${etapa.cor}15` }}
      >
        <div className="flex items-center justify-between mb-2">
          <div className="flex items-center gap-2">
            <div
              className="w-3 h-3 rounded-full"
              style={{ backgroundColor: etapa.cor }}
            />
            <h3 className="font-semibold text-sm">{etapa.nome}</h3>
          </div>
          <span
            className="text-xs font-medium px-2 py-0.5 rounded-full"
            style={{
              backgroundColor: `${etapa.cor}20`,
              color: etapa.cor,
            }}
          >
            {total.count}
          </span>
        </div>
        <p className="text-xs text-muted-foreground">
          {formatCurrency(total.valor)} em oportunidades
        </p>
      </div>

      {/* Lista de leads */}
      <ScrollArea className="flex-1 p-2">
        <SortableContext
          items={leads.map((l) => l.id)}
          strategy={verticalListSortingStrategy}
        >
          <div className="space-y-2 min-h-[100px]">
            {leads.map((lead) => (
              <LeadCard
                key={lead.id}
                lead={lead}
                onClick={() => onEditLead(lead)}
              />
            ))}
          </div>
        </SortableContext>
      </ScrollArea>

      {/* Footer - Adicionar lead */}
      <div className="p-2 border-t border-border/50">
        <Button
          variant="ghost"
          size="sm"
          className="w-full justify-start text-muted-foreground hover:text-foreground"
          onClick={onAddLead}
        >
          <Plus className="w-4 h-4 mr-2" />
          Adicionar lead
        </Button>
      </div>
    </div>
  );
}


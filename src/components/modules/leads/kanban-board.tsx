"use client";

import { useState } from "react";
import {
  DndContext,
  DragOverlay,
  closestCorners,
  KeyboardSensor,
  PointerSensor,
  useSensor,
  useSensors,
  type DragEndEvent,
  type DragStartEvent,
} from "@dnd-kit/core";
import { sortableKeyboardCoordinates } from "@dnd-kit/sortable";
import { KanbanColumn } from "./kanban-column";
import { LeadCard } from "./lead-card";
import { LeadForm } from "./lead-form";
import { MotivoPerdaModal } from "./motivo-perda-modal";
import { updateLeadEtapa } from "@/actions/leads";
import { toast } from "sonner";
import type { EtapaFunil, Lead } from "@/types/database";

interface LeadWithRelations extends Lead {
  contatos?: { id: string; nome: string } | null;
  organizacoes?: { id: string; nome: string } | null;
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

interface KanbanBoardProps {
  etapas: EtapaFunil[];
  leadsByEtapa: Record<string, LeadWithRelations[]>;
}

export function KanbanBoard({ etapas, leadsByEtapa }: KanbanBoardProps) {
  const [activeId, setActiveId] = useState<string | null>(null);
  const [formOpen, setFormOpen] = useState(false);
  const [selectedLead, setSelectedLead] = useState<LeadWithRelations | null>(null);
  const [motivoPerdaOpen, setMotivoPerdaOpen] = useState(false);
  const [pendingMove, setPendingMove] = useState<{
    leadId: string;
    etapaId: string;
  } | null>(null);

  const sensors = useSensors(
    useSensor(PointerSensor, {
      activationConstraint: {
        distance: 8,
      },
    }),
    useSensor(KeyboardSensor, {
      coordinateGetter: sortableKeyboardCoordinates,
    })
  );

  const findLead = (id: string): LeadWithRelations | null => {
    for (const leads of Object.values(leadsByEtapa)) {
      const lead = leads.find((l) => l.id === id);
      if (lead) return lead;
    }
    return null;
  };

  const handleDragStart = (event: DragStartEvent) => {
    setActiveId(event.active.id as string);
  };

  const handleDragEnd = async (event: DragEndEvent) => {
    const { active, over } = event;
    setActiveId(null);

    if (!over) return;

    const leadId = active.id as string;
    const targetEtapaId = over.id as string;

    // Encontrar o lead
    const lead = findLead(leadId);
    if (!lead) return;

    // Se a etapa não mudou, não faz nada
    if (lead.etapa_id === targetEtapaId) return;

    // Verificar se a etapa de destino é "Perdido"
    const targetEtapa = etapas.find((e) => e.id === targetEtapaId);
    if (targetEtapa?.is_perdido) {
      setPendingMove({ leadId, etapaId: targetEtapaId });
      setMotivoPerdaOpen(true);
      return;
    }

    // Atualizar a etapa
    const result = await updateLeadEtapa(leadId, targetEtapaId);
    if (result.error) {
      toast.error("Erro ao mover lead", { description: result.error });
    } else {
      toast.success("Lead movido com sucesso");
    }
  };

  const handleMotivoPerdaConfirm = async (motivo: string) => {
    if (!pendingMove) return;

    const result = await updateLeadEtapa(
      pendingMove.leadId,
      pendingMove.etapaId,
      motivo
    );

    if (result.error) {
      toast.error("Erro ao mover lead", { description: result.error });
    } else {
      toast.success("Lead marcado como perdido");
    }

    setPendingMove(null);
    setMotivoPerdaOpen(false);
  };

  const handleEditLead = (lead: LeadWithRelations) => {
    setSelectedLead(lead);
    setFormOpen(true);
  };

  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  const handleNewLead = (_etapaId?: string) => {
    setSelectedLead(null);
    setFormOpen(true);
  };

  const activeLead = activeId ? findLead(activeId) : null;

  // Calcular totais por etapa
  const totaisPorEtapa: Record<string, { count: number; valor: number }> = {};
  etapas.forEach((etapa) => {
    const leads = leadsByEtapa[etapa.id] || [];
    totaisPorEtapa[etapa.id] = {
      count: leads.length,
      valor: leads.reduce((sum, lead) => sum + (lead.valor_estimado || 0), 0),
    };
  });

  return (
    <>
      <DndContext
        sensors={sensors}
        collisionDetection={closestCorners}
        onDragStart={handleDragStart}
        onDragEnd={handleDragEnd}
      >
        <div className="flex gap-4 overflow-x-auto pb-4 min-h-[calc(100vh-250px)]">
          {etapas.map((etapa) => (
            <KanbanColumn
              key={etapa.id}
              etapa={etapa}
              leads={leadsByEtapa[etapa.id] || []}
              total={totaisPorEtapa[etapa.id]}
              onAddLead={() => handleNewLead(etapa.id)}
              onEditLead={handleEditLead}
            />
          ))}
        </div>

        <DragOverlay>
          {activeLead && <LeadCard lead={activeLead} isDragging />}
        </DragOverlay>
      </DndContext>

      <LeadForm
        open={formOpen}
        onOpenChange={setFormOpen}
        lead={selectedLead}
        etapas={etapas}
      />

      <MotivoPerdaModal
        open={motivoPerdaOpen}
        onOpenChange={setMotivoPerdaOpen}
        onConfirm={handleMotivoPerdaConfirm}
      />
    </>
  );
}


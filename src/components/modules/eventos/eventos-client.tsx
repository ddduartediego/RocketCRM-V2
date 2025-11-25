"use client";

import { useState } from "react";
import { EventosTable } from "./eventos-table";
import { EventoForm } from "./evento-form";
import type { Evento } from "@/types/database";

interface EventoWithRelations extends Evento {
  contatos?: { id: string; nome: string } | null;
  organizacoes?: { id: string; nome: string } | null;
  users?: { id: string; nome: string; avatar_url: string | null } | null;
}

interface EventosClientProps {
  eventos: EventoWithRelations[];
}

export function EventosClient({ eventos }: EventosClientProps) {
  const [formOpen, setFormOpen] = useState(false);
  const [selectedEvento, setSelectedEvento] = useState<Evento | null>(null);

  const handleEdit = (evento: Evento) => {
    setSelectedEvento(evento);
    setFormOpen(true);
  };

  const handleView = (evento: Evento) => {
    // Por enquanto, abre o form para visualização/edição
    setSelectedEvento(evento);
    setFormOpen(true);
  };

  const handleFormClose = (open: boolean) => {
    setFormOpen(open);
    if (!open) {
      setSelectedEvento(null);
    }
  };

  return (
    <>
      <EventosTable
        eventos={eventos}
        onEdit={handleEdit}
        onView={handleView}
      />

      <EventoForm
        open={formOpen}
        onOpenChange={handleFormClose}
        evento={selectedEvento}
      />
    </>
  );
}


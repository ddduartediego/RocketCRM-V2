"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { EventosTable } from "./eventos-table";
import { EventoForm } from "./evento-form";
import type { Evento } from "@/types/database";
import type { ResumoFinanceiroEvento } from "@/actions/financeiro";

interface EventoWithRelations extends Evento {
  contatos?: { id: string; nome: string } | null;
  organizacoes?: { id: string; nome: string } | null;
  users?: { id: string; nome: string; avatar_url: string | null } | null;
}

interface EventosClientProps {
  eventos: EventoWithRelations[];
  resumosFinanceiros?: Record<string, ResumoFinanceiroEvento>;
}

export function EventosClient({ eventos, resumosFinanceiros = {} }: EventosClientProps) {
  const router = useRouter();
  const [formOpen, setFormOpen] = useState(false);
  const [selectedEvento, setSelectedEvento] = useState<Evento | null>(null);

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
    }
  };

  return (
    <>
      <EventosTable
        eventos={eventos}
        onEdit={handleEdit}
        onView={handleView}
        resumosFinanceiros={resumosFinanceiros}
      />

      <EventoForm
        open={formOpen}
        onOpenChange={handleFormClose}
        evento={selectedEvento}
      />
    </>
  );
}


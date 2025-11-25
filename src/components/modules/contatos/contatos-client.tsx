"use client";

import { useState } from "react";
import { ContatosTable } from "./contatos-table";
import { ContatoForm } from "./contato-form";
import { ContatoDetail } from "./contato-detail";
import type { Contato } from "@/types/database";

interface ContatosClientProps {
  contatos: (Contato & { organizacoes?: { nome: string } | null })[];
}

export function ContatosClient({ contatos }: ContatosClientProps) {
  const [formOpen, setFormOpen] = useState(false);
  const [detailOpen, setDetailOpen] = useState(false);
  const [selectedContato, setSelectedContato] = useState<Contato | null>(null);

  const handleEdit = (contato: Contato) => {
    setSelectedContato(contato);
    setFormOpen(true);
  };

  const handleView = (contato: Contato) => {
    setSelectedContato(contato);
    setDetailOpen(true);
  };

  const handleFormClose = (open: boolean) => {
    setFormOpen(open);
    if (!open) {
      setSelectedContato(null);
    }
  };

  const handleDetailClose = (open: boolean) => {
    setDetailOpen(open);
    if (!open) {
      setSelectedContato(null);
    }
  };

  return (
    <>
      <ContatosTable
        contatos={contatos}
        onEdit={handleEdit}
        onView={handleView}
      />

      <ContatoForm
        open={formOpen}
        onOpenChange={handleFormClose}
        contato={selectedContato}
      />

      <ContatoDetail
        open={detailOpen}
        onOpenChange={handleDetailClose}
        contato={
          selectedContato
            ? (contatos.find((c) => c.id === selectedContato.id) as typeof selectedContato & { organizacoes?: { nome: string } | null }) || selectedContato
            : null
        }
        onEdit={handleEdit}
      />
    </>
  );
}

// Export para uso na página
export { ContatosClient as default };


"use client";

import { useState, useEffect } from "react";
import { Button } from "@/components/ui/button";
import { Plus } from "lucide-react";
import { LeadForm } from "@/components/modules/leads/lead-form";
import { getEtapasFunil } from "@/actions/leads";
import type { EtapaFunil } from "@/types/database";

export function LeadFormTrigger() {
  const [open, setOpen] = useState(false);
  const [etapas, setEtapas] = useState<EtapaFunil[]>([]);

  useEffect(() => {
    const loadEtapas = async () => {
      const { data } = await getEtapasFunil();
      setEtapas(data);
    };
    loadEtapas();
  }, []);

  return (
    <>
      <Button onClick={() => setOpen(true)}>
        <Plus className="w-4 h-4 mr-2" />
        Novo Lead
      </Button>
      <LeadForm open={open} onOpenChange={setOpen} etapas={etapas} />
    </>
  );
}


"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { Button } from "@/components/ui/button";
import { Plus } from "lucide-react";
import { EventoForm } from "@/components/modules/eventos/evento-form";

export function EventoFormTrigger() {
  const router = useRouter();
  const [open, setOpen] = useState(false);

  const handleOpenChange = (open: boolean) => {
    setOpen(open);
    if (!open) {
      router.refresh();
    }
  };

  return (
    <>
      <Button onClick={() => setOpen(true)}>
        <Plus className="w-4 h-4 mr-2" />
        Novo Evento
      </Button>
      <EventoForm open={open} onOpenChange={handleOpenChange} />
    </>
  );
}


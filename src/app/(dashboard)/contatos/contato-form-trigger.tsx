"use client";

import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Plus } from "lucide-react";
import { ContatoForm } from "@/components/modules/contatos/contato-form";

export function ContatoFormTrigger() {
  const [open, setOpen] = useState(false);

  return (
    <>
      <Button onClick={() => setOpen(true)}>
        <Plus className="w-4 h-4 mr-2" />
        Novo Contato
      </Button>
      <ContatoForm open={open} onOpenChange={setOpen} />
    </>
  );
}


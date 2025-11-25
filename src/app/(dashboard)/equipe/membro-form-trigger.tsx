"use client";

import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Plus } from "lucide-react";
import { MembroForm } from "@/components/modules/equipe";

export function MembroFormTrigger() {
  const [open, setOpen] = useState(false);

  return (
    <>
      <Button onClick={() => setOpen(true)}>
        <Plus className="mr-2 h-4 w-4" />
        Novo Membro
      </Button>
      <MembroForm open={open} onOpenChange={setOpen} />
    </>
  );
}


"use client";

import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Plus } from "lucide-react";
import { TransacaoForm } from "@/components/modules/financeiro";

export function TransacaoFormTrigger() {
  const [open, setOpen] = useState(false);

  return (
    <>
      <Button onClick={() => setOpen(true)}>
        <Plus className="mr-2 h-4 w-4" />
        Nova Transação
      </Button>
      <TransacaoForm open={open} onOpenChange={setOpen} transacao={null} />
    </>
  );
}


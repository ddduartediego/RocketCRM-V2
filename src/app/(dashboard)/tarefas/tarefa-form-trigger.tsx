"use client";

import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Plus } from "lucide-react";
import { TarefaForm } from "@/components/modules/tarefas";

export function TarefaFormTrigger() {
  const [open, setOpen] = useState(false);

  return (
    <>
      <Button onClick={() => setOpen(true)}>
        <Plus className="mr-2 h-4 w-4" />
        Nova Tarefa
      </Button>
      <TarefaForm open={open} onOpenChange={setOpen} tarefa={null} />
    </>
  );
}


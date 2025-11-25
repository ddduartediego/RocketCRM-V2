"use client";

import { useState, useCallback, useTransition } from "react";
import { useSearchParams, useRouter, usePathname } from "next/navigation";
import { TarefasTable } from "./tarefas-table";
import { TarefaForm } from "./tarefa-form";
import { TarefasFilters } from "./tarefas-filters";
import { ResumoTarefas } from "./resumo-tarefas";
import { Button } from "@/components/ui/button";
import { ChevronLeft, ChevronRight } from "lucide-react";
import type { Atividade } from "@/types/database";
import { getAtividades } from "@/actions/atividades";

interface Tarefa {
  id: string;
  titulo: string;
  descricao: string | null;
  status: string;
  prioridade: number | null;
  data_vencimento: string | null;
  evento_id: string | null;
  lead_id: string | null;
  contato_id: string | null;
  users: { id: string; nome: string; avatar_url: string | null } | null;
  eventos: { id: string; nome: string } | null;
  leads: { id: string; titulo: string } | null;
  contatos: { id: string; nome: string } | null;
}

interface TarefasClientProps {
  initialTarefas: Tarefa[];
  initialCount: number;
  resumo: {
    total: number;
    pendentes: number;
    emAndamento: number;
    concluidas: number;
    vencidas: number;
  };
}

export function TarefasClient({
  initialTarefas,
  initialCount,
  resumo,
}: TarefasClientProps) {
  const router = useRouter();
  const pathname = usePathname();
  const searchParams = useSearchParams();

  const [tarefas, setTarefas] = useState(initialTarefas);
  const [count, setCount] = useState(initialCount);
  const [isPending, startTransition] = useTransition();

  const [formOpen, setFormOpen] = useState(false);
  const [editingTarefa, setEditingTarefa] = useState<Atividade | null>(null);

  const search = searchParams.get("search") || "";
  const status = searchParams.get("status") || "todos";
  const prioridade = searchParams.get("prioridade") || "todos";
  const page = Number(searchParams.get("page")) || 1;
  const perPage = 20;

  const updateURL = useCallback(
    (params: Record<string, string>) => {
      const current = new URLSearchParams(searchParams.toString());
      Object.entries(params).forEach(([key, value]) => {
        if (value) {
          current.set(key, value);
        } else {
          current.delete(key);
        }
      });
      router.push(`${pathname}?${current.toString()}`);
    },
    [pathname, router, searchParams]
  );

  const fetchTarefas = useCallback(async () => {
    startTransition(async () => {
      const result = await getAtividades({
        search,
        status: status !== "todos" ? status : undefined,
        prioridade: prioridade !== "todos" ? Number(prioridade) : undefined,
        page,
        perPage,
      });
      setTarefas(result.data as Tarefa[]);
      setCount(result.count);
    });
  }, [search, status, prioridade, page]);

  function handleEdit(tarefa: Tarefa) {
    setEditingTarefa(tarefa as unknown as Atividade);
    setFormOpen(true);
  }

  function handleFormClose(open: boolean) {
    setFormOpen(open);
    if (!open) {
      setEditingTarefa(null);
      fetchTarefas();
    }
  }

  const totalPages = Math.ceil(count / perPage);

  return (
    <div className="space-y-6">
      {/* Resumo */}
      <ResumoTarefas {...resumo} />

      {/* Filtros */}
      <TarefasFilters
        search={search}
        status={status}
        prioridade={prioridade}
        onSearchChange={(value) => updateURL({ search: value, page: "1" })}
        onStatusChange={(value) => updateURL({ status: value, page: "1" })}
        onPrioridadeChange={(value) => updateURL({ prioridade: value, page: "1" })}
      />

      {/* Tabela */}
      {isPending ? (
        <div className="flex items-center justify-center py-12">
          <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-primary" />
        </div>
      ) : (
        <>
          <TarefasTable tarefas={tarefas} onEdit={handleEdit} />

          {totalPages > 1 && (
            <div className="flex items-center justify-between pt-4">
              <p className="text-sm text-muted-foreground">
                Mostrando {Math.min((page - 1) * perPage + 1, count)} a{" "}
                {Math.min(page * perPage, count)} de {count} tarefas
              </p>
              <div className="flex items-center gap-2">
                <Button
                  variant="outline"
                  size="sm"
                  onClick={() => updateURL({ page: String(page - 1) })}
                  disabled={page <= 1}
                >
                  <ChevronLeft className="h-4 w-4" />
                  Anterior
                </Button>
                <span className="text-sm">
                  {page} de {totalPages}
                </span>
                <Button
                  variant="outline"
                  size="sm"
                  onClick={() => updateURL({ page: String(page + 1) })}
                  disabled={page >= totalPages}
                >
                  Próximo
                  <ChevronRight className="h-4 w-4" />
                </Button>
              </div>
            </div>
          )}
        </>
      )}

      <TarefaForm
        open={formOpen}
        onOpenChange={handleFormClose}
        tarefa={editingTarefa}
      />
    </div>
  );
}


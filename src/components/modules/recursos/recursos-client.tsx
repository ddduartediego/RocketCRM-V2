"use client";

import { useState, useCallback, useTransition } from "react";
import { useSearchParams, useRouter, usePathname } from "next/navigation";
import { RecursosTable } from "./recursos-table";
import { RecursoForm } from "./recurso-form";
import { RecursosFilters } from "./recursos-filters";
import { AlocacoesModal } from "./alocacoes-modal";
import { Button } from "@/components/ui/button";
import { ChevronLeft, ChevronRight } from "lucide-react";
import type { Recurso } from "@/types/database";
import { getRecursos } from "@/actions/recursos";

interface RecursosClientProps {
  initialRecursos: Recurso[];
  initialCount: number;
}

export function RecursosClient({
  initialRecursos,
  initialCount,
}: RecursosClientProps) {
  const router = useRouter();
  const pathname = usePathname();
  const searchParams = useSearchParams();

  const [recursos, setRecursos] = useState(initialRecursos);
  const [count, setCount] = useState(initialCount);
  const [isPending, startTransition] = useTransition();

  const [formOpen, setFormOpen] = useState(false);
  const [editingRecurso, setEditingRecurso] = useState<Recurso | null>(null);
  const [alocacoesRecurso, setAlocacoesRecurso] = useState<Recurso | null>(null);

  const search = searchParams.get("search") || "";
  const tipo = searchParams.get("tipo") || "todos";
  const page = Number(searchParams.get("page")) || 1;
  const perPage = 10;

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

  const fetchRecursos = useCallback(async () => {
    startTransition(async () => {
      const result = await getRecursos({
        search,
        tipo,
        page,
        perPage,
      });
      setRecursos(result.data);
      setCount(result.count);
    });
  }, [search, tipo, page]);

  function handleEdit(recurso: Recurso) {
    setEditingRecurso(recurso);
    setFormOpen(true);
  }

  function handleFormClose(open: boolean) {
    setFormOpen(open);
    if (!open) {
      setEditingRecurso(null);
      fetchRecursos();
    }
  }

  function handleViewAlocacoes(recurso: Recurso) {
    setAlocacoesRecurso(recurso);
  }

  const totalPages = Math.ceil(count / perPage);

  return (
    <div className="space-y-6">
      <RecursosFilters
        search={search}
        tipo={tipo}
        onSearchChange={(value) => updateURL({ search: value, page: "1" })}
        onTipoChange={(value) => updateURL({ tipo: value, page: "1" })}
      />

      {isPending ? (
        <div className="flex items-center justify-center py-12">
          <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-primary" />
        </div>
      ) : (
        <>
          <RecursosTable
            recursos={recursos}
            onEdit={handleEdit}
            onViewAlocacoes={handleViewAlocacoes}
          />

          {totalPages > 1 && (
            <div className="flex items-center justify-between pt-4">
              <p className="text-sm text-muted-foreground">
                Mostrando {Math.min((page - 1) * perPage + 1, count)} a{" "}
                {Math.min(page * perPage, count)} de {count} recursos
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

      <RecursoForm
        open={formOpen}
        onOpenChange={handleFormClose}
        recurso={editingRecurso}
      />

      <AlocacoesModal
        open={!!alocacoesRecurso}
        onOpenChange={(open) => !open && setAlocacoesRecurso(null)}
        recurso={alocacoesRecurso}
      />
    </div>
  );
}


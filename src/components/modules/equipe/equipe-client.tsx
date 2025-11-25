"use client";

import { useState, useCallback, useTransition } from "react";
import { useSearchParams, useRouter, usePathname } from "next/navigation";
import { EquipeTable } from "./equipe-table";
import { MembroForm } from "./membro-form";
import { EquipeFilters } from "./equipe-filters";
import { AgendaModal } from "./agenda-modal";
import { Button } from "@/components/ui/button";
import { ChevronLeft, ChevronRight } from "lucide-react";
import type { MembroEquipe } from "@/types/database";
import { getMembrosEquipe } from "@/actions/equipe";

interface EquipeClientProps {
  initialMembros: MembroEquipe[];
  initialCount: number;
}

export function EquipeClient({
  initialMembros,
  initialCount,
}: EquipeClientProps) {
  const router = useRouter();
  const pathname = usePathname();
  const searchParams = useSearchParams();

  const [membros, setMembros] = useState(initialMembros);
  const [count, setCount] = useState(initialCount);
  const [isPending, startTransition] = useTransition();

  const [formOpen, setFormOpen] = useState(false);
  const [editingMembro, setEditingMembro] = useState<MembroEquipe | null>(null);
  const [agendaMembro, setAgendaMembro] = useState<MembroEquipe | null>(null);

  const search = searchParams.get("search") || "";
  const funcao = searchParams.get("funcao") || "todos";
  const tipoContrato = searchParams.get("tipo_contrato") || "todos";
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

  const fetchMembros = useCallback(async () => {
    startTransition(async () => {
      const result = await getMembrosEquipe({
        search,
        funcao,
        tipo_contrato: tipoContrato,
        page,
        perPage,
      });
      setMembros(result.data);
      setCount(result.count);
    });
  }, [search, funcao, tipoContrato, page]);

  function handleEdit(membro: MembroEquipe) {
    setEditingMembro(membro);
    setFormOpen(true);
  }

  function handleFormClose(open: boolean) {
    setFormOpen(open);
    if (!open) {
      setEditingMembro(null);
      fetchMembros();
    }
  }

  function handleViewAgenda(membro: MembroEquipe) {
    setAgendaMembro(membro);
  }

  const totalPages = Math.ceil(count / perPage);

  return (
    <div className="space-y-6">
      <EquipeFilters
        search={search}
        funcao={funcao}
        tipoContrato={tipoContrato}
        onSearchChange={(value) => updateURL({ search: value, page: "1" })}
        onFuncaoChange={(value) => updateURL({ funcao: value, page: "1" })}
        onTipoContratoChange={(value) =>
          updateURL({ tipo_contrato: value, page: "1" })
        }
      />

      {isPending ? (
        <div className="flex items-center justify-center py-12">
          <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-primary" />
        </div>
      ) : (
        <>
          <EquipeTable
            membros={membros}
            onEdit={handleEdit}
            onViewAgenda={handleViewAgenda}
          />

          {totalPages > 1 && (
            <div className="flex items-center justify-between pt-4">
              <p className="text-sm text-muted-foreground">
                Mostrando {Math.min((page - 1) * perPage + 1, count)} a{" "}
                {Math.min(page * perPage, count)} de {count} membros
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

      <MembroForm
        open={formOpen}
        onOpenChange={handleFormClose}
        membro={editingMembro}
      />

      <AgendaModal
        open={!!agendaMembro}
        onOpenChange={(open) => !open && setAgendaMembro(null)}
        membro={agendaMembro}
      />
    </div>
  );
}


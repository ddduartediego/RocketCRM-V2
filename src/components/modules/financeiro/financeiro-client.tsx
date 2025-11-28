"use client";

import { useState, useCallback, useTransition, useEffect } from "react";
import { useSearchParams, useRouter, usePathname } from "next/navigation";
import { TransacoesTable } from "./transacoes-table";
import { TransacaoForm } from "./transacao-form";
import { FinanceiroFilters } from "./financeiro-filters";
import { ResumoCards } from "./resumo-cards";
import { Button } from "@/components/ui/button";
import { ChevronLeft, ChevronRight } from "lucide-react";
import type { TransacaoFinanceira } from "@/types/database";
import { getTransacoes } from "@/actions/financeiro";

interface Transacao {
  id: string;
  descricao: string;
  tipo: string;
  valor: number;
  data_vencimento: string;
  data_pagamento: string | null;
  status: string;
  forma_pagamento: string | null;
  categorias_financeiras: { id: string; nome: string; cor: string } | null;
  eventos: { id: string; nome: string } | null;
  contatos: { id: string; nome: string } | null;
}

interface FinanceiroClientProps {
  initialTransacoes: Transacao[];
  initialCount: number;
  resumo: {
    receitasRealizadas: number;
    receitasPendentes: number;
    despesasRealizadas: number;
    despesasPendentes: number;
    saldoRealizado: number;
    saldoPrevisto: number;
    emAtraso: number;
  };
}

export function FinanceiroClient({
  initialTransacoes,
  initialCount,
  resumo,
}: FinanceiroClientProps) {
  const router = useRouter();
  const pathname = usePathname();
  const searchParams = useSearchParams();

  const [transacoes, setTransacoes] = useState(initialTransacoes);
  const [count, setCount] = useState(initialCount);
  const [isPending, startTransition] = useTransition();

  const [formOpen, setFormOpen] = useState(false);
  const [editingTransacao, setEditingTransacao] = useState<TransacaoFinanceira | null>(null);

  // Atualizar dados quando as props iniciais mudarem (após navegação/filtros)
  useEffect(() => {
    setTransacoes(initialTransacoes);
    setCount(initialCount);
  }, [initialTransacoes, initialCount]);

  const search = searchParams.get("search") || "";
  const tipo = searchParams.get("tipo") || "todos";
  const status = searchParams.get("status") || "todos";
  const dataInicio = searchParams.get("data_inicio") || "";
  const dataFim = searchParams.get("data_fim") || "";
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

  const fetchTransacoes = useCallback(async () => {
    startTransition(async () => {
      const result = await getTransacoes({
        search,
        tipo,
        status,
        data_inicio: dataInicio,
        data_fim: dataFim,
        page,
        perPage,
      });
      setTransacoes(result.data as Transacao[]);
      setCount(result.count);
    });
  }, [search, tipo, status, dataInicio, dataFim, page]);

  function handleEdit(transacao: Transacao) {
    setEditingTransacao(transacao as unknown as TransacaoFinanceira);
    setFormOpen(true);
  }

  function handleFormClose(open: boolean) {
    setFormOpen(open);
    if (!open) {
      setEditingTransacao(null);
      fetchTransacoes();
    }
  }

  const totalPages = Math.ceil(count / perPage);

  return (
    <div className="space-y-6">
      {/* Resumo */}
      <ResumoCards {...resumo} />

      {/* Filtros */}
      <FinanceiroFilters
        search={search}
        tipo={tipo}
        status={status}
        dataInicio={dataInicio}
        dataFim={dataFim}
        onSearchChange={(value) => updateURL({ search: value, page: "1" })}
        onTipoChange={(value) => updateURL({ tipo: value, page: "1" })}
        onStatusChange={(value) => updateURL({ status: value, page: "1" })}
        onDataInicioChange={(value) => updateURL({ data_inicio: value, page: "1" })}
        onDataFimChange={(value) => updateURL({ data_fim: value, page: "1" })}
      />

      {/* Tabela */}
      {isPending ? (
        <div className="flex items-center justify-center py-12">
          <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-primary" />
        </div>
      ) : (
        <>
          <TransacoesTable transacoes={transacoes} onEdit={handleEdit} />

          {totalPages > 1 && (
            <div className="flex items-center justify-between pt-4">
              <p className="text-sm text-muted-foreground">
                Mostrando {Math.min((page - 1) * perPage + 1, count)} a{" "}
                {Math.min(page * perPage, count)} de {count} transações
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

      <TransacaoForm
        open={formOpen}
        onOpenChange={handleFormClose}
        transacao={editingTransacao}
      />
    </div>
  );
}


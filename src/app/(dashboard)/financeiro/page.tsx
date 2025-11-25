import { Suspense } from "react";
import { getTransacoes, getResumoFinanceiro } from "@/actions/financeiro";
import { FinanceiroClient } from "@/components/modules/financeiro";
import { TransacaoFormTrigger } from "./transacao-form-trigger";

interface PageProps {
  searchParams: Promise<{
    search?: string;
    tipo?: string;
    status?: string;
    data_inicio?: string;
    data_fim?: string;
    page?: string;
  }>;
}

export default async function FinanceiroPage({ searchParams }: PageProps) {
  const params = await searchParams;
  const page = Number(params.page) || 1;
  const perPage = 20;

  const [transacoesResult, resumo] = await Promise.all([
    getTransacoes({
      search: params.search,
      tipo: params.tipo,
      status: params.status,
      data_inicio: params.data_inicio,
      data_fim: params.data_fim,
      page,
      perPage,
    }),
    getResumoFinanceiro(),
  ]);

  return (
    <div className="flex flex-col gap-6 p-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold tracking-tight">Financeiro</h1>
          <p className="text-muted-foreground">
            Controle de receitas, despesas e fluxo de caixa
          </p>
        </div>
        <TransacaoFormTrigger />
      </div>

      <Suspense fallback={<FinanceiroLoading />}>
        <FinanceiroClient
          initialTransacoes={transacoesResult.data as any}
          initialCount={transacoesResult.count}
          resumo={resumo}
        />
      </Suspense>
    </div>
  );
}

function FinanceiroLoading() {
  return (
    <div className="space-y-6">
      {/* Cards skeleton */}
      <div className="grid gap-4 grid-cols-2 lg:grid-cols-4">
        {[...Array(4)].map((_, i) => (
          <div
            key={i}
            className="h-[120px] rounded-lg bg-muted animate-pulse"
          />
        ))}
      </div>
      {/* Table skeleton */}
      <div className="h-[400px] rounded-lg bg-muted animate-pulse" />
    </div>
  );
}


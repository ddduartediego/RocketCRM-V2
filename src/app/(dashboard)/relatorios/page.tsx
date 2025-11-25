import { Suspense } from "react";
import {
  getResumoFinanceiro,
  getFluxoCaixaMensal,
  getTransacoesPorCategoria,
} from "@/actions/financeiro";
import { RelatoriosClient } from "@/components/modules/relatorios";

interface PageProps {
  searchParams: Promise<{
    ano?: string;
    mes?: string;
  }>;
}

export default async function RelatoriosPage({ searchParams }: PageProps) {
  const params = await searchParams;
  const anoAtual = new Date().getFullYear();
  const mesAtual = new Date().getMonth() + 1;

  const ano = params.ano ? parseInt(params.ano) : anoAtual;
  const mes = params.mes
    ? `${ano}-${params.mes.padStart(2, "0")}`
    : `${ano}-${mesAtual.toString().padStart(2, "0")}`;

  const [resumo, fluxoMensal, receitasPorCategoria, despesasPorCategoria] =
    await Promise.all([
      getResumoFinanceiro(mes),
      getFluxoCaixaMensal(ano),
      getTransacoesPorCategoria(mes, "receita"),
      getTransacoesPorCategoria(mes, "despesa"),
    ]);

  return (
    <div className="flex flex-col gap-6 p-6">
      <div>
        <h1 className="text-3xl font-bold tracking-tight">Relatórios</h1>
        <p className="text-muted-foreground">
          Visualize gráficos e métricas do seu negócio
        </p>
      </div>

      <Suspense fallback={<RelatoriosLoading />}>
        <RelatoriosClient
          resumo={resumo}
          fluxoMensal={fluxoMensal}
          receitasPorCategoria={receitasPorCategoria}
          despesasPorCategoria={despesasPorCategoria}
          anoSelecionado={ano}
          mesSelecionado={parseInt(params.mes || mesAtual.toString())}
        />
      </Suspense>
    </div>
  );
}

function RelatoriosLoading() {
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
      {/* Charts skeleton */}
      <div className="grid gap-6 lg:grid-cols-2">
        <div className="h-[350px] rounded-lg bg-muted animate-pulse" />
        <div className="h-[350px] rounded-lg bg-muted animate-pulse" />
      </div>
    </div>
  );
}


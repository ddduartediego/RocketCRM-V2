"use client";

import { useState, useCallback } from "react";
import { useRouter, usePathname, useSearchParams } from "next/navigation";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { ResumoCards } from "@/components/modules/financeiro/resumo-cards";
import { FluxoCaixaChart } from "./fluxo-caixa-chart";
import { CategoriasChart } from "./categorias-chart";
import { ExportarRelatorio } from "./exportar-relatorio";

interface ResumoData {
  receitasRealizadas: number;
  receitasPendentes: number;
  despesasRealizadas: number;
  despesasPendentes: number;
  saldoRealizado: number;
  saldoPrevisto: number;
  emAtraso: number;
}

interface FluxoMensalData {
  mes: string;
  receitas: number;
  despesas: number;
}

interface CategoriaData {
  nome: string;
  cor: string;
  valor: number;
}

interface RelatoriosClientProps {
  resumo: ResumoData;
  fluxoMensal: FluxoMensalData[];
  receitasPorCategoria: CategoriaData[];
  despesasPorCategoria: CategoriaData[];
  anoSelecionado: number;
  mesSelecionado: number;
}

const meses = [
  { value: "1", label: "Janeiro" },
  { value: "2", label: "Fevereiro" },
  { value: "3", label: "Março" },
  { value: "4", label: "Abril" },
  { value: "5", label: "Maio" },
  { value: "6", label: "Junho" },
  { value: "7", label: "Julho" },
  { value: "8", label: "Agosto" },
  { value: "9", label: "Setembro" },
  { value: "10", label: "Outubro" },
  { value: "11", label: "Novembro" },
  { value: "12", label: "Dezembro" },
];

const anos = Array.from({ length: 5 }, (_, i) => {
  const ano = new Date().getFullYear() - 2 + i;
  return { value: ano.toString(), label: ano.toString() };
});

export function RelatoriosClient({
  resumo,
  fluxoMensal,
  receitasPorCategoria,
  despesasPorCategoria,
  anoSelecionado,
  mesSelecionado,
}: RelatoriosClientProps) {
  const router = useRouter();
  const pathname = usePathname();
  const searchParams = useSearchParams();

  const [ano, setAno] = useState(anoSelecionado.toString());
  const [mes, setMes] = useState(mesSelecionado.toString());

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

  function handleAnoChange(value: string) {
    setAno(value);
    updateURL({ ano: value });
  }

  function handleMesChange(value: string) {
    setMes(value);
    updateURL({ mes: value });
  }

  const mesLabel = meses.find((m) => m.value === mes)?.label || mes;
  const periodoLabel = `${mesLabel} de ${ano}`;

  const dadosExportacao = {
    resumo,
    fluxoMensal,
    receitasPorCategoria,
    despesasPorCategoria,
  };

  return (
    <div className="space-y-6">
      {/* Filtros de período */}
      <Card>
        <CardHeader className="pb-3">
          <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
            <CardTitle className="text-lg">Período de Análise</CardTitle>
            <div className="flex items-center gap-4">
              <ExportarRelatorio dados={dadosExportacao} periodo={periodoLabel} />
              <div className="flex items-center gap-2">
                <span className="text-sm text-muted-foreground">Mês:</span>
                <Select value={mes} onValueChange={handleMesChange}>
                  <SelectTrigger className="w-[140px]">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    {meses.map((m) => (
                      <SelectItem key={m.value} value={m.value}>
                        {m.label}
                      </SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              </div>
              <div className="flex items-center gap-2">
                <span className="text-sm text-muted-foreground">Ano:</span>
                <Select value={ano} onValueChange={handleAnoChange}>
                  <SelectTrigger className="w-[100px]">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    {anos.map((a) => (
                      <SelectItem key={a.value} value={a.value}>
                        {a.label}
                      </SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              </div>
            </div>
          </div>
        </CardHeader>
      </Card>

      {/* Cards de resumo */}
      <ResumoCards {...resumo} />

      {/* Gráficos */}
      <div className="grid gap-6 lg:grid-cols-2">
        {/* Fluxo de Caixa Mensal */}
        <Card className="lg:col-span-2">
          <CardHeader>
            <CardTitle>Fluxo de Caixa - {ano}</CardTitle>
          </CardHeader>
          <CardContent>
            <FluxoCaixaChart data={fluxoMensal} />
          </CardContent>
        </Card>

        {/* Receitas por Categoria */}
        <Card>
          <CardHeader>
            <CardTitle>Receitas por Categoria</CardTitle>
          </CardHeader>
          <CardContent>
            <CategoriasChart data={receitasPorCategoria} tipo="receita" />
          </CardContent>
        </Card>

        {/* Despesas por Categoria */}
        <Card>
          <CardHeader>
            <CardTitle>Despesas por Categoria</CardTitle>
          </CardHeader>
          <CardContent>
            <CategoriasChart data={despesasPorCategoria} tipo="despesa" />
          </CardContent>
        </Card>
      </div>
    </div>
  );
}


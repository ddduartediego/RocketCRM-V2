"use client";

import { useState } from "react";
import { Button } from "@/components/ui/button";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { Download, FileSpreadsheet, FileText } from "lucide-react";
import { toast } from "sonner";

interface ExportarRelatorioProps {
  dados: {
    resumo: {
      receitasRealizadas: number;
      receitasPendentes: number;
      despesasRealizadas: number;
      despesasPendentes: number;
      saldoRealizado: number;
      saldoPrevisto: number;
      emAtraso: number;
    };
    fluxoMensal: { mes: string; receitas: number; despesas: number }[];
    receitasPorCategoria: { nome: string; valor: number }[];
    despesasPorCategoria: { nome: string; valor: number }[];
  };
  periodo: string;
}

export function ExportarRelatorio({ dados, periodo }: ExportarRelatorioProps) {
  const [isExporting, setIsExporting] = useState(false);

  function formatCurrency(value: number) {
    return new Intl.NumberFormat("pt-BR", {
      style: "currency",
      currency: "BRL",
    }).format(value);
  }

  async function exportarCSV() {
    setIsExporting(true);
    try {
      // Cabeçalho do CSV
      const linhas: string[] = [];

      // Resumo Financeiro
      linhas.push("RELATÓRIO FINANCEIRO - " + periodo);
      linhas.push("");
      linhas.push("RESUMO DO PERÍODO");
      linhas.push("Descrição;Valor");
      linhas.push(`Receitas Realizadas;${formatCurrency(dados.resumo.receitasRealizadas)}`);
      linhas.push(`Receitas Pendentes;${formatCurrency(dados.resumo.receitasPendentes)}`);
      linhas.push(`Despesas Realizadas;${formatCurrency(dados.resumo.despesasRealizadas)}`);
      linhas.push(`Despesas Pendentes;${formatCurrency(dados.resumo.despesasPendentes)}`);
      linhas.push(`Saldo Realizado;${formatCurrency(dados.resumo.saldoRealizado)}`);
      linhas.push(`Saldo Previsto;${formatCurrency(dados.resumo.saldoPrevisto)}`);
      linhas.push(`Pagamentos em Atraso;${dados.resumo.emAtraso}`);
      linhas.push("");

      // Fluxo de Caixa Mensal
      linhas.push("FLUXO DE CAIXA MENSAL");
      linhas.push("Mês;Receitas;Despesas;Saldo");
      dados.fluxoMensal.forEach((mes) => {
        const saldo = mes.receitas - mes.despesas;
        linhas.push(
          `${mes.mes};${formatCurrency(mes.receitas)};${formatCurrency(mes.despesas)};${formatCurrency(saldo)}`
        );
      });
      linhas.push("");

      // Receitas por Categoria
      if (dados.receitasPorCategoria.length > 0) {
        linhas.push("RECEITAS POR CATEGORIA");
        linhas.push("Categoria;Valor");
        dados.receitasPorCategoria.forEach((cat) => {
          linhas.push(`${cat.nome};${formatCurrency(cat.valor)}`);
        });
        linhas.push("");
      }

      // Despesas por Categoria
      if (dados.despesasPorCategoria.length > 0) {
        linhas.push("DESPESAS POR CATEGORIA");
        linhas.push("Categoria;Valor");
        dados.despesasPorCategoria.forEach((cat) => {
          linhas.push(`${cat.nome};${formatCurrency(cat.valor)}`);
        });
      }

      // Criar e baixar arquivo
      const csv = linhas.join("\n");
      const blob = new Blob(["\ufeff" + csv], { type: "text/csv;charset=utf-8;" });
      const url = URL.createObjectURL(blob);
      const link = document.createElement("a");
      link.href = url;
      link.download = `relatorio_financeiro_${periodo.replace(/\s/g, "_")}.csv`;
      document.body.appendChild(link);
      link.click();
      document.body.removeChild(link);
      URL.revokeObjectURL(url);

      toast.success("Relatório exportado com sucesso!");
    } catch (error) {
      console.error("Erro ao exportar:", error);
      toast.error("Erro ao exportar relatório");
    } finally {
      setIsExporting(false);
    }
  }

  async function exportarTXT() {
    setIsExporting(true);
    try {
      const linhas: string[] = [];

      // Cabeçalho
      linhas.push("═══════════════════════════════════════════════════════════════");
      linhas.push("                    RELATÓRIO FINANCEIRO");
      linhas.push(`                         ${periodo}`);
      linhas.push("═══════════════════════════════════════════════════════════════");
      linhas.push("");

      // Resumo
      linhas.push("┌─────────────────────────────────────────────────────────────┐");
      linhas.push("│                      RESUMO DO PERÍODO                       │");
      linhas.push("├─────────────────────────────────────────────────────────────┤");
      linhas.push(`│ Receitas Realizadas:  ${formatCurrency(dados.resumo.receitasRealizadas).padStart(20)}`);
      linhas.push(`│ Receitas Pendentes:   ${formatCurrency(dados.resumo.receitasPendentes).padStart(20)}`);
      linhas.push(`│ Despesas Realizadas:  ${formatCurrency(dados.resumo.despesasRealizadas).padStart(20)}`);
      linhas.push(`│ Despesas Pendentes:   ${formatCurrency(dados.resumo.despesasPendentes).padStart(20)}`);
      linhas.push("├─────────────────────────────────────────────────────────────┤");
      linhas.push(`│ SALDO REALIZADO:      ${formatCurrency(dados.resumo.saldoRealizado).padStart(20)}`);
      linhas.push(`│ SALDO PREVISTO:       ${formatCurrency(dados.resumo.saldoPrevisto).padStart(20)}`);
      linhas.push(`│ Pagamentos em Atraso: ${dados.resumo.emAtraso.toString().padStart(20)}`);
      linhas.push("└─────────────────────────────────────────────────────────────┘");
      linhas.push("");

      // Fluxo de Caixa
      linhas.push("┌─────────────────────────────────────────────────────────────┐");
      linhas.push("│                   FLUXO DE CAIXA MENSAL                      │");
      linhas.push("├─────────────────────────────────────────────────────────────┤");
      linhas.push("│   Mês     │    Receitas    │    Despesas    │     Saldo     │");
      linhas.push("├───────────┼────────────────┼────────────────┼───────────────┤");
      dados.fluxoMensal.forEach((mes) => {
        const saldo = mes.receitas - mes.despesas;
        linhas.push(
          `│ ${mes.mes.padEnd(9)} │ ${formatCurrency(mes.receitas).padStart(14)} │ ${formatCurrency(mes.despesas).padStart(14)} │ ${formatCurrency(saldo).padStart(13)} │`
        );
      });
      linhas.push("└───────────┴────────────────┴────────────────┴───────────────┘");
      linhas.push("");

      // Receitas por Categoria
      if (dados.receitasPorCategoria.length > 0) {
        linhas.push("┌─────────────────────────────────────────────────────────────┐");
        linhas.push("│                  RECEITAS POR CATEGORIA                      │");
        linhas.push("├─────────────────────────────────────────────────────────────┤");
        dados.receitasPorCategoria.forEach((cat) => {
          linhas.push(`│ ${cat.nome.padEnd(35)} ${formatCurrency(cat.valor).padStart(20)} │`);
        });
        linhas.push("└─────────────────────────────────────────────────────────────┘");
        linhas.push("");
      }

      // Despesas por Categoria
      if (dados.despesasPorCategoria.length > 0) {
        linhas.push("┌─────────────────────────────────────────────────────────────┐");
        linhas.push("│                  DESPESAS POR CATEGORIA                      │");
        linhas.push("├─────────────────────────────────────────────────────────────┤");
        dados.despesasPorCategoria.forEach((cat) => {
          linhas.push(`│ ${cat.nome.padEnd(35)} ${formatCurrency(cat.valor).padStart(20)} │`);
        });
        linhas.push("└─────────────────────────────────────────────────────────────┘");
      }

      linhas.push("");
      linhas.push("═══════════════════════════════════════════════════════════════");
      linhas.push(`           Gerado em: ${new Date().toLocaleString("pt-BR")}`);
      linhas.push("                     RocketCRM - Gestão de Eventos");
      linhas.push("═══════════════════════════════════════════════════════════════");

      // Criar e baixar arquivo
      const txt = linhas.join("\n");
      const blob = new Blob([txt], { type: "text/plain;charset=utf-8;" });
      const url = URL.createObjectURL(blob);
      const link = document.createElement("a");
      link.href = url;
      link.download = `relatorio_financeiro_${periodo.replace(/\s/g, "_")}.txt`;
      document.body.appendChild(link);
      link.click();
      document.body.removeChild(link);
      URL.revokeObjectURL(url);

      toast.success("Relatório exportado com sucesso!");
    } catch (error) {
      console.error("Erro ao exportar:", error);
      toast.error("Erro ao exportar relatório");
    } finally {
      setIsExporting(false);
    }
  }

  return (
    <DropdownMenu>
      <DropdownMenuTrigger asChild>
        <Button variant="outline" disabled={isExporting}>
          <Download className="mr-2 h-4 w-4" />
          {isExporting ? "Exportando..." : "Exportar"}
        </Button>
      </DropdownMenuTrigger>
      <DropdownMenuContent align="end">
        <DropdownMenuItem onClick={exportarCSV}>
          <FileSpreadsheet className="mr-2 h-4 w-4" />
          Exportar CSV (Excel)
        </DropdownMenuItem>
        <DropdownMenuItem onClick={exportarTXT}>
          <FileText className="mr-2 h-4 w-4" />
          Exportar TXT
        </DropdownMenuItem>
      </DropdownMenuContent>
    </DropdownMenu>
  );
}


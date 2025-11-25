"use client";

import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer } from "recharts";

interface FluxoCaixaData {
  mes: string;
  receitas: number;
  despesas: number;
}

interface FluxoCaixaChartProps {
  data: FluxoCaixaData[];
}

export function FluxoCaixaChart({ data }: FluxoCaixaChartProps) {
  const dataComSaldo = data.map((item) => ({
    ...item,
    saldo: item.receitas - item.despesas,
  }));

  const formatCurrency = (value: number) => {
    return new Intl.NumberFormat("pt-BR", {
      style: "currency",
      currency: "BRL",
      minimumFractionDigits: 0,
      maximumFractionDigits: 0,
    }).format(value);
  };

  if (data.every((item) => item.receitas === 0 && item.despesas === 0)) {
    return (
      <div className="flex items-center justify-center h-[300px] text-muted-foreground">
        Nenhum dado financeiro registrado para este período.
      </div>
    );
  }

  return (
    <ResponsiveContainer width="100%" height={300}>
      <BarChart data={dataComSaldo}>
        <CartesianGrid strokeDasharray="3 3" className="stroke-muted" />
        <XAxis
          dataKey="mes"
          fontSize={12}
          tickLine={false}
          axisLine={false}
          className="fill-muted-foreground"
        />
        <YAxis
          fontSize={12}
          tickLine={false}
          axisLine={false}
          tickFormatter={(value) => formatCurrency(value)}
          className="fill-muted-foreground"
        />
        <Tooltip
          formatter={(value: number) => formatCurrency(value)}
          contentStyle={{
            backgroundColor: "hsl(var(--card))",
            borderColor: "hsl(var(--border))",
            borderRadius: "8px",
          }}
          labelStyle={{ color: "hsl(var(--foreground))" }}
        />
        <Legend />
        <Bar
          dataKey="receitas"
          name="Receitas"
          fill="#22c55e"
          radius={[4, 4, 0, 0]}
        />
        <Bar
          dataKey="despesas"
          name="Despesas"
          fill="#dc2626"
          radius={[4, 4, 0, 0]}
        />
      </BarChart>
    </ResponsiveContainer>
  );
}


"use client";

import { PieChart, Pie, Cell, ResponsiveContainer, Legend, Tooltip } from "recharts";

interface CategoriaData {
  nome: string;
  cor: string;
  valor: number;
}

interface CategoriasChartProps {
  data: CategoriaData[];
  tipo: "receita" | "despesa";
}

const COLORS = [
  "#e4027d",
  "#341c44",
  "#22c55e",
  "#0ea5e9",
  "#eab308",
  "#dc2626",
  "#8b5cf6",
  "#ec4899",
  "#14b8a6",
  "#f97316",
];

export function CategoriasChart({ data, tipo }: CategoriasChartProps) {
  const total = data.reduce((sum, item) => sum + item.valor, 0);

  const formatCurrency = (value: number) => {
    return new Intl.NumberFormat("pt-BR", {
      style: "currency",
      currency: "BRL",
    }).format(value);
  };

  if (data.length === 0 || total === 0) {
    return (
      <div className="flex items-center justify-center h-[300px] text-muted-foreground">
        Nenhuma {tipo === "receita" ? "receita" : "despesa"} registrada neste período.
      </div>
    );
  }

  const dataWithPercentage = data.map((item, index) => ({
    ...item,
    percentage: ((item.valor / total) * 100).toFixed(1),
    fill: item.cor || COLORS[index % COLORS.length],
  }));

  return (
    <div className="flex flex-col">
      <ResponsiveContainer width="100%" height={250}>
        <PieChart>
          <Pie
            data={dataWithPercentage}
            cx="50%"
            cy="50%"
            innerRadius={60}
            outerRadius={90}
            paddingAngle={2}
            dataKey="valor"
            nameKey="nome"
          >
            {dataWithPercentage.map((entry, index) => (
              <Cell key={`cell-${index}`} fill={entry.fill} />
            ))}
          </Pie>
          <Tooltip
            formatter={(value: number) => formatCurrency(value)}
            contentStyle={{
              backgroundColor: "hsl(var(--card))",
              borderColor: "hsl(var(--border))",
              borderRadius: "8px",
            }}
            labelStyle={{ color: "hsl(var(--foreground))" }}
          />
          <Legend
            layout="vertical"
            align="right"
            verticalAlign="middle"
            formatter={(value) => <span className="text-sm">{value}</span>}
          />
        </PieChart>
      </ResponsiveContainer>

      {/* Lista de categorias com valores */}
      <div className="mt-4 space-y-2">
        {dataWithPercentage.map((item, index) => (
          <div
            key={index}
            className="flex items-center justify-between text-sm"
          >
            <div className="flex items-center gap-2">
              <div
                className="w-3 h-3 rounded-full"
                style={{ backgroundColor: item.fill }}
              />
              <span>{item.nome}</span>
            </div>
            <div className="flex items-center gap-4">
              <span className="text-muted-foreground">{item.percentage}%</span>
              <span className="font-medium">{formatCurrency(item.valor)}</span>
            </div>
          </div>
        ))}
        <div className="flex items-center justify-between pt-2 border-t font-medium">
          <span>Total</span>
          <span>{formatCurrency(total)}</span>
        </div>
      </div>
    </div>
  );
}


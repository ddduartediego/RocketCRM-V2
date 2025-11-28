# Fase 15 - Correção de Inconsistências no Dashboard

## Data: 28/11/2025

## Problemas Identificados

### 1. Próximos Eventos Incorretos
- **Problema**: A query de próximos eventos no dashboard não filtrava por status
- **Impacto**: Eventos com status "realizado", "cancelado" ou outros apareciam como "próximos eventos"
- **Local**: `src/app/(dashboard)/page.tsx` (linhas 38-43)

### 2. Dados Financeiros Inconsistentes
- **Problema**: Potencial problema de timezone na construção das datas do mês corrente
- **Impacto**: Receitas, despesas e saldo podiam mostrar dados de meses incorretos
- **Local**: `src/actions/financeiro.ts` (funções `getResumoFinanceiro` e `getTransacoesPorCategoria`)

## Correções Aplicadas

### Correção 1: Filtro de Status nos Próximos Eventos

**Arquivo**: `src/app/(dashboard)/page.tsx`

**Antes**:
```typescript
supabase
  .from("eventos")
  .select("id, nome, tipo, data_inicio, local, status")
  .gte("data_inicio", new Date().toISOString().split("T")[0])
  .order("data_inicio", { ascending: true })
  .limit(5),
```

**Depois**:
```typescript
supabase
  .from("eventos")
  .select("id, nome, tipo, data_inicio, local, status")
  .gte("data_inicio", new Date().toISOString().split("T")[0])
  .in("status", ["planejamento", "confirmado"])
  .order("data_inicio", { ascending: true })
  .limit(5),
```

**Também atualizado**: Descrição do card de "Eventos confirmados para os próximos dias" para "Eventos em planejamento ou confirmados"

### Correção 2: Lógica de Datas Timezone-Safe

**Arquivo**: `src/actions/financeiro.ts`

**Problema Original**:
```typescript
const dataAtual = mes ? new Date(`${mes}-01`) : new Date();
const inicioMes = new Date(dataAtual.getFullYear(), dataAtual.getMonth(), 1)
  .toISOString()
  .split("T")[0];
```

O uso de `.toISOString()` converte para UTC, o que pode causar problemas quando o servidor está em um timezone diferente do Brasil.

**Nova Abordagem**:
```typescript
let ano: number;
let mesNum: number;

if (mes) {
  const [anoStr, mesStr] = mes.split("-");
  ano = parseInt(anoStr, 10);
  mesNum = parseInt(mesStr, 10);
} else {
  const agora = new Date();
  ano = agora.getFullYear();
  mesNum = agora.getMonth() + 1;
}

const inicioMes = `${ano}-${String(mesNum).padStart(2, "0")}-01`;
const ultimoDia = new Date(ano, mesNum, 0).getDate();
const fimMes = `${ano}-${String(mesNum).padStart(2, "0")}-${String(ultimoDia).padStart(2, "0")}`;
```

## Arquivos Modificados

| Arquivo | Descrição |
|---------|-----------|
| `src/app/(dashboard)/page.tsx` | Adicionado filtro de status na query de próximos eventos |
| `src/actions/financeiro.ts` | Corrigida lógica de datas nas funções `getResumoFinanceiro` e `getTransacoesPorCategoria` |

## Observações

- A função `getProximosEventos` em `src/actions/eventos.ts` já tinha a lógica correta de filtro por status
- O dashboard agora mostra apenas eventos futuros com status "planejamento" ou "confirmado"
- As métricas financeiras agora usam uma abordagem timezone-safe para garantir que o mês corrente seja sempre calculado corretamente

## Testes Recomendados

1. Verificar se o dashboard mostra apenas eventos futuros válidos
2. Verificar se as receitas e despesas correspondem ao mês atual
3. Testar em diferentes timezones para garantir consistência


# Fase 16 - Filtro de Mês e Estatísticas no Dashboard

## Data: 28/11/2025

## Objetivo

Adicionar um filtro de mês minimalista no dashboard que permite visualizar dados financeiros e estatísticas de eventos, leads e tarefas para qualquer mês selecionado.

## Funcionalidades Implementadas

### 1. Filtro de Mês Minimalista
- Posicionado no header do dashboard, ao lado do título
- Design minimalista com botões de navegação (< / >)
- Exibe mês e ano atual por padrão
- Permite navegar para meses anteriores e futuros
- Indicador de loading durante carregamento

### 2. Estatísticas de Eventos do Mês
- Total de eventos no mês selecionado
- Breakdown por status:
  - Em planejamento
  - Confirmados
  - Realizados
  - Cancelados
- Link para página de eventos

### 3. Estatísticas de Leads do Mês
- Total de leads criados no mês
- Valor total estimado em potencial
- Breakdown por etapa do funil (com cores)
- Link para página de leads

### 4. Estatísticas de Tarefas do Mês
- Total de tarefas com vencimento no mês
- Breakdown por status:
  - Pendentes
  - Em andamento
  - Concluídas
  - Vencidas
- Barra de progresso visual
- Link para página de tarefas

## Arquivos Criados

| Arquivo | Função |
|---------|--------|
| `src/components/modules/dashboard/dashboard-client.tsx` | Componente cliente principal do dashboard com filtro de mês e todos os cards de estatísticas |
| `src/components/modules/dashboard/index.ts` | Arquivo de exportação do módulo |

## Arquivos Modificados

| Arquivo | Alteração |
|---------|-----------|
| `src/app/(dashboard)/page.tsx` | Simplificado para Server Component que carrega dados iniciais e renderiza o `DashboardClient` |
| `src/actions/eventos.ts` | Adicionada função `getEstatisticasEventosMes` com interface `EstatisticasEventosMes` |
| `src/actions/leads.ts` | Adicionada função `getEstatisticasLeadsMes` com interfaces `EtapaEstatistica` e `EstatisticasLeadsMes` |
| `src/actions/atividades.ts` | Adicionada função `getEstatisticasTarefasMes` com interface `EstatisticasTarefasMes` |

## Detalhes Técnicos

### Arquitetura

O dashboard agora segue o padrão de **Server Component com Client Component híbrido**:

1. **Server Component** (`page.tsx`):
   - Carrega os dados iniciais do mês atual
   - Busca contagens totais (leads, eventos, contatos)
   - Passa dados iniciais para o componente cliente

2. **Client Component** (`dashboard-client.tsx`):
   - Gerencia o estado do mês selecionado
   - Recarrega dados via Server Actions quando o mês muda
   - Usa `useTransition` para loading states não-bloqueantes

### Funções de Estatísticas

#### `getEstatisticasEventosMes(mes?: string)`
```typescript
interface EstatisticasEventosMes {
  total: number;
  porStatus: {
    planejamento: number;
    confirmado: number;
    realizado: number;
    cancelado: number;
  };
}
```
- Filtra eventos por `data_inicio` no mês especificado
- Agrupa por status

#### `getEstatisticasLeadsMes(mes?: string)`
```typescript
interface EstatisticasLeadsMes {
  total: number;
  valorTotal: number;
  porEtapa: EtapaEstatistica[];
}
```
- Filtra leads por `created_at` no mês especificado
- Agrupa por etapa do funil
- Calcula valor total estimado

#### `getEstatisticasTarefasMes(mes?: string)`
```typescript
interface EstatisticasTarefasMes {
  total: number;
  porStatus: {
    pendente: number;
    em_andamento: number;
    concluida: number;
  };
  vencidas: number;
}
```
- Filtra tarefas por `data_vencimento` no mês especificado
- Agrupa por status
- Conta tarefas vencidas (pendentes/em andamento com data passada)

### Tratamento de Timezone

Todas as funções usam a abordagem **timezone-safe** implementada na Fase 15:
- Constrói strings de data diretamente sem usar `.toISOString()`
- Evita conversões de UTC que podem causar inconsistências

## Layout dos Cards de Estatísticas

```
┌─────────────────────────────────────────────────────────────┐
│ Dashboard                           [<] Novembro 2025 [>]  │
├─────────────────────────────────────────────────────────────┤
│ ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐           │
│ │ Leads   │ │ Eventos │ │Contatos │ │Receitas │           │
│ │ Ativos  │ │Confirm. │ │ Total   │ │ do Mês  │           │
│ └─────────┘ └─────────┘ └─────────┘ └─────────┘           │
├─────────────────────────────────────────────────────────────┤
│ ┌───────────────┐ ┌───────────────┐ ┌───────────────┐      │
│ │ Despesas Mês  │ │  Saldo Mês    │ │ Em Atraso     │      │
│ └───────────────┘ └───────────────┘ └───────────────┘      │
├─────────────────────────────────────────────────────────────┤
│ ┌───────────────┐ ┌───────────────┐ ┌───────────────┐      │
│ │  EVENTOS MÊS  │ │  LEADS MÊS    │ │  TAREFAS MÊS  │      │
│ │    Total: X   │ │    Total: X   │ │    Total: X   │      │
│ │ ┌───┐ ┌───┐   │ │ Por Etapa:    │ │ ┌───┐ ┌───┐   │      │
│ │ │ P │ │ C │   │ │ ▣ Etapa 1: X  │ │ │ P │ │ A │   │      │
│ │ └───┘ └───┘   │ │ ▣ Etapa 2: X  │ │ └───┘ └───┘   │      │
│ │ ┌───┐ ┌───┐   │ │ ▣ Etapa 3: X  │ │ ┌───┐ ┌───┐   │      │
│ │ │ R │ │ X │   │ │               │ │ │ C │ │ V │   │      │
│ │ └───┘ └───┘   │ │               │ │ └───┘ └───┘   │      │
│ │  Ver todos →  │ │  Ver todos →  │ │  [▓▓▓▓░░] 60%│      │
│ └───────────────┘ └───────────────┘ └───────────────┘      │
└─────────────────────────────────────────────────────────────┘
```

## Observações

- Os cards antigos de "Próximos Eventos", "Leads Recentes" e "Tarefas Pendentes" foram substituídos pelos novos cards de estatísticas mensais
- As métricas gerais (Leads Ativos, Eventos Confirmados, Total de Contatos) permanecem mostrando totais gerais do sistema
- O filtro de mês afeta apenas os dados financeiros e os cards de estatísticas mensais
- A navegação entre meses é instantânea com feedback visual de loading


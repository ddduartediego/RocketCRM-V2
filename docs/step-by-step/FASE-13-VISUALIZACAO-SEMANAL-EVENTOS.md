# FASE 13 - Visualização Semanal de Eventos

**Data:** 27/11/2025

## Objetivo

Adicionar uma nova visualização semanal no módulo de Eventos, permitindo ao usuário alternar entre a visualização de tabela existente e uma grade semanal com navegação entre semanas.

## Funcionalidades Implementadas

### 1. Visualização Semanal

- Grade com 7 colunas representando os dias da semana (Segunda a Domingo)
- Cards de eventos mostrando:
  - Horário de início
  - Ícone do tipo de evento
  - Nome do evento
  - Nome do cliente
- Indicador visual do dia atual
- Borda colorida no card indicando o status do evento

### 2. Navegação de Semanas

- Botões para avançar e voltar semanas
- Botão "Hoje" para retornar à semana atual
- Indicador visual do período da semana (ex: "25 - 31 nov 2025")

### 3. Eventos Multi-dia

- Eventos que duram mais de um dia aparecem em todos os dias correspondentes
- Exemplo: Colônia de férias de 3 dias aparece em cada um dos 3 dias

### 4. Alternância de Visualização

- Toggle para alternar entre modo "Lista" (tabela) e modo "Semana"
- Estado mantido localmente no componente

## Arquivos Criados

### `src/components/modules/eventos/eventos-week-view.tsx`

Componente principal da visualização semanal.

**Props:**
- `eventos`: Lista de eventos com relações (cliente, responsável)
- `currentWeekStart`: Data de início da semana exibida
- `onWeekChange`: Callback para mudança de semana

**Funcionalidades:**
- Renderiza grade de 7 dias
- Mapeia eventos para cada dia (incluindo eventos multi-dia)
- Ordena eventos por hora de início
- Click no card redireciona para página de detalhes

### `src/components/modules/eventos/eventos-view-toggle.tsx`

Componente para alternar entre visualizações.

**Props:**
- `viewMode`: Modo atual ("table" ou "week")
- `onViewModeChange`: Callback para mudança de modo

**Export:**
- `EventosViewMode`: Type para os modos de visualização

## Arquivos Modificados

### `src/actions/eventos.ts`

Adicionada nova server action:

```typescript
getEventosSemana(startDate: string, endDate: string)
```

Busca eventos que ocorrem em um período específico, incluindo:
- Eventos que começam no período
- Eventos que terminam no período
- Eventos que englobam todo o período (começam antes e terminam depois)

### `src/components/modules/eventos/eventos-client.tsx`

Atualizado para:
- Suportar estado de modo de visualização
- Gerenciar estado da semana atual
- Buscar eventos da semana ao entrar no modo semanal
- Recarregar eventos após fechar formulário de edição

### `src/components/modules/eventos/index.ts`

Adicionados novos exports:
- `EventosWeekView`
- `EventosViewToggle`
- `EventosViewMode` (type)

## Comportamento

1. Por padrão, a página de eventos mostra a visualização em tabela
2. O usuário pode alternar para visualização semanal usando o toggle
3. Na visualização semanal:
   - A semana atual é exibida inicialmente
   - Usuário pode navegar para semanas anteriores/próximas
   - Eventos são carregados dinamicamente ao mudar de semana
   - Click em um evento redireciona para `/eventos/[id]`

## Visual

### Card de Evento na Semana

```
┌─────────────────────────┐
│ [09:00]     🎈         │
│ Festa Maria            │
│ João Silva             │
└─────────────────────────┘
```

- Borda esquerda colorida indica status
- Badge com horário de início
- Ícone do tipo de evento
- Nome do evento (até 2 linhas)
- Nome do cliente

## Considerações Técnicas

### Performance

- Eventos da semana são buscados sob demanda
- Mapeamento de eventos para dias é feito com `useMemo`
- Loading indicator durante carregamento

### Responsividade

- Toggle esconde texto em telas pequenas, mostrando apenas ícones
- Cards se adaptam ao espaço disponível
- Scroll vertical em dias com muitos eventos

## Próximos Passos Sugeridos

1. Persistir preferência de visualização no localStorage
2. Adicionar drag-and-drop para reagendar eventos
3. Adicionar criação rápida de evento ao clicar em um dia vazio
4. Adicionar visualização mensal como terceira opção


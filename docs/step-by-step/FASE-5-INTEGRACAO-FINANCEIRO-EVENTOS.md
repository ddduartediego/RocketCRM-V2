# Fase 5 - Integração Financeiro x Eventos

## ✅ Implementações Realizadas

### 1. Página de Detalhes do Evento (`/eventos/[id]`)

Nova página completa para visualização de detalhes do evento com:
- Header com informações principais e ações (editar/excluir)
- Cards de resumo financeiro (valor total, receitas, despesas, lucro)
- Abas "Informações" e "Financeiro"
- Comparação automática entre valor total do evento e receitas registradas

**Arquivos Criados:**
```
src/app/(dashboard)/eventos/[id]/page.tsx
src/components/modules/eventos/evento-detail.tsx
src/components/modules/eventos/evento-financeiro-tab.tsx
```

### 2. Aba Financeiro no Evento

Visualização completa das transações financeiras vinculadas ao evento:
- Alerta de divergência quando valor total ≠ receitas registradas
- Listagem separada de receitas e despesas
- Botão para criar nova transação já vinculada ao evento
- Ações rápidas: editar transação, marcar como pago
- Resumo com lucro/prejuízo do evento

### 3. Criação Automática de Transações

Ao criar um novo evento com valor financeiro:
- Checkbox "Criar transação financeira automaticamente" (marcado por padrão)
- **Quando há valor de sinal**: Cria DUAS transações
  - "Sinal - [Nome Evento]" → valor do sinal, categoria "Sinal"
  - "Restante - [Nome Evento]" → (valor_total - valor_sinal), categoria "Pagamento de Evento"
- **Quando não há sinal**: Cria UMA transação
  - "Pagamento - [Nome Evento]" → valor total, categoria "Pagamento de Evento"
- Vincula automaticamente ao evento e ao contato/cliente
- **Usa a forma de pagamento** selecionada no evento (campo Select com opções padronizadas)

### 3.1 Edição de Evento com Recriação de Transações

Ao editar um evento e alterar valores financeiros:
- Dialog de confirmação pergunta se deseja recriar transações
- Se confirmar: Remove transações de receita existentes e cria novas
- Se cancelar: Mantém transações existentes

**Arquivos Modificados:**
```
src/actions/eventos.ts
src/components/modules/eventos/evento-form.tsx
```

**Migration Criada:**
```
supabase/migrations/20251125220000_add_sinal_category.sql
```

### 4. Select de Eventos no Formulário de Transações

Permite vincular manualmente uma transação a um evento:
- Campo dropdown na aba "Geral" do formulário
- Lista eventos com nome e data
- Desabilitado automaticamente quando formulário é aberto no contexto de um evento

**Arquivos Modificados:**
```
src/components/modules/financeiro/transacao-form.tsx
```

### 5. Indicador de Status Financeiro na Lista de Eventos

Na tabela de eventos, ao lado do valor:
- ✅ Verde: Pago integralmente (100%+)
- 🕐 Amarelo: Pagamento parcial (com percentual)
- 🕐 Laranja: Pagamento pendente (0%)
- ⚠️ Vermelho: Sem transações registradas

**Arquivos Modificados:**
```
src/app/(dashboard)/eventos/page.tsx
src/components/modules/eventos/eventos-client.tsx
src/components/modules/eventos/eventos-table.tsx
```

## 📊 Server Actions Criadas/Modificadas

### `src/actions/eventos.ts`

```typescript
// Nova interface de opções para criação
interface CreateEventoOptions {
  sincronizar_google?: boolean;
  criar_transacao_receita?: boolean;
}

// Modificado para criar transação automaticamente
createEvento(formData: EventoFormData & CreateEventoOptions)

// Nova função para listagem simplificada
getEventosSimples()
```

### `src/actions/financeiro.ts`

```typescript
// Nova interface e função para resumos em lote
interface ResumoFinanceiroEvento {
  evento_id: string;
  totalReceitas: number;
  totalDespesas: number;
  receitasPagas: number;
  receitasPendentes: number;
}

getResumosFinanceirosEventos(eventoIds: string[])
```

## 🔗 Relacionamentos Implementados

| Origem | Destino | Tipo |
|--------|---------|------|
| `transacoes_financeiras.evento_id` | `eventos.id` | FK |
| Formulário de Evento | Transação de Receita | Criação automática |
| Página de Evento | Transações vinculadas | Listagem |
| Formulário de Transação | Eventos | Select manual |

## 📱 Fluxos de Usuário

### Criar Evento com Receita Automática
1. Usuário acessa `/eventos`
2. Clica em "Novo Evento"
3. Preenche dados incluindo valor total
4. Mantém checkbox "Criar transação financeira automaticamente" marcado
5. Salva evento
6. Sistema cria evento + transação de receita pendente

### Visualizar Financeiro do Evento
1. Usuário acessa `/eventos`
2. Clica em um evento da lista
3. É redirecionado para `/eventos/[id]`
4. Visualiza cards de resumo e aba "Financeiro"
5. Pode criar novas transações ou editar existentes

### Vincular Transação a Evento
1. Usuário acessa `/financeiro`
2. Clica em "Nova Transação"
3. Na aba "Geral", seleciona um evento no dropdown
4. Preenche demais dados
5. Transação é vinculada ao evento selecionado

## ✨ Destaques

- **Sincronização automática**: Eventos e transações são vinculados automaticamente
- **Visão consolidada**: Página de detalhes mostra resumo financeiro completo
- **Alertas visuais**: Indicadores de status financeiro na lista de eventos
- **Consistência de dados**: Comparação entre valor_total e receitas registradas
- **UX otimizada**: Checkbox para criar transação é visível apenas ao criar novo evento

## 📁 Exports Adicionados

```typescript
// src/components/modules/eventos/index.ts
export { EventoDetail } from "./evento-detail";
export { EventoFinanceiroTab } from "./evento-financeiro-tab";
```


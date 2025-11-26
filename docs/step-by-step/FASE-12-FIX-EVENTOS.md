# Fase 12 - Correções de Eventos

## Data: 26/11/2025

---

## Correção 1: Erro de Hidratação no AlertDialog

### Problema

Erro de hidratação do React ao editar valores financeiros de um evento:

```
In HTML, <p> cannot be a descendant of <p>.
This will cause a hydration error.
```

O componente `AlertDialogDescription` do Radix UI renderiza internamente um elemento `<p>`. Quando elementos `<p>` adicionais eram colocados dentro dele, criava-se uma estrutura HTML inválida (`<p>` dentro de `<p>`).

### Solução

Usar a prop `asChild` no `AlertDialogDescription` para evitar que ele renderize seu próprio elemento `<p>`, e em vez disso usar um `<div>` como container.

### Arquivo Modificado

- `src/components/modules/eventos/evento-form.tsx`

---

## Correção 2: Erro ao Excluir Evento com Transações Vinculadas

### Problema

Erro de foreign key ao tentar excluir um evento que possui transações financeiras vinculadas:

```
update or delete on table "eventos" violates foreign key constraint "transacoes_financeiras_evento_id_fkey" on table "transacoes_financeiras"
```

### Solução

1. **Criar função para verificar transações vinculadas**: Nova função `getTransacoesDoEvento()` que retorna as transações financeiras de um evento.

2. **Modificar `deleteEvento`**: Agora aceita um segundo parâmetro `excluirTransacoes`. Se houver transações e o parâmetro for `false`, retorna um erro especial `TRANSACOES_VINCULADAS`. Se for `true`, exclui as transações antes de excluir o evento.

3. **Dialog de confirmação específico**: Quando o usuário tenta excluir um evento com transações, um dialog aparece avisando quantas transações serão excluídas e pedindo confirmação.

### Arquivos Modificados

- `src/actions/eventos.ts`
  - Nova função `getTransacoesDoEvento(eventoId)`
  - Função `deleteEvento(id, excluirTransacoes?)` modificada

- `src/components/modules/eventos/evento-detail.tsx`
  - Novos estados para controlar os dialogs
  - Função `handleOpenDeleteDialog()` que verifica transações antes de abrir o dialog
  - Dois dialogs de confirmação: um simples e outro com aviso de transações

- `src/components/modules/eventos/eventos-table.tsx`
  - Mesma lógica aplicada para a tabela de eventos

### Fluxo de Exclusão

```
Usuário clica em "Excluir"
         ↓
Verifica se há transações vinculadas
         ↓
    ┌────┴────┐
    │         │
   Sim       Não
    ↓         ↓
Dialog com  Dialog
aviso de    simples
transações
    ↓         ↓
Confirma?   Confirma?
    ↓         ↓
Exclui      Exclui
transações  evento
e evento
```

---

## Status

✅ Concluído


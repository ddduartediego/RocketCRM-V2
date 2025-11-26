# FASE 6 - Alocações de Equipe e Recursos em Eventos

## Data: 25/11/2025

## Objetivo
Criar abas separadas para alocação de Equipe e Recursos na página de detalhes do evento, com criação automática de transações financeiras de despesa.

---

## Alterações Realizadas

### 1. Migration - Vínculo com Transações Financeiras
**Arquivo:** `supabase/migrations/20251125230000_add_transacao_id_alocacoes.sql`

Adicionados campos para vincular alocações às transações financeiras:
- `transacao_id` em `alocacao_equipe` - referência à transação de despesa gerada
- `transacao_id` em `alocacao_recursos` - referência à transação de despesa gerada  
- `valor` em `alocacao_recursos` - valor manual informado pelo usuário

### 2. Types Atualizados
**Arquivo:** `src/types/database.ts`

Adicionados campos `transacao_id` nas interfaces:
- `alocacao_equipe.Row/Insert/Update`
- `alocacao_recursos.Row/Insert/Update`
- Campo `valor` em `alocacao_recursos`

### 3. Schema de Validação
**Arquivo:** `src/lib/validations/recurso.ts`

Adicionado campo `valor` no schema `alocacaoRecursoSchema`.

### 4. Formulário de Alocação de Equipe
**Arquivo:** `src/components/modules/eventos/alocacao-equipe-form.tsx`

Funcionalidades:
- Select de membros ativos da equipe
- Ao selecionar membro, `valor_pago` é preenchido com `valor_diaria` cadastrado
- Campo de data pré-preenchido com data do evento
- Campos de hora início/fim
- Campo de função no evento (preenchido automaticamente)
- Campo de observações

### 5. Formulário de Alocação de Recursos
**Arquivo:** `src/components/modules/eventos/alocacao-recurso-form.tsx`

Funcionalidades:
- Select de recursos ativos
- Campo quantidade com validação de disponibilidade
- Campo valor manual (sugestão baseada em custo_unitario × quantidade)
- Campos data início/fim pré-preenchidos com datas do evento
- Campo de observações

### 6. Aba de Equipe
**Arquivo:** `src/components/modules/eventos/evento-equipe-tab.tsx`

Funcionalidades:
- Card resumo com total de custos com equipe
- Tabela com membros alocados (nome, função, data, horário, valor)
- Botões de editar e excluir
- Dialog de confirmação ao excluir com opção de excluir transação vinculada
- Botão para adicionar novo membro

### 7. Aba de Recursos
**Arquivo:** `src/components/modules/eventos/evento-recursos-tab.tsx`

Funcionalidades:
- Card resumo com total de custos com recursos
- Tabela com recursos alocados (nome, tipo, quantidade, período, valor)
- Botões de editar e excluir
- Dialog de confirmação ao excluir com opção de excluir transação vinculada
- Botão para adicionar novo recurso

### 8. Actions de Equipe Atualizadas
**Arquivo:** `src/actions/equipe.ts`

Alterações em `createAlocacaoEquipe`:
- Ao criar alocação com valor, cria transação de despesa categoria "Monitores"
- Descrição: "Diária - [Nome Membro] - [Nome Evento]"
- Vincula transação_id na alocação

Alterações em `deleteAlocacaoEquipe`:
- Novo parâmetro `excluirTransacao: boolean`
- Se true e houver transação vinculada, exclui a transação também

### 9. Actions de Recursos Atualizadas
**Arquivo:** `src/actions/recursos.ts`

Alterações em `createAlocacaoRecurso`:
- Ao criar alocação com valor, cria transação de despesa categoria "Materiais"
- Descrição: "[Nome Recurso] (Nx) - [Nome Evento]"
- Vincula transação_id na alocação

Alterações em `deleteAlocacaoRecurso`:
- Novo parâmetro `excluirTransacao: boolean`
- Se true e houver transação vinculada, exclui a transação também

### 10. Evento Detail Atualizado
**Arquivo:** `src/components/modules/eventos/evento-detail.tsx`

- Adicionada aba "Equipe" após "Financeiro"
- Adicionada aba "Recursos" após "Equipe"
- Props `alocacoesEquipe` e `alocacoesRecursos` adicionadas

### 11. Página do Evento Atualizada
**Arquivo:** `src/app/(dashboard)/eventos/[id]/page.tsx`

- Busca paralela de alocações de equipe e recursos
- Passa dados para o componente EventoDetail

### 12. Exports Atualizados
**Arquivo:** `src/components/modules/eventos/index.ts`

Novos exports:
- `EventoEquipeTab`
- `EventoRecursosTab`
- `AlocacaoEquipeForm`
- `AlocacaoRecursoForm`

---

## Fluxo de Uso

### Adicionar Membro da Equipe
1. Acessar detalhes do evento → aba "Equipe"
2. Clicar "Adicionar Membro"
3. Selecionar membro → valor preenchido com diária cadastrada
4. Alterar dados conforme necessário
5. Ao salvar:
   - Cria registro em `alocacao_equipe`
   - Cria transação de despesa (categoria "Monitores")
   - Vincula transação na alocação

### Adicionar Recurso
1. Acessar detalhes do evento → aba "Recursos"
2. Clicar "Adicionar Recurso"
3. Selecionar recurso, informar quantidade e valor
4. Ao salvar:
   - Cria registro em `alocacao_recursos`
   - Cria transação de despesa (categoria "Materiais")
   - Vincula transação na alocação

### Excluir Alocação
1. Clicar no ícone de lixeira
2. Dialog pergunta se deseja excluir transação vinculada
3. Se sim: exclui alocação + transação
4. Se não: exclui apenas alocação

---

## Categorias Financeiras Utilizadas
- **Equipe:** Monitores (despesa)
- **Recursos:** Materiais (despesa)

---

## Próximos Passos Sugeridos
1. Adicionar relatório de custos por evento (equipe + recursos)
2. Dashboard com visão geral de alocações do mês
3. Notificações de conflito de agenda ao alocar membros
4. Integração com calendário para visualizar alocações


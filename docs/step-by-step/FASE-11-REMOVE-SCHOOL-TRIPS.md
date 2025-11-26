# FASE 11: Remoção de Viagens Escolares e Simplificação

**Data:** 26/11/2025  
**Status:** Concluído  

## Objetivo

Remover todas as referências a viagens escolares do sistema RocketCRM e simplificar campos não utilizados. O sistema agora foca exclusivamente na gestão de eventos gerais.

## Escopo das Alterações

### 1. Itens Removidos

| Item | Descrição |
|------|-----------|
| `viagem_pedagogica` | Tipo de evento removido |
| `viagem_formatura` | Tipo de evento removido |
| `turma_serie` | Campo removido de eventos e leads |
| `escola` | Tipo de contato removido |
| `organizacao_id` | Campo removido de eventos, leads e contatos |
| `num_participantes` | Campo removido de eventos |

---

## Arquivos Modificados

### Migration SQL

- **Arquivo:** `supabase/migrations/20251126000000_remove_school_trips.sql`
- **Ações:**
  - Remove coluna `turma_serie` das tabelas `eventos` e `leads`
  - Remove coluna `organizacao_id` das tabelas `eventos`, `leads` e `contatos`
  - Remove coluna `num_participantes` da tabela `eventos`
  - Recria enum `tipo_evento` sem `viagem_pedagogica` e `viagem_formatura`
  - Recria enum `tipo_contato` sem `escola`
  - Migra dados existentes para valores válidos
  - Atualiza default de `organizacoes.tipo` de `escola` para `empresa`

### Types TypeScript

- **Arquivo:** `src/types/database.ts`
- **Alterações:**
  - Removido `escola` do tipo `tipo_contato`
  - Removido `viagem_pedagogica` e `viagem_formatura` do tipo `tipo_evento`
  - Removido `turma_serie` dos tipos de `eventos` e `leads` (Row, Insert, Update)
  - Removido `organizacao_id` dos tipos de `eventos`, `leads` e `contatos` (Row, Insert, Update)
  - Removido `num_participantes` do tipo de `eventos` (Row, Insert, Update)
  - Removido relacionamentos com `organizacoes`

### Validações Zod

| Arquivo | Alterações |
|---------|------------|
| `src/lib/validations/evento.ts` | Removido viagens do enum, removido campos `turma_serie`, `organizacao_id`, `num_participantes`, atualizado `tipoEventoOptions` |
| `src/lib/validations/lead.ts` | Removido viagens do enum, removido campos `turma_serie`, `organizacao_id`, atualizado `tipoServicoOptions` |
| `src/lib/validations/contato.ts` | Removido `escola` do enum, removido campo `organizacao_id`, atualizado `tipoContatoOptions` |

### Componentes de Eventos

| Arquivo | Alterações |
|---------|------------|
| `src/components/modules/eventos/evento-form.tsx` | Removido campos turma_serie, organizacao_id, num_participantes; mudado default de tipo para `colonia_ferias` |
| `src/components/modules/eventos/evento-detail.tsx` | Removido seções turma_serie, organizacao, num_participantes; removido labels de viagens |
| `src/components/modules/eventos/eventos-table.tsx` | Removido mapeamento de viagens, atualizado exibição de cliente |
| `src/components/modules/eventos/eventos-client.tsx` | Removido interface de organizacoes |

### Componentes de Leads

| Arquivo | Alterações |
|---------|------------|
| `src/components/modules/leads/lead-form.tsx` | Removido campos turma_serie, organizacao_id |
| `src/components/modules/leads/lead-card.tsx` | Removido exibição de turma e organização, removido labels de viagens |
| `src/components/modules/leads/kanban-board.tsx` | Removido interface de organizacoes |
| `src/components/modules/leads/kanban-column.tsx` | Removido interface de organizacoes |

### Componentes de Contatos

| Arquivo | Alterações |
|---------|------------|
| `src/components/modules/contatos/contatos-table.tsx` | Removido tipo "Escola" e coluna de Organização |
| `src/components/modules/contatos/contato-detail.tsx` | Removido tipo "Escola" e seção Organização |
| `src/components/modules/contatos/contato-form.tsx` | Removido campo organizacao_id |
| `src/components/modules/contatos/contatos-client.tsx` | Removido interface de organizacoes |

### Actions

| Arquivo | Alterações |
|---------|------------|
| `src/actions/leads.ts` | Removido função getOrganizacoes, removido selects de organizacoes |
| `src/actions/contatos.ts` | Removido função getOrganizacoes, removido selects de organizacoes |

### Outros Arquivos

| Arquivo | Alterações |
|---------|------------|
| `src/components/modules/equipe/agenda-modal.tsx` | Removido mapeamento de viagens |
| `src/lib/google/calendar.ts` | Removido cores de viagens do mapeamento |
| `src/app/(dashboard)/page.tsx` | Removido mapeamento de viagens, alterado texto "escolas" para "organizações" |

---

## Instruções de Deploy

### 1. Executar Migration no Supabase

1. Acesse o SQL Editor do Supabase
2. Execute o arquivo `supabase/migrations/20251126000000_remove_school_trips.sql`
3. A migration irá:
   - Migrar dados existentes automaticamente
   - Eventos/Leads com `viagem_pedagogica` ou `viagem_formatura` → `outro`
   - Contatos/Organizações com `escola` → `empresa`

### 2. Deploy da Aplicação

1. Após a migration, faça deploy do código atualizado
2. A aplicação já estará compatível com os novos tipos

---

## Impacto nos Dados Existentes

| Dado Antigo | Novo Valor |
|-------------|------------|
| `tipo_evento = viagem_pedagogica` | `tipo_evento = outro` |
| `tipo_evento = viagem_formatura` | `tipo_evento = outro` |
| `tipo_contato = escola` | `tipo_contato = empresa` |
| Campo `turma_serie` | **Removido** (dados perdidos) |
| Campo `organizacao_id` | **Removido** (relacionamentos perdidos) |
| Campo `num_participantes` | **Removido** (dados perdidos) |

> **Aviso:** Os campos `turma_serie`, `organizacao_id` e `num_participantes` serão removidos permanentemente. Se houver dados importantes nestes campos, faça backup antes da migration.

---

## Tipos de Evento Disponíveis (Pós-Alteração)

| Valor | Label | Ícone |
|-------|-------|-------|
| `colonia_ferias` | Colônia de Férias | 🏕️ |
| `festa_infantil` | Festa Infantil | 🎈 |
| `gincana` | Gincana | 🏃 |
| `outro` | Outro | 📅 |

## Tipos de Contato Disponíveis (Pós-Alteração)

| Valor | Label |
|-------|-------|
| `pessoa_fisica` | Pessoa Física |
| `empresa` | Empresa |
| `fornecedor` | Fornecedor |

---

## Rollback

Caso seja necessário reverter as alterações, será preciso criar uma nova migration que:

1. Adicione novamente os valores aos enums
2. Recrie a coluna `turma_serie` nas tabelas
3. Note que os dados de `turma_serie` não poderão ser recuperados

---

## Considerações de Escalabilidade

A remoção de campos e tipos não utilizados:

- ✅ Simplifica a estrutura do banco de dados
- ✅ Reduz complexidade nos formulários
- ✅ Melhora a experiência do usuário com menos opções irrelevantes
- ✅ Facilita manutenção futura do código


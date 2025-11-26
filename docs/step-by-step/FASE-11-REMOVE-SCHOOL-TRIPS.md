# FASE 11: Remoção de Viagens Escolares

**Data:** 26/11/2025  
**Status:** Concluído  

## Objetivo

Remover todas as referências a viagens escolares do sistema RocketCRM, que agora foca exclusivamente na gestão de eventos gerais.

## Escopo das Alterações

### 1. Itens Removidos

| Item | Descrição |
|------|-----------|
| `viagem_pedagogica` | Tipo de evento removido |
| `viagem_formatura` | Tipo de evento removido |
| `turma_serie` | Campo removido de eventos e leads |
| `escola` | Tipo de contato removido |

---

## Arquivos Modificados

### Migration SQL

- **Arquivo:** `supabase/migrations/20251126000000_remove_school_trips.sql`
- **Ações:**
  - Remove coluna `turma_serie` das tabelas `eventos` e `leads`
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

### Validações Zod

| Arquivo | Alterações |
|---------|------------|
| `src/lib/validations/evento.ts` | Removido viagens do enum, removido campo `turma_serie`, atualizado `tipoEventoOptions` |
| `src/lib/validations/lead.ts` | Removido viagens do enum, removido campo `turma_serie`, atualizado `tipoServicoOptions` |
| `src/lib/validations/contato.ts` | Removido `escola` do enum, atualizado `tipoContatoOptions` |

### Componentes de Eventos

| Arquivo | Alterações |
|---------|------------|
| `src/components/modules/eventos/evento-form.tsx` | Removido campo turma_serie, atualizado placeholder, mudado default de tipo para `colonia_ferias`, atualizado label "Organização" |
| `src/components/modules/eventos/evento-detail.tsx` | Removido seção turma_serie, removido labels de viagens |
| `src/components/modules/eventos/eventos-table.tsx` | Removido mapeamento de viagens, removido badge turma_serie |

### Componentes de Leads

| Arquivo | Alterações |
|---------|------------|
| `src/components/modules/leads/lead-form.tsx` | Removido campo turma_serie, atualizado placeholder, atualizado label "Organização" |
| `src/components/modules/leads/lead-card.tsx` | Removido exibição de turma, removido labels de viagens |

### Componentes de Contatos

| Arquivo | Alterações |
|---------|------------|
| `src/components/modules/contatos/contatos-table.tsx` | Removido tipo "Escola" do mapeamento e cores |
| `src/components/modules/contatos/contato-detail.tsx` | Removido tipo "Escola" do mapeamento |

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

> **Aviso:** O campo `turma_serie` será removido permanentemente. Se houver dados importantes neste campo, faça backup antes da migration.

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


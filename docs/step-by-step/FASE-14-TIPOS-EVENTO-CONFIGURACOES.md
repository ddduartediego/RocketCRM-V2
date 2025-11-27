# FASE 14 - Tipos de Evento Configuráveis e Redesign de Configurações

**Data:** 27/11/2025
**Objetivo:** Permitir que os usuários configurem tipos de eventos personalizados e redesenhar a página de configurações com layout de sidebar moderno.

---

## Resumo das Alterações

### 1. Banco de Dados

#### Nova Tabela: `tipos_evento`

```sql
CREATE TABLE tipos_evento (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nome TEXT NOT NULL,
  icone TEXT DEFAULT '📅',
  cor TEXT DEFAULT '#0ea5e9',
  ordem INT DEFAULT 0,
  ativo BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);
```

**Campos:**
- `id`: Identificador único (UUID)
- `nome`: Nome do tipo de evento
- `icone`: Emoji para representar o tipo
- `cor`: Cor hexadecimal para identificação visual
- `ordem`: Ordem de exibição
- `ativo`: Se o tipo está disponível para uso

#### Alterações nas Tabelas Existentes

**Tabela `eventos`:**
- Adicionada coluna `tipo_id` (FK para `tipos_evento`)
- Coluna `tipo` (enum) mantida para compatibilidade

**Tabela `leads`:**
- Adicionada coluna `tipo_servico_id` (FK para `tipos_evento`)
- Coluna `tipo_servico` (enum) mantida para compatibilidade

#### Migration

Arquivo: `supabase/migrations/20251127000000_tipos_evento.sql`

---

### 2. Backend - Server Actions

#### Novo arquivo de configurações (`src/actions/configuracoes.ts`)

Adicionadas funções:
- `getTiposEvento()` - Lista todos os tipos de evento
- `createTipoEvento()` - Cria novo tipo
- `updateTipoEvento()` - Atualiza tipo existente
- `deleteTipoEvento()` - Exclui tipo (com validação de uso)
- `reorderTiposEvento()` - Reordena tipos

---

### 3. Types

#### Arquivo: `src/types/database.ts`

Alterações:
- Adicionada interface `tipos_evento` em Tables
- Adicionado campo `tipo_id` em eventos
- Adicionado campo `tipo_servico_id` em leads
- Exportado tipo `TipoEventoRow`
- Renomeado `TipoEvento` para `TipoEventoEnum` (enum antigo)

---

### 4. Validações

#### Arquivo: `src/lib/validations/evento.ts`

Alterações:
- Campo `tipo` substituído por `tipo_id` (UUID)
- Removido `tipoEventoOptions` estático (agora vem do banco)

---

### 5. Frontend - Redesign da Página de Configurações

#### Layout com Sidebar

A página de configurações foi completamente redesenhada com um layout moderno:

```
┌─────────────────────────────────────────────────┐
│  Configurações                                  │
├──────────────┬──────────────────────────────────┤
│  □ Perfil    │                                  │
│  □ Funil     │     [Conteúdo da seção           │
│  □ Categorias│      selecionada]                │
│  ■ Tipos     │                                  │
│  □ Preferênc │                                  │
└──────────────┴──────────────────────────────────┘
```

#### Arquivos Criados/Modificados

**Criados:**
- `src/components/modules/configuracoes/configuracoes-client.tsx` - Componente principal com sidebar
- `src/components/modules/configuracoes/tipos-evento-config.tsx` - Configuração de tipos

**Modificados:**
- `src/app/(dashboard)/configuracoes/page.tsx` - Usa novo layout
- `src/components/modules/configuracoes/index.ts` - Exportações atualizadas

---

### 6. Formulário de Eventos

#### Arquivo: `src/components/modules/eventos/evento-form.tsx`

Alterações:
- Busca tipos de evento dinamicamente do banco
- Campo `tipo_id` ao invés de `tipo` (enum)
- Exibe ícone e nome do tipo no select

---

### 7. Filtros de Eventos

#### Arquivo: `src/components/modules/eventos/eventos-filters.tsx`

Alterações:
- Busca tipos de evento dinamicamente
- Filtra por `tipo_id` ao invés do enum

---

### 8. Actions de Eventos

#### Arquivo: `src/actions/eventos.ts`

Alterações:
- Queries incluem relacionamento com `tipos_evento`
- Filtro por `tipo_id` ao invés de enum
- Join com tabela `tipos_evento` para trazer nome, ícone e cor

---

## Arquivos Alterados

```
supabase/migrations/
  └── 20251127000000_tipos_evento.sql      (NOVO)

src/actions/
  └── configuracoes.ts                      (MODIFICADO)
  └── eventos.ts                            (MODIFICADO)

src/types/
  └── database.ts                           (MODIFICADO)

src/lib/validations/
  └── evento.ts                             (MODIFICADO)

src/app/(dashboard)/configuracoes/
  └── page.tsx                              (MODIFICADO)

src/components/modules/configuracoes/
  └── index.ts                              (MODIFICADO)
  └── configuracoes-client.tsx              (NOVO)
  └── tipos-evento-config.tsx               (NOVO)

src/components/modules/eventos/
  └── evento-form.tsx                       (MODIFICADO)
  └── eventos-filters.tsx                   (MODIFICADO)

docs/step-by-step/
  └── FASE-14-TIPOS-EVENTO-CONFIGURACOES.md (NOVO)
```

---

## Tipos Padrão Criados

Na migration, são criados 4 tipos de evento padrão:

| Nome | Ícone | Cor |
|------|-------|-----|
| Colônia de Férias | 🏕️ | #22c55e |
| Festa Infantil | 🎈 | #e4027d |
| Gincana | 🏃 | #f97316 |
| Outro | 📅 | #6b7280 |

---

## Funcionalidades da Configuração de Tipos

1. **Criar novo tipo:** Nome, ícone (emoji) e cor personalizáveis
2. **Editar tipo existente:** Alterar nome, ícone ou cor
3. **Ativar/Desativar:** Tipos inativos não aparecem nos selects
4. **Excluir:** Só permitido se não houver eventos/leads usando
5. **Preview:** Visualização em tempo real ao criar/editar

---

## Compatibilidade

- As colunas `tipo` (enum) nas tabelas `eventos` e `leads` foram mantidas
- Novos registros usam `tipo_id`
- Dados existentes foram migrados automaticamente
- Pode ser removido o enum em uma migration futura

---

## Próximos Passos Sugeridos

1. Remover colunas `tipo` (enum) após confirmar estabilidade
2. Adicionar drag-and-drop para reordenação de tipos
3. Implementar preferências do sistema (seção desabilitada)
4. Considerar adicionar tipos de evento específicos por negócio


# 📦 RocketCRM - Migrations do Supabase

Este diretório contém todas as migrations SQL necessárias para configurar o banco de dados do RocketCRM.

## 🗂️ Estrutura

| # | Arquivo | Descrição |
|---|---------|-----------|
| ⭐ | `00_full_setup.sql` | **Script único com tudo** (recomendado) |
| 1 | `20251125172325_initial_schema.sql` | Schema completo do banco de dados |
| 2 | `20251125172451_enable_rls_policies.sql` | Políticas de Row Level Security |
| 3 | `20251125172509_auth_user_sync_trigger.sql` | Trigger para sincronizar usuários |
| 4 | `20251125201650_fix_etapas_funil_rls.sql` | Correção RLS para etapas do funil |
| 5 | `20251125201702_fix_categorias_financeiras_rls.sql` | Correção RLS para categorias financeiras |

## 🚀 Como Executar

### Opção 1: Script Único (Recomendado) ⭐

1. Acesse o [Dashboard do Supabase](https://supabase.com/dashboard)
2. Selecione seu projeto
3. Vá em **SQL Editor** → **New Query**
4. Copie e cole todo o conteúdo de `00_full_setup.sql`
5. Clique em **Run**

> ✅ Este arquivo contém TUDO que você precisa em um único script!

### Opção 2: Migrations Individuais

Se preferir executar em partes (útil para debug):

1. Acesse o [Dashboard do Supabase](https://supabase.com/dashboard)
2. Selecione seu projeto
3. Vá em **SQL Editor** → **New Query**
4. Copie e cole o conteúdo de cada arquivo NA ORDEM (1 → 5)
5. Clique em **Run** para cada arquivo

> ⚠️ **Execute na ordem numérica!** Cada migration depende das anteriores.

### Opção 3: Via Supabase CLI

```bash
# Instalar CLI
npm install -g supabase

# Login
supabase login

# Linkar projeto
supabase link --project-ref seu-project-ref

# Executar migrations
supabase db push
```

## 📋 O Que Cada Migration Faz

### 1. `initial_schema.sql`
Cria toda a estrutura do banco:
- **Enums**: `perfil_usuario`, `tipo_contato`, `status_lead`, `tipo_evento`, etc.
- **Tabelas**:
  - `users` - Usuários do sistema
  - `organizacoes` - Escolas, empresas
  - `contatos` - Pessoas físicas
  - `etapas_funil` - Estágios do funil de vendas
  - `leads` - Oportunidades de negócio
  - `eventos` - Eventos e viagens
  - `recursos` - Brinquedos, veículos
  - `equipe` - Monitores, coordenadores
  - `categorias_financeiras` - Categorias de receita/despesa
  - `transacoes_financeiras` - Movimentações financeiras
  - `atividades` - Tarefas e checklist
  - `interacoes` - Histórico de contatos
  - `logs_auditoria` - Auditoria de ações
- **Dados Iniciais**: Etapas padrão do funil e categorias financeiras

### 2. `enable_rls_policies.sql`
Configura políticas de segurança para cada tabela:
- SELECT, INSERT, UPDATE, DELETE para usuários autenticados
- Proteção por Row Level Security (RLS)

### 3. `auth_user_sync_trigger.sql`
Cria trigger que automaticamente:
- Sincroniza novos usuários do `auth.users` para `public.users`
- Extrai nome e avatar do Google OAuth

### 4. `fix_etapas_funil_rls.sql`
Adiciona políticas RLS completas para a tabela `etapas_funil`:
- Permite criar, editar e excluir etapas personalizadas

### 5. `fix_categorias_financeiras_rls.sql`
Adiciona políticas RLS completas para a tabela `categorias_financeiras`:
- Permite criar, editar e excluir categorias personalizadas

## 🔧 Troubleshooting

### Erro: "relation already exists"
A migration já foi executada. Pule para a próxima.

### Erro: "permission denied"
Certifique-se de estar usando as credenciais corretas (service_role).

### Erro: "RLS policy violation"
Execute as migrations de RLS (arquivos 2, 4 e 5).

## 📊 Diagrama do Schema

```
┌─────────────┐     ┌──────────────┐     ┌────────────┐
│   users     │     │ organizacoes │     │  contatos  │
└──────┬──────┘     └──────┬───────┘     └─────┬──────┘
       │                   │                   │
       │    ┌──────────────┴───────────────────┤
       │    │                                  │
       ▼    ▼                                  ▼
┌──────────────┐                        ┌──────────────┐
│    leads     │◄───────────────────────│   eventos    │
└──────┬───────┘                        └──────┬───────┘
       │                                       │
       │         ┌─────────────────────────────┤
       │         │                             │
       ▼         ▼                             ▼
┌──────────────────┐    ┌──────────────┐    ┌──────────────┐
│   atividades     │    │   recursos   │    │    equipe    │
└──────────────────┘    └──────────────┘    └──────────────┘
```

## 📝 Notas

- As migrations são idempotentes onde possível (IF NOT EXISTS)
- RLS está habilitado em todas as tabelas
- O trigger de sync de usuários é crítico para o funcionamento do sistema


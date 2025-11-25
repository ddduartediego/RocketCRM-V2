# Fase 0 - Setup Inicial do RocketCRM

**Data:** 25/11/2025
**Status:** ✅ Concluído

---

## 📋 Resumo

Esta fase estabeleceu a fundação completa do projeto RocketCRM, incluindo:

1. Criação do projeto Next.js 15
2. Configuração da paleta de cores personalizada "Galáxia Rosa"
3. Instalação e configuração do shadcn/ui
4. Schema completo do banco de dados no Supabase
5. Sistema de autenticação com Google OAuth
6. Layout base com sidebar responsiva

---

## 🗂️ Estrutura de Arquivos Criados

```
rocket-crm/
├── src/
│   ├── app/
│   │   ├── globals.css              # Paleta de cores "Galáxia Rosa"
│   │   ├── layout.tsx               # Layout raiz com fonte Plus Jakarta Sans
│   │   ├── page.tsx                 # Página raiz (redireciona)
│   │   ├── (auth)/
│   │   │   ├── layout.tsx           # Layout de autenticação
│   │   │   ├── login/
│   │   │   │   └── page.tsx         # Página de login com Google
│   │   │   └── callback/
│   │   │       └── route.ts         # Callback OAuth
│   │   └── (dashboard)/
│   │       ├── layout.tsx           # Layout do dashboard com sidebar
│   │       └── page.tsx             # Dashboard principal
│   ├── components/
│   │   ├── ui/                      # Componentes shadcn/ui (24 arquivos)
│   │   └── layout/
│   │       ├── app-sidebar.tsx      # Sidebar com navegação
│   │       └── header.tsx           # Header com notificações
│   ├── lib/
│   │   ├── utils.ts                 # Utilitários (cn)
│   │   └── supabase/
│   │       ├── client.ts            # Cliente Supabase (browser)
│   │       ├── server.ts            # Cliente Supabase (server)
│   │       └── middleware.ts        # Middleware de autenticação
│   ├── hooks/
│   │   └── use-mobile.ts            # Hook para detecção mobile
│   ├── types/
│   │   └── database.ts              # Tipos TypeScript gerados
│   └── middleware.ts                # Middleware Next.js
├── docs/
│   └── step-by-step/
│       └── FASE-0-SETUP.md          # Esta documentação
├── package.json
├── components.json                   # Configuração shadcn/ui
└── tsconfig.json
```

---

## 🎨 Paleta de Cores Configurada

### Core
| Token | Valor | Uso |
|-------|-------|-----|
| `primary` | #e4027d | Cor principal (magenta) |
| `primary-hover` | #b60163 | Hover do primary |
| `primary-soft` | #fd72be | Versão suave (badges) |
| `secondary` | #341c44 | Cor secundária (roxo profundo) |
| `secondary-hover` | #3e2151 | Hover do secondary |
| `secondary-soft` | #5d327a | Versão suave |

### Neutros
| Token | Valor | Uso |
|-------|-------|-----|
| `background` | #fff9fc | Fundo da aplicação |
| `foreground` | #1f1028 | Texto principal |
| `card` | #ffffff | Fundo de cards |
| `muted` | #f4e7f2 | Fundos secundários |
| `muted-foreground` | #6b506e | Texto secundário |
| `border` | #edd3ea | Bordas |
| `input` | #e7c6e5 | Bordas de inputs |
| `accent` | #ffe3f3 | Destaques |

### Semânticas
| Token | Valor | Uso |
|-------|-------|-----|
| `success` | #22c55e | Sucesso |
| `warning` | #eab308 | Alerta |
| `destructive` | #dc2626 | Erro/Perigo |
| `info` | #0ea5e9 | Informação |

### Sidebar (Tema escuro)
| Token | Valor |
|-------|-------|
| `sidebar-background` | #341c44 |
| `sidebar-foreground` | #f4e7f2 |
| `sidebar-primary` | #e4027d |
| `sidebar-border` | #5d327a |

---

## 🗄️ Schema do Banco de Dados

### Tabelas Criadas

| Tabela | Descrição | Campos Principais |
|--------|-----------|-------------------|
| `users` | Usuários do sistema | id, nome, email, perfil, avatar_url |
| `contatos` | Pessoas físicas | nome, telefone, whatsapp, email, tags |
| `organizacoes` | Escolas/Empresas | nome, tipo, cnpj, contato_principal |
| `etapas_funil` | Etapas do pipeline | nome, cor, ordem, is_final |
| `leads` | Oportunidades | titulo, valor, etapa, contato, origem |
| `eventos` | Viagens/Festas | nome, tipo, data, cliente, status, valor |
| `recursos` | Brinquedos/Veículos | nome, tipo, quantidade, capacidade |
| `alocacao_recursos` | Reserva de recursos | evento, recurso, datas |
| `equipe` | Monitores/Staff | nome, funcao, tipo_contrato, valor_diaria |
| `alocacao_equipe` | Escala de equipe | evento, membro, data, horarios |
| `categorias_financeiras` | Categorias | nome, tipo (receita/despesa), cor |
| `transacoes_financeiras` | Financeiro | valor, vencimento, status, evento |
| `atividades` | Tarefas | titulo, vencimento, status, responsavel |
| `interacoes` | Histórico | tipo, descricao, contato/lead/evento |
| `logs_auditoria` | Auditoria | acao, tabela, dados |

### Enums Criados

- `tipo_contato`: pessoa_fisica, escola, empresa, fornecedor
- `status_lead`: novo, qualificado, proposta_enviada, negociacao, aceito, perdido
- `tipo_evento`: viagem_pedagogica, viagem_formatura, colonia_ferias, festa_infantil, gincana, outro
- `status_evento`: planejamento, confirmado, em_andamento, realizado, cancelado
- `tipo_recurso`: brinquedo, veiculo, espaco, equipamento, outro
- `funcao_equipe`: monitor, recreador, coordenador, motorista, outro
- `tipo_contrato_equipe`: fixo, freelancer
- `tipo_transacao`: receita, despesa
- `status_pagamento`: pendente, pago, em_atraso, cancelado
- `perfil_usuario`: admin, usuario
- `status_atividade`: pendente, em_andamento, concluida, cancelada

### RLS (Row Level Security)

Todas as tabelas possuem RLS habilitado com políticas:
- Usuários autenticados podem ler/criar/editar dados
- Apenas admins podem gerenciar etapas_funil e categorias_financeiras
- Logs de auditoria são visíveis apenas para admins

### Triggers

- `update_updated_at`: Atualiza automaticamente o campo `updated_at`
- `on_auth_user_created`: Cria registro em `public.users` quando usuário faz signup
- `on_auth_user_updated`: Sincroniza dados do auth.users com public.users

---

## 📦 Dependências Instaladas

### Produção
```json
{
  "next": "16.0.4",
  "react": "19.2.0",
  "react-dom": "19.2.0",
  "@supabase/supabase-js": "latest",
  "@supabase/ssr": "latest",
  "react-hook-form": "latest",
  "@hookform/resolvers": "latest",
  "zod": "latest",
  "@dnd-kit/core": "latest",
  "@dnd-kit/sortable": "latest",
  "@dnd-kit/utilities": "latest",
  "recharts": "latest",
  "date-fns": "latest"
}
```

### Componentes shadcn/ui Instalados
- button, card, input, label, form
- select, textarea, badge, avatar
- dropdown-menu, dialog, sheet
- table, tabs, separator, skeleton
- sonner, popover, command, calendar
- tooltip, scroll-area, sidebar

---

## ⚙️ Configurações Importantes

### 1. Variáveis de Ambiente (.env.local)

Criar arquivo `.env.local` na raiz do projeto:

```env
NEXT_PUBLIC_SUPABASE_URL=https://kxnolcnbugqlwjogbrzl.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

### 2. Google OAuth no Supabase

1. Acesse o [Supabase Dashboard](https://supabase.com/dashboard)
2. Vá em **Authentication > Providers > Google**
3. Habilite o provider
4. Configure as credenciais do Google Cloud Console:
   - Client ID
   - Client Secret
5. Adicione a URL de callback: `https://kxnolcnbugqlwjogbrzl.supabase.co/auth/v1/callback`

### 3. Google Cloud Console

1. Acesse [console.cloud.google.com](https://console.cloud.google.com)
2. Crie ou selecione um projeto
3. Vá em **APIs & Services > Credentials**
4. Crie um OAuth 2.0 Client ID
5. Adicione as URIs autorizadas:
   - `http://localhost:3000` (desenvolvimento)
   - `https://seu-dominio.vercel.app` (produção)
6. Adicione os URIs de redirecionamento:
   - `https://kxnolcnbugqlwjogbrzl.supabase.co/auth/v1/callback`

---

## 🚀 Como Rodar o Projeto

```bash
# Instalar dependências
npm install

# Criar arquivo .env.local com as variáveis acima

# Rodar em desenvolvimento
npm run dev

# Acessar: http://localhost:3000
```

---

## 📝 Próximos Passos (Fase 1)

1. **Módulo Contatos**
   - Listagem com busca e filtros
   - CRUD completo
   - Sistema de tags
   - Histórico de interações

2. **Módulo Leads/Vendas**
   - Kanban visual com drag-and-drop
   - Etapas configuráveis
   - Cards de lead
   - Modal de motivo de perda

3. **Módulo Eventos (básico)**
   - Tipos de evento
   - CRUD de eventos
   - Vinculação com contatos
   - Status do evento

---

## ✅ Checklist Fase 0

- [x] Criar projeto Next.js 15 com App Router + TypeScript
- [x] Configurar Tailwind CSS com paleta personalizada
- [x] Instalar e configurar shadcn/ui
- [x] Configurar Supabase Client
- [x] Criar schema completo do banco
- [x] Habilitar RLS e criar políticas
- [x] Configurar Auth Google
- [x] Criar layout base (Sidebar + Header)
- [x] Criar middleware de autenticação
- [x] Criar documentação step-by-step


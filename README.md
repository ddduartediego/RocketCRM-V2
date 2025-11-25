# 🚀 RocketCRM

Sistema de CRM completo para gestão de eventos, desenvolvido com Next.js 15, TypeScript e Supabase.

![RocketCRM](https://img.shields.io/badge/version-1.0.0-pink)
![Next.js](https://img.shields.io/badge/Next.js-16-black)
![TypeScript](https://img.shields.io/badge/TypeScript-5-blue)
![Supabase](https://img.shields.io/badge/Supabase-PostgreSQL-green)

## ✨ Funcionalidades

### Módulos Principais
- **📇 Contatos** - Gestão de clientes, escolas e fornecedores
- **🎯 Leads** - Funil de vendas com Kanban drag-and-drop
- **📅 Eventos** - Gestão completa com integração Google Calendar
- **📦 Recursos** - Controle de brinquedos, veículos e equipamentos
- **👥 Equipe** - Gestão de monitores e colaboradores
- **💰 Financeiro** - Receitas, despesas e fluxo de caixa
- **📊 Relatórios** - Gráficos interativos e exportação CSV/TXT
- **✅ Tarefas** - Checklist e acompanhamento de atividades
- **⚙️ Configurações** - Personalização do sistema

### Destaques
- 🔐 Autenticação via Google OAuth
- 📆 Sincronização automática com Google Calendar
- 🎨 Interface moderna com tema "Galáxia Rosa"
- 📱 Design responsivo
- 🌙 Suporte a modo escuro

## 🛠️ Stack Tecnológica

| Tecnologia | Versão | Uso |
|------------|--------|-----|
| Next.js | 16.x | Framework React |
| TypeScript | 5.x | Tipagem estática |
| Tailwind CSS | 4.x | Estilização |
| shadcn/ui | latest | Componentes UI |
| Supabase | latest | Backend & Auth |
| Recharts | 2.x | Gráficos |
| @dnd-kit | 6.x | Drag and Drop |

## 📋 Pré-requisitos

- Node.js 18+ 
- npm ou yarn
- Conta no [Supabase](https://supabase.com)
- Conta no [Google Cloud Console](https://console.cloud.google.com)
- Conta na [Vercel](https://vercel.com) (para deploy)

## 🚀 Início Rápido

### 1. Clonar o repositório

```bash
git clone https://github.com/seu-usuario/rocket-crm.git
cd rocket-crm
```

### 2. Instalar dependências

```bash
npm install
```

### 3. Configurar variáveis de ambiente

```bash
cp .env.example .env.local
```

Edite o arquivo `.env.local` com suas credenciais:

```env
NEXT_PUBLIC_SUPABASE_URL=https://seu-projeto.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=sua-anon-key
SUPABASE_SERVICE_ROLE_KEY=sua-service-role-key

NEXT_PUBLIC_GOOGLE_CLIENT_ID=seu-google-client-id
GOOGLE_CLIENT_SECRET=seu-google-client-secret
```

### 4. Executar em desenvolvimento

```bash
npm run dev
```

Acesse [http://localhost:3000](http://localhost:3000)

## 📚 Documentação

- [Setup Completo para Produção](./docs/SETUP-PRODUCAO.md)
- [Fase 0 - Setup Inicial](./docs/step-by-step/FASE-0-SETUP.md)
- [Fase 1 - Módulos Core](./docs/step-by-step/FASE-1-CORE.md)
- [Fase 2 - Agenda e Alocações](./docs/step-by-step/FASE-2-AGENDA-ALOCACOES.md)
- [Fase 3 - Financeiro e Relatórios](./docs/step-by-step/FASE-3-FINANCEIRO-RELATORIOS.md)
- [Fase 4 - Tarefas e Polimento](./docs/step-by-step/FASE-4-TAREFAS-POLIMENTO.md)

## 🌐 Deploy

### Vercel (Recomendado)

[![Deploy with Vercel](https://vercel.com/button)](https://vercel.com/new/clone?repository-url=https://github.com/seu-usuario/rocket-crm)

Veja o guia completo em [docs/SETUP-PRODUCAO.md](./docs/SETUP-PRODUCAO.md)

## 📁 Estrutura do Projeto

```
rocket-crm/
├── src/
│   ├── app/                    # App Router (páginas)
│   │   ├── (auth)/            # Rotas de autenticação
│   │   ├── (dashboard)/       # Rotas do dashboard
│   │   └── auth/              # Callback OAuth
│   ├── actions/               # Server Actions
│   ├── components/
│   │   ├── layout/           # Layout components
│   │   ├── modules/          # Módulos do sistema
│   │   └── ui/               # shadcn/ui components
│   ├── lib/
│   │   ├── supabase/         # Clients Supabase
│   │   └── validations/      # Schemas Zod
│   └── types/                # TypeScript types
├── docs/                      # Documentação
└── public/                   # Assets estáticos
```

## 🎨 Paleta de Cores

O sistema usa a paleta "Galáxia Rosa":

| Cor | Hex | Uso |
|-----|-----|-----|
| Primary | `#e4027d` | Ações principais |
| Secondary | `#341c44` | Elementos secundários |
| Success | `#22c55e` | Sucesso/Receitas |
| Warning | `#eab308` | Alertas |
| Destructive | `#dc2626` | Erros/Despesas |

## 📄 Licença

Este projeto é proprietário. Todos os direitos reservados.

## 👨‍💻 Desenvolvido por

RocketCRM v1.0 - Sistema de Gestão de Eventos

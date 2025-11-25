# 🚀 RocketCRM - Guia de Setup para Produção

Este guia detalha todos os passos necessários para configurar e fazer deploy do RocketCRM em ambiente de produção.

## 📋 Índice

1. [Pré-requisitos](#pré-requisitos)
2. [Configuração do Supabase](#1-configuração-do-supabase)
3. [Configuração do Google Cloud](#2-configuração-do-google-cloud)
4. [Configuração do Projeto](#3-configuração-do-projeto)
5. [Deploy na Vercel](#4-deploy-na-vercel)
6. [Pós-deploy](#5-pós-deploy)
7. [Troubleshooting](#troubleshooting)

---

## Pré-requisitos

- [ ] Node.js 18+ instalado
- [ ] Conta no [Supabase](https://supabase.com)
- [ ] Conta no [Google Cloud Console](https://console.cloud.google.com)
- [ ] Conta na [Vercel](https://vercel.com)
- [ ] Repositório Git (GitHub, GitLab ou Bitbucket)

---

## 1. Configuração do Supabase

### 1.1 Criar Projeto

1. Acesse [supabase.com](https://supabase.com) e faça login
2. Clique em **New Project**
3. Preencha:
   - **Name**: `RocketCRM` (ou nome desejado)
   - **Database Password**: Gere uma senha forte e guarde-a
   - **Region**: Escolha a mais próxima (ex: `South America (São Paulo)`)
4. Clique em **Create new project**
5. Aguarde a inicialização (~2 minutos)

### 1.2 Obter Credenciais

1. No dashboard do projeto, vá em **Settings** → **API**
2. Copie e guarde:
   - **Project URL**: `https://xxxxx.supabase.co`
   - **anon public key**: `eyJhbGciOiJIUzI1NiIsInR5cCI6...`
   - **service_role key**: `eyJhbGciOiJIUzI1NiIsInR5cCI6...` (⚠️ Mantenha segura!)

### 1.3 Configurar Autenticação Google

1. Vá em **Authentication** → **Providers**
2. Encontre **Google** e clique para expandir
3. Ative o toggle **Enable Sign in with Google**
4. Deixe os campos de Client ID e Secret vazios por enquanto (configuraremos depois)
5. Copie a **Callback URL**: `https://xxxxx.supabase.co/auth/v1/callback`

### 1.4 Configurar URL do Site

1. Vá em **Authentication** → **URL Configuration**
2. Configure:
   - **Site URL**: `https://seu-dominio.vercel.app` (URL final da Vercel)
   - **Redirect URLs**: Adicione:
     ```
     https://seu-dominio.vercel.app/auth/callback
     http://localhost:3000/auth/callback
     ```

### 1.5 Executar Migrations

As migrations criam toda a estrutura do banco de dados.

#### Opção 1: Script Único (Recomendado) ⭐

1. No Supabase, vá em **SQL Editor** → **New Query**
2. Copie todo o conteúdo do arquivo `supabase/migrations/00_full_setup.sql`
3. Cole no editor e clique em **Run**

> ✅ Este script único contém todas as tabelas, enums, políticas RLS, trigger e dados iniciais.

#### Opção 2: Migrations Individuais

Se preferir executar em partes, use os arquivos separados na ordem:

| # | Arquivo | Descrição |
|---|---------|-----------|
| 1 | `20251125172325_initial_schema.sql` | Schema completo |
| 2 | `20251125172451_enable_rls_policies.sql` | Políticas RLS |
| 3 | `20251125172509_auth_user_sync_trigger.sql` | Trigger sync usuários |
| 4 | `20251125201650_fix_etapas_funil_rls.sql` | Fix RLS etapas |
| 5 | `20251125201702_fix_categorias_financeiras_rls.sql` | Fix RLS categorias |

> **⚠️ Importante**: Execute na ordem numérica. Cada migration depende da anterior.

---

## 2. Configuração do Google Cloud

### 2.1 Criar Projeto

1. Acesse [console.cloud.google.com](https://console.cloud.google.com)
2. Clique no seletor de projetos → **New Project**
3. Preencha:
   - **Project name**: `RocketCRM`
   - **Organization**: Selecione se houver
4. Clique em **Create**

### 2.2 Ativar APIs

1. Vá em **APIs & Services** → **Library**
2. Busque e ative:
   - **Google Calendar API**
   - **Google+ API** (ou People API)

### 2.3 Configurar Tela de Consentimento OAuth

1. Vá em **APIs & Services** → **OAuth consent screen**
2. Selecione **External** e clique **Create**
3. Preencha:
   - **App name**: `RocketCRM`
   - **User support email**: Seu email
   - **Developer contact**: Seu email
4. Clique **Save and Continue**
5. Em **Scopes**, adicione:
   - `email`
   - `profile`
   - `openid`
   - `https://www.googleapis.com/auth/calendar`
   - `https://www.googleapis.com/auth/calendar.events`
6. Continue e finalize

### 2.4 Criar Credenciais OAuth

1. Vá em **APIs & Services** → **Credentials**
2. Clique **Create Credentials** → **OAuth client ID**
3. Selecione **Web application**
4. Preencha:
   - **Name**: `RocketCRM Web`
   - **Authorized JavaScript origins**:
     ```
     https://seu-dominio.vercel.app
     http://localhost:3000
     ```
   - **Authorized redirect URIs**:
     ```
     https://xxxxx.supabase.co/auth/v1/callback
     http://localhost:3000/auth/callback
     ```
5. Clique **Create**
6. Copie e guarde:
   - **Client ID**: `xxxx.apps.googleusercontent.com`
   - **Client Secret**: `GOCSPX-xxxxx`

### 2.5 Finalizar Configuração no Supabase

1. Volte ao Supabase → **Authentication** → **Providers** → **Google**
2. Cole:
   - **Client ID**: O Client ID do Google
   - **Client Secret**: O Client Secret do Google
3. Clique **Save**

---

## 3. Configuração do Projeto

### 3.1 Clonar e Instalar

```bash
# Clonar repositório
git clone https://github.com/seu-usuario/rocket-crm.git
cd rocket-crm

# Instalar dependências
npm install
```

### 3.2 Configurar Variáveis de Ambiente

Crie o arquivo `.env.local`:

```env
# Supabase
NEXT_PUBLIC_SUPABASE_URL=https://xxxxx.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6...

# Google OAuth
NEXT_PUBLIC_GOOGLE_CLIENT_ID=xxxxx.apps.googleusercontent.com
GOOGLE_CLIENT_SECRET=GOCSPX-xxxxx
```

### 3.3 Testar Localmente

```bash
npm run dev
```

Acesse `http://localhost:3000` e teste:
- [ ] Login com Google
- [ ] Navegação pelos módulos
- [ ] Criação de registros

---

## 4. Deploy na Vercel

### 4.1 Conectar Repositório

1. Acesse [vercel.com](https://vercel.com) e faça login
2. Clique **Add New** → **Project**
3. Importe seu repositório Git
4. Selecione o repositório `rocket-crm`

### 4.2 Configurar Build

1. Framework Preset: **Next.js** (detectado automaticamente)
2. Root Directory: `./` (raiz)
3. Build Command: `npm run build`
4. Output Directory: `.next`

### 4.3 Configurar Variáveis de Ambiente

Na seção **Environment Variables**, adicione:

| Nome | Valor |
|------|-------|
| `NEXT_PUBLIC_SUPABASE_URL` | `https://xxxxx.supabase.co` |
| `NEXT_PUBLIC_SUPABASE_ANON_KEY` | `eyJhbGciOiJIUzI1...` |
| `NEXT_PUBLIC_GOOGLE_CLIENT_ID` | `xxxxx.apps.googleusercontent.com` |
| `GOOGLE_CLIENT_SECRET` | `GOCSPX-xxxxx` |

### 4.4 Deploy

1. Clique **Deploy**
2. Aguarde o build (~2-3 minutos)
3. Acesse a URL gerada: `https://rocket-crm-xxx.vercel.app`

### 4.5 Configurar Domínio Personalizado (Opcional)

1. Vá em **Settings** → **Domains**
2. Adicione seu domínio: `crm.seudominio.com.br`
3. Configure os DNS conforme instruções

---

## 5. Pós-deploy

### 5.1 Atualizar URLs

Após obter a URL final da Vercel, atualize:

**No Supabase:**
1. **Authentication** → **URL Configuration**
   - Site URL: `https://seu-dominio.vercel.app`
   - Redirect URLs: Adicionar a URL final

**No Google Cloud:**
1. **APIs & Services** → **Credentials** → Editar OAuth Client
   - Adicionar URL final em **Authorized JavaScript origins**
   - Adicionar callback em **Authorized redirect URIs**

### 5.2 Criar Usuário Admin

1. Acesse a aplicação e faça login com Google
2. No Supabase, vá em **Table Editor** → **users**
3. Edite o perfil do usuário para `admin` se necessário

### 5.3 Configurar Dados Iniciais

O sistema já vem com etapas do funil pré-configuradas. Você pode personalizá-las em:
- **Configurações** → **Etapas do Funil**
- **Configurações** → **Categorias Financeiras**

---

## Troubleshooting

### Erro: "Invalid login credentials"
- Verifique se o Google OAuth está configurado corretamente no Supabase
- Confira se as URLs de callback estão corretas

### Erro: "RLS policy violation"
- Execute as migrations de RLS no Supabase
- Verifique se o usuário está autenticado

### Erro: "Module not found"
- Execute `npm install` novamente
- Verifique se todas as dependências estão no `package.json`

### Google Calendar não sincroniza
- Verifique se a Google Calendar API está ativada
- Confira os scopes no consent screen
- Verifique se o usuário autorizou acesso ao calendário

### Build falha na Vercel
- Verifique os logs de build
- Certifique-se de que todas as variáveis de ambiente estão configuradas
- Teste o build localmente: `npm run build`

---

## 📊 Checklist Final

- [ ] Supabase configurado e rodando
- [ ] Google OAuth funcionando
- [ ] Google Calendar API ativada
- [ ] Deploy na Vercel concluído
- [ ] URLs de callback atualizadas
- [ ] Login funcionando em produção
- [ ] Módulos principais testados
- [ ] Dados iniciais configurados

---

## 📞 Suporte

Em caso de problemas:
1. Verifique os logs no Supabase (Logs → Edge Functions / Postgres)
2. Verifique os logs na Vercel (Deployments → Functions)
3. Consulte a documentação das tecnologias:
   - [Next.js Docs](https://nextjs.org/docs)
   - [Supabase Docs](https://supabase.com/docs)
   - [Vercel Docs](https://vercel.com/docs)

---

**RocketCRM v1.0** - Sistema de Gestão de Eventos


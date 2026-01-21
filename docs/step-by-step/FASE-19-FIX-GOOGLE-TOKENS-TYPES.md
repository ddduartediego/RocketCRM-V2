# FASE 19 - Correção dos Tipos de Tokens do Google

## Problema Identificado

O build no Vercel estava falhando com erro de TypeScript:

```
Type error: Object literal may only specify known properties, and 'google_access_token' 
does not exist in type '{ ativo?: boolean | undefined; ... }'.
```

## Causa Raiz

A migration `20260121000000_add_google_tokens.sql` adicionou as colunas de tokens do Google à tabela `users` no banco de dados:
- `google_access_token`
- `google_refresh_token`
- `google_token_expires_at`

Porém, o arquivo de tipos TypeScript `src/types/database.ts` não foi atualizado para refletir essas novas colunas.

## Solução Implementada

### Arquivo Alterado

**`src/types/database.ts`**

Adicionadas as propriedades de tokens do Google nas três seções da tabela `users`:

1. **Row** (leitura):
   - `google_access_token: string | null`
   - `google_refresh_token: string | null`
   - `google_token_expires_at: string | null`

2. **Insert** (inserção - opcionais):
   - `google_access_token?: string | null`
   - `google_refresh_token?: string | null`
   - `google_token_expires_at?: string | null`

3. **Update** (atualização - opcionais):
   - `google_access_token?: string | null`
   - `google_refresh_token?: string | null`
   - `google_token_expires_at?: string | null`

## Arquivos Relacionados

| Arquivo | Função |
|---------|--------|
| `src/types/database.ts` | Define os tipos TypeScript para todas as tabelas do Supabase |
| `src/app/auth/callback/route.ts` | Usa os campos de token para salvar credenciais do Google OAuth |
| `supabase/migrations/20260121000000_add_google_tokens.sql` | Migration que criou as colunas no banco |

## Resultado

Build do Vercel passa sem erros de TypeScript.

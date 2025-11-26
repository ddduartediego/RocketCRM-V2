# Fase 10 - Correção do Erro 431 e Erros de TypeScript

## Problema 1: Erro 431 (Request Header Fields Too Large)

O erro **HTTP 431 (Request Header Fields Too Large)** estava ocorrendo ao tentar adicionar um membro a um evento. 

### Solução

Atualizamos o middleware para usar `getClaims()` ao invés de `getUser()`, conforme recomendado pela documentação mais recente do Supabase. Isso é mais leve pois não faz chamada de rede adicional.

**Arquivo:** `src/lib/supabase/middleware.ts`

```typescript
// ANTES
const { data: { user } } = await supabase.auth.getUser();

// DEPOIS
const { data } = await supabase.auth.getClaims();
const user = data?.claims;
```

## Problema 2: Erros de TypeScript no Build

### 2.1 Tipo `cor` em categorias_financeiras

O campo `cor` pode ser `null` no banco de dados.

**Arquivos:** 
- `src/components/modules/eventos/evento-detail.tsx`
- `src/components/modules/eventos/evento-financeiro-tab.tsx`

```typescript
// ANTES
categorias_financeiras?: { id: string; nome: string; cor: string } | null;

// DEPOIS
categorias_financeiras?: { id: string; nome: string; cor: string | null } | null;
```

### 2.2 Valores financeiros opcionais

Os valores `totalReceitas`, `totalDespesas` e `lucro` podem ser `undefined`.

**Arquivo:** `src/app/(dashboard)/eventos/[id]/page.tsx`

```typescript
resumoFinanceiro={{
  totalReceitas: transacoesResult.totalReceitas ?? 0,
  totalDespesas: transacoesResult.totalDespesas ?? 0,
  lucro: transacoesResult.lucro ?? 0,
}}
```

### 2.3 Schemas Zod com z.coerce.number()

O `z.coerce.number()` combinado com `optional().nullable()` infere tipo `unknown` no TypeScript.

**Arquivos:**
- `src/lib/validations/equipe.ts`
- `src/lib/validations/recurso.ts`
- `src/lib/validations/evento.ts`

```typescript
// ANTES
valor_pago: z.coerce.number().min(0).optional().nullable(),

// DEPOIS
valor_pago: z.union([z.number().min(0), z.null()]).optional(),
```

### 2.4 Uso de cor null no JSX

**Arquivo:** `src/components/modules/eventos/evento-financeiro-tab.tsx`

```typescript
// ANTES
color: transacao.categorias_financeiras.cor,

// DEPOIS
color: transacao.categorias_financeiras.cor ?? "#888888",
```

## Arquivos Modificados

| Arquivo | Alteração |
|---------|-----------|
| `src/lib/supabase/middleware.ts` | Usar `getClaims()` ao invés de `getUser()` |
| `src/components/modules/eventos/evento-detail.tsx` | Tipo `cor` aceita `null` |
| `src/components/modules/eventos/evento-financeiro-tab.tsx` | Tipo `cor` aceita `null` + fallback |
| `src/app/(dashboard)/eventos/[id]/page.tsx` | Valores financeiros com fallback `?? 0` |
| `src/lib/validations/equipe.ts` | Schema corrigido para tipos corretos |
| `src/lib/validations/recurso.ts` | Schema corrigido para tipos corretos |
| `src/lib/validations/evento.ts` | Schema corrigido para tipos corretos |

## Resultado

- ✅ Build local passa sem erros
- ✅ Build do Vercel passa sem erros
- ✅ Login e navegação funcionando corretamente


# Fase 10 - Correção do Erro 431 (Request Header Fields Too Large)

## Problema Identificado

O erro **HTTP 431 (Request Header Fields Too Large)** estava ocorrendo ao tentar adicionar um membro a um evento. Este erro acontece quando os headers HTTP, principalmente cookies, excedem o limite máximo permitido pelo servidor.

### Causa Raiz

Os cookies de sessão do Supabase Auth estavam acumulando dados excessivos, causando:
- Tokens JWT muito grandes
- Múltiplas sessões/tokens antigos não limpos
- Cookies corrompidos ou fragmentados

### Stack Trace

```
POST http://localhost:3000/eventos/[id] net::ERR_ABORTED 431 (Request Header Fields Too Large)

- getMembrosEquipe @ equipe.ts:28
- AlocacaoEquipeForm.useEffect @ alocacao-equipe-form.tsx:93
- EventoEquipeTab @ evento-equipe-tab.tsx:259
- EventoDetail @ evento-detail.tsx:469
```

## Solução Implementada

### 1. Middleware com Proteção de Tamanho de Cookies

Arquivo: `src/lib/supabase/middleware.ts`

Adicionada lógica para:
- Verificar o tamanho total dos cookies do Supabase
- Limpar automaticamente sessões corrompidas/muito grandes
- Forçar re-login quando necessário

```typescript
// Limite máximo de tamanho total de cookies (em bytes) para evitar erro 431
const MAX_COOKIE_SIZE = 4000;

function getSupabaseCookies(request: NextRequest) {
  const allCookies = request.cookies.getAll();
  
  // Filtrar apenas cookies do Supabase
  const supabaseCookies = allCookies.filter(
    (cookie) => cookie.name.startsWith("sb-") || cookie.name.includes("supabase")
  );
  
  // Calcular tamanho total dos cookies
  const totalSize = supabaseCookies.reduce(
    (sum, cookie) => sum + cookie.name.length + (cookie.value?.length || 0),
    0
  );
  
  // Se os cookies estão muito grandes, retornar vazio para forçar re-login
  if (totalSize > MAX_COOKIE_SIZE) {
    console.warn(`[Middleware] Cookies do Supabase muito grandes (${totalSize} bytes). Limpando sessão.`);
    return [];
  }
  
  return allCookies;
}
```

## Como Resolver Manualmente (Solução Imediata)

Se o erro persistir antes da correção ser aplicada:

1. Abra o Chrome DevTools (F12)
2. Vá em **Application** → **Cookies** → **http://localhost:3000**
3. Clique com botão direito → **Clear**
4. Recarregue a página e faça login novamente

## Arquivos Modificados

| Arquivo | Alteração |
|---------|-----------|
| `src/lib/supabase/middleware.ts` | Adicionada proteção de tamanho de cookies |

## Benefícios da Correção

1. **Prevenção automática**: O middleware agora detecta e limpa cookies corrompidos
2. **Experiência do usuário**: Em vez de erro 431, o usuário é redirecionado para login
3. **Logging**: Mensagens de warning no console para debug
4. **Resiliência**: Sistema mais robusto contra problemas de sessão

## Observações

- O limite de 4000 bytes foi escolhido por ser conservador (o limite típico é 8KB por cookie)
- Cookies do Supabase geralmente ficam entre 2000-3000 bytes em condições normais
- Se o erro persistir em produção, considere aumentar o limite de headers no servidor


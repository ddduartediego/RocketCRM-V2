# FASE 17 - Debounce nos Filtros de Busca

## Objetivo

Melhorar a experiência do usuário ao realizar filtros nas páginas do sistema, implementando um delay (debounce) antes de executar a busca.

## Problema

Anteriormente, todos os filtros de busca do sistema executavam a pesquisa a cada caractere digitado, causando:
- Múltiplas requisições desnecessárias ao servidor
- Interface lenta/travando durante a digitação
- Experiência ruim para o usuário que não conseguia digitar a busca completa

## Solução Implementada

### Hook useDebounce

Criado um hook reutilizável em `src/hooks/use-debounce.ts` com duas variantes:

1. **`useDebounce(value, delay)`** - Retorna o valor com debounce aplicado
2. **`useDebouncedCallback(callback, delay)`** - Retorna uma função com debounce aplicado

O delay padrão é de **400ms**, que oferece um bom equilíbrio entre responsividade e eficiência.

### Como Funciona

```
Usuário digita "João":
  J → Inicia timer 400ms
  o → Reseta timer 400ms  
  ã → Reseta timer 400ms
  o → Reseta timer 400ms
  [Usuário para de digitar]
  → Após 400ms, busca "João"
```

O input continua responsivo (mostra o que o usuário digita imediatamente), mas a busca só é disparada após o usuário parar de digitar.

## Arquivos Modificados

### Novo Arquivo
- `src/hooks/use-debounce.ts` - Hook reutilizável para debounce

### Componentes de Filtro Atualizados
- `src/components/modules/eventos/eventos-filters.tsx`
- `src/components/modules/contatos/contatos-filters.tsx`
- `src/components/modules/tarefas/tarefas-filters.tsx`
- `src/components/modules/financeiro/financeiro-filters.tsx`
- `src/components/modules/equipe/equipe-filters.tsx`
- `src/components/modules/recursos/recursos-filters.tsx`

## Uso do Hook

### Exemplo 1: useDebounce (para valores)

```tsx
import { useDebounce } from "@/hooks/use-debounce";

function SearchFilter() {
  const [searchInput, setSearchInput] = useState("");
  const debouncedSearch = useDebounce(searchInput, 400);

  useEffect(() => {
    // Executado apenas quando debouncedSearch muda
    fetchResults(debouncedSearch);
  }, [debouncedSearch]);

  return (
    <Input
      value={searchInput}
      onChange={(e) => setSearchInput(e.target.value)}
    />
  );
}
```

### Exemplo 2: useDebouncedCallback (para funções)

```tsx
import { useDebouncedCallback } from "@/hooks/use-debounce";

function SearchFilter() {
  const handleSearch = useDebouncedCallback((value: string) => {
    fetchResults(value);
  }, 400);

  return (
    <Input
      onChange={(e) => handleSearch(e.target.value)}
    />
  );
}
```

## Estratégia de Implementação

Para cada componente de filtro:

1. **Estado local**: Mantém o valor digitado para exibição imediata (UX responsiva)
2. **useDebounce**: Cria um valor com debounce que só muda após o delay
3. **useEffect**: Dispara a busca/atualização de URL quando o valor com debounce muda
4. **Sincronização**: Sincroniza o input com props externas quando necessário

## Benefícios

1. **Melhor UX**: Usuário pode digitar a busca completa sem interrupções
2. **Menos requisições**: Reduz significativamente o número de chamadas ao servidor
3. **Performance**: Menos re-renders e processamento desnecessário
4. **Reutilizável**: Hook pode ser usado em qualquer outro lugar do sistema

## Considerações

- O delay de 400ms pode ser ajustado conforme necessidade
- Para campos de data ou select, não é necessário debounce (ação única do usuário)
- O hook `useDebouncedCallback` está disponível para casos onde se precisa fazer debounce de uma função callback

## Data da Implementação

Janeiro de 2026

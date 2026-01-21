import { useState, useEffect, useCallback, useRef } from "react";

/**
 * Hook para debounce de valores
 * Retorna o valor com debounce após o delay especificado
 * 
 * @param value - Valor a ser "debounced"
 * @param delay - Tempo em ms para aguardar (padrão: 400ms)
 * @returns Valor com debounce aplicado
 */
export function useDebounce<T>(value: T, delay: number = 400): T {
  const [debouncedValue, setDebouncedValue] = useState<T>(value);

  useEffect(() => {
    const timer = setTimeout(() => {
      setDebouncedValue(value);
    }, delay);

    return () => {
      clearTimeout(timer);
    };
  }, [value, delay]);

  return debouncedValue;
}

/**
 * Hook para debounce de callbacks/funções
 * Retorna uma função que só será executada após o delay
 * 
 * @param callback - Função a ser executada com debounce
 * @param delay - Tempo em ms para aguardar (padrão: 400ms)
 * @returns Função com debounce aplicado
 */
export function useDebouncedCallback<T extends (...args: Parameters<T>) => ReturnType<T>>(
  callback: T,
  delay: number = 400
): (...args: Parameters<T>) => void {
  const timeoutRef = useRef<NodeJS.Timeout | null>(null);
  const callbackRef = useRef(callback);

  // Atualiza a referência do callback para evitar stale closures
  useEffect(() => {
    callbackRef.current = callback;
  }, [callback]);

  // Limpa o timeout ao desmontar
  useEffect(() => {
    return () => {
      if (timeoutRef.current) {
        clearTimeout(timeoutRef.current);
      }
    };
  }, []);

  return useCallback(
    (...args: Parameters<T>) => {
      if (timeoutRef.current) {
        clearTimeout(timeoutRef.current);
      }

      timeoutRef.current = setTimeout(() => {
        callbackRef.current(...args);
      }, delay);
    },
    [delay]
  );
}

"use client";

import { useCallback, useEffect, useState } from "react";

/**
 * Carrega dados assíncronos associados a uma `key` (por exemplo, o id do usuário).
 * - Ao mudar a key, `loading` volta a ser true e os dados antigos NÃO são devolvidos
 *   (evita mostrar dados de outro usuário/turma durante a troca).
 * - `refresh()` busca de novo mantendo os dados atuais na tela até a resposta chegar.
 * `load` precisa ser estável (useCallback).
 */
export function useLoader<T>(key: string, load: () => Promise<T>) {
  const [result, setResult] = useState<{
    key: string;
    data?: T;
    error?: string;
  } | null>(null);

  useEffect(() => {
    let cancelled = false;
    load().then(
      (data) => {
        if (!cancelled) setResult({ key, data });
      },
      (e: unknown) => {
        if (!cancelled)
          setResult({
            key,
            error: e instanceof Error ? e.message : "Erro ao carregar.",
          });
      },
    );
    return () => {
      cancelled = true;
    };
  }, [key, load]);

  const refresh = useCallback(async () => {
    try {
      setResult({ key, data: await load() });
    } catch (e) {
      setResult({
        key,
        error: e instanceof Error ? e.message : "Erro ao carregar.",
      });
    }
  }, [key, load]);

  const current = result?.key === key ? result : null;
  return {
    data: current?.data ?? null,
    error: current?.error ?? null,
    loading: current === null,
    refresh,
  };
}

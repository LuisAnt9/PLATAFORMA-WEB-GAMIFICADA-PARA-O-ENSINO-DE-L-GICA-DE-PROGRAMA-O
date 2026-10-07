"use client";

import { createContext, useCallback, useContext, useMemo } from "react";
import {
  EMPTY_CATALOG,
  EXERCISE_COLUMNS,
  MODULE_COLUMNS,
  exerciseFromRow,
  moduleFromRow,
  type Catalog,
  type ExerciseRow,
  type ModuleRow,
} from "@/lib/catalog";
import { getSupabase } from "@/lib/supabase";
import { useLoader } from "@/lib/use-loader";
import { useAuth } from "./AuthProvider";

interface CatalogState {
  catalog: Catalog;
  loading: boolean;
  error: string | null;
  /** Recarrega do banco (usado depois que o professor edita exercícios). */
  reload: () => Promise<void>;
}

const CatalogContext = createContext<CatalogState | null>(null);

export function useCatalog(): CatalogState {
  const ctx = useContext(CatalogContext);
  if (!ctx) throw new Error("useCatalog fora do CatalogProvider");
  return ctx;
}

async function fetchCatalog(): Promise<Catalog> {
  const supabase = getSupabase();
  const [m, e] = await Promise.all([
    supabase.from("modules").select(MODULE_COLUMNS).order("position"),
    supabase.from("exercises").select(EXERCISE_COLUMNS).order("position"),
  ]);
  if (m.error || e.error) throw new Error((m.error ?? e.error)!.message);
  return {
    modules: (m.data as ModuleRow[]).map(moduleFromRow),
    exercises: (e.data as ExerciseRow[]).map(exerciseFromRow),
  };
}

export default function CatalogProvider({
  children,
}: {
  children: React.ReactNode;
}) {
  const { profile } = useAuth();
  const userId = profile?.id ?? "";
  const load = useCallback(
    () => (userId ? fetchCatalog() : Promise.resolve(EMPTY_CATALOG)),
    [userId],
  );
  const { data, error, loading, refresh } = useLoader(
    `catalog:${userId}`,
    load,
  );

  const value = useMemo(
    () => ({ catalog: data ?? EMPTY_CATALOG, loading, error, reload: refresh }),
    [data, loading, error, refresh],
  );
  return (
    <CatalogContext.Provider value={value}>{children}</CatalogContext.Provider>
  );
}

/** Mostra carregando/erro enquanto o catálogo não está pronto; depois renderiza os filhos. */
export function CatalogGate({ children }: { children: React.ReactNode }) {
  const { loading, error } = useCatalog();
  if (error) {
    return (
      <p
        role="alert"
        className="rounded-lg bg-red-50 p-3 text-sm text-red-800 dark:bg-red-950 dark:text-red-200"
      >
        Não foi possível carregar os exercícios: {error}
      </p>
    );
  }
  if (loading) {
    return (
      <p role="status" className="text-zinc-500">
        Carregando...
      </p>
    );
  }
  return <>{children}</>;
}

"use client";

import { useSyncExternalStore } from "react";
import { THEME_KEY, type Theme } from "@/lib/theme";

const listeners = new Set<() => void>();
const current = (): Theme =>
  document.documentElement.classList.contains("dark") ? "escuro" : "claro";

/** Alternância visível entre tema claro e escuro (a escolha fica salva neste navegador). */
export default function ThemeToggle() {
  const theme = useSyncExternalStore(
    (cb) => {
      listeners.add(cb);
      return () => listeners.delete(cb);
    },
    current,
    () => "escuro" as Theme,
  );
  const dark = theme === "escuro";
  function toggle() {
    const next: Theme = dark ? "claro" : "escuro";
    document.documentElement.classList.toggle("dark", next === "escuro");
    try {
      localStorage.setItem(THEME_KEY, next);
    } catch {
      /* sem armazenamento: vale até recarregar */
    }
    listeners.forEach((l) => l());
  }
  return (
    <button
      type="button"
      onClick={toggle}
      aria-pressed={dark}
      aria-label="Tema escuro"
      title={dark ? "Mudar para o tema claro" : "Mudar para o tema escuro"}
      className="rounded-lg px-2.5 py-1.5 text-zinc-600 hover:bg-zinc-100 dark:text-zinc-400 dark:hover:bg-zinc-800"
    >
      <span aria-hidden>{dark ? "🌙" : "☀️"}</span>
    </button>
  );
}

"use client";

import { useSyncExternalStore } from "react";

const QUERY = "(min-width: 640px)";

/** true em telas a partir de 640px (computador/tablet). No servidor assume tela larga. */
export function useWideScreen(): boolean {
  return useSyncExternalStore(
    (cb) => {
      const mq = window.matchMedia(QUERY);
      mq.addEventListener("change", cb);
      return () => mq.removeEventListener("change", cb);
    },
    () => window.matchMedia(QUERY).matches,
    () => true,
  );
}

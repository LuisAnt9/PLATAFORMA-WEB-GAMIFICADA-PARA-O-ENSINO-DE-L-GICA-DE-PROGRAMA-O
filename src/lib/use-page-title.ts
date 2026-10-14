"use client";

import { useEffect } from "react";

const SITE = "Lógica Gamificada";

/** Título da aba por página ("Ranking · Lógica Gamificada"): ajuda a orientar quem usa leitor de tela e várias abas. */
export function usePageTitle(title: string | null | undefined) {
  useEffect(() => {
    document.title = title ? `${title} · ${SITE}` : SITE;
  }, [title]);
}

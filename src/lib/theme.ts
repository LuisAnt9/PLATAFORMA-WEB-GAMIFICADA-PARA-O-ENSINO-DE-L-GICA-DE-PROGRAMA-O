export type Theme = "claro" | "escuro";

export const THEME_KEY = "logica-gamificada:tema";

/**
 * Decide o tema inicial: escolha salva do aluno; senão a preferência do sistema (claro ou escuro);
 * senão (sistema sem preferência) escuro, o padrão da plataforma.
 */
export function resolveTheme(
  saved: string | null,
  systemLight: boolean,
  systemDark: boolean,
): Theme {
  if (saved === "claro" || saved === "escuro") return saved;
  if (systemDark) return "escuro";
  if (systemLight) return "claro";
  return "escuro";
}

/** Script que roda antes da primeira pintura, para a página não piscar no tema errado. */
export const THEME_SCRIPT = `(function(){try{var s=null;try{s=localStorage.getItem(${JSON.stringify(THEME_KEY)})}catch(e){}var l=matchMedia("(prefers-color-scheme: light)").matches,d=matchMedia("(prefers-color-scheme: dark)").matches;var t=(s==="claro"||s==="escuro")?s:d?"escuro":l?"claro":"escuro";if(t==="escuro")document.documentElement.classList.add("dark")}catch(e){document.documentElement.classList.add("dark")}})();`;

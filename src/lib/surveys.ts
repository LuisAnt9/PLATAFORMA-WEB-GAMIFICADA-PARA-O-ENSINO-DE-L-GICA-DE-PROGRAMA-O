// Questionários da avaliação do TCC: SUS (usabilidade) e escala Likert (experiência de aprendizagem).
// A pontuação SUS existe em SQL (função sus_score) e aqui; um teste confere que dão o mesmo resultado.

export type SurveyKind = "sus" | "likert";

export const SUS_ITEMS = [
  "Acho que gostaria de usar este sistema com frequência.",
  "Achei o sistema desnecessariamente complexo.",
  "Achei o sistema fácil de usar.",
  "Acho que precisaria de ajuda de uma pessoa com conhecimentos técnicos para usar o sistema.",
  "Achei que as várias funções do sistema estão bem integradas.",
  "Achei que o sistema apresenta muita inconsistência.",
  "Imagino que as pessoas aprenderão a usar este sistema rapidamente.",
  "Achei o sistema atrapalhado de usar.",
  "Senti-me confiante ao usar o sistema.",
  "Precisei aprender várias coisas novas antes de conseguir usar o sistema.",
];

export const LIKERT_ITEMS = [
  "A plataforma me ajudou a entender melhor a lógica de programação.",
  "Os exercícios me ajudaram a perceber os meus erros.",
  "As explicações e os exemplos das lições eram claros.",
  "Os recursos de jogo (XP, medalhas e missões) me motivaram a estudar.",
  "As dicas me ajudaram a continuar quando fiquei travado(a).",
  "Sinto-me mais confiante para resolver problemas com programação.",
  "O ritmo das lições (liberadas em ordem) foi adequado para mim.",
  "Eu recomendaria esta plataforma a outros estudantes.",
];

export const SCALE_LABELS = [
  "Discordo totalmente",
  "Discordo",
  "Nem concordo nem discordo",
  "Concordo",
  "Concordo totalmente",
];

export const ITEMS: Record<SurveyKind, string[]> = {
  sus: SUS_ITEMS,
  likert: LIKERT_ITEMS,
};

/**
 * Pontuação SUS de 0 a 100: nos itens ímpares conta (resposta - 1); nos pares, (5 - resposta);
 * a soma é multiplicada por 2,5. As 10 respostas vão de 1 a 5, na ordem das afirmações.
 */
export function susScore(answers: number[]): number {
  if (answers.length !== 10 || answers.some((a) => !Number.isInteger(a) || a < 1 || a > 5))
    throw new Error("O SUS precisa de 10 respostas de 1 a 5.");
  const sum = answers.reduce((n, a, i) => n + (i % 2 === 0 ? a - 1 : 5 - a), 0);
  return Math.round(sum * 2.5 * 10) / 10;
}

/** Faixa de leitura da pontuação SUS (referência usada com frequência na literatura). */
export function susBand(score: number): string {
  if (score >= 85) return "excelente";
  if (score >= 73) return "boa";
  if (score >= 68) return "aceitável (acima da média de 68)";
  if (score >= 51) return "abaixo da média";
  return "ruim";
}

/** Média de uma escala Likert (1 a 5). */
export function likertMean(answers: number[]): number {
  return answers.reduce((n, a) => n + a, 0) / answers.length;
}

import type { ExerciseConfig } from "./catalog";

/** Remove espaços nas pontas e reduz sequências de espaços a um só (a comparação é sensível a maiúsculas, como em código). */
export function normalizeAnswer(text: string): string {
  return text.trim().replace(/\s+/g, " ");
}

export interface ChoiceView {
  options: string[];
  correct: number;
}

/** Lê a configuração de múltipla escolha com cuidado; devolve null se estiver malformada. */
export function choiceView(c: ExerciseConfig): ChoiceView | null {
  const { options, correct } = c;
  if (
    !Array.isArray(options) ||
    options.length < 2 ||
    !options.every((o) => typeof o === "string")
  )
    return null;
  if (
    typeof correct !== "number" ||
    !Number.isInteger(correct) ||
    correct < 0 ||
    correct >= options.length
  )
    return null;
  return { options, correct };
}

export function gradeChoice(
  c: ExerciseConfig,
  selected: number | null,
): boolean {
  const v = choiceView(c);
  return v !== null && selected !== null && selected === v.correct;
}

export type TemplatePart =
  | { type: "text"; text: string }
  | { type: "blank"; index: number };

const PLACEHOLDER = /\{\{(\d+)\}\}/g;

/** Quebra o modelo em texto e lacunas ({{1}}, {{2}}...). `index` é 0-based. */
export function splitTemplate(template: string): TemplatePart[] {
  const parts: TemplatePart[] = [];
  let last = 0;
  for (const m of template.matchAll(PLACEHOLDER)) {
    if (m.index > last)
      parts.push({ type: "text", text: template.slice(last, m.index) });
    parts.push({ type: "blank", index: Number(m[1]) - 1 });
    last = m.index + m[0].length;
  }
  if (last < template.length)
    parts.push({ type: "text", text: template.slice(last) });
  return parts;
}

/** Números das lacunas na ordem em que aparecem no modelo (1-based). */
export function placeholderNumbers(template: string): number[] {
  return [...template.matchAll(PLACEHOLDER)].map((m) => Number(m[1]));
}

export interface BlankView {
  template: string;
  blanks: { answers: string[] }[];
}

export function blankView(c: ExerciseConfig): BlankView | null {
  const { template, blanks } = c;
  if (
    typeof template !== "string" ||
    !Array.isArray(blanks) ||
    blanks.length === 0
  )
    return null;
  for (const b of blanks) {
    if (
      !b ||
      !Array.isArray(b.answers) ||
      b.answers.length === 0 ||
      !b.answers.every((a) => typeof a === "string")
    )
      return null;
  }
  // todas as lacunas do modelo precisam ter gabarito
  const nums = placeholderNumbers(template);
  if (nums.length === 0 || nums.some((n) => n < 1 || n > blanks.length))
    return null;
  return { template, blanks };
}

export interface BlankResult {
  passed: boolean;
  /** Uma entrada por lacuna do gabarito. */
  correct: boolean[];
}

export function gradeBlanks(c: ExerciseConfig, answers: string[]): BlankResult {
  const v = blankView(c);
  if (!v) return { passed: false, correct: [] };
  const correct = v.blanks.map((b, i) => {
    const given = normalizeAnswer(answers[i] ?? "");
    return given !== "" && b.answers.some((a) => normalizeAnswer(a) === given);
  });
  return { passed: correct.every(Boolean), correct };
}

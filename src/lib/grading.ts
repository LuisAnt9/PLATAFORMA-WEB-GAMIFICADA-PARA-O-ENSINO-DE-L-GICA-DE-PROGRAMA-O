import type { ChoiceOption, ExerciseConfig } from "./catalog";

/** Remove espaços nas pontas e reduz sequências de espaços a um só (a comparação é sensível a maiúsculas, como em código). */
export function normalizeAnswer(text: string): string {
  return text.trim().replace(/\s+/g, " ");
}

/** Texto de uma alternativa, no formato simples ou no com confusão. */
export function optionText(o: ChoiceOption): string {
  return typeof o === "string" ? o : o.text;
}

/** Confusão que a alternativa revela (nula se não houver). */
export function optionMisconception(o: ChoiceOption): string | null {
  return typeof o === "string" ? null : o.misconception?.trim() || null;
}

function validOption(o: unknown): o is ChoiceOption {
  if (typeof o === "string") return true;
  if (typeof o !== "object" || o === null) return false;
  const { text, misconception } = o as Record<string, unknown>;
  return (
    typeof text === "string" &&
    (misconception === undefined || typeof misconception === "string")
  );
}

export interface ChoiceView {
  options: string[];
  /** Confusão de cada alternativa (nula quando não marcada). */
  misconceptions: (string | null)[];
  correct: number;
}

/** Lê a configuração de múltipla escolha com cuidado; devolve null se estiver malformada. */
export function choiceView(c: ExerciseConfig): ChoiceView | null {
  const { options, correct } = c;
  if (
    !Array.isArray(options) ||
    options.length < 2 ||
    !options.every(validOption)
  )
    return null;
  if (
    typeof correct !== "number" ||
    !Number.isInteger(correct) ||
    correct < 0 ||
    correct >= options.length
  )
    return null;
  return {
    options: options.map(optionText),
    misconceptions: options.map(optionMisconception),
    correct,
  };
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

// ---------------------------------------------------------------------------------------------
// Interpretação de código e ordenação
// ---------------------------------------------------------------------------------------------

/** Trecho de código de um exercício de interpretação (null se ausente ou vazio). */
export function interpretationCode(c: ExerciseConfig): string | null {
  return typeof c.code === "string" && c.code.trim() !== "" ? c.code : null;
}

export interface OrderView {
  /** Passos na ordem correta (nunca mostrar assim ao aluno: use shuffledOrder). */
  items: string[];
}

/** Lê a configuração de ordenação com cuidado; null se malformada. */
export function orderView(c: ExerciseConfig): OrderView | null {
  const { items } = c;
  if (
    !Array.isArray(items) ||
    items.length < 2 ||
    items.length > 10 ||
    !items.every((i) => typeof i === "string" && i.trim() !== "") ||
    new Set(items.map((i) => i.trim())).size !== items.length
  )
    return null;
  return { items };
}

/** A resposta do aluno está certa quando a lista tem os mesmos passos, na mesma ordem. */
export function gradeOrder(c: ExerciseConfig, arrangement: string[]): boolean {
  const v = orderView(c);
  return (
    v !== null &&
    arrangement.length === v.items.length &&
    arrangement.every((x, i) => x === v.items[i])
  );
}

function hash(text: string): number {
  let h = 2166136261;
  for (let i = 0; i < text.length; i++) {
    h ^= text.charCodeAt(i);
    h = Math.imul(h, 16777619);
  }
  return h >>> 0;
}

/**
 * Embaralha os passos de um jeito estável (o mesmo exercício sempre abre na mesma ordem) e
 * garante que a ordem inicial nunca seja a correta.
 */
export function shuffledOrder(items: string[], seed: string): string[] {
  if (items.length < 2) return [...items];
  for (let attempt = 0; attempt < 20; attempt++) {
    let state = hash(`${seed}:${attempt}`) || 1;
    const next = () => {
      state = (Math.imul(state, 1664525) + 1013904223) >>> 0;
      return state / 2 ** 32;
    };
    const out = [...items];
    for (let i = out.length - 1; i > 0; i--) {
      const j = Math.floor(next() * (i + 1));
      [out[i], out[j]] = [out[j], out[i]];
    }
    if (out.some((x, i) => x !== items[i])) return out;
  }
  return [...items.slice(1), items[0]];
}

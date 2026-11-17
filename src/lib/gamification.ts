import { conceptPerformance } from "./student";
import {
  baseXp,
  type Catalog,
  type Difficulty,
  type ExerciseKind,
} from "./catalog";

export interface ExerciseProgress {
  attempts: number;
  solved: boolean;
  /** Acertou na primeira tentativa. */
  firstTry: boolean;
  xp: number;
}

export type Progress = Record<string, ExerciseProgress>;

/** Tudo de que uma medalha pode depender. */
export interface BadgeContext {
  progress: Progress;
  catalog: Catalog;
  /** Maior sequência de dias seguidos já alcançada. */
  bestStreak: number;
  /** Mundos concluídos (os que já renderam o bônus no banco). */
  worldsDone?: string[];
}

export interface Badge {
  id: string;
  name: string;
  description: string;
  /** Dificuldade de aprendizagem à qual a medalha responde (não é só estética). */
  purpose: string;
  earned: (ctx: BadgeContext) => boolean;
}

const solvedIn = (p: Progress, ids: string[]) =>
  ids.length > 0 && ids.every((id) => p[id]?.solved);

const FIXED_BADGES: Badge[] = [
  {
    id: "primeiro-passo",
    name: "Primeiro passo",
    description: "Resolva seu primeiro exercício.",
    purpose: "Reduzir a barreira de início.",
    earned: ({ progress: p }) => Object.values(p).some((e) => e.solved),
  },
  {
    id: "persistente",
    name: "Persistente",
    description: "Acerte um exercício depois de errar 3 ou mais vezes.",
    purpose:
      "Tratar o erro como parte do aprendizado, não como motivo de desistência.",
    earned: ({ progress: p }) =>
      Object.values(p).some((e) => e.solved && e.attempts >= 4),
  },
  {
    id: "de-primeira",
    name: "De primeira",
    description: "Acerte 3 exercícios na primeira tentativa.",
    purpose: "Reconhecer a evolução do raciocínio lógico.",
    earned: ({ progress: p }) =>
      Object.values(p).filter((e) => e.solved && e.firstTry).length >= 3,
  },
  {
    id: "constancia-3",
    name: "Constância",
    description: "Pratique 3 dias seguidos.",
    purpose:
      "Criar o hábito de estudar um pouco todo dia, em vez de acumular tudo antes da prova.",
    earned: ({ bestStreak }) => bestStreak >= 3,
  },
  {
    id: "constancia-7",
    name: "Uma semana inteira",
    description: "Pratique 7 dias seguidos.",
    purpose:
      "Consolidar a rotina de estudo, que sustenta a evolução em programação.",
    earned: ({ bestStreak }) => bestStreak >= 7,
  },
];

/** Nome da medalha de cada mundo (equivalentes para introdução, operadores, vetores e funções). */
const WORLD_BADGES: Record<string, { name: string; topic: string }> = {
  "mundo-1": { name: "Pensador lógico", topic: "a introdução à lógica" },
  "mundo-2": { name: "Mestre das variáveis", topic: "variáveis e tipos de dados" },
  "mundo-3": { name: "Calculista dos operadores", topic: "os operadores" },
  "mundo-4": { name: "Decisões inteligentes", topic: "as estruturas condicionais" },
  "mundo-5": { name: "Mestre dos ciclos", topic: "as estruturas de repetição" },
  "mundo-6": { name: "Organizador de dados", topic: "vetores e matrizes" },
  "mundo-7": { name: "Arquiteto de funções", topic: "funções e modularização" },
};

/**
 * Conceitos "superados": o aluno precisou de 3 ou mais tentativas em algum exercício do conceito
 * e hoje está em bom caminho nele (regra D8: mínimos de tentativas já cumpridos).
 */
function overcameConcept({ progress: p, catalog: c }: BadgeContext): boolean {
  const struggled = new Set(
    (c.links ?? [])
      .filter((l) => {
        const e = p[l.exerciseId];
        return e?.solved && e.attempts >= 3;
      })
      .map((l) => l.conceptId),
  );
  if (struggled.size === 0) return false;
  return conceptPerformance(c, p).some(
    (x) => x.level === "em-bom-caminho" && struggled.has(x.conceptId),
  );
}

/** Medalhas fixas + uma por mundo + a de todos os mundos (dependem do catálogo atual). */
export function badgesFor(c: Catalog): Badge[] {
  const published = c.exercises.filter((e) => e.published);
  return [
    ...FIXED_BADGES,
    {
      id: "superacao",
      name: "Superação",
      description:
        "Domine um conceito em que você teve dificuldade (3 ou mais tentativas em um exercício).",
      purpose:
        "Valorizar a evolução depois do erro, que é onde a aprendizagem acontece.",
      earned: overcameConcept,
    },
    {
      id: "primeiro-mundo",
      name: "Primeiro mundo concluído",
      description: "Conclua o seu primeiro mundo.",
      purpose: "Marcar o fechamento de um ciclo de estudo completo.",
      earned: ({ worldsDone }) => (worldsDone ?? []).length >= 1,
    },
    ...[...(c.worlds ?? [])]
      .sort((a, b) => a.position - b.position)
      .map<Badge>((w) => {
        const info = WORLD_BADGES[w.id];
        return {
          id: `mundo-${w.id}`,
          name: info?.name ?? `Mundo concluído: ${w.title}`,
          description: `Conclua o mundo "${w.title}"${info ? ` e domine ${info.topic}` : ""}.`,
          purpose: w.objective || w.title,
          earned: ({ worldsDone }) => (worldsDone ?? []).includes(w.id),
        };
      }),
    {
      id: "trilha-completa",
      name: "Todos os exercícios",
      description: "Resolva todos os exercícios publicados.",
      purpose: "Marcar a conclusão de todo o conteúdo disponível.",
      earned: ({ progress: p }) =>
        solvedIn(
          p,
          published.map((e) => e.id),
        ),
    },
  ];
}

/**
 * XP ganho ao resolver: bônus de 50% para acerto na primeira tentativa. É a mesma conta do banco
 * (o valor que vale é o gravado pelo servidor); aqui serve para mostrar o ganho na hora.
 */
export function xpFor(
  difficulty: Difficulty,
  attempts: number,
  kind?: ExerciseKind,
): number {
  const base = baseXp({ difficulty, kind });
  return attempts <= 1 ? Math.round(base * 1.5) : base;
}

export function totalXp(p: Progress): number {
  return Object.values(p).reduce((sum, e) => sum + (e.solved ? e.xp : 0), 0);
}

/** Nível 1 com 0 XP; cada nível exige mais XP (limiar = 25 * (n-1)^2). */
export function levelInfo(xp: number) {
  let level = 1;
  while (xp >= 25 * level * level) level++;
  const floor = 25 * (level - 1) * (level - 1);
  const next = 25 * level * level;
  return { level, floor, next, progress: (xp - floor) / (next - floor) };
}

export function earnedBadges(ctx: BadgeContext): Badge[] {
  return badgesFor(ctx.catalog).filter((b) => b.earned(ctx));
}

/** Registra o resultado de uma tentativa, devolvendo o novo progresso. */
export function recordAttempt(
  p: Progress,
  exercise: { id: string; difficulty: Difficulty; kind?: ExerciseKind },
  passed: boolean,
): Progress {
  const prev = p[exercise.id] ?? {
    attempts: 0,
    solved: false,
    firstTry: false,
    xp: 0,
  };
  if (prev.solved) return p; // já resolvido: não altera XP
  const attempts = prev.attempts + 1;
  return {
    ...p,
    [exercise.id]: passed
      ? {
          attempts,
          solved: true,
          firstTry: attempts === 1,
          xp: xpFor(exercise.difficulty, attempts, exercise.kind),
        }
      : { ...prev, attempts },
  };
}

export interface Stats {
  solved: number;
  total: number;
  attempts: number;
  firstTryRate: number; // 0..1, sobre os exercícios resolvidos
  xp: number;
}

export function statsOf(p: Progress, c: Catalog): Stats {
  const entries = Object.values(p);
  const solvedEntries = entries.filter((e) => e.solved);
  return {
    solved: c.exercises.filter((e) => e.published && p[e.id]?.solved).length,
    total: c.exercises.filter((e) => e.published).length,
    attempts: entries.reduce((n, e) => n + e.attempts, 0),
    firstTryRate: solvedEntries.length
      ? solvedEntries.filter((e) => e.firstTry).length / solvedEntries.length
      : 0,
    xp: totalXp(p),
  };
}

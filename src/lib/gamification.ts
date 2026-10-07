import {
  XP_BY_DIFFICULTY,
  exercisesOf,
  type Catalog,
  type Difficulty,
} from "./catalog";

export interface ExerciseProgress {
  attempts: number;
  solved: boolean;
  /** Acertou na primeira tentativa. */
  firstTry: boolean;
  xp: number;
}

export type Progress = Record<string, ExerciseProgress>;

export interface Badge {
  id: string;
  name: string;
  description: string;
  /** Dificuldade de aprendizagem à qual a medalha responde (não é só estética). */
  purpose: string;
  earned: (p: Progress, c: Catalog) => boolean;
}

const solvedIn = (p: Progress, ids: string[]) =>
  ids.length > 0 && ids.every((id) => p[id]?.solved);

const FIXED_BADGES: Badge[] = [
  {
    id: "primeiro-passo",
    name: "Primeiro passo",
    description: "Resolva seu primeiro exercício.",
    purpose: "Reduzir a barreira de início.",
    earned: (p) => Object.values(p).some((e) => e.solved),
  },
  {
    id: "persistente",
    name: "Persistente",
    description: "Acerte um exercício depois de errar 3 ou mais vezes.",
    purpose:
      "Tratar o erro como parte do aprendizado, não como motivo de desistência.",
    earned: (p) => Object.values(p).some((e) => e.solved && e.attempts >= 4),
  },
  {
    id: "de-primeira",
    name: "De primeira",
    description: "Acerte 3 exercícios na primeira tentativa.",
    purpose: "Reconhecer a evolução do raciocínio lógico.",
    earned: (p) =>
      Object.values(p).filter((e) => e.solved && e.firstTry).length >= 3,
  },
];

/** Medalhas fixas + uma por módulo + a da trilha completa (dependem do catálogo atual). */
export function badgesFor(c: Catalog): Badge[] {
  const published = c.exercises.filter((e) => e.published);
  return [
    ...FIXED_BADGES,
    ...[...c.modules]
      .sort((a, b) => a.position - b.position)
      .map<Badge>((m) => ({
        id: `modulo-${m.id}`,
        name: `Módulo: ${m.title}`,
        description: `Conclua todos os exercícios de ${m.title}.`,
        purpose: m.focus,
        earned: (p, cat) =>
          solvedIn(
            p,
            exercisesOf(cat, m.id)
              .filter((e) => e.published)
              .map((e) => e.id),
          ),
      })),
    {
      id: "trilha-completa",
      name: "Trilha completa",
      description: "Resolva todos os exercícios.",
      purpose: "Marcar a conclusão da trilha.",
      earned: (p) =>
        solvedIn(
          p,
          published.map((e) => e.id),
        ),
    },
  ];
}

/** XP ganho ao resolver: bônus de 50% para acerto na primeira tentativa. */
export function xpFor(difficulty: Difficulty, attempts: number): number {
  const base = XP_BY_DIFFICULTY[difficulty];
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

export function earnedBadges(p: Progress, c: Catalog): Badge[] {
  return badgesFor(c).filter((b) => b.earned(p, c));
}

/** Registra o resultado de uma tentativa, devolvendo o novo progresso. */
export function recordAttempt(
  p: Progress,
  exercise: { id: string; difficulty: Difficulty },
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
          xp: xpFor(exercise.difficulty, attempts),
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

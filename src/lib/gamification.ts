import { exercises, exercisesOf, modules, XP_BY_DIFFICULTY } from "./exercises";

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
  earned: (p: Progress) => boolean;
}

const solvedCount = (p: Progress) =>
  Object.values(p).filter((e) => e.solved).length;

export const badges: Badge[] = [
  {
    id: "primeiro-passo",
    name: "Primeiro passo",
    description: "Resolva seu primeiro exercício.",
    purpose: "Reduzir a barreira de início.",
    earned: (p) => solvedCount(p) >= 1,
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
  ...modules.map<Badge>((m) => ({
    id: `modulo-${m.id}`,
    name: `Módulo: ${m.title}`,
    description: `Conclua todos os exercícios de ${m.title}.`,
    purpose: m.focus,
    earned: (p) => exercisesOf(m.id).every((e) => p[e.id]?.solved),
  })),
  {
    id: "trilha-completa",
    name: "Trilha completa",
    description: "Resolva todos os exercícios.",
    purpose: "Marcar a conclusão da trilha.",
    earned: (p) => exercises.every((e) => p[e.id]?.solved),
  },
];

/** XP ganho ao resolver: bônus de 50% para acerto na primeira tentativa. */
export function xpFor(exerciseId: string, attempts: number): number {
  const ex = exercises.find((e) => e.id === exerciseId);
  if (!ex) return 0;
  const base = XP_BY_DIFFICULTY[ex.difficulty];
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

export function earnedBadges(p: Progress): Badge[] {
  return badges.filter((b) => b.earned(p));
}

/** Registra o resultado de uma tentativa, devolvendo o novo progresso. */
export function recordAttempt(
  p: Progress,
  exerciseId: string,
  passed: boolean,
): Progress {
  const prev = p[exerciseId] ?? {
    attempts: 0,
    solved: false,
    firstTry: false,
    xp: 0,
  };
  if (prev.solved) return p; // já resolvido: não altera XP
  const attempts = prev.attempts + 1;
  return {
    ...p,
    [exerciseId]: passed
      ? {
          attempts,
          solved: true,
          firstTry: attempts === 1,
          xp: xpFor(exerciseId, attempts),
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

export function statsOf(p: Progress): Stats {
  const entries = Object.values(p);
  const solvedEntries = entries.filter((e) => e.solved);
  return {
    solved: solvedEntries.length,
    total: exercises.length,
    attempts: entries.reduce((n, e) => n + e.attempts, 0),
    firstTryRate: solvedEntries.length
      ? solvedEntries.filter((e) => e.firstTry).length / solvedEntries.length
      : 0,
    xp: totalXp(p),
  };
}

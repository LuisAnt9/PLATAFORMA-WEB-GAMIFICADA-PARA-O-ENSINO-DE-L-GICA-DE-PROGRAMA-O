import { describe, expect, it } from "vitest";
import type { Catalog, Exercise } from "./catalog";
import {
  badgesFor,
  earnedBadges,
  levelInfo,
  recordAttempt,
  statsOf,
  totalXp,
  xpFor,
  type Progress,
} from "./gamification";

const ex = (
  id: string,
  moduleId: string,
  difficulty: Exercise["difficulty"] = "facil",
  published = true,
): Exercise => ({
  id,
  kind: "code",
  lesson: null,
  config: {},
  moduleId,
  title: id,
  difficulty,
  statement: "",
  functionName: id,
  starterCode: "",
  tests: [],
  hint: "",
  position: 1,
  published,
});

const catalog: Catalog = {
  modules: [
    {
      id: "m1",
      title: "Um",
      focus: "foco um",
      intro: "",
      optional: false,
      worldId: null,
      example: "",
      review: "",
      position: 1,
    },
    {
      id: "m2",
      title: "Dois",
      focus: "foco dois",
      intro: "",
      optional: false,
      worldId: null,
      example: "",
      review: "",
      position: 2,
    },
  ],
  exercises: [
    ex("a", "m1"),
    ex("b", "m1", "medio"),
    ex("c", "m2", "dificil"),
    ex("rascunho", "m2", "facil", false),
  ],
};
const A = catalog.exercises[0];
const B = catalog.exercises[1];
const C = catalog.exercises[2];

describe("xpFor", () => {
  it("dá bônus de 50% para acerto na primeira tentativa", () => {
    expect(xpFor("facil", 1)).toBe(30);
    expect(xpFor("facil", 2)).toBe(20);
    expect(xpFor("dificil", 1)).toBe(75);
  });
  it("tabela da D4: 20, 35, 50 e 75 para o desafio, sem bônus depois da 1ª tentativa", () => {
    expect([xpFor("facil", 2), xpFor("medio", 2), xpFor("dificil", 2)]).toEqual([20, 35, 50]);
    expect(xpFor("dificil", 2, "challenge")).toBe(75);
    expect(xpFor("dificil", 1, "challenge")).toBe(113);
    expect(xpFor("facil", 1, "choice")).toBe(30);
  });
});

describe("levelInfo", () => {
  it("começa no nível 1 com 0 XP", () => {
    expect(levelInfo(0)).toMatchObject({ level: 1, floor: 0, next: 25 });
  });
  it("sobe de nível nos limiares", () => {
    expect(levelInfo(24).level).toBe(1);
    expect(levelInfo(25).level).toBe(2);
    expect(levelInfo(100).level).toBe(3);
  });
  it("progresso fica entre 0 e 1", () => {
    for (const xp of [0, 10, 25, 60, 99, 500]) {
      const { progress } = levelInfo(xp);
      expect(progress).toBeGreaterThanOrEqual(0);
      expect(progress).toBeLessThan(1);
    }
  });
});

describe("recordAttempt", () => {
  it("conta tentativas erradas sem dar XP", () => {
    const p = recordAttempt({}, A, false);
    expect(p.a).toMatchObject({ attempts: 1, solved: false, xp: 0 });
    expect(totalXp(p)).toBe(0);
  });
  it("marca acerto de primeira", () => {
    expect(recordAttempt({}, A, true).a).toMatchObject({
      solved: true,
      firstTry: true,
      xp: 30,
    });
  });
  it("acerto após erros dá XP sem bônus, conforme a dificuldade", () => {
    let p: Progress = recordAttempt({}, B, false);
    p = recordAttempt(p, B, true);
    expect(p.b).toMatchObject({ attempts: 2, firstTry: false, xp: 35 });
  });
  it("não altera exercício já resolvido (sem XP duplicado)", () => {
    const solved = recordAttempt({}, A, true);
    expect(recordAttempt(solved, A, true)).toBe(solved);
  });
});

describe("medalhas", () => {
  it("ids únicos e propósito pedagógico declarado", () => {
    const list = badgesFor(catalog);
    expect(new Set(list.map((b) => b.id)).size).toBe(list.length);
    for (const b of list) expect(b.purpose.length).toBeGreaterThan(5);
  });
  it("medalhas fixas, superação, primeiro mundo, uma por mundo e a de todos os exercícios", () => {
    expect(badgesFor(catalog)).toHaveLength(5 + 1 + 1 + 0 + 1); // fixas + superação + primeiro mundo + trilha
    const comMundos = badgesFor({
      ...catalog,
      worlds: [
        { id: "mundo-2", title: "Variáveis", objective: "", position: 2 },
        { id: "mundo-4", title: "Condicionais", objective: "", position: 4 },
        { id: "outro", title: "Outro", objective: "", position: 9 },
      ],
    });
    const nomes = comMundos.map((b) => b.name);
    expect(nomes).toContain("Mestre das variáveis");
    expect(nomes).toContain("Decisões inteligentes");
    expect(nomes).toContain("Mundo concluído: Outro");
  });
  it("persistente exige acerto após 3+ erros", () => {
    let p: Progress = {};
    for (let i = 0; i < 3; i++) p = recordAttempt(p, A, false);
    expect(
      earnedBadges({ progress: p, catalog, bestStreak: 0 }).map((b) => b.id),
    ).not.toContain("persistente");
    p = recordAttempt(p, A, true);
    expect(
      earnedBadges({ progress: p, catalog, bestStreak: 0 }).map((b) => b.id),
    ).toContain("persistente");
  });
  it("medalhas de mundo dependem do bônus de conclusão e a de todos os exercícios ignora rascunhos", () => {
    const c: Catalog = {
      ...catalog,
      worlds: [{ id: "mundo-4", title: "Condicionais", objective: "", position: 4 }],
    };
    const ids = (p: Progress, worldsDone: string[] = []) =>
      earnedBadges({ progress: p, catalog: c, bestStreak: 0, worldsDone }).map((b) => b.id);
    let p: Progress = {};
    for (const e of [A, B]) p = recordAttempt(p, e, true);
    expect(ids(p)).not.toContain("primeiro-mundo");
    expect(ids(p)).not.toContain("trilha-completa");
    expect(ids(p, ["mundo-4"])).toEqual(
      expect.arrayContaining(["primeiro-mundo", "mundo-mundo-4"]),
    );
    p = recordAttempt(p, C, true);
    expect(ids(p)).toContain("trilha-completa"); // o rascunho não conta
  });
  it("superação: dominar um conceito em que precisou de 3+ tentativas", () => {
    const c: Catalog = {
      ...catalog,
      concepts: [{ id: "k", title: "K", description: "", worldId: null }],
      links: ["a", "b"].map((id) => ({ exerciseId: id, conceptId: "k", weight: 1 })),
    };
    let p: Progress = {};
    for (let i = 0; i < 2; i++) p = recordAttempt(p, A, false);
    p = recordAttempt(p, A, true); // 3 tentativas em A
    p = recordAttempt(p, B, true); // 1 tentativa em B: 4 tentativas, 2 exercícios, 100% resolvidos
    const ids = earnedBadges({ progress: p, catalog: c, bestStreak: 0 }).map((b) => b.id);
    expect(ids).toContain("superacao");
    // sem dificuldade (todos de primeira) não há superação
    let q: Progress = {};
    for (const e of [A, B]) q = recordAttempt(q, e, true);
    expect(
      earnedBadges({ progress: q, catalog: c, bestStreak: 0 }).map((b) => b.id),
    ).not.toContain("superacao");
  });
  it("catálogo vazio não concede medalhas de conclusão", () => {
    const ids = earnedBadges({
      progress: {},
      catalog: { modules: [], exercises: [] },
      bestStreak: 0,
    }).map((b) => b.id);
    expect(ids).toEqual([]);
  });
});

describe("medalhas de constância", () => {
  const ids = (bestStreak: number) =>
    earnedBadges({ progress: {}, catalog, bestStreak }).map((b) => b.id);
  it("3 e 7 dias seguidos, usando a MELHOR sequência (não some se quebrar)", () => {
    expect(ids(2)).toEqual([]);
    expect(ids(3)).toEqual(["constancia-3"]);
    expect(ids(7)).toEqual(["constancia-3", "constancia-7"]);
  });
});

describe("statsOf", () => {
  it("zera tudo sem progresso e não conta rascunhos no total", () => {
    expect(statsOf({}, catalog)).toEqual({
      solved: 0,
      total: 3,
      attempts: 0,
      firstTryRate: 0,
      xp: 0,
    });
  });
  it("calcula tentativas, XP e taxa de acerto de primeira", () => {
    let p: Progress = recordAttempt({}, A, true);
    p = recordAttempt(p, B, false);
    p = recordAttempt(p, B, true);
    expect(statsOf(p, catalog)).toMatchObject({
      solved: 2,
      attempts: 3,
      firstTryRate: 0.5,
      xp: 65,
    });
  });
});

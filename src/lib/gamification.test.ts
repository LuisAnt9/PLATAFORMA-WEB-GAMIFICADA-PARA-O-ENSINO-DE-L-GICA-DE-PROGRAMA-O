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
    { id: "m1", title: "Um", focus: "foco um", position: 1 },
    { id: "m2", title: "Dois", focus: "foco dois", position: 2 },
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
    expect(xpFor("facil", 1)).toBe(15);
    expect(xpFor("facil", 2)).toBe(10);
    expect(xpFor("dificil", 1)).toBe(53);
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
      xp: 15,
    });
  });
  it("acerto após erros dá XP sem bônus, conforme a dificuldade", () => {
    let p: Progress = recordAttempt({}, B, false);
    p = recordAttempt(p, B, true);
    expect(p.b).toMatchObject({ attempts: 2, firstTry: false, xp: 20 });
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
  it("uma medalha por módulo, mais as fixas e a da trilha", () => {
    expect(badgesFor(catalog)).toHaveLength(3 + 2 + 1);
  });
  it("persistente exige acerto após 3+ erros", () => {
    let p: Progress = {};
    for (let i = 0; i < 3; i++) p = recordAttempt(p, A, false);
    expect(earnedBadges(p, catalog).map((b) => b.id)).not.toContain(
      "persistente",
    );
    p = recordAttempt(p, A, true);
    expect(earnedBadges(p, catalog).map((b) => b.id)).toContain("persistente");
  });
  it("medalha do módulo e da trilha ignoram rascunhos", () => {
    let p: Progress = {};
    for (const e of [A, B]) p = recordAttempt(p, e, true);
    expect(earnedBadges(p, catalog).map((b) => b.id)).toContain("modulo-m1");
    expect(earnedBadges(p, catalog).map((b) => b.id)).not.toContain(
      "trilha-completa",
    );
    p = recordAttempt(p, C, true);
    const ids = earnedBadges(p, catalog).map((b) => b.id);
    expect(ids).toContain("modulo-m2"); // m2 só tem "c" publicado
    expect(ids).toContain("trilha-completa");
  });
  it("catálogo vazio não concede medalhas de conclusão", () => {
    const ids = earnedBadges({}, { modules: [], exercises: [] }).map(
      (b) => b.id,
    );
    expect(ids).toEqual([]);
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
      xp: 35,
    });
  });
});

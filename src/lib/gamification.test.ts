import { describe, expect, it } from "vitest";
import { exercises } from "./exercises";
import { badges, earnedBadges, levelInfo, recordAttempt, totalXp, xpFor, type Progress } from "./gamification";

describe("xpFor", () => {
  it("dá bônus de 50% para acerto na primeira tentativa", () => {
    expect(xpFor("soma", 1)).toBe(15);
    expect(xpFor("soma", 2)).toBe(10);
  });
  it("retorna 0 para exercício inexistente", () => {
    expect(xpFor("nao-existe", 1)).toBe(0);
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
    const p = recordAttempt({}, "soma", false);
    expect(p.soma).toMatchObject({ attempts: 1, solved: false, xp: 0 });
    expect(totalXp(p)).toBe(0);
  });
  it("marca acerto de primeira", () => {
    const p = recordAttempt({}, "soma", true);
    expect(p.soma).toMatchObject({ solved: true, firstTry: true, xp: 15 });
  });
  it("acerto após erros dá XP sem bônus", () => {
    let p: Progress = recordAttempt({}, "soma", false);
    p = recordAttempt(p, "soma", true);
    expect(p.soma).toMatchObject({ attempts: 2, firstTry: false, xp: 10 });
  });
  it("não altera exercício já resolvido (sem XP duplicado)", () => {
    const solved = recordAttempt({}, "soma", true);
    expect(recordAttempt(solved, "soma", true)).toBe(solved);
  });
});

describe("medalhas", () => {
  it("ids são únicos", () => {
    const ids = badges.map((b) => b.id);
    expect(new Set(ids).size).toBe(ids.length);
  });
  it("toda medalha declara seu propósito pedagógico", () => {
    for (const b of badges) expect(b.purpose.length).toBeGreaterThan(5);
  });
  it("persistente exige acerto após 3+ erros", () => {
    let p: Progress = {};
    for (let i = 0; i < 3; i++) p = recordAttempt(p, "soma", false);
    expect(earnedBadges(p).map((b) => b.id)).not.toContain("persistente");
    p = recordAttempt(p, "soma", true);
    expect(earnedBadges(p).map((b) => b.id)).toContain("persistente");
  });
  it("trilha completa ao resolver todos", () => {
    let p: Progress = {};
    for (const e of exercises) p = recordAttempt(p, e.id, true);
    expect(earnedBadges(p).map((b) => b.id)).toContain("trilha-completa");
  });
});

describe("exercícios", () => {
  it("ids únicos e função declarada no código inicial", () => {
    expect(new Set(exercises.map((e) => e.id)).size).toBe(exercises.length);
    for (const e of exercises) expect(e.starterCode).toContain(`function ${e.functionName}(`);
  });
  it("todo exercício tem ao menos 3 casos de teste", () => {
    for (const e of exercises) expect(e.tests.length).toBeGreaterThanOrEqual(3);
  });
});

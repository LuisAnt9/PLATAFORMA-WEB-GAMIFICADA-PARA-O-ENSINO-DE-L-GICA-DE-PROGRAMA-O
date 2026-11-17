import { describe, expect, it } from "vitest";
import type { Catalog, Exercise, Module } from "./catalog";
import { moduleStates } from "./learning";
import {
  conceptPerformance,
  lessonSteps,
  stepIndex,
  stepOfExercise,
  weeklyActivity,
  worldSummaries,
} from "./student";
import { addDays } from "./streak";

const mod = (id: string, pos: number, o: Partial<Module> = {}): Module => ({
  id,
  title: id,
  focus: "",
  intro: "texto",
  optional: false,
  worldId: "w1",
  example: "",
  review: "",
  position: pos,
  ...o,
});
const ex = (id: string, moduleId: string, kind: Exercise["kind"] = "choice", published = true): Exercise => ({
  id, kind, lesson: null, config: {}, moduleId, title: id, difficulty: "facil",
  statement: "", functionName: "", starterCode: "", tests: [], hint: "", position: 1, published,
});
const cat = (o: Partial<Catalog>): Catalog => ({ modules: [], exercises: [], concepts: [], links: [], worlds: [], ...o });
const states = (c: Catalog, p = {}) => moduleStates(c, p);
const solved = (n = 1) => ({ attempts: n, solved: true, firstTry: n === 1, xp: 10 });

describe("worldSummaries", () => {
  const c = cat({
    worlds: [
      { id: "w1", title: "Um", objective: "", position: 1 },
      { id: "w2", title: "Dois", objective: "", position: 2 },
      { id: "w3", title: "Três", objective: "", position: 3 },
    ],
    modules: [mod("a", 1), mod("b", 2, { worldId: "w2" })],
    exercises: [ex("a1", "a"), ex("a2", "a"), ex("b1", "b"), ex("rascunho", "b", "choice", false)],
  });
  it("sem nada feito: primeiro mundo não iniciado, segundo bloqueado, terceiro em breve", () => {
    const r = worldSummaries(c, {}, states(c), true);
    expect(r.map((w) => w.status)).toEqual(["nao-iniciado", "bloqueado", "em-breve"]);
  });
  it("no modo prática nada fica bloqueado", () => {
    expect(worldSummaries(c, {}, states(c), false)[1].status).toBe("nao-iniciado");
  });
  it("conta só exercícios publicados e marca andamento e conclusão", () => {
    let p = { a1: solved() };
    let r = worldSummaries(c, p, states(c, p), true);
    expect(r[0]).toMatchObject({ total: 2, done: 1, status: "em-andamento" });
    p = { a1: solved(), a2: solved() } as typeof p & { a2: ReturnType<typeof solved> };
    r = worldSummaries(c, p, states(c, p), true);
    expect(r[0].status).toBe("concluido");
    expect(r[1].status).toBe("nao-iniciado"); // liberado
  });
  it("lição complementar não impede o mundo de ficar concluído", () => {
    const c2 = cat({
      worlds: c.worlds,
      modules: [mod("a", 1), mod("opt", 2, { optional: true })],
      exercises: [ex("a1", "a"), ex("o1", "opt")],
    });
    const p = { a1: solved() };
    expect(worldSummaries(c2, p, states(c2, p), true)[0].status).toBe("concluido");
  });
  it("lições de mundo desconhecido entram em 'Outras lições'", () => {
    const c3 = cat({ worlds: [], modules: [mod("x", 1, { worldId: null })], exercises: [ex("x1", "x")] });
    const r = worldSummaries(c3, {}, states(c3), true);
    expect(r).toHaveLength(1);
    expect(r[0].world.title).toBe("Outras lições");
  });
});

describe("passos da lição", () => {
  it("classifica os tipos de exercício", () => {
    expect(stepOfExercise(ex("x", "m", "interpretation"))).toBe("interpretacao");
    expect(stepOfExercise(ex("x", "m", "blank"))).toBe("interpretacao");
    expect(stepOfExercise(ex("x", "m", "order"))).toBe("interpretacao");
    expect(stepOfExercise(ex("x", "m", "code"))).toBe("pratica");
    expect(stepOfExercise(ex("x", "m", "fix"))).toBe("pratica");
    expect(stepOfExercise(ex("x", "m", "challenge"))).toBe("desafio");
  });
  it("lição completa tem os 7 passos, na ordem", () => {
    const m = mod("m", 1, { intro: "i", example: "e", review: "r" });
    const c = cat({ modules: [m], exercises: [ex("1", "m", "interpretation"), ex("2", "m", "code"), ex("3", "m", "challenge")] });
    expect(lessonSteps(c, m).map((s) => s.id)).toEqual([
      "introducao", "explicacao", "exemplo", "interpretacao", "pratica", "desafio", "revisao",
    ]);
  });
  it("lição antiga (só exercícios) esconde os passos vazios", () => {
    const m = mod("m", 1, { intro: "", example: "", review: "" });
    const c = cat({ modules: [m], exercises: [ex("1", "m", "code"), ex("r", "m", "challenge", false)] });
    expect(lessonSteps(c, m).map((s) => s.id)).toEqual(["introducao", "pratica"]);
  });
  it("stepIndex aceita só passos existentes", () => {
    const m = mod("m", 1);
    const steps = lessonSteps(cat({ modules: [m], exercises: [ex("1", "m")] }), m);
    expect(stepIndex(steps, "interpretacao")).toBe(2);
    expect(stepIndex(steps, "desafio")).toBe(0);
    expect(stepIndex(steps, null)).toBe(0);
  });
});

describe("conceptPerformance (regra D8)", () => {
  const c = cat({
    concepts: [{ id: "k", title: "K", description: "", worldId: "w1" }],
    modules: [mod("m", 1)],
    exercises: [ex("e1", "m"), ex("e2", "m"), ex("e3", "m")],
    links: ["e1", "e2", "e3"].map((id) => ({ exerciseId: id, conceptId: "k", weight: 1 })),
  });
  const p = (a: [string, number, boolean][]) =>
    Object.fromEntries(a.map(([id, attempts, s]) => [id, { attempts, solved: s, firstTry: s && attempts === 1, xp: 0 }]));
  it("nada tentado: nada aparece", () => {
    expect(conceptPerformance(c, {})).toEqual([]);
  });
  it("poucas tentativas ou um só exercício: dados insuficientes", () => {
    expect(conceptPerformance(c, p([["e1", 5, false]]))[0].level).toBe("insuficiente");
    expect(conceptPerformance(c, p([["e1", 1, true], ["e2", 1, true]]))[0].level).toBe("insuficiente");
  });
  it("3 tentativas em 2 exercícios, acertando: em bom caminho", () => {
    expect(conceptPerformance(c, p([["e1", 1, true], ["e2", 2, true]]))[0]).toMatchObject({
      level: "em-bom-caminho", exercisesTried: 2, exercisesSolved: 2, attempts: 3,
    });
  });
  it("muitas tentativas ou erros: para praticar", () => {
    expect(conceptPerformance(c, p([["e1", 4, false], ["e2", 3, true]]))[0].level).toBe("praticar");
  });
  it("ignora exercícios em rascunho", () => {
    const c2 = { ...c, exercises: [ex("e1", "m", "choice", false), ex("e2", "m"), ex("e3", "m")] };
    expect(conceptPerformance(c2, p([["e1", 9, false], ["e2", 1, true]]))[0].exercisesTried).toBe(1);
  });
});

describe("weeklyActivity", () => {
  it("conta dias de prática por semana, da mais antiga à mais recente", () => {
    const today = "2026-03-15";
    const r = weeklyActivity(["2026-03-15", "2026-03-14", "2026-03-01"], today, 3, addDays);
    expect(r).toHaveLength(3);
    expect(r[2].count).toBe(2);
    expect(r[0].start < r[2].start).toBe(true);
    expect(r.reduce((n, w) => n + w.count, 0)).toBe(3);
  });
});

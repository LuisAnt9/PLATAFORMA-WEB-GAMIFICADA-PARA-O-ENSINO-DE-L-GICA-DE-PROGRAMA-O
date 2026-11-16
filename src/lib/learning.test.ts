import { describe, expect, it } from "vitest";
import type { Catalog, Exercise } from "./catalog";
import type { Progress } from "./gamification";
import { moduleStates } from "./learning";

const ex = (id: string, moduleId: string, published = true): Exercise => ({
  id,
  kind: "code",
  lesson: null,
  config: {},
  moduleId,
  title: id,
  difficulty: "facil",
  statement: "",
  functionName: "f",
  starterCode: "",
  tests: [],
  hint: "",
  position: 1,
  published,
});
const mod = (id: string, position: number) => ({
  id,
  title: id.toUpperCase(),
  focus: "",
  intro: "",
  optional: false,
  worldId: null,
  example: "",
  review: "",
  position,
});
const solved = (...ids: string[]): Progress =>
  Object.fromEntries(
    ids.map((id) => [
      id,
      { attempts: 1, solved: true, firstTry: true, xp: 10 },
    ]),
  );

const catalog: Catalog = {
  modules: [mod("c", 3), mod("a", 1), mod("b", 2), mod("vazio", 4)],
  exercises: [
    ...["a1", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10"].map((i) =>
      ex(i, "a"),
    ),
    ex("b1", "b"),
    ex("b2", "b"),
    ex("b3-rascunho", "b", false),
    ex("c1", "c"),
  ],
};

describe("moduleStates", () => {
  it("só o primeiro módulo começa liberado, na ordem de position", () => {
    const s = moduleStates(catalog, {});
    expect(s.a.unlocked).toBe(true);
    expect(s.b.unlocked).toBe(false);
    expect(s.b.blockedBy).toEqual({ id: "a", title: "A" });
    expect(s.c.unlocked).toBe(false);
  });
  it("módulo sem exercícios publicados é ignorado", () => {
    expect(moduleStates(catalog, {}).vazio).toBeUndefined();
  });
  it("libera o próximo ao resolver 70% (arredondado para cima)", () => {
    const six = solved("a1", "a2", "a3", "a4", "a5", "a6");
    expect(moduleStates(catalog, six).a.complete).toBe(false);
    expect(moduleStates(catalog, six).b.unlocked).toBe(false);
    const seven = solved("a1", "a2", "a3", "a4", "a5", "a6", "a7");
    const s = moduleStates(catalog, seven);
    expect(s.a).toMatchObject({ needed: 7, done: 7, complete: true });
    expect(s.b.unlocked).toBe(true);
    expect(s.b.blockedBy).toBeNull();
  });
  it("rascunhos não contam como exercício do módulo", () => {
    const s = moduleStates(catalog, solved("b1"));
    expect(s.b.total).toBe(2);
    expect(s.b.needed).toBe(2);
  });
  it("não pula etapa: concluir o módulo 3 sem liberar o 2 não libera o 3", () => {
    const s = moduleStates(catalog, solved("c1"));
    expect(s.c.complete).toBe(true);
    expect(s.c.unlocked).toBe(false);
    // o módulo seguinte ao c não existe, mas b continua bloqueado por a
    expect(s.b.unlocked).toBe(false);
  });
  it("com tudo resolvido, todos ficam liberados", () => {
    const all = solved(...catalog.exercises.map((e) => e.id));
    const s = moduleStates(catalog, all);
    expect(Object.values(s).every((m) => m.unlocked && m.complete)).toBe(true);
  });
});

describe("lições complementares (optional)", () => {
  const cat = (opcional: boolean): Catalog => ({
    modules: [mod("a", 1), { ...mod("b", 2), optional: opcional }, mod("c", 3)],
    exercises: [
      ...["a1", "a2"].map((i) => ex(i, "a")),
      ...["b1", "b2"].map((i) => ex(i, "b")),
      ...["c1", "c2"].map((i) => ex(i, "c")),
    ],
  });
  const feitos = (...ids: string[]): Progress =>
    Object.fromEntries(
      ids.map((id) => [
        id,
        { attempts: 1, solved: true, firstTry: true, xp: 10 },
      ]),
    );

  it("sem ser complementar, a lição do meio trava a seguinte", () => {
    const s = moduleStates(cat(false), feitos("a1", "a2"));
    expect(s.b.unlocked).toBe(true);
    expect(s.c.unlocked).toBe(false);
    expect(s.c.blockedBy).toEqual({ id: "b", title: "B" });
  });
  it("sendo complementar, a seguinte libera sem concluí-la", () => {
    const s = moduleStates(cat(true), feitos("a1", "a2"));
    expect(s.b.unlocked).toBe(true); // a complementar também abre depois da anterior
    expect(s.c.unlocked).toBe(true);
    expect(s.c.blockedBy).toBeNull();
  });
  it("a complementar não libera nada por si só: a seguinte depende da última lição obrigatória", () => {
    const s = moduleStates(cat(true), feitos("b1", "b2"));
    expect(s.b.complete).toBe(true);
    expect(s.c.unlocked).toBe(false);
    expect(s.c.blockedBy).toEqual({ id: "a", title: "A" });
  });
  it("complementar no começo não trava a primeira lição obrigatória", () => {
    const c: Catalog = {
      modules: [{ ...mod("x", 1), optional: true }, mod("y", 2)],
      exercises: [ex("x1", "x"), ex("y1", "y")],
    };
    const s = moduleStates(c, {});
    expect(s.x.unlocked).toBe(true);
    expect(s.y.unlocked).toBe(true);
  });
});

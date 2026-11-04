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

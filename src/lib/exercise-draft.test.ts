import { describe, expect, it } from "vitest";
import type { Exercise } from "./catalog";
import {
  buildStarterCode,
  draftFromExercise,
  emptyDraft,
  formatArgs,
  newExerciseId,
  parseArgs,
  parseExpected,
  slugify,
  validateDraft,
  type Draft,
} from "./exercise-draft";

const valid = (over: Partial<Draft> = {}): Draft => ({
  ...emptyDraft("m1"),
  title: "Soma",
  statement: "Some dois números.",
  functionName: "soma",
  params: "a, b",
  tests: [{ args: "2, 3", expected: "5" }],
  ...over,
});

describe("parseArgs / parseExpected", () => {
  it("lê números, textos, vetores e objetos", () => {
    expect(parseArgs('2, "ab", [1, 2], true')).toEqual({
      ok: true,
      value: [2, "ab", [1, 2], true],
    });
  });
  it("vazio significa função sem argumentos", () => {
    expect(parseArgs("")).toEqual({ ok: true, value: [] });
  });
  it("rejeita texto sem aspas e sintaxe quebrada", () => {
    expect(parseArgs("abc").ok).toBe(false);
    expect(parseArgs("[1, 2").ok).toBe(false);
  });
  it("esperado: exige valor JSON", () => {
    expect(parseExpected("5")).toEqual({ ok: true, value: 5 });
    expect(parseExpected('"par"')).toEqual({ ok: true, value: "par" });
    expect(parseExpected("[]")).toEqual({ ok: true, value: [] });
    expect(parseExpected("").ok).toBe(false);
    expect(parseExpected("par").ok).toBe(false);
  });
});

describe("validateDraft", () => {
  it("aceita um rascunho válido e devolve os testes convertidos", () => {
    const r = validateDraft(valid());
    expect(r.errors).toEqual([]);
    expect(r.tests).toEqual([{ args: [2, 3], expected: 5 }]);
  });
  it("exige título, módulo e enunciado", () => {
    const r = validateDraft(valid({ title: " ", moduleId: "", statement: "" }));
    expect(r.errors.length).toBe(3);
  });
  it("rejeita nome de função perigoso, reservado ou com acento", () => {
    for (const fn of ["f(){}", "a b", "função", "1abc", "return", "x;y"]) {
      expect(
        validateDraft(valid({ functionName: fn })).errors.length,
        fn,
      ).toBeGreaterThan(0);
    }
    expect(validateDraft(valid({ functionName: "_ok$1" })).errors).toEqual([]);
  });
  it("valida parâmetros", () => {
    expect(
      validateDraft(valid({ params: "a, a" })).errors.length,
    ).toBeGreaterThan(0);
    expect(
      validateDraft(valid({ params: "a, 1b" })).errors.length,
    ).toBeGreaterThan(0);
    expect(
      validateDraft(valid({ params: "", tests: [{ args: "", expected: "1" }] }))
        .errors,
    ).toEqual([]);
  });
  it("aponta a linha de teste com problema", () => {
    const r = validateDraft(
      valid({
        tests: [
          { args: "1, 2", expected: "3" },
          { args: "x", expected: "3" },
          { args: "1", expected: "" },
        ],
      }),
    );
    expect(r.testErrors[0]).toBeNull();
    expect(r.testErrors[1]).toContain("JSON");
    expect(r.testErrors[2]).toContain("esperado");
    expect(r.errors.length).toBeGreaterThan(0);
  });
  it("rejeita mais entradas do que parâmetros", () => {
    const r = validateDraft(
      valid({ tests: [{ args: "1, 2, 3", expected: "3" }] }),
    );
    expect(r.testErrors[0]).toContain("parâmetros");
  });
  it("limita a quantidade de testes", () => {
    const many = Array.from({ length: 31 }, () => ({
      args: "1, 2",
      expected: "3",
    }));
    expect(validateDraft(valid({ tests: many })).errors.length).toBeGreaterThan(
      0,
    );
    expect(validateDraft(valid({ tests: [] })).errors.length).toBeGreaterThan(
      0,
    );
  });
});

describe("draftFromExercise <-> buildStarterCode", () => {
  const e: Exercise = {
    id: "soma",
    moduleId: "m1",
    title: "Somar",
    difficulty: "medio",
    statement: "s",
    functionName: "soma",
    starterCode: "function soma(a, b) {\n  // seu código aqui\n}\n",
    tests: [{ args: [2, [1, "x"]], expected: { ok: true } }],
    hint: "h",
    position: 1,
    published: true,
  };
  it("recupera parâmetros e formata os testes de volta em texto", () => {
    const d = draftFromExercise(e);
    expect(d.params).toBe("a, b");
    expect(d.tests[0]).toEqual({ args: '2, [1,"x"]', expected: '{"ok":true}' });
    expect(validateDraft(d).tests).toEqual(e.tests);
  });
  it("gera o mesmo código inicial dos exercícios originais", () => {
    expect(buildStarterCode("soma", " a ,b ")).toBe(e.starterCode);
    expect(buildStarterCode("f", "")).toBe(
      "function f() {\n  // seu código aqui\n}\n",
    );
  });
  it("formatArgs é o inverso de parseArgs", () => {
    const args = [1, "a", [2, 3], null];
    expect(parseArgs(formatArgs(args))).toEqual({ ok: true, value: args });
  });
});

describe("ids", () => {
  it("slugify remove acentos e símbolos", () => {
    expect(slugify("  Média  Aritmética (3 números)! ")).toBe(
      "media-aritmetica-3-numeros",
    );
    expect(slugify("???")).toBe("");
  });
  it("newExerciseId evita colisão e respeita o formato do banco", () => {
    expect(newExerciseId("Soma dos Pares", new Set())).toBe("soma-dos-pares");
    const id = newExerciseId(
      "Soma dos Pares",
      new Set(["soma-dos-pares"]),
      () => 0.5,
    );
    expect(id).toMatch(/^soma-dos-pares-[a-z0-9]{3}$/);
    expect(newExerciseId("!!!", new Set())).toBe("exercicio");
    expect(id).toMatch(/^[a-z0-9-]{1,60}$/);
  });
  it("respeita o tamanho máximo (módulos têm limite de 40)", () => {
    const long =
      "Um título muito comprido para um módulo de lógica de programação";
    const free = newExerciseId(long, new Set(), Math.random, 40);
    expect(free.length).toBeLessThanOrEqual(40);
    const dup = newExerciseId(long, new Set([free]), () => 0.1, 40);
    expect(dup.length).toBeLessThanOrEqual(40);
    expect(dup).not.toBe(free);
  });
});

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
    kind: "code",
    lesson: null,
    config: {},
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

describe("validateDraft: múltipla escolha", () => {
  const choice = (over: Partial<Draft> = {}): Draft => ({
    ...emptyDraft("m1"),
    kind: "choice",
    title: "Pergunta",
    statement: "Qual?",
    options: ["Um", "Dois", "Três"],
    correct: 1,
    ...over,
  });
  it("aceita e monta a configuração (sem função nem testes)", () => {
    const r = validateDraft(choice({ explanation: " Porque sim. " }));
    expect(r.errors).toEqual([]);
    expect(r.config).toEqual({
      options: ["Um", "Dois", "Três"],
      correct: 1,
      explanation: "Porque sim.",
    });
    expect(r.tests).toEqual([]);
  });
  it("não exige nome de função nem testes", () => {
    expect(
      validateDraft(choice({ functionName: "", tests: [] })).errors,
    ).toEqual([]);
  });
  it("exige gabarito marcado e dentro do intervalo", () => {
    expect(validateDraft(choice({ correct: null })).errors.join()).toContain(
      "correta",
    );
    expect(validateDraft(choice({ correct: 5 })).errors.join()).toContain(
      "correta",
    );
  });
  it("exige entre 2 e 6 alternativas, preenchidas e diferentes", () => {
    expect(
      validateDraft(choice({ options: ["Só uma"], correct: 0 })).errors.join(),
    ).toContain("pelo menos 2");
    expect(
      validateDraft(
        choice({ options: ["a", "b", "c", "d", "e", "f", "g"] }),
      ).errors.join(),
    ).toContain("No máximo 6");
    expect(
      validateDraft(choice({ options: ["a", " "], correct: 0 })).errors.join(),
    ).toContain("vazias");
    expect(
      validateDraft(
        choice({ options: ["Sim", "sim"], correct: 0 }),
      ).errors.join(),
    ).toContain("repetidas");
  });
  it("continua exigindo título, módulo e enunciado", () => {
    expect(
      validateDraft(choice({ title: "", moduleId: "", statement: "" })).errors
        .length,
    ).toBe(3);
  });
});

describe("validateDraft: completar a lacuna", () => {
  const blank = (over: Partial<Draft> = {}): Draft => ({
    ...emptyDraft("m1"),
    kind: "blank",
    title: "Complete",
    statement: "Complete.",
    template: "{{1}} (x) { } {{2}} { }",
    blankAnswers: ["if", "else\nelse  "],
    ...over,
  });
  it("aceita e monta a configuração, uma resposta aceita por linha", () => {
    const r = validateDraft(blank());
    expect(r.errors).toEqual([]);
    expect(r.config).toEqual({
      template: "{{1}} (x) { } {{2}} { }",
      blanks: [{ answers: ["if"] }, { answers: ["else", "else"] }],
    });
  });
  it("exige lacunas numeradas em sequência, sem repetir", () => {
    expect(
      validateDraft(
        blank({ template: "sem lacunas", blankAnswers: [] }),
      ).errors.join(),
    ).toContain("pelo menos uma lacuna");
    expect(
      validateDraft(
        blank({ template: "{{1}} {{3}}", blankAnswers: ["a", "b"] }),
      ).errors.join(),
    ).toContain("em sequência");
    expect(
      validateDraft(
        blank({ template: "{{1}} {{1}}", blankAnswers: ["a"] }),
      ).errors.join(),
    ).toContain("em sequência");
    expect(
      validateDraft(
        blank({ template: "{{2}} {{1}}", blankAnswers: ["a", "b"] }),
      ).errors,
    ).toEqual([]); // ordem no texto é livre
  });
  it("exige ao menos uma resposta aceita em cada lacuna", () => {
    expect(
      validateDraft(blank({ blankAnswers: ["if", "  \n "] })).errors.join(),
    ).toContain("lacuna 2");
    expect(
      validateDraft(blank({ blankAnswers: ["if"] })).errors.join(),
    ).toContain("lacuna 2");
  });
  it("limita o número de lacunas e o tamanho do modelo", () => {
    const many = Array.from({ length: 11 }, (_, i) => `{{${i + 1}}}`).join(" ");
    expect(
      validateDraft(
        blank({ template: many, blankAnswers: Array(11).fill("a") }),
      ).errors.join(),
    ).toContain("No máximo 10");
    expect(
      validateDraft(
        blank({ template: "{{1}}" + "x".repeat(2001), blankAnswers: ["a"] }),
      ).errors.join(),
    ).toContain("2000");
  });
  it("não exige nome de função nem testes", () => {
    expect(
      validateDraft(blank({ functionName: "", tests: [] })).errors,
    ).toEqual([]);
  });
});

describe("mini-explicação e explicação", () => {
  it("limites de tamanho", () => {
    expect(
      validateDraft(valid({ lesson: "x".repeat(1501) })).errors.join(),
    ).toContain("1500");
    expect(
      validateDraft(valid({ explanation: "x".repeat(501) })).errors.join(),
    ).toContain("500");
    expect(validateDraft(valid({ lesson: "x".repeat(1500) })).errors).toEqual(
      [],
    );
  });
});

describe("draftFromExercise: tipos sem código", () => {
  const base = {
    id: "x",
    lesson: "Aula",
    moduleId: "m",
    title: "T",
    difficulty: "facil" as const,
    statement: "s",
    functionName: "",
    starterCode: "",
    tests: [],
    hint: "",
    position: 1,
    published: true,
  };
  it("múltipla escolha volta idêntica ao ser reaberta no editor", () => {
    const e: Exercise = {
      ...base,
      kind: "choice",
      config: { options: ["a", "b"], correct: 1, explanation: "ok" },
    };
    const d = draftFromExercise(e);
    expect(d).toMatchObject({
      kind: "choice",
      lesson: "Aula",
      options: ["a", "b"],
      correct: 1,
      explanation: "ok",
    });
    expect(validateDraft(d).config).toEqual(e.config);
  });
  it("lacunas voltam idênticas (respostas aceitas, uma por linha)", () => {
    const e: Exercise = {
      ...base,
      kind: "blank",
      config: { template: "i{{1}}", blanks: [{ answers: ["++", "+= 1"] }] },
    };
    const d = draftFromExercise(e);
    expect(d.blankAnswers).toEqual(["++\n+= 1"]);
    expect(validateDraft(d).config).toEqual(e.config);
  });
});

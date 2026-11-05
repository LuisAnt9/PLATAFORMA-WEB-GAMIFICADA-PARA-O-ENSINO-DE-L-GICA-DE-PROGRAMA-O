import { describe, expect, it } from "vitest";
import { buildAttemptParams } from "./attempts";
import type { Exercise } from "./catalog";

const base: Exercise = {
  id: "ex",
  kind: "code",
  lesson: null,
  config: {},
  moduleId: "m",
  title: "T",
  difficulty: "facil",
  statement: "",
  functionName: "f",
  starterCode: "",
  tests: [
    { args: [1], expected: 1 },
    { args: [2], expected: 2 },
    { args: [3], expected: 3 },
  ],
  hint: "",
  position: 1,
  published: true,
};
const test = (passed: boolean) => ({ args: [], expected: 1, passed });

describe("buildAttemptParams", () => {
  it("código errado: testes aprovados, total e categoria do executor", () => {
    const p = buildAttemptParams({
      exercise: base,
      submission: {
        kind: "code",
        code: "function f(){}",
        result: {
          passed: false,
          tests: [test(true), test(false), test(false)],
          errorCategory: "saida_incorreta",
        },
      },
      passed: false,
      durationMs: 1234.6,
    });
    expect(p).toMatchObject({
      p_exercise: "ex",
      p_passed: false,
      p_answer: "function f(){}",
      p_tests_passed: 1,
      p_tests_total: 3,
      p_error_category: "saida_incorreta",
      p_duration_ms: 1235,
      p_mode: "livre",
      p_assignment_id: null,
    });
  });
  it("erro de sintaxe: nenhum teste rodou", () => {
    const p = buildAttemptParams({
      exercise: base,
      submission: {
        kind: "code",
        code: "function f(",
        result: {
          passed: false,
          tests: [],
          fatal: "x",
          errorCategory: "sintaxe",
        },
      },
      passed: false,
      durationMs: 10,
    });
    expect(p).toMatchObject({
      p_tests_passed: 0,
      p_tests_total: 3,
      p_error_category: "sintaxe",
    });
  });
  it("acerto não leva categoria; código enorme é cortado; duração limitada", () => {
    const p = buildAttemptParams({
      exercise: base,
      submission: {
        kind: "code",
        code: "x".repeat(9000),
        result: { passed: true, tests: [test(true), test(true), test(true)] },
      },
      passed: true,
      durationMs: 99_999_999,
    });
    expect(p.p_error_category).toBeNull();
    expect((p.p_answer as string).length).toBe(4000);
    expect(p.p_duration_ms).toBe(3_600_000);
  });
  it("escolha: manda a alternativa marcada (o servidor calcula o acerto)", () => {
    const ex: Exercise = {
      ...base,
      kind: "choice",
      tests: [],
      config: { options: ["a", { text: "b", misconception: "m" }], correct: 0 },
    };
    const p = buildAttemptParams({
      exercise: ex,
      submission: { kind: "choice", selected: 1 },
      passed: false,
      durationMs: 5,
    });
    expect(p.p_selected).toBe(1);
    expect(JSON.parse(p.p_answer as string)).toEqual({
      selected: 1,
      text: "b",
    });
    expect(p).not.toHaveProperty("p_error_category");
  });
  it("lacunas: respostas e quantas estavam certas", () => {
    const ex: Exercise = { ...base, kind: "blank", tests: [] };
    const p = buildAttemptParams({
      exercise: ex,
      submission: {
        kind: "blank",
        answers: ["if", "elsee"],
        result: { passed: false, correct: [true, false] },
      },
      passed: false,
      durationMs: 5,
      mode: "atividade",
      assignmentId: 7,
    });
    expect(p).toMatchObject({
      p_tests_passed: 1,
      p_tests_total: 2,
      p_mode: "atividade",
      p_assignment_id: 7,
    });
    expect(JSON.parse(p.p_answer as string)).toEqual(["if", "elsee"]);
  });
});

describe("buildAttemptParams: ordenação e dica", () => {
  it("ordenação: manda os passos na ordem do aluno (o servidor decide o acerto)", () => {
    const ex: Exercise = {
      ...base,
      kind: "order",
      tests: [],
      config: { items: ["a", "b"] },
    };
    const p = buildAttemptParams({
      exercise: ex,
      submission: { kind: "order", arrangement: ["b", "a"], inPlace: 0 },
      passed: false,
      durationMs: 5,
    });
    expect(JSON.parse(p.p_answer as string)).toEqual(["b", "a"]);
    expect(p).toMatchObject({ p_tests_passed: 0, p_tests_total: 2 });
    expect(p).not.toHaveProperty("p_selected");
  });
  it("nível de dica fica entre 0 e 3", () => {
    const mk = (hintLevel?: number) =>
      buildAttemptParams({
        exercise: {
          ...base,
          kind: "choice",
          tests: [],
          config: { options: ["a", "b"], correct: 0 },
        },
        submission: { kind: "choice", selected: 0 },
        passed: true,
        durationMs: 1,
        hintLevel,
      }).p_hint_level;
    expect(mk()).toBe(0);
    expect(mk(2)).toBe(2);
    expect(mk(9)).toBe(3);
    expect(mk(-4)).toBe(0);
  });
});

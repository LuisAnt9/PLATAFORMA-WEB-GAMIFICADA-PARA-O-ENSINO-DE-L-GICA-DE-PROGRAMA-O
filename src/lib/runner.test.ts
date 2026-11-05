import { describe, expect, it } from "vitest";
import { categorizeTests, type TestResult } from "./runner";

const t = (passed: boolean, error?: string): TestResult => ({
  args: [],
  expected: 1,
  passed,
  ...(error ? { error } : {}),
});

describe("categorizeTests", () => {
  it("não há categoria quando todos passam", () => {
    expect(categorizeTests([t(true), t(true)])).toBeUndefined();
  });
  it("valor errado sem erro é saída incorreta", () => {
    expect(categorizeTests([t(true), t(false)])).toBe("saida_incorreta");
  });
  it("só erros lançados são erro de execução", () => {
    expect(categorizeTests([t(false, "x is not defined")])).toBe("execucao");
  });
  it("mistura de erro lançado e valor errado conta como saída incorreta", () => {
    expect(categorizeTests([t(false, "boom"), t(false)])).toBe(
      "saida_incorreta",
    );
  });
});

import { evaluateTest, forbiddenFeature } from "./runner";

describe("evaluateTest (valor retornado e saída impressa)", () => {
  it("só valor retornado: compara com expected", () => {
    expect(
      evaluateTest({ args: [1], expected: 2 }, { received: 2 }).passed,
    ).toBe(true);
    const r = evaluateTest({ args: [1], expected: 2 }, { received: 3 });
    expect(r.passed).toBe(false);
    expect(r.received).toBe(3);
  });
  it("expected undefined é um valor esperado (função sem return)", () => {
    expect(
      evaluateTest({ args: [], expected: undefined }, { received: undefined })
        .passed,
    ).toBe(true);
  });
  it("só saída: compara as linhas impressas e ignora o retorno", () => {
    const t = { args: [], output: ["Olá", "3"] };
    expect(evaluateTest(t, { received: 99, lines: ["Olá", "3"] }).passed).toBe(
      true,
    );
    const r = evaluateTest(t, { received: 99, lines: ["Olá", "4"] });
    expect(r.passed).toBe(false);
    expect(r.receivedOutput).toEqual(["Olá", "4"]);
    expect(r.expectedOutput).toEqual(["Olá", "3"]);
    expect(r).not.toHaveProperty("received");
  });
  it("saída com linha a mais ou a menos reprova", () => {
    const t = { args: [], output: ["a"] };
    expect(evaluateTest(t, { lines: [] }).passed).toBe(false);
    expect(evaluateTest(t, { lines: ["a", "b"] }).passed).toBe(false);
  });
  it("valor e saída: os dois precisam bater", () => {
    const t = { args: [], expected: 5, output: ["x"] };
    expect(evaluateTest(t, { received: 5, lines: ["x"] }).passed).toBe(true);
    expect(evaluateTest(t, { received: 4, lines: ["x"] }).passed).toBe(false);
    expect(evaluateTest(t, { received: 5, lines: ["y"] }).passed).toBe(false);
  });
  it("erro lançado reprova e guarda a mensagem; entradas simuladas são devolvidas", () => {
    const r = evaluateTest(
      { args: [], expected: 1, inputs: ["a", 2] },
      { error: "boom" },
    );
    expect(r).toMatchObject({ passed: false, error: "boom", inputs: ["a", 2] });
  });
});

describe("forbiddenFeature", () => {
  it("bloqueia importação dinâmica e importScripts", () => {
    expect(forbiddenFeature("const m = await import('x')")).not.toBeNull();
    expect(forbiddenFeature("importScripts('https://x/y.js')")).not.toBeNull();
  });
  it("deixa passar código comum", () => {
    expect(forbiddenFeature("function soma(a,b){ return a + b }")).toBeNull();
    expect(forbiddenFeature("const important = 1;")).toBeNull();
  });
});

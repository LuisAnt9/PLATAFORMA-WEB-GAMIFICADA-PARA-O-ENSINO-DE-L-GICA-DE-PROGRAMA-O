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

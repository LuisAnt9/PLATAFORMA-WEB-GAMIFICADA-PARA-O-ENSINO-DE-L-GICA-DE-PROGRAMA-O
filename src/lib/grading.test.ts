import { describe, expect, it } from "vitest";
import {
  blankView,
  choiceView,
  gradeBlanks,
  gradeChoice,
  normalizeAnswer,
  placeholderNumbers,
  splitTemplate,
} from "./grading";

describe("normalizeAnswer", () => {
  it("apara e reduz espaços, mas mantém maiúsculas", () => {
    expect(normalizeAnswer("  += \t 1  ")).toBe("+= 1");
    expect(normalizeAnswer("If")).toBe("If");
  });
});

describe("múltipla escolha", () => {
  const cfg = { options: ["a", "b", "c"], correct: 1 };
  it("acerta só a alternativa certa", () => {
    expect(gradeChoice(cfg, 1)).toBe(true);
    expect(gradeChoice(cfg, 0)).toBe(false);
    expect(gradeChoice(cfg, null)).toBe(false);
  });
  it("rejeita configuração malformada em vez de aceitar tudo", () => {
    for (const bad of [
      {},
      { options: ["a"], correct: 0 },
      { options: ["a", "b"], correct: 2 },
      { options: ["a", "b"], correct: 0.5 },
      { options: ["a", 3 as unknown as string], correct: 0 },
    ]) {
      expect(choiceView(bad)).toBeNull();
      expect(gradeChoice(bad, 0)).toBe(false);
    }
  });
});

describe("lacunas", () => {
  const cfg = {
    template: "{{1}} (x > 1) { return 1; } {{2}} { return 2; }",
    blanks: [{ answers: ["if"] }, { answers: ["else", "else  "] }],
  };
  it("quebra o modelo em texto e lacunas na ordem", () => {
    expect(splitTemplate("a {{1}} b {{2}}")).toEqual([
      { type: "text", text: "a " },
      { type: "blank", index: 0 },
      { type: "text", text: " b " },
      { type: "blank", index: 1 },
    ]);
    expect(splitTemplate("sem lacunas")).toEqual([
      { type: "text", text: "sem lacunas" },
    ]);
    expect(placeholderNumbers("{{2}} e {{1}}")).toEqual([2, 1]);
  });
  it("corrige cada lacuna e só passa com todas certas", () => {
    expect(gradeBlanks(cfg, ["if", "else"])).toEqual({
      passed: true,
      correct: [true, true],
    });
    expect(gradeBlanks(cfg, ["if", "elsee"])).toEqual({
      passed: false,
      correct: [true, false],
    });
    expect(gradeBlanks(cfg, ["IF", " else "]).correct).toEqual([false, true]); // maiúsculas importam
  });
  it("lacuna vazia ou resposta ausente nunca acerta", () => {
    expect(gradeBlanks(cfg, ["", ""]).passed).toBe(false);
    expect(gradeBlanks(cfg, []).passed).toBe(false);
  });
  it("aceita qualquer uma das respostas cadastradas, ignorando espaços extras", () => {
    const c = { template: "i{{1}}", blanks: [{ answers: ["++", "+= 1"] }] };
    expect(gradeBlanks(c, ["+=   1"]).passed).toBe(true);
    expect(gradeBlanks(c, ["++"]).passed).toBe(true);
    expect(gradeBlanks(c, ["+=1"]).passed).toBe(false);
  });
  it("configuração inconsistente (lacuna sem gabarito) não passa nunca", () => {
    const bad = { template: "{{1}} {{3}}", blanks: [{ answers: ["a"] }] };
    expect(blankView(bad)).toBeNull();
    expect(gradeBlanks(bad, ["a", "x"]).passed).toBe(false);
    expect(
      blankView({ template: "sem lacunas", blanks: [{ answers: ["a"] }] }),
    ).toBeNull();
    expect(
      blankView({ template: "{{1}}", blanks: [{ answers: [] }] }),
    ).toBeNull();
  });
});

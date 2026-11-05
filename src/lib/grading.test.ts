import { describe, expect, it } from "vitest";
import {
  blankView,
  choiceView,
  gradeBlanks,
  gradeChoice,
  gradeOrder,
  interpretationCode,
  orderView,
  shuffledOrder,
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

describe("alternativas com confusão (migration 0010)", () => {
  const config = {
    options: [
      "certa",
      { text: "errada", misconception: "confunde && com ||" },
      { text: "outra" },
    ],
    correct: 0,
  };
  it("lê os dois formatos e devolve textos e confusões", () => {
    const v = choiceView(config);
    expect(v?.options).toEqual(["certa", "errada", "outra"]);
    expect(v?.misconceptions).toEqual([null, "confunde && com ||", null]);
  });
  it("a correção não muda com o formato", () => {
    expect(gradeChoice(config, 0)).toBe(true);
    expect(gradeChoice(config, 1)).toBe(false);
  });
  it("rejeita alternativa malformada", () => {
    expect(
      choiceView({ options: ["a", { nome: "x" } as never], correct: 0 }),
    ).toBeNull();
    expect(choiceView({ options: ["a", 3 as never], correct: 0 })).toBeNull();
  });
});

describe("interpretação de código", () => {
  it("lê o trecho e ignora vazio ou ausente", () => {
    expect(interpretationCode({ code: "let x = 1;" })).toBe("let x = 1;");
    expect(interpretationCode({ code: "  " })).toBeNull();
    expect(interpretationCode({})).toBeNull();
  });
});

describe("ordenação", () => {
  const config = { items: ["Abrir a porta", "Entrar", "Fechar a porta"] };
  it("orderView aceita de 2 a 10 passos distintos e recusa o resto", () => {
    expect(orderView(config)?.items).toHaveLength(3);
    expect(orderView({ items: ["só um"] })).toBeNull();
    expect(orderView({ items: ["a", "a"] })).toBeNull();
    expect(orderView({ items: ["a", " "] })).toBeNull();
    expect(
      orderView({ items: Array.from({ length: 11 }, (_, i) => `p${i}`) }),
    ).toBeNull();
    expect(orderView({ items: ["a", 1 as never] })).toBeNull();
    expect(orderView({})).toBeNull();
  });
  it("gradeOrder: só a ordem exata acerta", () => {
    expect(
      gradeOrder(config, ["Abrir a porta", "Entrar", "Fechar a porta"]),
    ).toBe(true);
    expect(
      gradeOrder(config, ["Entrar", "Abrir a porta", "Fechar a porta"]),
    ).toBe(false);
    expect(gradeOrder(config, ["Abrir a porta", "Entrar"])).toBe(false);
    expect(gradeOrder({ items: ["a"] }, ["a"])).toBe(false);
  });
  it("shuffledOrder é estável, completo e nunca devolve a ordem certa", () => {
    const items = ["a", "b", "c", "d", "e"];
    const um = shuffledOrder(items, "exercicio-1");
    expect(shuffledOrder(items, "exercicio-1")).toEqual(um);
    expect([...um].sort()).toEqual(items);
    for (let i = 0; i < 200; i++) {
      expect(shuffledOrder(items, `ex-${i}`)).not.toEqual(items);
      expect(shuffledOrder(["x", "y"], `ex-${i}`)).toEqual(["y", "x"]);
    }
  });
  it("seeds diferentes dão ordens diferentes", () => {
    const items = ["a", "b", "c", "d", "e", "f"];
    const ordens = new Set(
      Array.from({ length: 30 }, (_, i) =>
        shuffledOrder(items, `s${i}`).join(""),
      ),
    );
    expect(ordens.size).toBeGreaterThan(5);
  });
});

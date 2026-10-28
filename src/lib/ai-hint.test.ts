import { describe, expect, it } from "vitest";
import { buildHintPrompt, extractGeminiText, MAX_CODE } from "./ai-hint";
import type { Exercise } from "./catalog";

const base: Exercise = {
  id: "soma",
  kind: "code",
  lesson: null,
  config: {},
  moduleId: "m",
  title: "Soma",
  difficulty: "facil",
  statement: "Some dois números.",
  functionName: "soma",
  starterCode: "",
  tests: [{ args: [1, 2], expected: 3 }],
  hint: "",
  position: 1,
  published: true,
};

describe("buildHintPrompt", () => {
  it("inclui enunciado, testes e o código do aluno", () => {
    const p = buildHintPrompt(base, {
      code: "function soma(a,b){}",
      attempt: "falhou",
    });
    expect(p).toContain("Some dois números.");
    expect(p).toContain("soma(1, 2) → 3");
    expect(p).toContain("function soma(a,b){}");
    expect(p).toContain("falhou");
  });
  it("corta código enorme", () => {
    const p = buildHintPrompt(base, { code: "x".repeat(MAX_CODE * 3) });
    expect(p.length).toBeLessThan(MAX_CODE + 1500);
  });
  it("múltipla escolha marca a correta como uso interno", () => {
    const p = buildHintPrompt(
      { ...base, kind: "choice", config: { options: ["a", "b"], correct: 1 } },
      {},
    );
    expect(p).toContain("não revele");
    expect(p).toContain("2) b");
    expect(p).toContain("(ainda não tentou)");
  });
});

describe("extractGeminiText", () => {
  it("junta as partes de texto", () => {
    expect(
      extractGeminiText({
        candidates: [
          { content: { parts: [{ text: "Oi " }, { text: "aluno" }] } },
        ],
      }),
    ).toBe("Oi aluno");
  });
  it("devolve null para resposta vazia, bloqueada ou estranha", () => {
    expect(extractGeminiText({})).toBeNull();
    expect(extractGeminiText({ candidates: [{}] })).toBeNull();
    expect(extractGeminiText(null)).toBeNull();
    expect(
      extractGeminiText({
        candidates: [{ content: { parts: [{ text: 5 }] } }],
      }),
    ).toBeNull();
  });
});

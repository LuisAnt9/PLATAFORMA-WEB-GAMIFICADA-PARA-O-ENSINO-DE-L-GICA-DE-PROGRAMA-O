import { describe, expect, it } from "vitest";
import { ITEMS, LIKERT_ITEMS, SUS_ITEMS, likertMean, susBand, susScore } from "./surveys";

describe("SUS e Likert", () => {
  it("o SUS tem 10 afirmações (alternando positivas e negativas) e o Likert tem 8", () => {
    expect(SUS_ITEMS).toHaveLength(10);
    expect(LIKERT_ITEMS).toHaveLength(8);
    expect(ITEMS.sus).toBe(SUS_ITEMS);
  });
  it("pontuação SUS: extremos e caso neutro", () => {
    expect(susScore([5, 1, 5, 1, 5, 1, 5, 1, 5, 1])).toBe(100);
    expect(susScore([1, 5, 1, 5, 1, 5, 1, 5, 1, 5])).toBe(0);
    expect(susScore([3, 3, 3, 3, 3, 3, 3, 3, 3, 3])).toBe(50);
  });
  it("pontuação SUS: conta de exemplo conferida à mão", () => {
    // ímpares: (4-1)+(5-1)+(4-1)+(4-1)+(5-1) = 17; pares: (5-2)+(5-1)+(5-2)+(5-2)+(5-1) = 17 → (17+17)*2,5 = 85
    expect(susScore([4, 2, 5, 1, 4, 2, 4, 2, 5, 1])).toBe(85);
  });
  it("recusa respostas inválidas", () => {
    expect(() => susScore([5, 1, 5])).toThrow();
    expect(() => susScore([5, 1, 5, 1, 5, 1, 5, 1, 5, 6])).toThrow();
    expect(() => susScore([5, 1, 5, 1, 5, 1, 5, 1, 5, 1.5])).toThrow();
  });
  it("faixas de leitura", () => {
    expect(susBand(90)).toBe("excelente");
    expect(susBand(75)).toBe("boa");
    expect(susBand(70)).toContain("aceitável");
    expect(susBand(55)).toBe("abaixo da média");
    expect(susBand(30)).toBe("ruim");
  });
  it("média Likert", () => {
    expect(likertMean([5, 3, 4, 4])).toBe(4);
  });
});

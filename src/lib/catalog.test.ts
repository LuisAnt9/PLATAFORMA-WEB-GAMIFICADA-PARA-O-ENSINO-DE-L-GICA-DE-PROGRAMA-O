import { describe, expect, it } from "vitest";
import { conceptsOf, isChoiceKind, isCodeKind, type Catalog } from "./catalog";

describe("tipos de exercício", () => {
  it("agrupa os tipos com código e os de escolher alternativa", () => {
    expect(
      ["code", "fix", "challenge"].every((k) => isCodeKind(k as never)),
    ).toBe(true);
    expect(
      ["choice", "blank", "interpretation", "order"].some((k) =>
        isCodeKind(k as never),
      ),
    ).toBe(false);
    expect(isChoiceKind("choice") && isChoiceKind("interpretation")).toBe(true);
    expect(isChoiceKind("order") || isChoiceKind("code")).toBe(false);
  });
});

describe("conceptsOf", () => {
  const catalog: Catalog = {
    modules: [],
    exercises: [],
    concepts: [
      { id: "a", title: "A", description: "", worldId: null },
      { id: "b", title: "B", description: "", worldId: null },
    ],
    links: [
      { exerciseId: "e1", conceptId: "a", weight: 1 },
      { exerciseId: "e1", conceptId: "b", weight: 3 },
      { exerciseId: "e2", conceptId: "a", weight: 1 },
      { exerciseId: "e1", conceptId: "fantasma", weight: 5 },
    ],
  };
  it("ordena pelo peso e ignora conceito desconhecido", () => {
    expect(conceptsOf(catalog, "e1").map((c) => c.id)).toEqual(["b", "a"]);
    expect(conceptsOf(catalog, "e2").map((c) => c.id)).toEqual(["a"]);
    expect(conceptsOf(catalog, "nenhum")).toEqual([]);
  });
  it("funciona sem conceitos (banco sem a migration)", () => {
    expect(conceptsOf({ modules: [], exercises: [] }, "e1")).toEqual([]);
  });
});

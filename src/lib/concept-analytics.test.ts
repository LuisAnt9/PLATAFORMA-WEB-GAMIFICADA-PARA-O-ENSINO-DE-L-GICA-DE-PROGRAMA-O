import { describe, expect, it } from "vitest";
import {
  conceptReport,
  levelOf,
  missingFor,
  type AttemptRow,
  type LinkRow,
} from "./concept-analytics";

let nextId = 1;
const t = (
  user: string,
  exercise: string,
  passed: boolean,
  at: number,
  o: Partial<AttemptRow> = {},
): AttemptRow => ({
  id: nextId++,
  user_id: user,
  exercise_id: exercise,
  passed,
  at,
  mode: "livre",
  error_category: passed ? null : "saida_incorreta",
  misconception: null,
  ...o,
});
const links: LinkRow[] = [
  { exercise_id: "e1", concept_id: "k", weight: 1 },
  { exercise_id: "e2", concept_id: "k", weight: 1 },
  { exercise_id: "e3", concept_id: "k", weight: 3 },
  { exercise_id: "e3", concept_id: "j", weight: 1 },
];
const find = (r: ReturnType<typeof conceptReport>, s: string, c: string) =>
  r.studentConcepts.find((x) => x.student_id === s && x.concept_id === c)!;

describe("levelOf (regra D8)", () => {
  it("poucas tentativas ou um só exercício: dados insuficientes, qualquer que seja a pontuação", () => {
    expect(levelOf(2, 2, 1)).toBe("nao_avaliado");
    expect(levelOf(5, 1, 1)).toBe("nao_avaliado");
    expect(levelOf(1, 1, 0)).toBe("nao_avaliado");
  });
  it("faixas da pontuação de erro", () => {
    expect(levelOf(3, 2, 0)).toBe("bom");
    expect(levelOf(3, 2, 0.25)).toBe("bom");
    expect(levelOf(3, 2, 0.26)).toBe("em_desenvolvimento");
    expect(levelOf(3, 2, 0.5)).toBe("em_desenvolvimento");
    expect(levelOf(3, 2, 0.51)).toBe("dificuldade");
  });
  it("diz quanto falta para ter dados suficientes", () => {
    expect(missingFor(1, 1)).toEqual({ attempts: 2, exercises: 1 });
    expect(missingFor(9, 4)).toEqual({ attempts: 0, exercises: 0 });
  });
});

describe("conceptReport: aluno x conceito", () => {
  it("só uma tentativa: dados insuficientes (mesmo errando)", () => {
    const r = conceptReport({ attempts: [t("a", "e1", false, 1)], links, studentsTotal: 6 });
    expect(find(r, "a", "k")).toMatchObject({ attempts: 1, level: "nao_avaliado" });
  });
  it("só erros em 2 exercícios: ainda não demonstrou domínio", () => {
    const r = conceptReport({
      attempts: [t("a", "e1", false, 1), t("a", "e2", false, 2), t("a", "e1", false, 3)],
      links,
      studentsTotal: 6,
    });
    expect(find(r, "a", "k")).toMatchObject({ level: "dificuldade", score: 1 });
  });
  it("errou e depois acertou: a recência faz a pontuação cair", () => {
    const erros = [t("a", "e1", false, 1), t("a", "e2", false, 2), t("a", "e1", false, 3)];
    const antes = find(conceptReport({ attempts: erros, links, studentsTotal: 6 }), "a", "k").score;
    const depois = find(
      conceptReport({ attempts: [...erros, t("a", "e2", true, 4), t("a", "e1", true, 5), t("a", "e2", true, 6)], links, studentsTotal: 6 }),
      "a",
      "k",
    );
    expect(depois.score).toBeLessThan(antes);
    // acertos recentes pesam mais que erros antigos
    expect(depois.score).toBeLessThan(0.5);
    expect(depois.level).not.toBe("dificuldade");
  });
  it("acertar primeiro e errar depois pesa mais que o contrário", () => {
    const a = conceptReport({ attempts: [t("a", "e1", true, 1), t("a", "e2", true, 2), t("a", "e1", false, 3), t("a", "e2", false, 4)], links, studentsTotal: 6 });
    const b = conceptReport({ attempts: [t("a", "e1", false, 1), t("a", "e2", false, 2), t("a", "e1", true, 3), t("a", "e2", true, 4)], links, studentsTotal: 6 });
    expect(find(a, "a", "k").score).toBeGreaterThan(find(b, "a", "k").score);
  });
  it("só acertos em 3 tentativas e 2 exercícios: bom desempenho", () => {
    const r = conceptReport({ attempts: [t("a", "e1", true, 1), t("a", "e2", true, 2), t("a", "e1", true, 3)], links, studentsTotal: 6 });
    expect(find(r, "a", "k")).toMatchObject({ level: "bom", score: 0 });
  });
  it("uma tentativa conta para todos os conceitos do exercício, com o peso da ligação", () => {
    const r = conceptReport({
      attempts: [t("a", "e3", false, 1), t("a", "e1", true, 2), t("a", "e2", true, 3)],
      links,
      studentsTotal: 6,
    });
    expect(find(r, "a", "j").attempts).toBe(1);
    // conceito k: e3 (peso 3, errada, a mais antiga) e dois acertos de peso 1
    const k = find(r, "a", "k");
    const w = [1, 0.8, 0.64];
    const esperado = (3 * w[2]) / (1 * w[0] + 1 * w[1] + 3 * w[2]);
    expect(k.score).toBeCloseTo(esperado, 10);
  });
  it("tentativas de alunos diferentes não se misturam", () => {
    const r = conceptReport({ attempts: [t("a", "e1", false, 1), t("b", "e1", true, 2)], links, studentsTotal: 6 });
    expect(find(r, "a", "k").score).toBe(1);
    expect(find(r, "b", "k").score).toBe(0);
  });
});

describe("conceptReport: conceito na turma", () => {
  const six = ["a", "b", "c", "d", "e", "f"];
  const base = six.flatMap((s, i) => [t(s, "e1", i % 2 === 0, 10 + i), t(s, "e2", false, 20 + i)]);
  it("turma com menos de 5 alunos: dados insuficientes, sem taxa de erro", () => {
    const r = conceptReport({ attempts: base, links, studentsTotal: 4 });
    const k = r.concepts.find((c) => c.concept_id === "k")!;
    expect(k.sufficient).toBe(false);
    expect(k.error_rate).toBeNull();
  });
  it("com 5 alunos ou mais: taxa de erro ponderada pelo peso", () => {
    const r = conceptReport({ attempts: base, links, studentsTotal: 6 });
    const k = r.concepts.find((c) => c.concept_id === "k")!;
    expect(k.sufficient).toBe(true);
    // e1: 3 acertos e 3 erros; e2: 6 erros (todas as ligações com peso 1) => 9 erros em 12
    expect(k.error_rate).toBeCloseTo(9 / 12, 10);
    expect(k.students).toBe(6);
  });
  it("conceito com 1 só exercício não tem taxa, mesmo com muitos alunos", () => {
    const r = conceptReport({ attempts: six.flatMap((s) => [t(s, "e1", false, 1), t(s, "e1", false, 2)]), links, studentsTotal: 6 });
    expect(r.concepts.find((c) => c.concept_id === "k")!.error_rate).toBeNull();
  });
  it("conta os alunos por nível", () => {
    const r = conceptReport({
      attempts: [
        ...["a", "b"].flatMap((s) => [t(s, "e1", true, 1), t(s, "e2", true, 2), t(s, "e1", true, 3)]),
        ...["c"].flatMap((s) => [t(s, "e1", false, 1), t(s, "e2", false, 2), t(s, "e1", false, 3)]),
        t("d", "e1", false, 1),
      ],
      links,
      studentsTotal: 6,
    });
    const k = r.concepts.find((c) => c.concept_id === "k")!;
    expect([k.bom, k.dificuldade, k.nao_avaliado]).toEqual([2, 1, 1]);
  });
  it("filtra por modalidade (livre, atividade, avaliação ficam separadas)", () => {
    const att = [t("a", "e1", false, 1, { mode: "atividade" }), t("a", "e2", true, 2, { mode: "livre" })];
    expect(conceptReport({ attempts: att, links, studentsTotal: 6, mode: "atividade" }).studentConcepts[0].attempts).toBe(1);
    expect(conceptReport({ attempts: att, links, studentsTotal: 6, mode: "avaliacao" }).concepts).toEqual([]);
  });
});

describe("conceptReport: erros recorrentes", () => {
  it("agrupa confusões e categorias só entre as tentativas erradas", () => {
    const r = conceptReport({
      attempts: [
        t("a", "e1", false, 1, { misconception: "confunde && com ||", error_category: "escolha_incorreta" }),
        t("b", "e1", false, 2, { misconception: "confunde && com ||", error_category: "escolha_incorreta" }),
        t("b", "e2", false, 3, { misconception: "usa = no lugar de ===", error_category: "escolha_incorreta" }),
        t("a", "e2", true, 4, { misconception: "ignorada: acerto" }),
        t("a", "e1", false, 5, { error_category: "sintaxe" }),
      ],
      links,
      studentsTotal: 6,
    });
    expect(r.misconceptions[0]).toEqual({ text: "confunde && com ||", count: 2, students: 2 });
    expect(r.misconceptions.map((m) => m.text)).not.toContain("ignorada: acerto");
    expect(r.categories).toEqual([
      { category: "escolha_incorreta", count: 3 },
      { category: "sintaxe", count: 1 },
    ]);
  });
  it("exercícios mais difíceis exigem 3 tentativas", () => {
    const r = conceptReport({
      attempts: [t("a", "e1", false, 1), t("b", "e1", false, 2), t("a", "e2", false, 3), t("b", "e2", false, 4), t("c", "e2", true, 5)],
      links,
      studentsTotal: 6,
    });
    expect(r.hardest.map((h) => h.exercise_id)).toEqual(["e2"]);
    expect(r.hardest[0].error_rate).toBeCloseTo(2 / 3, 10);
  });
  it("sem tentativas: tudo vazio", () => {
    const r = conceptReport({ attempts: [], links, studentsTotal: 0 });
    expect(r).toEqual({ concepts: [], studentConcepts: [], hardest: [], misconceptions: [], categories: [] });
  });
});

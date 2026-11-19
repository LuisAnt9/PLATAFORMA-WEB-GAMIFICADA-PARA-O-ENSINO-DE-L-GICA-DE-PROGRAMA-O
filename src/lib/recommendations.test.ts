import { describe, expect, it } from "vitest";
import type { ConceptReportData, ConceptRow } from "./concept-report";
import { recommend } from "./recommendations";

const concept = (o: Partial<ConceptRow>): ConceptRow => ({
  concept_id: "k", title: "Operadores lógicos", world_id: null, attempts: 40, exercises: 4, students: 8,
  sufficient: true, error_rate: 0.55, bom: 2, em_desenvolvimento: 2, dificuldade: 4, nao_avaliado: 0, ...o,
});
const report = (o: Partial<ConceptReportData> = {}): ConceptReportData => ({
  students_total: 8, min_students: 5, concepts: [], student_concepts: [], hardest_exercises: [],
  misconceptions: [], error_categories: [], by_mode: [], timeline: [], ...o,
});

describe("recomendações por regras", () => {
  it("conceito com muita dificuldade vira recomendação com botão de reforço", () => {
    const r = recommend(report({ concepts: [concept({})] }), "c1");
    expect(r).toHaveLength(1);
    expect(r[0].text).toContain('A turma apresenta dificuldade em "Operadores lógicos"');
    expect(r[0].text).toContain("4 de 8 alunos");
    expect(r[0].action?.href).toBe("/professor/atividades/nova?turma=c1&conceito=k");
  });
  it("linguagem neutra: não rotula alunos nem usa 'incapaz'", () => {
    const txt = recommend(report({ concepts: [concept({})], misconceptions: [{ text: "confunde && com ||", count: 5, students: 3 }] }), "c1")
      .map((x) => x.text).join(" ");
    expect(txt).not.toMatch(/incapaz|fraco|burro|ruim/i);
  });
  it("turma com menos de 5 alunos: nenhuma recomendação", () => {
    expect(recommend(report({ students_total: 4, concepts: [concept({})] }), "c1")).toEqual([]);
  });
  it("dados insuficientes, taxa baixa ou poucos alunos com dificuldade: não recomenda", () => {
    expect(recommend(report({ concepts: [concept({ sufficient: false, error_rate: null })] }), "c1")).toEqual([]);
    expect(recommend(report({ concepts: [concept({ error_rate: 0.2 })] }), "c1")).toEqual([]);
    expect(recommend(report({ concepts: [concept({ dificuldade: 1, bom: 7 })] }), "c1")).toEqual([]);
  });
  it("no máximo 3 conceitos, do pior para o melhor", () => {
    const cs = [0.5, 0.9, 0.7, 0.6].map((e, i) => concept({ concept_id: `k${i}`, title: `C${i}`, error_rate: e }));
    const r = recommend(report({ concepts: cs }), "c1");
    expect(r.map((x) => x.id)).toEqual(["conceito-k1", "conceito-k2", "conceito-k3"]);
  });
  it("confusão frequente exige 3 respostas de 2 alunos", () => {
    expect(recommend(report({ misconceptions: [{ text: "x", count: 2, students: 2 }] }), "c1")).toEqual([]);
    expect(recommend(report({ misconceptions: [{ text: "x", count: 3, students: 1 }] }), "c1")).toEqual([]);
    expect(recommend(report({ misconceptions: [{ text: "confunde = com ===", count: 3, students: 2 }] }), "c1")[0].text).toContain("confunde = com ===");
  });
  it("padrões de erro de código: sintaxe, execução e tempo", () => {
    const sint = recommend(report({ error_categories: [{ category: "sintaxe", count: 6 }, { category: "saida_incorreta", count: 4 }] }), "c1");
    expect(sint.map((x) => x.id)).toEqual(["sintaxe"]);
    const poucos = recommend(report({ error_categories: [{ category: "sintaxe", count: 4 }] }), "c1");
    expect(poucos).toEqual([]);
    const tempo = recommend(report({ error_categories: [{ category: "tempo", count: 3 }, { category: "saida_incorreta", count: 10 }] }), "c1");
    expect(tempo.map((x) => x.id)).toEqual(["tempo"]);
  });
});

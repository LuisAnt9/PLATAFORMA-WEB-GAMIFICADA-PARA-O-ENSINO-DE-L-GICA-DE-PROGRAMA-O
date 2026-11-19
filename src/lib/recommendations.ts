import type { ConceptReportData } from "./concept-report";

export interface Recommendation {
  id: string;
  text: string;
  /** Botão "criar atividade de reforço" (preenche o formulário da E10 com exercícios do conceito). */
  action?: { label: string; href: string };
}

/** Taxa de erro a partir da qual um conceito merece atenção, e mínimo de alunos com dificuldade. */
export const ATTENTION_ERROR_RATE = 0.4;
const pct = (v: number) => `${Math.round(v * 100)}%`;
const CODE_CATEGORIES = ["sintaxe", "execucao", "tempo", "saida_incorreta"];

/**
 * Recomendações por regras (modelos de frase, sem IA). Nunca rotulam alunos: falam de conceitos
 * e de padrões da turma. Sem dados suficientes (turma pequena), não recomendam nada.
 */
export function recommend(report: ConceptReportData, classId: string): Recommendation[] {
  if (report.students_total < report.min_students) return [];
  const out: Recommendation[] = [];

  const worrying = report.concepts
    .filter((c) => c.sufficient && c.error_rate !== null && c.error_rate >= ATTENTION_ERROR_RATE)
    .filter((c) => {
      const evaluated = c.bom + c.em_desenvolvimento + c.dificuldade;
      return c.dificuldade >= Math.max(2, Math.ceil(evaluated * 0.25));
    })
    .sort((a, b) => (b.error_rate ?? 0) - (a.error_rate ?? 0))
    .slice(0, 3);
  for (const c of worrying) {
    const evaluated = c.bom + c.em_desenvolvimento + c.dificuldade;
    out.push({
      id: `conceito-${c.concept_id}`,
      text: `A turma apresenta dificuldade em "${c.title}": ${c.dificuldade} de ${evaluated} alunos ainda não demonstraram domínio (taxa de erro de ${pct(c.error_rate ?? 0)}). Considere revisar esse conceito.`,
      action: {
        label: "Criar atividade de reforço",
        href: `/professor/atividades/nova?turma=${classId}&conceito=${c.concept_id}`,
      },
    });
  }

  for (const m of report.misconceptions.filter((x) => x.count >= 3 && x.students >= 2).slice(0, 2)) {
    out.push({
      id: `confusao-${m.text}`,
      text: `Confusão frequente: ${m.text} (${m.count} respostas, ${m.students} alunos). Vale um exemplo na aula mostrando a diferença.`,
    });
  }

  const code = report.error_categories.filter((c) => CODE_CATEGORIES.includes(c.category));
  const codeTotal = code.reduce((n, c) => n + c.count, 0);
  const share = (cat: string) => (code.find((c) => c.category === cat)?.count ?? 0) / (codeTotal || 1);
  if (codeTotal >= 5 && share("sintaxe") >= 0.4)
    out.push({
      id: "sintaxe",
      text: `Muitos erros de código são de sintaxe (${pct(share("sintaxe"))}). Considere revisar a escrita de chaves, parênteses, aspas e ponto e vírgula.`,
    });
  if (codeTotal >= 5 && share("execucao") >= 0.4)
    out.push({
      id: "execucao",
      text: `Muitos erros acontecem na execução (${pct(share("execucao"))}), por exemplo usar uma variável que não foi declarada. Considere revisar declaração e uso de variáveis.`,
    });
  const tempo = code.find((c) => c.category === "tempo")?.count ?? 0;
  if (tempo >= 3)
    out.push({
      id: "tempo",
      text: `${tempo} tentativas estouraram o tempo. Pode haver repetições que nunca terminam; vale comentar como evitá-las.`,
    });
  return out;
}

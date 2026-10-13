import type { PGlite } from "@electric-sql/pglite";
import { beforeAll, describe, expect, it } from "vitest";
import { gradeBlanks, gradeChoice } from "../../src/lib/grading";
import { extraSolutions } from "./extras-solutions";
import { createDb } from "./helpers";

// Soluções de referência dos exercícios da migration. Ficam só aqui (nunca no site) para não irem ao navegador do aluno.
const originalSolutions: Record<string, string> = {
  soma: "function soma(a,b){return a+b}",
  media: "function media(a,b,c){return (a+b+c)/3}",
  celsius: "function celsiusParaFahrenheit(c){return c*9/5+32}",
  "area-retangulo": "function areaRetangulo(b,a){return b*a}",
  "par-ou-impar": "function parOuImpar(n){return n%2===0?'par':'impar'}",
  "maior-de-tres":
    "function maiorDeTres(a,b,c){let m=a;if(b>m)m=b;if(c>m)m=c;return m}",
  nota: "function situacao(n){if(n>=7)return 'aprovado';else if(n>=5)return 'recuperacao';return 'reprovado'}",
  bissexto: "function ehBissexto(a){return (a%4===0&&a%100!==0)||a%400===0}",
  somatorio:
    "function somatorio(n){let s=0;for(let i=1;i<=n;i++)s+=i;return s}",
  fatorial: "function fatorial(n){let f=1;for(let i=2;i<=n;i++)f*=i;return f}",
  tabuada:
    "function tabuada(n){const r=[];for(let i=1;i<=10;i++)r.push(n*i);return r}",
  primo:
    "function ehPrimo(n){if(n<2)return false;for(let i=2;i<n;i++)if(n%i===0)return false;return true}",
  "soma-vetor":
    "function somaVetor(v){let s=0;for(let i=0;i<v.length;i++)s+=v[i];return s}",
  "inverter-vetor":
    "function inverter(v){const r=[];for(let i=v.length-1;i>=0;i--)r.push(v[i]);return r}",
  "maior-vetor":
    "function maiorElemento(v){let m=v[0];for(const x of v)if(x>m)m=x;return m}",
  "busca-linear":
    "function buscar(v,x){for(let i=0;i<v.length;i++)if(v[i]===x)return i;return -1}",
  ordenar:
    "function ordenar(v){const r=[...v];for(let i=0;i<r.length;i++)for(let j=0;j<r.length-1-i;j++)if(r[j]>r[j+1]){const t=r[j];r[j]=r[j+1];r[j+1]=t}return r}",
};

const solutions: Record<string, string> = {
  ...originalSolutions,
  ...extraSolutions,
};

interface Row {
  id: string;
  function_name: string;
  starter_code: string;
  tests: { args: unknown[]; expected: unknown }[];
}

let rows: Row[];
let db: PGlite;

beforeAll(async () => {
  db = await createDb();
  rows = (
    await db.query<Row>(
      "select id, function_name, starter_code, tests from public.exercises where kind = 'code' order by position",
    )
  ).rows;
});

const json = (v: unknown) => JSON.stringify(v);

describe("exercícios de código da migration", () => {
  it("há uma solução para cada exercício, e só para eles", () => {
    expect(Object.keys(solutions).sort()).toEqual(rows.map((r) => r.id).sort());
  });
  it("o código inicial declara a função esperada", () => {
    for (const r of rows)
      expect(r.starter_code).toContain(`function ${r.function_name}(`);
  });
  it("todo exercício tem ao menos 3 casos de teste", () => {
    for (const r of rows) expect(r.tests.length).toBeGreaterThanOrEqual(3);
  });
  it("a solução de referência passa em todos os testes; o código inicial não passa", () => {
    for (const r of rows) {
      const good = new Function(
        `${solutions[r.id]}\n;return ${r.function_name};`,
      )();
      for (const t of r.tests)
        expect(json(good(...structuredClone(t.args)))).toBe(json(t.expected));

      const starter = new Function(
        `${r.starter_code}\n;return ${r.function_name};`,
      )();
      const all = r.tests.every(
        (t) => json(starter(...structuredClone(t.args))) === json(t.expected),
      );
      expect(
        all,
        `o código inicial de "${r.id}" não deveria passar sozinho`,
      ).toBe(false);
    }
  });
});

interface OtherRow {
  id: string;
  kind: "choice" | "blank";
  lesson: string | null;
  config: {
    options?: string[];
    correct?: number;
    template?: string;
    blanks?: { answers: string[] }[];
    explanation?: string;
  };
}

describe("exercícios de múltipla escolha e lacunas da migration", () => {
  let others: OtherRow[];
  beforeAll(async () => {
    others = (
      await db.query<OtherRow>(
        "select id, kind, lesson, config from public.exercises where kind <> 'code' order by position",
      )
    ).rows;
  });

  it("existem exemplos dos dois tipos, cada um com a mini-explicação", () => {
    expect(others.some((o) => o.kind === "choice")).toBe(true);
    expect(others.some((o) => o.kind === "blank")).toBe(true);
    for (const o of others)
      expect(o.lesson?.length ?? 0, o.id).toBeGreaterThan(20);
  });
  it("o gabarito acerta e uma resposta errada não passa (mesma lógica do site)", () => {
    for (const o of others) {
      if (o.kind === "choice") {
        const { options, correct } = o.config;
        expect(gradeChoice(o.config, correct!), o.id).toBe(true);
        for (let i = 0; i < options!.length; i++)
          if (i !== correct)
            expect(gradeChoice(o.config, i), `${o.id}/${i}`).toBe(false);
      } else {
        const right = o.config.blanks!.map((b) => b.answers[0]);
        expect(gradeBlanks(o.config, right).passed, o.id).toBe(true);
        expect(
          gradeBlanks(
            o.config,
            right.map(() => "xyz"),
          ).passed,
          o.id,
        ).toBe(false);
        expect(
          gradeBlanks(
            o.config,
            o.config.blanks!.map(() => ""),
          ).passed,
          o.id,
        ).toBe(false);
      }
    }
  });
});

describe("conteúdo extra (migration 0006)", () => {
  it("todos os exercícios extras entram como rascunho e os 17+5 originais continuam publicados", async () => {
    const drafts = await db.query<{ n: number }>(
      "select count(*)::int as n from public.exercises where published = false",
    );
    const live = await db.query<{ n: number }>(
      "select count(*)::int as n from public.exercises where published = true",
    );
    expect(drafts.rows[0].n).toBe(31);
    expect(live.rows[0].n).toBe(22);
  });
  it("módulos novos existem, na ordem certa (depois de Vetores)", async () => {
    const r = await db.query<{ id: string }>(
      "select id from public.modules order by position",
    );
    expect(r.rows.map((m) => m.id)).toEqual([
      "primeiros-passos",
      "fundamentos",
      "condicionais",
      "repeticao",
      "vetores",
      "funcoes",
      "textos",
    ]);
  });
  it("alternativas de cada múltipla escolha são diferentes entre si", async () => {
    const r = await db.query<{ id: string; config: { options: string[] } }>(
      "select id, config from public.exercises where kind = 'choice'",
    );
    for (const row of r.rows) {
      const lower = row.config.options.map((o) => o.toLowerCase());
      expect(new Set(lower).size, row.id).toBe(lower.length);
    }
  });
  it("lacunas numeradas em sequência e com gabarito para cada uma", async () => {
    const r = await db.query<{
      id: string;
      config: { template: string; blanks: { answers: string[] }[] };
    }>("select id, config from public.exercises where kind = 'blank'");
    for (const row of r.rows) {
      const nums = [...row.config.template.matchAll(/\{\{(\d+)\}\}/g)]
        .map((m) => Number(m[1]))
        .sort((a, b) => a - b);
      expect(nums, row.id).toEqual(row.config.blanks.map((_, i) => i + 1));
    }
  });
  it("exercícios de código têm ao menos 3 casos de teste, e não há posições repetidas num módulo", async () => {
    const r = await db.query<{ id: string; n: number }>(
      "select id, jsonb_array_length(tests)::int as n from public.exercises where kind = 'code'",
    );
    for (const row of r.rows) expect(row.n, row.id).toBeGreaterThanOrEqual(3);
    const dup = await db.query(
      "select module_id, position from public.exercises group by module_id, position having count(*) > 1",
    );
    expect(dup.rows).toEqual([]);
  });
});

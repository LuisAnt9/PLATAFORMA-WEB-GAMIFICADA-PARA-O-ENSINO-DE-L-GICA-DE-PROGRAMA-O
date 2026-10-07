import type { PGlite } from "@electric-sql/pglite";
import { beforeAll, describe, expect, it } from "vitest";
import { createDb } from "./helpers";

// Soluções de referência dos exercícios da migration. Ficam só aqui (nunca no site) para não irem ao navegador do aluno.
const solutions: Record<string, string> = {
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
      "select id, function_name, starter_code, tests from public.exercises order by position",
    )
  ).rows;
});

const json = (v: unknown) => JSON.stringify(v);

describe("exercícios da migration", () => {
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

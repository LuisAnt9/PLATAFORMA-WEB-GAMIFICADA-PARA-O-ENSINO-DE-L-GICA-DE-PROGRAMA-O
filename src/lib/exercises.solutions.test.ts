import { describe, expect, it } from "vitest";
import { exercises } from "./exercises";

// Soluções de referência: ficam só aqui (e não em exercises.ts) para não irem ao navegador do aluno.
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

describe("soluções de referência", () => {
  it("existe solução para cada exercício, e só para eles", () => {
    expect(Object.keys(solutions).sort()).toEqual(
      exercises.map((e) => e.id).sort(),
    );
  });

  for (const e of exercises) {
    it(`${e.id}: a solução passa em todos os testes`, () => {
      const fn = new Function(
        `${solutions[e.id]}\n;return ${e.functionName};`,
      )();
      for (const t of e.tests) {
        expect(JSON.stringify(fn(...structuredClone(t.args)))).toBe(
          JSON.stringify(t.expected),
        );
      }
    });

    it(`${e.id}: o código inicial (sem solução) não passa`, () => {
      const fn = new Function(`${e.starterCode}\n;return ${e.functionName};`)();
      const allPass = e.tests.every(
        (t) =>
          JSON.stringify(fn(...structuredClone(t.args))) ===
          JSON.stringify(t.expected),
      );
      expect(allPass).toBe(false);
    });
  }
});

import { describe, expect, it } from "vitest";
import {
  buildImportSql,
  exerciseRow,
  runTests,
  validateContent,
} from "./content-lib.mjs";

const codigo = (over = {}) => ({
  id: "soma",
  tipo: "codigo",
  titulo: "Soma",
  dificuldade: "facil",
  publicado: true,
  posicao: 1,
  conceitos: [{ id: "c1", peso: 1 }],
  enunciado: "Some.",
  funcao: "soma",
  codigoInicial: "function soma(a, b) {}",
  testes: [
    { entrada: [1, 2], esperado: 3 },
    { entrada: [2, 2], esperado: 4 },
  ],
  ...over,
});
const escolha = (over = {}) => ({
  id: "esc",
  tipo: "escolha",
  titulo: "Escolha",
  dificuldade: "facil",
  publicado: true,
  posicao: 2,
  conceitos: [{ id: "c1", peso: 1 }],
  enunciado: "Qual?",
  opcoes: ["a", "b", "c"],
  correta: 1,
  ...over,
});
const lacuna = (over = {}) => ({
  id: "lac",
  tipo: "lacuna",
  titulo: "Lacuna",
  dificuldade: "facil",
  publicado: true,
  posicao: 3,
  conceitos: [{ id: "c1", peso: 1 }],
  enunciado: "Complete.",
  modelo: "{{1}} (x) { } {{2}} { }",
  lacunas: [{ respostas: ["if"] }, { respostas: ["else"] }],
  ...over,
});
const base = (exercicios, lesson = {}, extras = {}) => ({
  worlds: [{ id: "mundo-1", titulo: "M1" }],
  concepts: [{ id: "c1", titulo: "C1", mundo: "mundo-1" }],
  lessons: [
    {
      file: "mundo-1/licao-01-x.json",
      data: {
        id: "l1",
        mundo: "mundo-1",
        titulo: "L1",
        posicao: 1,
        exercicios,
        ...lesson,
      },
    },
  ],
  solutions: { soma: "function soma(a, b) { return a + b; }" },
  ...extras,
});
const erros = (c) => validateContent(c).errors.join("\n");

describe("validateContent: aceita conteúdo correto", () => {
  it("um exercício de cada tipo", () => {
    const r = validateContent(base([codigo(), escolha(), lacuna()]));
    expect(r.errors).toEqual([]);
    expect(r.stats).toMatchObject({
      lessons: 1,
      exercises: 3,
      byKind: { codigo: 1, escolha: 1, lacuna: 1 },
    });
  });
});

describe("validateContent: estrutura e conceitos", () => {
  it("exercício sem conceito", () => {
    expect(erros(base([codigo({ conceitos: [] })]))).toContain("sem conceito");
  });
  it("conceito inexistente, repetido e peso inválido", () => {
    expect(
      erros(base([codigo({ conceitos: [{ id: "nao-existe", peso: 1 }] })])),
    ).toContain('conceito inexistente "nao-existe"');
    expect(
      erros(
        base([
          codigo({
            conceitos: [
              { id: "c1", peso: 1 },
              { id: "c1", peso: 1 },
            ],
          }),
        ]),
      ),
    ).toContain("conceito repetido");
    expect(
      erros(base([codigo({ conceitos: [{ id: "c1", peso: 9 }] })])),
    ).toContain("peso");
  });
  it("mundo inexistente e ids duplicados", () => {
    expect(erros(base([codigo()], { mundo: "mundo-9" }))).toContain(
      'mundo inexistente "mundo-9"',
    );
    expect(erros(base([codigo(), codigo()]))).toContain("duplicado");
    const dup = base([codigo()]);
    dup.lessons.push(structuredClone(dup.lessons[0]));
    expect(erros(dup)).toContain("lição duplicada");
  });
  it("id inválido, tipo inválido, dificuldade inválida, publicado ausente", () => {
    expect(erros(base([codigo({ id: "Soma Maiúscula" })]))).toContain(
      "id inválido",
    );
    expect(erros(base([codigo({ tipo: "desenho" })]))).toContain(
      "tipo inválido",
    );
    expect(erros(base([codigo({ dificuldade: "impossivel" })]))).toContain(
      "dificuldade inválida",
    );
    expect(erros(base([codigo({ publicado: undefined })]))).toContain(
      "publicado",
    );
  });
  it("textos vazios ou grandes demais para o banco", () => {
    expect(erros(base([codigo({ enunciado: " " })]))).toContain("enunciado");
    expect(erros(base([codigo({ titulo: "x".repeat(101) })]))).toContain(
      "título",
    );
    expect(erros(base([codigo({ dica: "x".repeat(501) })]))).toContain("dica");
    expect(erros(base([codigo()], { intro: "x".repeat(3001) }))).toContain(
      "intro",
    );
  });
  it("JSON de lição ilegível", () => {
    const c = base([]);
    c.lessons = [
      {
        file: "mundo-1/ruim.json",
        data: { __erroLeitura: "Unexpected token" },
      },
    ];
    expect(erros(c)).toContain("JSON inválido");
  });
});

describe("validateContent: exercícios de código", () => {
  it("sem solução de referência", () => {
    expect(erros(base([codigo()], {}, { solutions: {} }))).toContain(
      "sem solução de referência",
    );
  });
  it("solução que não passa nos próprios testes", () => {
    const c = base(
      [codigo()],
      {},
      { solutions: { soma: "function soma(a, b) { return a - b; }" } },
    );
    expect(erros(c)).toContain("NÃO passa no teste");
  });
  it("código inicial que já passa em tudo (testes fracos)", () => {
    const c = base([
      codigo({ codigoInicial: "function soma(a, b) { return a + b; }" }),
    ]);
    expect(erros(c)).toContain("código inicial já passa");
  });
  it("nome de função inválido e testes mal formados", () => {
    expect(erros(base([codigo({ funcao: "2soma" })]))).toContain(
      "nome de função inválido",
    );
    expect(erros(base([codigo({ testes: [] })]))).toContain("1 a 30");
    expect(
      erros(base([codigo({ testes: [{ entrada: 1, esperado: 1 }] })])),
    ).toContain('"entrada" deve ser uma lista');
  });
  it("solução com laço infinito é reprovada sem travar", () => {
    const c = base(
      [codigo()],
      {},
      { solutions: { soma: "function soma(){ while(true){} }" } },
    );
    expect(erros(c)).toContain("NÃO passa");
  });
  it("avisa de solução sem exercício", () => {
    const r = validateContent(
      base(
        [codigo()],
        {},
        {
          solutions: { soma: "function soma(a,b){return a+b}", fantasma: "x" },
        },
      ),
    );
    expect(r.warnings.join()).toContain("fantasma");
  });
});

describe("validateContent: múltipla escolha", () => {
  it("alternativas repetidas, vazias, poucas e gabarito fora do intervalo", () => {
    expect(erros(base([escolha({ opcoes: ["a", "A", "c"] })]))).toContain(
      "repetidas",
    );
    expect(erros(base([escolha({ opcoes: ["a", " ", "c"] })]))).toContain(
      "vazia",
    );
    expect(
      erros(base([escolha({ opcoes: ["só uma"], correta: 0 })])),
    ).toContain("2 a 6");
    expect(erros(base([escolha({ correta: 5 })]))).toContain(
      "correta deve ser",
    );
  });
  it("lição diagnóstica exige confusão em cada alternativa errada", () => {
    const sem = base(
      [
        escolha({
          opcoes: ["a", { texto: "b" }, { texto: "c", confusao: "x" }],
          correta: 0,
        }),
      ],
      { diagnostica: true },
    );
    expect(erros(sem)).toContain("alternativa errada 2 precisa");
    const ok = base(
      [
        escolha({
          opcoes: [
            "a",
            { texto: "b", confusao: "m1" },
            { texto: "c", confusao: "m2" },
          ],
          correta: 0,
        }),
      ],
      { diagnostica: true },
    );
    expect(erros(ok)).toBe("");
  });
  it("a alternativa correta não tem confusão e a confusão tem limite", () => {
    expect(
      erros(
        base([
          escolha({ opcoes: [{ texto: "a", confusao: "x" }, "b"], correta: 0 }),
        ]),
      ),
    ).toContain("não deve ter confusão");
    expect(
      erros(
        base([
          escolha({
            opcoes: ["a", { texto: "b", confusao: "x".repeat(201) }],
            correta: 0,
          }),
        ]),
      ),
    ).toContain("200");
  });
});

describe("validateContent: lacunas", () => {
  it("marcadores que não batem com as lacunas", () => {
    expect(erros(base([lacuna({ modelo: "{{1}} e {{3}}" })]))).toContain(
      "não correspondem",
    );
    expect(erros(base([lacuna({ modelo: "{{1}} {{1}}" })]))).toContain(
      "não correspondem",
    );
    expect(erros(base([lacuna({ modelo: "sem marcadores" })]))).toContain(
      "não tem marcadores",
    );
  });
  it("lacuna sem resposta ou com resposta vazia", () => {
    expect(
      erros(
        base([lacuna({ lacunas: [{ respostas: ["if"] }, { respostas: [] }] })]),
      ),
    ).toContain("lacuna 2");
    expect(
      erros(
        base([
          lacuna({ lacunas: [{ respostas: [" "] }, { respostas: ["else"] }] }),
        ]),
      ),
    ).toContain("lacuna 1");
  });
});

describe("runTests", () => {
  it("compara o resultado como o site faz e captura erros", () => {
    const r = runTests(
      "function f(x){ if (x === 0) throw new Error('zero'); return x * 2; }",
      "f",
      [
        { entrada: [2], esperado: 4 },
        { entrada: [3], esperado: 7 },
        { entrada: [0], esperado: 0 },
      ],
    );
    expect(r.map((x) => x.passou)).toEqual([true, false, false]);
    expect(r[2].erro).toBe("zero");
  });
  it("função ausente e erro de sintaxe reprovam tudo", () => {
    expect(
      runTests("var x = 1;", "f", [{ entrada: [], esperado: 1 }])[0].passou,
    ).toBe(false);
    expect(
      runTests("function f(", "f", [{ entrada: [], esperado: 1 }])[0].passou,
    ).toBe(false);
  });
});

describe("buildImportSql", () => {
  it("converte para as colunas do banco e é estável", () => {
    const e = escolha({
      opcoes: ["a", { texto: "b", confusao: "m" }],
      correta: 0,
      explicacao: "Porque sim.",
    });
    expect(exerciseRow(e).config).toEqual({
      options: [{ text: "a" }, { text: "b", misconception: "m" }],
      correct: 0,
      explanation: "Porque sim.",
    });
    expect(exerciseRow(escolha()).config.options).toEqual(["a", "b", "c"]);
    expect(exerciseRow(codigo()).tests).toEqual([
      { args: [1, 2], expected: 3 },
      { args: [2, 2], expected: 4 },
    ]);
    const c = base([codigo(), escolha(), lacuna()]);
    expect(buildImportSql(c)).toBe(buildImportSql(structuredClone(c)));
  });
  it("recusa texto que quebraria o SQL", () => {
    expect(() =>
      buildImportSql(base([escolha({ enunciado: "tem $c$ no meio" })])),
    ).toThrow("$c$");
  });
});

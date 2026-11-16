import { describe, expect, it } from "vitest";
import {
  buildImportSql,
  buildPublishSql,
  buildReviewMarkdown,
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

// ---------------------------------------------------------------------------------------------
// E3: tipos novos, entrada e saída
// ---------------------------------------------------------------------------------------------
const interpretacao = (over = {}) => ({
  id: "int",
  tipo: "interpretacao",
  titulo: "Interpretar",
  dificuldade: "facil",
  publicado: true,
  posicao: 4,
  conceitos: [{ id: "c1", peso: 1 }],
  enunciado: "Qual a saída?",
  codigo: "let x = 1;\nconsole.log(x);",
  opcoes: ["1", { texto: "2", confusao: "soma sem querer" }],
  correta: 0,
  ...over,
});
const ordenacao = (over = {}) => ({
  id: "ord",
  tipo: "ordenacao",
  titulo: "Ordenar",
  dificuldade: "facil",
  publicado: true,
  posicao: 5,
  conceitos: [{ id: "c1", peso: 1 }],
  enunciado: "Ordene.",
  itens: ["Primeiro", "Segundo", "Terceiro"],
  ...over,
});
const corrigir = (over = {}) => ({
  id: "fix",
  tipo: "corrigir",
  titulo: "Corrigir",
  dificuldade: "facil",
  publicado: true,
  posicao: 6,
  conceitos: [{ id: "c1", peso: 1 }],
  enunciado: "Corrija.",
  funcao: "dobro",
  codigoInicial: "function dobro(n) { return n + 2; }",
  testes: [
    { entrada: [3], esperado: 6 },
    { entrada: [5], esperado: 10 },
  ],
  ...over,
});
const saudacao = (over = {}) => ({
  id: "sau",
  tipo: "desafio",
  titulo: "Saudação",
  dificuldade: "medio",
  publicado: true,
  posicao: 7,
  conceitos: [
    { id: "c1", peso: 1 },
    { id: "c2", peso: 1 },
  ],
  enunciado: "Cumprimente.",
  funcao: "saudacao",
  codigoInicial: "function saudacao() {}",
  testes: [{ entrada: [], entradas: ["Ana"], saida: ["Olá, Ana!"] }],
  ...over,
});
const sols = {
  soma: "function soma(a, b) { return a + b; }",
  fix: "function dobro(n) { return n * 2; }",
  sau: "function saudacao() { console.log(`Olá, ${lerEntrada()}!`); }",
};
const completo = (exs, lesson = {}) => {
  const c = base(exs, lesson, { solutions: sols });
  c.concepts.push({ id: "c2", titulo: "C2", mundo: "mundo-1" });
  return c;
};

describe("validateContent: tipos novos", () => {
  it("aceita um exemplo de cada", () => {
    const r = validateContent(
      completo([interpretacao(), ordenacao(), corrigir(), saudacao()]),
    );
    expect(r.errors).toEqual([]);
    expect(r.stats.byKind).toMatchObject({
      interpretacao: 1,
      ordenacao: 1,
      corrigir: 1,
      desafio: 1,
    });
  });
  it("interpretação precisa do trecho de código e herda as regras da escolha", () => {
    expect(erros(completo([interpretacao({ codigo: " " })]))).toContain(
      'campo "codigo"',
    );
    expect(erros(completo([interpretacao({ codigo: undefined })]))).toContain(
      'campo "codigo"',
    );
    expect(erros(completo([interpretacao({ opcoes: ["1", "1"] })]))).toContain(
      "repetidas",
    );
    expect(erros(completo([interpretacao({ correta: 7 })]))).toContain(
      "correta deve ser",
    );
    const diag = completo([interpretacao({ opcoes: ["1", "2"], correta: 0 })], {
      diagnostica: true,
    });
    expect(erros(diag)).toContain("precisa de");
  });
  it("ordenação: de 2 a 10 passos, sem vazio nem repetido", () => {
    expect(erros(completo([ordenacao({ itens: ["só um"] })]))).toContain(
      "2 a 10",
    );
    expect(
      erros(
        completo([
          ordenacao({ itens: Array.from({ length: 11 }, (_, i) => `p${i}`) }),
        ]),
      ),
    ).toContain("2 a 10");
    expect(erros(completo([ordenacao({ itens: ["a", " "] })]))).toContain(
      "passo vazio",
    );
    expect(erros(completo([ordenacao({ itens: ["a", " a "] })]))).toContain(
      "repetidos",
    );
    expect(erros(completo([ordenacao({ itens: undefined })]))).toContain(
      "2 a 10",
    );
  });
  it("corrigir: o defeito precisa reprovar nos testes e a função precisa estar declarada", () => {
    expect(
      erros(
        completo([
          corrigir({ codigoInicial: "function dobro(n) { return n * 2; }" }),
        ]),
      ),
    ).toContain("código com defeito já passa");
    expect(
      erros(
        completo([corrigir({ codigoInicial: "const dobro = (n) => n + 2;" })]),
      ),
    ).toContain('declarar "function dobro');
  });
  it("corrigir: exige solução de referência que passe", () => {
    const c = completo([corrigir()]);
    c.solutions = { fix: "function dobro(n) { return n * 3; }" };
    expect(erros(c)).toContain("NÃO passa");
  });
  it("desafio com um só conceito gera aviso, não erro", () => {
    const r = validateContent(
      completo([saudacao({ conceitos: [{ id: "c1", peso: 1 }] })]),
    );
    expect(r.errors).toEqual([]);
    expect(r.warnings.join()).toContain("vários conceitos");
  });
  it("comentário só vale para exercício com código", () => {
    expect(erros(completo([corrigir({ comentario: "Explicação." })]))).toBe("");
    expect(erros(completo([ordenacao({ comentario: "x" })]))).toContain(
      "comentario",
    );
    expect(
      erros(completo([corrigir({ comentario: "x".repeat(2001) })])),
    ).toContain("comentario");
  });
});

describe("validateContent: testes com entrada e saída", () => {
  it("aceita teste só com saída (sem esperado) e com valor + saída", () => {
    expect(erros(completo([saudacao()]))).toBe("");
    const c = completo([
      saudacao({
        testes: [
          {
            entrada: [],
            entradas: ["Ana"],
            esperado: undefined,
            saida: ["Olá, Ana!"],
          },
        ],
      }),
    ]);
    expect(erros(c)).toBe("");
  });
  it("teste sem esperado e sem saída", () => {
    expect(
      erros(completo([saudacao({ testes: [{ entrada: [] }] })])),
    ).toContain("falta");
  });
  it("entradas e saída malformadas", () => {
    expect(
      erros(
        completo([
          saudacao({
            testes: [{ entrada: [], entradas: "Ana", saida: ["x"] }],
          }),
        ]),
      ),
    ).toContain('"entradas" deve ser uma lista');
    expect(
      erros(completo([saudacao({ testes: [{ entrada: [], saida: "x" }] })])),
    ).toContain('"saida" deve ser uma lista');
    expect(
      erros(completo([saudacao({ testes: [{ entrada: [], saida: [] }] })])),
    ).toContain('"saida" deve ser uma lista');
    expect(
      erros(completo([saudacao({ testes: [{ entrada: [], saida: [1] }] })])),
    ).toContain('"saida" deve ser uma lista');
  });
  it("saída errada reprova a solução", () => {
    const c = completo([
      saudacao({
        testes: [{ entrada: [], entradas: ["Ana"], saida: ["Oi, Ana!"] }],
      }),
    ]);
    expect(erros(c)).toContain("NÃO passa");
  });
});

describe("runTests: entrada e saída", () => {
  it("lerEntrada entrega as entradas em ordem e console.log é capturado", () => {
    const fonte =
      "function soma2() { const a = lerEntrada(); const b = lerEntrada(); console.log('a=', a); console.log(a + b); return 'fim'; }";
    const [r] = runTests(fonte, "soma2", [
      { entrada: [], entradas: [2, 3], esperado: "fim", saida: ["a= 2", "5"] },
    ]);
    expect(r.passou).toBe(true);
    expect(r.linhas).toEqual(["a= 2", "5"]);
  });
  it("sem entradas, lerEntrada devolve undefined; as linhas não vazam entre testes", () => {
    const fonte = "function f() { console.log(String(lerEntrada())); }";
    const r = runTests(fonte, "f", [
      { entrada: [], saida: ["undefined"] },
      { entrada: [], entradas: ["x"], saida: ["x"] },
      { entrada: [], saida: ["undefined"] },
    ]);
    expect(r.map((x) => x.passou)).toEqual([true, true, true]);
  });
  it("saída com linha a mais ou a menos reprova; valor e saída precisam bater juntos", () => {
    const fonte = "function f() { console.log('a'); return 1; }";
    expect(
      runTests(fonte, "f", [{ entrada: [], saida: ["a", "b"] }])[0].passou,
    ).toBe(false);
    expect(
      runTests(fonte, "f", [{ entrada: [], esperado: 2, saida: ["a"] }])[0]
        .passou,
    ).toBe(false);
    expect(
      runTests(fonte, "f", [{ entrada: [], esperado: 1, saida: ["a"] }])[0]
        .passou,
    ).toBe(true);
  });
  it("objetos impressos viram JSON, como no site", () => {
    const fonte = "function f() { console.log([1, 2], { a: 1 }, undefined); }";
    expect(
      runTests(fonte, "f", [
        { entrada: [], saida: ['[1,2] {"a":1} undefined'] },
      ])[0].passou,
    ).toBe(true);
  });
});

describe("buildImportSql: tipos novos e soluções", () => {
  it("converte os tipos novos para as colunas do banco", () => {
    expect(exerciseRow(interpretacao())).toMatchObject({
      kind: "interpretation",
      function_name: null,
      tests: [],
      config: {
        code: "let x = 1;\nconsole.log(x);",
        correct: 0,
        options: [
          { text: "1" },
          { text: "2", misconception: "soma sem querer" },
        ],
      },
    });
    expect(exerciseRow(ordenacao())).toMatchObject({
      kind: "order",
      config: { items: ["Primeiro", "Segundo", "Terceiro"] },
      tests: [],
    });
    expect(exerciseRow(corrigir())).toMatchObject({
      kind: "fix",
      function_name: "dobro",
      starter_code: "function dobro(n) { return n + 2; }",
      tests: [
        { args: [3], expected: 6 },
        { args: [5], expected: 10 },
      ],
    });
    const t = exerciseRow(saudacao()).tests[0];
    expect(t).toEqual({ args: [], inputs: ["Ana"], output: ["Olá, Ana!"] });
    expect("expected" in t).toBe(false);
  });
  it("gera as soluções só dos exercícios com código, com o comentário", () => {
    const c = completo([
      ordenacao(),
      corrigir({ comentario: "O defeito era o operador." }),
      saudacao(),
    ]);
    const sql = buildImportSql(c);
    expect(sql).toContain("insert into public.exercise_solutions");
    expect(sql).toContain("function dobro(n) { return n * 2; }");
    expect(sql).toContain("O defeito era o operador.");
    expect(sql).not.toMatch(/\('ord'/);
    const sem = buildImportSql(completo([ordenacao()]));
    expect(sem).not.toContain("insert into public.exercise_solutions");
  });
});

// ---------------------------------------------------------------------------------------------
// E4: formato das lições, revisão e publicação
// ---------------------------------------------------------------------------------------------
const ex = (id, tipo, dif, extra = {}) => ({
  id,
  tipo,
  titulo: id,
  dificuldade: dif,
  publicado: false,
  posicao: 1,
  conceitos: [
    { id: "c1", peso: 1 },
    { id: "c2", peso: 1 },
  ],
  enunciado: "E?",
  ...extra,
});
const esc = (id, dif) =>
  ex(id, "escolha", dif, {
    opcoes: ["a", { texto: "b", confusao: "x" }],
    correta: 0,
  });
const inter = (id, dif) =>
  ex(id, "interpretacao", dif, {
    codigo: "let x;",
    opcoes: [{ texto: "a", confusao: "x" }, "b"],
    correta: 1,
  });
const completaOk = () => [
  esc("e1", "facil"),
  esc("e2", "medio"),
  esc("e3", "dificil"),
  inter("i1", "facil"),
  inter("i2", "medio"),
];
const lic = (formato, exercicios, extra = {}) =>
  completo(exercicios, {
    formato,
    intro: "Intro",
    exemplo: "Exemplo",
    revisao: "Revisão",
    diagnostica: true,
    ...extra,
  });

describe("validateContent: formato das lições", () => {
  it("lição completa e correta passa", () => {
    expect(erros(lic("completa", completaOk()))).toBe("");
  });
  it("sem formato, nada é exigido", () => {
    expect(erros(completo([esc("e1", "facil")]))).toBe("");
  });
  it("formato desconhecido", () => {
    expect(erros(lic("incompleta", completaOk()))).toContain(
      'formato inválido "incompleta"',
    );
  });
  it("completa exige introdução, exemplo e revisão", () => {
    expect(erros(lic("completa", completaOk(), { intro: "" }))).toContain(
      "introdução",
    );
    expect(erros(lic("completa", completaOk(), { exemplo: " " }))).toContain(
      "exemplo",
    );
    expect(
      erros(lic("completa", completaOk(), { revisao: undefined })),
    ).toContain("revisão");
  });
  it("completa exige 5 exercícios, 2 interpretações e os três níveis de dificuldade", () => {
    expect(erros(lic("completa", completaOk().slice(0, 4)))).toContain(
      "pelo menos 5 exercícios",
    );
    const poucas = [
      esc("e1", "facil"),
      esc("e2", "medio"),
      esc("e3", "dificil"),
      esc("e4", "facil"),
      inter("i1", "facil"),
    ];
    expect(erros(lic("completa", poucas))).toContain(
      "2 exercícios de interpretação",
    );
    const semDificil = completaOk().map((e) =>
      e.dificuldade === "dificil" ? { ...e, dificuldade: "medio" } : e,
    );
    expect(erros(lic("completa", semDificil))).toContain(
      "um exercício difícil",
    );
    const semFacil = completaOk().map((e) =>
      e.dificuldade === "facil" ? { ...e, dificuldade: "medio" } : e,
    );
    expect(erros(lic("completa", semFacil))).toContain("um exercício fácil");
  });
  it("lição diagnóstica exige confusão em cada alternativa errada", () => {
    const ruim = completaOk();
    ruim[0] = ex("e1", "escolha", "facil", {
      opcoes: ["a", "b"],
      correta: 0,
    });
    expect(erros(lic("completa", ruim))).toContain("precisa de");
  });
  it("introdução longa gera só aviso", () => {
    const r = validateContent(
      lic("completa", completaOk(), { intro: "x".repeat(1300) }),
    );
    expect(r.errors).toEqual([]);
    expect(r.warnings.join()).toContain("1200");
  });
  it("desafio: só exercícios difíceis e ao menos um com vários conceitos", () => {
    expect(erros(lic("desafio", [esc("d1", "dificil")]))).toBe("");
    expect(erros(lic("desafio", [esc("d1", "medio")]))).toContain(
      "só tem exercícios difíceis",
    );
    expect(erros(lic("desafio", []))).toContain("pelo menos 1 exercício");
    const um = esc("d1", "dificil");
    um.conceitos = [{ id: "c1", peso: 1 }];
    expect(erros(lic("desafio", [um]))).toContain("vários conceitos");
  });
});

describe("buildPublishSql", () => {
  const c = () => {
    const x = completo(completaOk(), {
      formato: "completa",
      intro: "I",
      exemplo: "E",
      revisao: "R",
    });
    x.lessons.push({
      file: "mundo-1/licao-02-sem-formato.json",
      data: {
        id: "legada",
        mundo: "mundo-1",
        titulo: "Legada",
        posicao: 9,
        exercicios: [esc("legado", "facil")],
      },
    });
    x.lessons.push({
      file: "mundo-2/licao-01-outra.json",
      data: {
        id: "outra",
        mundo: "mundo-2",
        titulo: "Outra",
        posicao: 20,
        formato: "completa",
        intro: "I",
        exemplo: "E",
        revisao: "R",
        exercicios: [esc("outro", "facil")],
      },
    });
    x.worlds.push({ id: "mundo-2", titulo: "M2" });
    return x;
  };
  it("publica só as lições com formato do mundo pedido", () => {
    const sql = buildPublishSql(c(), "mundo-1");
    expect(sql).toContain("set published = true");
    for (const id of ["e1", "e2", "e3", "i1", "i2"])
      expect(sql).toContain(`$c$${id}$c$`);
    expect(sql).not.toContain("$c$legado$c$");
    expect(sql).not.toContain("$c$outro$c$");
    expect(sql).toContain("5 exercício(s) de 1 lição(ões)");
  });
  it("despublica com publish: false", () => {
    expect(buildPublishSql(c(), "mundo-1", { publish: false })).toContain(
      "set published = false",
    );
  });
  it("aceita lições específicas, mesmo sem formato", () => {
    const sql = buildPublishSql(c(), "mundo-1", { lessonIds: ["legada"] });
    expect(sql).toContain("$c$legado$c$");
    expect(sql).not.toContain("$c$e1$c$");
  });
  it("erros claros: lição inexistente e mundo sem lições", () => {
    expect(() =>
      buildPublishSql(c(), "mundo-1", { lessonIds: ["nao-existe"] }),
    ).toThrow("não encontrada");
    expect(() => buildPublishSql(c(), "mundo-9")).toThrow("Nenhuma lição");
  });
});

describe("buildReviewMarkdown", () => {
  const c = () => {
    const x = completo(
      [
        esc("e1", "facil"),
        ex("o1", "ordenacao", "medio", { itens: ["Primeiro", "Segundo"] }),
        ex("l1", "lacuna", "facil", {
          modelo: "{{1}} (x)",
          lacunas: [{ respostas: ["if", "IF"] }],
        }),
        ex("sol", "codigo", "medio", {
          funcao: "soma",
          codigoInicial: "function soma(a, b) {}",
          testes: [
            { entrada: [1, 2], esperado: 3 },
            { entrada: [], entradas: ["a"], saida: ["a"] },
          ],
          comentario: "Comentário.",
        }),
      ],
      {
        formato: "completa",
        intro: "Linha 1\nLinha 2",
        exemplo: "Código aqui",
        revisao: "- ponto",
      },
    );
    x.solutions = { sol: "function soma(a, b) { return a + b; }" };
    x.worlds[0].objetivo = "Objetivo do mundo.";
    return x;
  };
  it("monta o documento com resumo, gabarito, confusões, ordem, lacunas, testes e solução", () => {
    const md = buildReviewMarkdown(c(), "mundo-1");
    expect(md).toContain("# Revisão do conteúdo — M1");
    expect(md).toContain("Nada foi publicado");
    expect(md).toContain("| L1 | 4 | 2 | 2 | 0 |");
    expect(md).toContain("- ✔ **a** (correta)");
    expect(md).toContain("- ✗ b — *confusão: x*");
    expect(md).toContain("1. Primeiro\n2. Segundo");
    expect(md).toContain("lacuna 1: if ou IF");
    expect(md).toContain('imprime ["a"]');
    expect(md).toContain("return a + b");
    expect(md).toContain("**Solução comentada:** Comentário.");
    expect(md).toContain("> Linha 1\n> Linha 2");
    expect(md).toContain("[ ] Aprovada");
  });
  it("erros claros", () => {
    expect(() => buildReviewMarkdown(c(), "mundo-9")).toThrow(
      "Mundo inexistente",
    );
    const sem = c();
    sem.lessons[0].data.formato = undefined;
    expect(() => buildReviewMarkdown(sem, "mundo-1")).toThrow("Nenhuma lição");
  });
});

describe("runTests: valores especiais impressos como no console real", () => {
  it("NaN, Infinity, -Infinity, -0, booleanos e null aparecem como texto, e não como null", () => {
    const fonte =
      "function f() { console.log(0 / 0); console.log(1 / 0, -1 / 0); console.log(-0, true, null); console.log([1, 2], { a: 1 }); }";
    const [r] = runTests(fonte, "f", [
      {
        entrada: [],
        saida: ["NaN", "Infinity -Infinity", "-0 true null", '[1,2] {"a":1}'],
      },
    ]);
    expect(r.linhas).toEqual([
      "NaN",
      "Infinity -Infinity",
      "-0 true null",
      '[1,2] {"a":1}',
    ]);
    expect(r.passou).toBe(true);
  });
});

describe("lições complementares", () => {
  it("aceita true/false e recusa outros valores", () => {
    expect(erros(lic("completa", completaOk(), { complementar: true }))).toBe(
      "",
    );
    expect(
      erros(lic("completa", completaOk(), { complementar: "sim" })),
    ).toContain("complementar");
  });
  it("o SQL de importação grava a coluna optional (true só para as complementares)", () => {
    const c = lic("completa", completaOk(), { complementar: true });
    c.lessons.push({
      file: "mundo-1/licao-02-normal.json",
      data: {
        id: "normal",
        mundo: "mundo-1",
        titulo: "Normal",
        posicao: 5,
        exercicios: [esc("outro-x", "facil")],
      },
    });
    const sql = buildImportSql(c);
    expect(sql).toContain("optional, origem) values");
    expect(sql).toMatch(/\$c\$l1\$c\$[^\n]*, true, \$c\$arquivo\$c\$/);
    expect(sql).toMatch(/\$c\$normal\$c\$[^\n]*, false, \$c\$arquivo\$c\$/);
    expect(sql).toContain("optional = excluded.optional");
  });
});

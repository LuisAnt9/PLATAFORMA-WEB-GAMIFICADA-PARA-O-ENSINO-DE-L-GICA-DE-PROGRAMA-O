import fs from "node:fs";
import path from "node:path";
import { beforeAll, describe, expect, it } from "vitest";
import {
  buildImportSql,
  buildPublishSql,
  loadContent,
} from "../../scripts/content-lib.mjs";
import { createDb } from "./helpers";

// Etapa E2: o SQL gerado a partir de content/ reproduz os exercícios atuais sem alterar ids,
// é idempotente e respeita o que o professor editou no painel.

const root = path.resolve(import.meta.dirname, "../../content");
const content = () => structuredClone(loadContent(root));
const COLS =
  "id, module_id, kind, title, difficulty, statement, lesson, function_name, starter_code, tests, config, hint, position, published";

let db, prof, snapshot;

async function as(uid, sql) {
  await db.exec(
    `set role authenticated; select set_config('request.jwt.claim.sub','${uid}',false);`,
  );
  try {
    return { ok: true, rows: (await db.query(sql)).rows };
  } catch (e) {
    return { ok: false, error: e.message, rows: [] };
  } finally {
    await db.exec("reset role;");
  }
}
const rows = async (sql) => (await db.query(sql)).rows;
// Os 53 exercícios que já existiam antes do conteúdo em arquivos (o resto é conteúdo novo).
const LICOES_MUNDO_2 = [
  "introducao-as-variaveis",
  "declaracao-de-variaveis",
  "let-e-const",
  "tipo-string",
  "tipo-number",
  "tipo-boolean",
  "manipulacao-de-textos",
  "concatenacao",
  "template-literals",
  "operacoes-com-numeros",
  "conversao-de-tipos",
  "entrada-e-saida-de-informacoes",
  "uso-do-console-log",
  "desafio-do-mundo-2",
];
const LICOES_MUNDO_3 = [
  "introducao-aos-operadores",
  "operadores-aritmeticos",
  "operadores-de-atribuicao",
  "operadores-relacionais",
  "operadores-logicos",
  "precedencia-dos-operadores",
  "desafio-do-mundo-3",
];
let idsOriginais = null;
const exercises = () =>
  idsOriginais
    ? db
        .query(
          `select ${COLS} from public.exercises where id = any($1) order by id`,
          [idsOriginais],
        )
        .then((r) => r.rows)
    : rows(`select ${COLS} from public.exercises order by id`);
const one = async (sql) => (await db.query(sql)).rows[0];

beforeAll(async () => {
  db = await createDb();
  const r = await db.query(
    "insert into auth.users(email, raw_user_meta_data) values ('prof@x.com', '{\"name\":\"Prof\"}') returning id",
  );
  prof = r.rows[0].id;
  await db.exec(
    `update public.profiles set role = 'professor' where id = '${prof}'`,
  );
  snapshot = await exercises();
  idsOriginais = snapshot.map((e) => e.id);
}, 60_000);

describe("origem do conteúdo (0011)", () => {
  it("exercícios e lições das migrations já vêm como 'arquivo'", async () => {
    expect(
      (
        await one(
          "select count(*)::int as n from public.exercises where origem = 'arquivo'",
        )
      ).n,
    ).toBe(53);
    expect(
      (
        await one(
          "select count(*)::int as n from public.modules where origem = 'arquivo'",
        )
      ).n,
    ).toBe(7);
  });
  it("editar pelo painel marca a linha como 'painel'; publicar e reordenar não", async () => {
    const ex = "soma";
    expect(
      (
        await as(
          prof,
          `update public.exercises set published = false where id = '${ex}'`,
        )
      ).ok,
    ).toBe(true);
    expect(
      (
        await as(
          prof,
          `update public.exercises set position = position + 100 where id = '${ex}'`,
        )
      ).ok,
    ).toBe(true);
    expect(
      (await one(`select origem from public.exercises where id = '${ex}'`))
        .origem,
    ).toBe("arquivo");
    expect(
      (
        await as(
          prof,
          `update public.exercises set title = 'Somar (editado)' where id = '${ex}'`,
        )
      ).ok,
    ).toBe(true);
    expect(
      (await one(`select origem from public.exercises where id = '${ex}'`))
        .origem,
    ).toBe("painel");
    await db.exec(
      `update public.exercises set title = 'Somar dois números', published = true, position = 1, origem = 'arquivo' where id = '${ex}'`,
    );
  });
  it("migrations e SQL Editor (outro papel) não marcam como 'painel'", async () => {
    await db.exec(
      "update public.exercises set title = 'Somar dois números!' where id = 'soma'",
    );
    expect(
      (await one("select origem from public.exercises where id = 'soma'"))
        .origem,
    ).toBe("arquivo");
    await db.exec(
      "update public.exercises set title = 'Somar dois números' where id = 'soma'",
    );
  });
});

describe("importação do conteúdo", () => {
  it("o arquivo supabase/importar-conteudo.sql está em dia com content/", () => {
    const committed = fs.readFileSync(
      path.resolve(import.meta.dirname, "../importar-conteudo.sql"),
      "utf8",
    );
    expect(committed).toBe(buildImportSql(loadContent(root)));
  });

  it("reproduz os 53 exercícios sem alterar nenhum campo nem id", async () => {
    await db.exec(buildImportSql(content()));
    const depois = await exercises();
    expect(depois).toHaveLength(53);
    expect(depois.map((e) => e.id)).toEqual(snapshot.map((e) => e.id));
    for (let i = 0; i < depois.length; i++)
      expect(depois[i], depois[i].id).toEqual(snapshot[i]);
  });

  it("é idempotente (rodar de novo não muda nada)", async () => {
    await db.exec(buildImportSql(content()));
    expect(await exercises()).toEqual(snapshot);
    expect(
      (await one("select count(*)::int as n from public.exercise_concepts")).n,
    ).toBe(
      (
        await one(
          "select count(*)::int as n from (select distinct exercise_id, concept_id from public.exercise_concepts) x",
        )
      ).n,
    );
  });

  it("cria 7 mundos, 66 conceitos e liga as lições aos mundos", async () => {
    expect(
      (
        await one(
          "select count(*)::int as n from public.worlds where id like 'mundo-%'",
        )
      ).n,
    ).toBe(7);
    expect(
      (await one("select count(*)::int as n from public.concepts")).n,
    ).toBe(66);
    const l = await rows(
      "select id, world_id from public.modules order by position",
    );
    // posições: mundo * 100 + n (primeiros-passos 100; as 8 lições novas do Mundo 1 vão de 101 a 108)
    expect(l.map((m) => m.id)).toEqual([
      "primeiros-passos",
      "o-que-e-programacao",
      "o-que-e-logica",
      "o-que-sao-algoritmos",
      "sequencia-logica",
      "entrada-processamento-saida",
      "pseudocodigo",
      "fluxogramas",
      "desafio-do-mundo-1",
      ...LICOES_MUNDO_2,
      "textos",
      ...LICOES_MUNDO_3,
      "fundamentos",
      "condicionais",
      "repeticao",
      "vetores",
      "funcoes",
      "exemplos-dos-tipos",
    ]);
    expect(l.map((m) => m.world_id)).toEqual([
      ...Array(9).fill("mundo-1"),
      ...Array(LICOES_MUNDO_2.length).fill("mundo-2"),
      "mundo-2", // a lição antiga "textos" (posição 290)
      ...Array(LICOES_MUNDO_3.length).fill("mundo-3"),
      "mundo-3", // a lição antiga "fundamentos" (posição 390)
      "mundo-4",
      "mundo-5",
      "mundo-6",
      "mundo-7",
      "mundo-1",
    ]);
  });

  it("importa os exemplos dos tipos novos como rascunho, com a configuração certa", async () => {
    const e = Object.fromEntries(
      (
        await rows(
          "select id, kind, published, function_name, tests, config from public.exercises where id like 'exemplo-%'",
        )
      ).map((r) => [r.id, r]),
    );
    expect(Object.keys(e).sort()).toEqual([
      "exemplo-corrigir",
      "exemplo-entrada-saida",
      "exemplo-interpretacao",
      "exemplo-ordenacao",
    ]);
    expect(Object.values(e).every((x) => x.published === false)).toBe(true);
    expect(e["exemplo-interpretacao"].kind).toBe("interpretation");
    expect(e["exemplo-interpretacao"].config.code).toContain("console.log(x)");
    expect(e["exemplo-interpretacao"].config.options[0]).toEqual({
      text: "4",
      misconception: "ignora a linha que muda o valor da variável",
    });
    expect(e["exemplo-ordenacao"].config.items).toHaveLength(4);
    expect(e["exemplo-corrigir"].kind).toBe("fix");
    expect(e["exemplo-entrada-saida"].kind).toBe("challenge");
    expect(e["exemplo-entrada-saida"].tests[0]).toEqual({
      args: [],
      inputs: ["Ana"],
      output: ["Olá, Ana!"],
    });
    expect("expected" in e["exemplo-entrada-saida"].tests[0]).toBe(false);
  });

  it("importa as soluções dos exercícios de código (33 + 2 exemplos + 2 do Mundo 1 + 19 do Mundo 2 + 12 do Mundo 3), com o comentário", async () => {
    expect(
      (await one("select count(*)::int as n from public.exercise_solutions")).n,
    ).toBe(68);
    const s = await one(
      "select solution, commentary from public.exercise_solutions where exercise_id = 'exemplo-corrigir'",
    );
    expect(s.solution).toContain("return n * 2");
    expect(s.commentary).toContain("operador");
    const soma = await one(
      "select solution from public.exercise_solutions where exercise_id = 'soma'",
    );
    expect(soma.solution).toContain("return a + b");
  });

  it("todo exercício tem pelo menos um conceito", async () => {
    const sem = await rows(
      "select e.id from public.exercises e where not exists (select 1 from public.exercise_concepts c where c.exercise_id = e.id)",
    );
    expect(sem).toEqual([]);
    const v = await one(
      "select count(*)::int as n from public.exercise_concepts where exercise_id = 'soma'",
    );
    expect(v.n).toBe(2);
  });

  it("atualiza o que o arquivo mudou, enquanto ninguém editou no painel", async () => {
    const c = content();
    const l = c.lessons.find((x) => x.data.id === "fundamentos").data;
    l.exercicios.find((e) => e.id === "soma").enunciado =
      "Enunciado novo vindo do arquivo.";
    await db.exec(buildImportSql(c));
    expect(
      (await one("select statement from public.exercises where id = 'soma'"))
        .statement,
    ).toBe("Enunciado novo vindo do arquivo.");
    await db.exec(buildImportSql(content())); // volta ao original
    expect(await exercises()).toEqual(snapshot);
  });

  it("não sobrescreve exercício editado no painel, mas mantém o vínculo de conceitos dele", async () => {
    await as(
      prof,
      "update public.exercises set statement = 'Texto do professor' where id = 'media'",
    );
    await as(
      prof,
      "insert into public.exercise_concepts (exercise_id, concept_id, weight) values ('media', 'm1-logica', 1)",
    );
    const c = content();
    c.lessons
      .find((x) => x.data.id === "fundamentos")
      .data.exercicios.find((e) => e.id === "media").enunciado = "Do arquivo";
    await db.exec(buildImportSql(c));
    expect(
      await one(
        "select statement, origem from public.exercises where id = 'media'",
      ),
    ).toEqual({
      statement: "Texto do professor",
      origem: "painel",
    });
    const cs = (
      await rows(
        "select concept_id from public.exercise_concepts where exercise_id = 'media' order by 1",
      )
    ).map((r) => r.concept_id);
    expect(cs).toContain("m1-logica");
  });

  it("não altera 'published' nem 'position' de exercícios que já existem", async () => {
    await db.exec(
      "update public.exercises set published = true, position = 77 where id = 'quadrado'",
    ); // rascunho no arquivo
    await db.exec(buildImportSql(content()));
    expect(
      await one(
        "select published, position from public.exercises where id = 'quadrado'",
      ),
    ).toEqual({ published: true, position: 77 });
    await db.exec(
      "update public.exercises set published = false, position = (select position from public.exercises where id = 'media-ponderada') where id = 'quadrado'",
    );
  });

  it("não sobrescreve lição editada no painel", async () => {
    await as(
      prof,
      "update public.modules set title = 'Título do professor' where id = 'vetores'",
    );
    await db.exec(buildImportSql(content()));
    expect(
      await one(
        "select title, origem from public.modules where id = 'vetores'",
      ),
    ).toEqual({ title: "Título do professor", origem: "painel" });
  });

  it("lição e exercício novos entram como o arquivo manda, com origem 'arquivo' e conceitos", async () => {
    const c = content();
    c.lessons.push({
      file: "mundo-2/licao-99-teste.json",
      data: {
        id: "licao-teste",
        mundo: "mundo-2",
        titulo: "Lição de teste",
        foco: "",
        posicao: 50,
        intro: "Intro",
        exemplo: "",
        revisao: "",
        exercicios: [
          {
            id: "teste-novo",
            tipo: "escolha",
            titulo: "Novo",
            dificuldade: "facil",
            publicado: false,
            posicao: 1,
            conceitos: [{ id: "m2-string", peso: 3 }],
            enunciado: "Qual?",
            opcoes: ["a", { texto: "b", confusao: "confunde x com y" }],
            correta: 0,
          },
        ],
      },
    });
    await db.exec(buildImportSql(c));
    const e = await one(
      "select published, origem, config, module_id from public.exercises where id = 'teste-novo'",
    );
    expect(e.published).toBe(false);
    expect(e.origem).toBe("arquivo");
    expect(e.module_id).toBe("licao-teste");
    expect(e.config.options).toEqual([
      { text: "a" },
      { text: "b", misconception: "confunde x com y" },
    ]);
    expect(
      await one(
        "select weight from public.exercise_concepts where exercise_id = 'teste-novo' and concept_id = 'm2-string'",
      ),
    ).toEqual({ weight: 3 });
  });
});

describe("Mundo 1 (E4): importação, rascunho e publicação", () => {
  const novos = async () =>
    (
      await rows(
        "select e.id from public.exercises e join public.modules m on m.id = e.module_id where m.id in ('o-que-e-programacao','o-que-e-logica','o-que-sao-algoritmos','sequencia-logica','entrada-processamento-saida','pseudocodigo','fluxogramas','desafio-do-mundo-1') order by e.id",
      )
    ).map((r) => r.id);

  it("importa as 8 lições e os 47 exercícios, todos como rascunho e com conceitos", async () => {
    await db.exec(buildImportSql(content()));
    expect(await novos()).toHaveLength(47);
    const pub = await one(
      "select count(*)::int as n from public.exercises e join public.modules m on m.id = e.module_id where m.world_id = 'mundo-1' and m.id <> 'primeiros-passos' and m.id <> 'exemplos-dos-tipos' and e.published",
    );
    expect(pub.n).toBe(0);
    const semConceito = await rows(
      "select e.id from public.exercises e join public.modules m on m.id = e.module_id where m.world_id = 'mundo-1' and not exists (select 1 from public.exercise_concepts c where c.exercise_id = e.id)",
    );
    expect(semConceito).toEqual([]);
  });

  it("as alternativas erradas guardam a confusão e a posição da correta varia", async () => {
    const r = await rows(
      "select config from public.exercises where id like 'prog-%' and kind in ('choice','interpretation')",
    );
    for (const x of r) {
      const erradas = x.config.options.filter((_, i) => i !== x.config.correct);
      expect(
        erradas.every((o) => typeof o === "object" && o.misconception),
      ).toBe(true);
    }
    const todas = await rows(
      "select (config ->> 'correct')::int as c from public.exercises e join public.modules m on m.id = e.module_id where m.world_id = 'mundo-1' and kind in ('choice','interpretation') and e.id not in (select id from public.exercises where id like 'exemplo-%') and m.id not in ('primeiros-passos')",
    );
    expect(new Set(todas.map((x) => x.c)).size).toBe(4);
  });

  it("o SQL de publicação publica só o Mundo 1 novo e o de despublicação desfaz", async () => {
    await db.exec(buildPublishSql(content(), "mundo-1"));
    const pub = await rows(
      "select e.id from public.exercises e where e.published and e.module_id in ('o-que-e-programacao','o-que-e-logica','o-que-sao-algoritmos','sequencia-logica','entrada-processamento-saida','pseudocodigo','fluxogramas','desafio-do-mundo-1')",
    );
    expect(pub).toHaveLength(47);
    // exercícios de outros mundos e os exemplos continuam como estavam
    expect(
      (
        await one(
          "select published from public.exercises where id = 'exemplo-ordenacao'",
        )
      ).published,
    ).toBe(false);
    expect(
      (
        await one(
          "select published from public.exercises where id = 'quadrado'",
        )
      ).published,
    ).toBe(false);
    expect(
      (await one("select published from public.exercises where id = 'soma'"))
        .published,
    ).toBe(true);
    await db.exec(buildPublishSql(content(), "mundo-1", { publish: false }));
    expect(
      (
        await one(
          "select count(*)::int as n from public.exercises where published and module_id = 'pseudocodigo'",
        )
      ).n,
    ).toBe(0);
  });

  it("publicação parcial: só as lições pedidas", async () => {
    await db.exec(
      buildPublishSql(content(), "mundo-1", { lessonIds: ["fluxogramas"] }),
    );
    expect(
      (
        await one(
          "select count(*)::int as n from public.exercises where published and module_id = 'fluxogramas'",
        )
      ).n,
    ).toBe(6);
    expect(
      (
        await one(
          "select count(*)::int as n from public.exercises where published and module_id = 'pseudocodigo'",
        )
      ).n,
    ).toBe(0);
    await db.exec(
      buildPublishSql(content(), "mundo-1", {
        lessonIds: ["fluxogramas"],
        publish: false,
      }),
    );
  });

  it("os exercícios de entrada e saída do Mundo 1 são importados com entradas simuladas e saída", async () => {
    const e = await one(
      "select tests, kind from public.exercises where id = 'eps-dobro'",
    );
    expect(e.kind).toBe("code");
    expect(e.tests[0]).toEqual({ args: [], inputs: [4], output: ["8"] });
  });
});

describe("Mundo 2 (E5): importação, rascunho e publicação", () => {
  const lista = LICOES_MUNDO_2.map((l) => `'${l}'`).join(",");
  const doMundo2 = () =>
    rows(
      `select e.* from public.exercises e where e.module_id in (${lista}) order by e.id`,
    );

  it("importa as 14 lições e os 99 exercícios, todos como rascunho e com conceitos", async () => {
    await db.exec(buildImportSql(content()));
    const ex = await doMundo2();
    expect(ex).toHaveLength(99);
    expect(ex.every((e) => e.published === false)).toBe(true);
    const sem = await rows(
      `select e.id from public.exercises e where e.module_id in (${lista}) and not exists (select 1 from public.exercise_concepts c where c.exercise_id = e.id)`,
    );
    expect(sem).toEqual([]);
    const conceitos = await rows(
      `select distinct c.concept_id from public.exercise_concepts c join public.exercises e on e.id = c.exercise_id where e.module_id in (${lista}) and c.concept_id like 'm2-%' order by 1`,
    );
    expect(conceitos).toHaveLength(13); // todos os conceitos do mundo são avaliados
  });

  it("toda alternativa errada das questões de escolha traz a confusão", async () => {
    const q = await doMundo2();
    const escolha = q.filter(
      (e) => e.kind === "choice" || e.kind === "interpretation",
    );
    expect(escolha.length).toBeGreaterThan(50);
    for (const e of escolha) {
      const erradas = e.config.options.filter((_, i) => i !== e.config.correct);
      expect(
        erradas.every((o) => typeof o === "object" && o.misconception),
        e.id,
      ).toBe(true);
    }
    expect(new Set(escolha.map((e) => e.config.correct)).size).toBe(4);
  });

  it("os exercícios de entrada e saída chegam com entradas simuladas e saída esperada", async () => {
    const e = await one(
      "select tests, kind from public.exercises where id = 'desafio2-ficha-da-pessoa'",
    );
    expect(e.kind).toBe("challenge");
    expect(e.tests[0].inputs).toEqual(["Ana", "20", "1.75"]);
    expect(e.tests[0].output).toHaveLength(4);
    expect("expected" in e.tests[0]).toBe(false);
  });

  it("publicar o Mundo 2 publica só as lições novas (a lição antiga de textos continua rascunho)", async () => {
    await db.exec(buildPublishSql(content(), "mundo-2"));
    expect((await doMundo2()).every((e) => e.published)).toBe(true);
    expect(
      (
        await one(
          "select count(*)::int as n from public.exercises where module_id = 'textos' and published",
        )
      ).n,
    ).toBe(0);
    await db.exec(buildPublishSql(content(), "mundo-2", { publish: false }));
    expect((await doMundo2()).some((e) => e.published)).toBe(false);
  });
});

describe("Mundo 3 (E6): importação, rascunho e publicação", () => {
  const lista = LICOES_MUNDO_3.map((l) => `'${l}'`).join(",");
  const doMundo3 = () =>
    rows(
      `select e.* from public.exercises e where e.module_id in (${lista}) order by e.id`,
    );

  it("importa as 7 lições e os 54 exercícios, todos como rascunho e com conceitos", async () => {
    await db.exec(buildImportSql(content()));
    const ex = await doMundo3();
    expect(ex).toHaveLength(54);
    expect(ex.every((e) => e.published === false)).toBe(true);
    const sem = await rows(
      `select e.id from public.exercises e where e.module_id in (${lista}) and not exists (select 1 from public.exercise_concepts c where c.exercise_id = e.id)`,
    );
    expect(sem).toEqual([]);
    const conceitos = await rows(
      `select distinct c.concept_id from public.exercise_concepts c join public.exercises e on e.id = c.exercise_id where e.module_id in (${lista}) and c.concept_id like 'm3-%' order by 1`,
    );
    expect(conceitos).toHaveLength(6); // todos os conceitos do mundo são avaliados
  });

  it("toda alternativa errada das questões de escolha traz a confusão", async () => {
    const escolha = (await doMundo3()).filter(
      (e) => e.kind === "choice" || e.kind === "interpretation",
    );
    expect(escolha.length).toBeGreaterThan(25);
    for (const e of escolha) {
      const erradas = e.config.options.filter((_, i) => i !== e.config.correct);
      expect(
        erradas.every((o) => typeof o === "object" && o.misconception),
        e.id,
      ).toBe(true);
    }
    expect(new Set(escolha.map((e) => e.config.correct)).size).toBe(4);
  });

  it("a calculadora tem teste de divisão por zero com saída Infinity e NaN", async () => {
    const e = await one(
      "select tests from public.exercises where id = 'desafio3-calculadora'",
    );
    const zero = e.tests.find((t) => t.inputs[1] === "0");
    expect(zero.output).toContain("Divisão: Infinity");
    expect(zero.output).toContain("Resto: NaN");
  });

  it("publicar o Mundo 3 não mexe na lição antiga (que continua com seus exercícios publicados)", async () => {
    await db.exec(buildPublishSql(content(), "mundo-3"));
    expect((await doMundo3()).every((e) => e.published)).toBe(true);
    expect(
      (await one("select published from public.exercises where id = 'soma'"))
        .published,
    ).toBe(true);
    await db.exec(buildPublishSql(content(), "mundo-3", { publish: false }));
    expect((await doMundo3()).some((e) => e.published)).toBe(false);
    expect(
      (await one("select published from public.exercises where id = 'soma'"))
        .published,
    ).toBe(true);
  });
});

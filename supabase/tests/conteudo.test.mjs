import fs from "node:fs";
import path from "node:path";
import { beforeAll, describe, expect, it } from "vitest";
import { buildImportSql, loadContent } from "../../scripts/content-lib.mjs";
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
const exercises = () =>
  rows(`select ${COLS} from public.exercises order by id`);
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
    expect(l.map((m) => m.world_id)).toEqual([
      "mundo-1",
      "mundo-3",
      "mundo-4",
      "mundo-5",
      "mundo-6",
      "mundo-7",
      "mundo-2",
    ]);
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

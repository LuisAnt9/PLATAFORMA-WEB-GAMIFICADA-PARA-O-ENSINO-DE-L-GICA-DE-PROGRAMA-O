import type { PGlite } from "@electric-sql/pglite";
import { beforeAll, describe, expect, it } from "vitest";
import { createDb } from "./helpers";

// Etapa E3 (migration 0012): tipos novos de exercício, nível de dica e solução comentada.

let db: PGlite;
let ana: string, bia: string, prof: string;

async function as(uid: string | null, sql: string) {
  await db.exec(
    `set role ${uid ? "authenticated" : "anon"}; select set_config('request.jwt.claim.sub','${uid ?? ""}',false);`,
  );
  try {
    return {
      ok: true as const,
      rows: (await db.query<Record<string, unknown>>(sql)).rows,
    };
  } catch (e) {
    return {
      ok: false as const,
      error: (e as Error).message,
      rows: [] as Record<string, unknown>[],
    };
  } finally {
    await db.exec("reset role;");
  }
}

async function newUser(email: string, name: string) {
  const r = await db.query<{ id: string }>(
    `insert into auth.users(email, raw_user_meta_data) values ($1, $2) returning id`,
    [email, JSON.stringify({ name })],
  );
  return r.rows[0].id;
}

const insert = (
  id: string,
  kind: string,
  fn: string | null,
  tests: string,
  config: object,
  published = true,
) =>
  db
    .exec(
      `insert into public.exercises (id, module_id, kind, title, difficulty, statement, function_name, starter_code, tests, config, published)
       values ('${id}', 'primeiros-passos', '${kind}', 'T', 'facil', 'S', ${fn ? `'${fn}'` : "null"}, '', '${tests}'::jsonb, '${JSON.stringify(config).replace(/'/g, "''")}'::jsonb, ${published})`,
    )
    .then(
      () => true,
      () => false,
    );

const attempt = (uid: string, ex: string, args: string) =>
  as(
    uid,
    `select public.record_attempt(p_exercise => '${ex}', ${args.includes("p_passed") ? "" : "p_passed => false, "}${args}) as id`,
  );
const last = async (uid: string, cols: string) =>
  (
    await as(
      uid,
      `select ${cols} from public.attempts order by id desc limit 1`,
    )
  ).rows[0];

beforeAll(async () => {
  db = await createDb();
  ana = await newUser("ana@x.com", "Ana");
  bia = await newUser("bia@x.com", "Bia");
  prof = await newUser("prof@x.com", "Prof");
  await db.exec(
    `update public.profiles set role='professor' where id='${prof}'`,
  );
});

describe("0012: restrições dos tipos de exercício", () => {
  const opts = ["a", "b"];
  it("interpretação: exige código e alternativas como na escolha", async () => {
    expect(
      await insert("i-ok", "interpretation", null, "[]", {
        code: "let x = 1;",
        options: opts,
        correct: 0,
      }),
    ).toBe(true);
    expect(
      await insert("i-sem-codigo", "interpretation", null, "[]", {
        options: opts,
        correct: 0,
      }),
    ).toBe(false);
    expect(
      await insert("i-codigo-vazio", "interpretation", null, "[]", {
        code: "",
        options: opts,
        correct: 0,
      }),
    ).toBe(false);
    expect(
      await insert("i-correta-fora", "interpretation", null, "[]", {
        code: "x",
        options: opts,
        correct: 5,
      }),
    ).toBe(false);
  });
  it("ordenação: de 2 a 10 passos", async () => {
    expect(
      await insert("o-ok", "order", null, "[]", {
        items: ["um", "dois", "três"],
      }),
    ).toBe(true);
    expect(await insert("o-1", "order", null, "[]", { items: ["só um"] })).toBe(
      false,
    );
    expect(
      await insert("o-11", "order", null, "[]", {
        items: Array.from({ length: 11 }, (_, i) => `p${i}`),
      }),
    ).toBe(false);
    expect(await insert("o-sem", "order", null, "[]", {})).toBe(false);
  });
  it("corrigir e desafio: precisam de função e testes; os outros tipos não podem ter", async () => {
    const t = '[{"args":[1],"expected":1}]';
    expect(await insert("f-ok", "fix", "f", t, {})).toBe(true);
    expect(await insert("c-ok", "challenge", "g", t, {})).toBe(true);
    expect(await insert("f-sem-funcao", "fix", null, t, {})).toBe(false);
    expect(await insert("c-sem-testes", "challenge", "g", "[]", {})).toBe(
      false,
    );
    expect(
      await insert("o-com-funcao", "order", "f", "[]", { items: ["a", "b"] }),
    ).toBe(false);
    expect(
      await insert("i-com-testes", "interpretation", null, t, {
        code: "x",
        options: opts,
        correct: 0,
      }),
    ).toBe(false);
  });
  it("tipo desconhecido é recusado e os tipos antigos continuam valendo", async () => {
    expect(await insert("x-desconhecido", "desenho", null, "[]", {})).toBe(
      false,
    );
    expect(
      await insert("ch-ok", "choice", null, "[]", {
        options: opts,
        correct: 1,
      }),
    ).toBe(true);
    expect(
      await insert("ch-com-codigo-obrigatorio", "choice", null, "[]", {
        options: ["só"],
        correct: 0,
      }),
    ).toBe(false);
  });
});

describe("0012: tentativas dos tipos novos", () => {
  beforeAll(async () => {
    await insert("int-1", "interpretation", null, "[]", {
      code: "let x = 4;\nx = x + 3;",
      options: ["4", { text: "3", misconception: "ignora a soma" }, "7"],
      correct: 2,
    });
    await insert("ord-1", "order", null, "[]", {
      items: ["Abrir a porta", "Entrar", "Fechar a porta"],
    });
  });
  it("interpretação: acerto e confusão calculados no servidor", async () => {
    await attempt(ana, "int-1", "p_passed => true, p_selected => 1");
    expect(
      await last(ana, "passed, error_category, misconception, kind"),
    ).toEqual({
      passed: false,
      error_category: "escolha_incorreta",
      misconception: "ignora a soma",
      kind: "interpretation",
    });
    await attempt(ana, "int-1", "p_selected => 2");
    expect(await last(ana, "passed")).toEqual({ passed: true });
  });
  it("ordenação: o acerto vem da comparação no servidor", async () => {
    const certa = JSON.stringify(["Abrir a porta", "Entrar", "Fechar a porta"]);
    const errada = JSON.stringify([
      "Entrar",
      "Abrir a porta",
      "Fechar a porta",
    ]);
    await attempt(ana, "ord-1", `p_passed => true, p_answer => '${errada}'`);
    expect(await last(ana, "passed, error_category, kind")).toEqual({
      passed: false,
      error_category: "ordem_incorreta",
      kind: "order",
    });
    await attempt(ana, "ord-1", `p_passed => false, p_answer => '${certa}'`);
    expect(await last(ana, "passed, error_category")).toEqual({
      passed: true,
      error_category: null,
    });
  });
  it("ordenação: resposta que não é uma lista é recusada", async () => {
    expect((await attempt(ana, "ord-1", "p_answer => 'texto solto'")).ok).toBe(
      false,
    );
    expect((await attempt(ana, "ord-1", "p_answer => '{\"a\":1}'")).ok).toBe(
      false,
    );
    expect((await attempt(ana, "ord-1", "p_passed => false")).ok).toBe(false);
  });
  it("corrigir e desafio funcionam como código", async () => {
    await attempt(
      ana,
      "f-ok",
      "p_passed => false, p_error_category => 'execucao', p_tests_passed => 0, p_tests_total => 1",
    );
    expect(await last(ana, "kind, error_category")).toEqual({
      kind: "fix",
      error_category: "execucao",
    });
    await attempt(ana, "c-ok", "p_passed => false");
    expect(await last(ana, "kind, error_category")).toEqual({
      kind: "challenge",
      error_category: "saida_incorreta",
    });
  });
  it("registra o nível de dica usado (0 a 3) e recusa valores inválidos", async () => {
    await attempt(ana, "f-ok", "p_passed => true, p_hint_level => 2");
    expect(await last(ana, "hint_level")).toEqual({ hint_level: 2 });
    await attempt(ana, "f-ok", "p_passed => true");
    expect(await last(ana, "hint_level")).toEqual({ hint_level: 0 });
    expect((await attempt(ana, "f-ok", "p_hint_level => 4")).ok).toBe(false);
    expect((await attempt(ana, "f-ok", "p_hint_level => -1")).ok).toBe(false);
  });
});

describe("0012: solução comentada", () => {
  beforeAll(async () => {
    await db.exec(
      "insert into public.exercise_solutions (exercise_id, solution, commentary) values ('f-ok', 'function f(x){return x}', 'Devolve o próprio valor.')",
    );
  });
  it("aluno não lê a tabela e não consegue escrever nela", async () => {
    expect(
      (await as(bia, "select * from public.exercise_solutions")).rows,
    ).toEqual([]);
    expect(
      (
        await as(
          bia,
          "insert into public.exercise_solutions (exercise_id, solution) values ('c-ok', 'x')",
        )
      ).ok,
    ).toBe(false);
    expect(
      (await as(bia, "update public.exercise_solutions set solution = 'x'"))
        .rows,
    ).toEqual([]);
    expect((await as(null, "select * from public.exercise_solutions")).ok).toBe(
      false,
    );
  });
  it("só entrega a solução a quem já acertou o exercício", async () => {
    const antes = await as(bia, "select * from public.get_solution('f-ok')");
    expect(antes.ok).toBe(false);
    expect(antes.error).toContain("ACERTE_PRIMEIRO");
    await attempt(bia, "f-ok", "p_passed => false"); // errar não libera
    expect(
      (await as(bia, "select * from public.get_solution('f-ok')")).ok,
    ).toBe(false);
    await attempt(bia, "f-ok", "p_passed => true");
    const depois = await as(bia, "select * from public.get_solution('f-ok')");
    expect(depois.rows).toEqual([
      {
        solution: "function f(x){return x}",
        commentary: "Devolve o próprio valor.",
      },
    ]);
  });
  it("acertar um exercício não libera a solução de outro; visitante não recebe", async () => {
    expect(
      (await as(bia, "select * from public.get_solution('c-ok')")).ok,
    ).toBe(false);
    expect(
      (await as(null, "select * from public.get_solution('f-ok')")).ok,
    ).toBe(false);
  });
  it("professor recebe a solução sem precisar acertar", async () => {
    expect(
      (await as(prof, "select * from public.get_solution('f-ok')")).rows,
    ).toHaveLength(1);
  });
  it("exercício sem solução cadastrada devolve vazio para quem acertou", async () => {
    await attempt(ana, "c-ok", "p_passed => true");
    expect(
      (await as(ana, "select * from public.get_solution('c-ok')")).rows,
    ).toEqual([]);
  });
});

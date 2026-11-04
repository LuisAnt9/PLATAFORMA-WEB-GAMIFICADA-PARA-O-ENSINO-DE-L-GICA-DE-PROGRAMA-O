import type { PGlite } from "@electric-sql/pglite";
import { beforeAll, describe, expect, it } from "vitest";
import { createDb } from "./helpers";

// Etapa E1 (migration 0010): mundos, conceitos e registro de tentativas.

let db: PGlite;
let ana: string, bia: string, prof: string, prof2: string;

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

const attempt = (
  uid: string,
  exercise: string,
  args: Record<string, string | number | boolean | null> = {},
) => {
  const a = { p_passed: false, ...args };
  const list = (
    Object.entries(a) as [string, string | number | boolean | null][]
  )
    .map(
      ([k, v]) =>
        `${k} => ${v === null ? "null" : typeof v === "string" ? `'${v.replace(/'/g, "''")}'` : v}`,
    )
    .join(", ");
  return as(
    uid,
    `select public.record_attempt(p_exercise => '${exercise}', ${list}) as id`,
  );
};
const count = async (uid: string, where = "true") =>
  (
    await as(
      uid,
      `select count(*)::int as n from public.attempts where ${where}`,
    )
  ).rows[0].n;

beforeAll(async () => {
  db = await createDb();
  ana = await newUser("ana@x.com", "Ana");
  bia = await newUser("bia@x.com", "Bia");
  prof = await newUser("prof@x.com", "Prof");
  prof2 = await newUser("prof2@x.com", "Prof Dois");
  await db.exec(
    `update public.profiles set role='professor' where id in ('${prof}','${prof2}')`,
  );
  const c = await as(prof, "select * from public.create_class('Turma 1')");
  const code = String(c.rows[0].code ?? Object.values(c.rows[0])[1]);
  await as(ana, `select * from public.join_class('${code}')`);
  await db.exec(`
    insert into public.exercises (id, module_id, kind, title, difficulty, statement, function_name, starter_code, tests, config, published)
    values
      ('conf-1', 'primeiros-passos', 'choice', 'Com confusões', 'facil', 'Qual?', null, '', '[]'::jsonb,
       '{"options":[{"text":"certa"},{"text":"errada A","misconception":"confunde && com ||"},"errada B"],"correct":0}'::jsonb, true),
      ('rascunho-1', 'primeiros-passos', 'choice', 'Rascunho', 'facil', 'Qual?', null, '', '[]'::jsonb,
       '{"options":["a","b"],"correct":0}'::jsonb, false);
  `);
});

describe("0010: mundos e lições", () => {
  it("lições existentes ficam no mundo provisório e ganham campos novos", async () => {
    const r = await db.query<{ n: number; w: number }>(
      "select count(*)::int as n, count(*) filter (where world_id = 'trilha-atual')::int as w from public.modules",
    );
    expect(r.rows[0].n).toBe(r.rows[0].w);
    const cols = await db.query<{ example: string; review: string }>(
      "select example, review from public.modules limit 1",
    );
    expect(cols.rows[0]).toEqual({ example: "", review: "" });
  });
  it("todos leem os mundos; só professor cria e edita", async () => {
    expect(
      (await as(ana, "select * from public.worlds")).rows.length,
    ).toBeGreaterThan(0);
    expect((await as(null, "select * from public.worlds")).ok).toBe(false);
    expect(
      (await as(ana, "insert into public.worlds (id, title) values ('x','X')"))
        .ok,
    ).toBe(false);
    expect(
      (
        await as(
          prof,
          "insert into public.worlds (id, title) values ('mundo-1','Mundo 1')",
        )
      ).ok,
    ).toBe(true);
    expect(
      (await as(ana, "update public.worlds set title='Y' where id='mundo-1'"))
        .rows,
    ).toEqual([]);
    expect(
      (
        await as(
          prof,
          "update public.modules set world_id='mundo-1', example='ex', review='rev' where id='primeiros-passos'",
        )
      ).ok,
    ).toBe(true);
    expect(
      (
        await as(
          prof,
          `update public.modules set review='${"x".repeat(1501)}' where id='primeiros-passos'`,
        )
      ).ok,
    ).toBe(false);
  });
});

describe("0010: conceitos", () => {
  it("professor cadastra conceitos e liga exercícios; aluno só lê", async () => {
    expect(
      (
        await as(
          prof,
          "insert into public.concepts (id, title, world_id) values ('operadores-logicos','Operadores lógicos','mundo-1')",
        )
      ).ok,
    ).toBe(true);
    expect(
      (
        await as(
          ana,
          "insert into public.concepts (id, title) values ('x','X')",
        )
      ).ok,
    ).toBe(false);
    expect(
      (
        await as(
          prof,
          "insert into public.exercise_concepts (exercise_id, concept_id, weight) values ('conf-1','operadores-logicos',3), ('rascunho-1','operadores-logicos',1)",
        )
      ).ok,
    ).toBe(true);
    expect(
      (
        await as(
          ana,
          "insert into public.exercise_concepts (exercise_id, concept_id) values ('conf-1','operadores-logicos')",
        )
      ).ok,
    ).toBe(false);
    expect(
      (
        await as(
          prof,
          "insert into public.exercise_concepts (exercise_id, concept_id, weight) values ('conf-1','operadores-logicos',9)",
        )
      ).ok,
    ).toBe(false);
  });
  it("aluno não vê a ligação de exercício em rascunho", async () => {
    const r = await as(
      ana,
      "select exercise_id from public.exercise_concepts order by 1",
    );
    expect(r.rows.map((x) => x.exercise_id)).toEqual(["conf-1"]);
    expect(
      (await as(prof, "select exercise_id from public.exercise_concepts")).rows,
    ).toHaveLength(2);
  });
});

describe("0010: tentativas", () => {
  it("visitante não registra; ninguém insere, edita ou apaga direto", async () => {
    expect(
      (await attempt(null as unknown as string, "conf-1", { p_selected: 0 }))
        .ok,
    ).toBe(false);
    for (const sql of [
      `insert into public.attempts (user_id, exercise_id, kind, passed) values ('${ana}','conf-1','choice',true)`,
      "update public.attempts set passed = true",
      "delete from public.attempts",
    ]) {
      expect((await as(ana, sql)).ok, sql).toBe(false);
    }
  });
  it("múltipla escolha: acerto e confusão são calculados no servidor", async () => {
    // o navegador "diz" que acertou, mas marcou a alternativa errada A
    const r = await attempt(ana, "conf-1", {
      p_passed: true,
      p_selected: 1,
      p_answer: '{"selected":1}',
    });
    expect(r.ok).toBe(true);
    const row = (
      await as(
        ana,
        "select passed, error_category, misconception, kind from public.attempts order by id desc limit 1",
      )
    ).rows[0];
    expect(row).toEqual({
      passed: false,
      error_category: "escolha_incorreta",
      misconception: "confunde && com ||",
      kind: "choice",
    });
    await attempt(ana, "conf-1", { p_selected: 2 });
    expect(
      (
        await as(
          ana,
          "select misconception from public.attempts order by id desc limit 1",
        )
      ).rows[0].misconception,
    ).toBeNull();
    await attempt(ana, "conf-1", { p_selected: 0 });
    expect(
      (
        await as(
          ana,
          "select passed, error_category from public.attempts order by id desc limit 1",
        )
      ).rows[0],
    ).toEqual({ passed: true, error_category: null });
  });
  it("alternativa inexistente ou ausente é recusada", async () => {
    expect((await attempt(ana, "conf-1", { p_selected: 9 })).ok).toBe(false);
    expect((await attempt(ana, "conf-1", {})).ok).toBe(false);
  });
  it("código: aceita categoria do executor e o tipo vem do banco", async () => {
    const r = await attempt(ana, "soma", {
      p_answer: "function soma(){}",
      p_tests_passed: 1,
      p_tests_total: 3,
      p_error_category: "saida_incorreta",
      p_duration_ms: 4200,
    });
    expect(r.ok).toBe(true);
    const row = (
      await as(
        ana,
        "select kind, passed, tests_passed, tests_total, error_category, duration_ms from public.attempts order by id desc limit 1",
      )
    ).rows[0];
    expect(row).toEqual({
      kind: "code",
      passed: false,
      tests_passed: 1,
      tests_total: 3,
      error_category: "saida_incorreta",
      duration_ms: 4200,
    });
    await attempt(ana, "soma", { p_error_category: "sintaxe" });
    expect(
      (
        await as(
          ana,
          "select error_category from public.attempts order by id desc limit 1",
        )
      ).rows[0].error_category,
    ).toBe("sintaxe");
    await attempt(ana, "soma", { p_passed: true, p_error_category: "sintaxe" });
    expect(
      (
        await as(
          ana,
          "select passed, error_category from public.attempts order by id desc limit 1",
        )
      ).rows[0],
    ).toEqual({ passed: true, error_category: null });
  });
  it("rejeita categoria inventada, testes incoerentes, modalidade inválida e exercício inexistente", async () => {
    expect(
      (await attempt(ana, "soma", { p_error_category: "burrice" })).ok,
    ).toBe(false);
    expect(
      (await attempt(ana, "soma", { p_tests_passed: 5, p_tests_total: 3 })).ok,
    ).toBe(false);
    expect((await attempt(ana, "soma", { p_mode: "trapaca" })).ok).toBe(false);
    expect((await attempt(ana, "nao-existe", {})).ok).toBe(false);
    expect((await attempt(ana, "soma", { p_duration_ms: -5 })).ok).toBe(false);
  });
  it("aluno não registra tentativa de rascunho; professor pode", async () => {
    expect((await attempt(ana, "rascunho-1", { p_selected: 0 })).ok).toBe(
      false,
    );
    expect((await attempt(prof, "rascunho-1", { p_selected: 0 })).ok).toBe(
      true,
    );
  });
  it("resposta enorme é cortada em 4000 caracteres", async () => {
    await attempt(ana, "soma", { p_answer: "x".repeat(9000) });
    const n = (
      await as(
        ana,
        "select char_length(answer)::int as n from public.attempts order by id desc limit 1",
      )
    ).rows[0].n;
    expect(n).toBe(4000);
  });
  it("visibilidade: o aluno vê só as dele; o professor, só as da própria turma", async () => {
    await attempt(bia, "soma", { p_passed: true });
    expect(await count(ana, `user_id = '${bia}'`)).toBe(0);
    expect(await count(bia)).toBe(1);
    expect(await count(prof, `user_id = '${ana}'`)).toBeGreaterThan(0); // ana está na turma de prof
    expect(await count(prof, `user_id = '${bia}'`)).toBe(0); // bia não está
    expect(await count(prof2)).toBe(0); // outro professor, sem turma
  });
  it("limita 60 tentativas por minuto", async () => {
    const carlos = await newUser("carlos@x.com", "Carlos");
    for (let i = 0; i < 60; i++) {
      expect((await attempt(carlos, "soma", {})).ok).toBe(true);
    }
    const r = await attempt(carlos, "soma", {});
    expect(r.ok).toBe(false);
    expect(r.error).toContain("MUITAS_TENTATIVAS");
    expect(await count(carlos)).toBe(60);
  });
});

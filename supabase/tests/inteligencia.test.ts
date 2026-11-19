/* eslint-disable @typescript-eslint/no-explicit-any -- o relatório é um JSON solto, lido de forma flexível nos testes */
import type { PGlite } from "@electric-sql/pglite";
import { beforeAll, describe, expect, it } from "vitest";
import { conceptReport, type AttemptRow, type LinkRow } from "../../src/lib/concept-analytics";
import { createDb } from "./helpers";

// Etapa E11 (migration 0016). DADOS DE SIMULAÇÃO: alunos e tentativas fictícios, gerados só neste teste.

let db: PGlite;
let prof: string, prof2: string, outsider: string;
let turma: string, turma2: string;
const alunos: string[] = [];
const nomes = ["Ana", "Bia", "Caio", "Dani", "Edu", "Fabi"];

async function as(uid: string, sql: string) {
  await db.exec(`set role authenticated; select set_config('request.jwt.claim.sub','${uid}',false);`);
  try {
    return { ok: true as const, rows: (await db.query<Record<string, unknown>>(sql)).rows };
  } catch (e) {
    return { ok: false as const, error: (e as Error).message, rows: [] as Record<string, unknown>[] };
  } finally {
    await db.exec("reset role;");
  }
}
async function newUser(email: string, name: string) {
  const r = await db.query<{ id: string }>(`insert into auth.users(email, raw_user_meta_data) values ($1, $2) returning id`, [email, JSON.stringify({ name })]);
  return r.rows[0].id;
}
const report = async (uid: string, cls: string, args = "") => {
  const r = await as(uid, `select public.concept_report('${cls}'${args}) as r`);
  expect(r.ok, JSON.stringify(r)).toBe(true);
  return r.rows[0].r as any;
};
const ex = (id: string) =>
  `('${id}', 'sim-licao', 'choice', '${id}', 'facil', 'Q?', null, '', '[]'::jsonb, '{"options":["a","b"],"correct":0}'::jsonb, true)`;

/** Lê as tentativas do banco como o painel as vê e calcula com as funções puras. */
async function pure(cls: string, mode: string | null = null, studentsTotal = 6) {
  const att = await db.query<any>(
    `select t.id, t.user_id, t.exercise_id, t.passed, extract(epoch from t.created_at)::float8 * 1000 as at, t.mode, t.error_category, t.misconception
     from public.attempts t join public.class_members cm on cm.student_id = t.user_id and cm.class_id = '${cls}'`,
  );
  const links = await db.query<LinkRow>("select exercise_id, concept_id, weight from public.exercise_concepts");
  return conceptReport({
    attempts: att.rows.map((a: any) => ({ ...a, id: Number(a.id) })) as AttemptRow[],
    links: links.rows,
    studentsTotal,
    mode: mode as any,
  });
}

let t0 = 0;
const add = (u: string, e: string, passed: boolean, minutes: number, o: { mode?: string; cat?: string | null; mis?: string | null } = {}) =>
  db.query(
    `insert into public.attempts (user_id, exercise_id, kind, passed, mode, error_category, misconception, created_at)
     values ($1, $2, 'choice', $3, $4, $5, $6, now() - ($7 || ' minutes')::interval)`,
    [u, e, passed, o.mode ?? "livre", passed ? null : (o.cat ?? "escolha_incorreta"), passed ? null : (o.mis ?? null), String(minutes)],
  );

beforeAll(async () => {
  db = await createDb();
  prof = await newUser("p@x.com", "Prof");
  prof2 = await newUser("p2@x.com", "Prof Dois");
  outsider = await newUser("o@x.com", "Fora da turma");
  await db.exec(`update public.profiles set role='professor' where id in ('${prof}','${prof2}')`);
  const c1 = await as(prof, "select * from public.create_class('Turma sim')");
  turma = String(c1.rows[0].id);
  const code = String(c1.rows[0].code);
  const c2 = await as(prof2, "select * from public.create_class('Turma outra')");
  turma2 = String(c2.rows[0].id);
  for (const n of nomes) {
    const id = await newUser(`${n.toLowerCase()}@x.com`, n);
    alunos.push(id);
    await as(id, `select * from public.join_class('${code}')`);
  }
  await db.exec(`
    insert into public.worlds (id, title) values ('sim-mundo', 'Mundo sim'), ('sim-mundo2', 'Mundo sim 2');
    insert into public.modules (id, title, focus, position, world_id) values ('sim-licao', 'Lição sim', 'f', 9001, 'sim-mundo'), ('sim-licao2', 'Lição sim 2', 'f', 9002, 'sim-mundo2');
    insert into public.exercises (id, module_id, kind, title, difficulty, statement, function_name, starter_code, tests, config, published) values
      ${[ex("s1"), ex("s2"), ex("s3"), ex("s4")].join(",")};
    update public.exercises set module_id = 'sim-licao2' where id = 's4';
    insert into public.concepts (id, title, world_id) values ('c-logicos', 'Operadores lógicos', 'sim-mundo'), ('c-igual', 'Igualdade', 'sim-mundo'), ('c-raro', 'Conceito pouco praticado', 'sim-mundo2');
    insert into public.exercise_concepts (exercise_id, concept_id, weight) values
      ('s1','c-logicos',1), ('s2','c-logicos',2), ('s3','c-igual',1), ('s2','c-igual',1), ('s4','c-raro',1);
  `);
  // Ana e Bia dominam; Caio e Dani erram quase tudo; Edu melhora; Fabi quase não tenta
  const [ana, bia, caio, dani, edu, fabi] = alunos;
  for (const [i, u] of [ana, bia].entries()) for (const [j, e] of ["s1", "s2", "s3", "s1", "s2"].entries()) await add(u, e, true, 500 - i * 10 - j);
  for (const [i, u] of [caio, dani].entries())
    for (const [j, e] of ["s1", "s2", "s3", "s1", "s2", "s3"].entries())
      await add(u, e, false, 500 - i * 10 - j, { mis: j % 2 ? "confunde && com ||" : "usa = no lugar de ===", mode: j < 2 ? "atividade" : "livre" });
  for (const [j, e] of ["s1", "s2", "s1", "s2", "s1", "s2"].entries()) await add(edu, e, j >= 3, 400 - j); // errou e depois acertou
  await add(fabi, "s1", false, 100, { cat: "sintaxe", mode: "avaliacao" });
  await add(dani, "s4", false, 90);
  t0 = Date.now();
});

describe("relatório por conceito: números conferem com a fórmula pura", () => {
  it("o SQL e as funções puras dão o mesmo resultado (alunos, conceitos, exercícios, erros)", async () => {
    const sql = await report(prof, turma);
    const js = await pure(turma);
    for (const c of js.concepts) {
      const s = sql.concepts.find((x: any) => x.concept_id === c.concept_id);
      expect(s, c.concept_id).toBeTruthy();
      expect([s.attempts, s.exercises, s.students, s.sufficient, s.bom, s.em_desenvolvimento, s.dificuldade, s.nao_avaliado]).toEqual([
        c.attempts, c.exercises, c.students, c.sufficient, c.bom, c.em_desenvolvimento, c.dificuldade, c.nao_avaliado,
      ]);
      if (c.error_rate === null) expect(s.error_rate).toBeNull();
      else expect(s.error_rate).toBeCloseTo(c.error_rate, 9);
    }
    expect(sql.concepts).toHaveLength(js.concepts.length);
    expect(sql.student_concepts).toHaveLength(js.studentConcepts.length);
    for (const sc of js.studentConcepts) {
      const s = sql.student_concepts.find((x: any) => x.student_id === sc.student_id && x.concept_id === sc.concept_id);
      expect(s.level).toBe(sc.level);
      expect(s.attempts).toBe(sc.attempts);
      expect(s.exercises).toBe(sc.exercises);
      expect(s.score).toBeCloseTo(sc.score, 9);
    }
    expect(sql.hardest_exercises.map((h: any) => [h.exercise_id, h.attempts, h.errors])).toEqual(js.hardest.map((h) => [h.exercise_id, h.attempts, h.errors]));
    expect(sql.misconceptions.map((m: any) => [m.text, m.count, m.students])).toEqual(js.misconceptions.map((m) => [m.text, m.count, m.students]));
    expect(sql.error_categories.map((m: any) => [m.category, m.count])).toEqual(js.categories.map((m) => [m.category, m.count]));
  });
  it("com filtro de modalidade também confere", async () => {
    for (const mode of ["livre", "atividade", "avaliacao"]) {
      const sql = await report(prof, turma, `, p_mode => '${mode}'`);
      const js = await pure(turma, mode);
      const byId = (a: any[], b: any[]) => String(a[0]).localeCompare(String(b[0]));
      expect(sql.concepts.map((c: any) => [c.concept_id, c.attempts]).sort(byId)).toEqual(js.concepts.map((c) => [c.concept_id, c.attempts]).sort(byId));
    }
  });
  it("o painel é igual ao recontado direto de `attempts`", async () => {
    const sql = await report(prof, turma);
    const logicos = sql.concepts.find((c: any) => c.concept_id === "c-logicos");
    const raw = await db.query<{ n: number; erros: number; w: number; werr: number }>(
      `select count(*)::int as n, count(*) filter (where not t.passed)::int as erros,
              sum(ec.weight)::int as w, sum(ec.weight) filter (where not t.passed)::int as werr
       from public.attempts t join public.exercise_concepts ec on ec.exercise_id = t.exercise_id
       join public.class_members cm on cm.student_id = t.user_id and cm.class_id = '${turma}'
       where ec.concept_id = 'c-logicos'`,
    );
    expect(logicos.attempts).toBe(raw.rows[0].n);
    expect(logicos.error_rate).toBeCloseTo(raw.rows[0].werr / raw.rows[0].w, 9);
  });
  it("a linha do tempo e a separação por modalidade somam as tentativas da turma", async () => {
    const sql = await report(prof, turma);
    const total = (await db.query<{ n: number }>(`select count(*)::int as n from public.attempts t join public.class_members cm on cm.student_id = t.user_id and cm.class_id = '${turma}'`)).rows[0].n;
    expect(sql.timeline.reduce((n: number, d: any) => n + d.attempts, 0)).toBe(total);
    expect(sql.by_mode.reduce((n: number, d: any) => n + d.attempts, 0)).toBe(total);
    expect(sql.by_mode.map((m: any) => m.mode)).toEqual(["atividade", "avaliacao", "livre"]);
  });
});

describe("leitura do resultado (dados simulados)", () => {
  it("Caio e Dani ainda não demonstraram domínio; Ana e Bia vão bem; Edu, que melhorou, não é 'dificuldade'", async () => {
    const sql = await report(prof, turma);
    const lv = (i: number, c: string) => sql.student_concepts.find((x: any) => x.student_id === alunos[i] && x.concept_id === c)?.level;
    expect(lv(0, "c-logicos")).toBe("bom");
    expect(lv(1, "c-logicos")).toBe("bom");
    expect(lv(2, "c-logicos")).toBe("dificuldade");
    expect(lv(3, "c-logicos")).toBe("dificuldade");
    expect(lv(4, "c-logicos")).not.toBe("dificuldade");
    expect(lv(5, "c-logicos")).toBe("nao_avaliado"); // Fabi: 1 tentativa
  });
  it("conceito pouco praticado: dados insuficientes mesmo com turma grande", async () => {
    const sql = await report(prof, turma);
    const raro = sql.concepts.find((c: any) => c.concept_id === "c-raro");
    expect(raro.sufficient).toBe(false);
    expect(raro.error_rate).toBeNull();
  });
  it("erros recorrentes: confusões por frequência e categoria", async () => {
    const sql = await report(prof, turma);
    expect(sql.misconceptions.map((m: any) => m.text).sort()).toEqual(["confunde && com ||", "usa = no lugar de ==="]);
    expect(sql.error_categories.find((c: any) => c.category === "sintaxe").count).toBe(1);
  });
  it("turma com menos de 5 alunos: sem taxa de erro agregada", async () => {
    const c = await as(prof2, "select * from public.create_class('Pequena')");
    const small = String(c.rows[0].id);
    for (const u of alunos.slice(0, 4)) await db.query(`insert into public.class_members (class_id, student_id) values ('${small}', '${u}')`);
    const sql = await report(prof2, small);
    expect(sql.students_total).toBe(4);
    expect(sql.concepts.length).toBeGreaterThan(0);
    expect(sql.concepts.every((c: any) => c.sufficient === false && c.error_rate === null)).toBe(true);
  });
});

describe("filtros", () => {
  it("por lição e por mundo", async () => {
    const l2 = await report(prof, turma, `, p_module => 'sim-licao2'`);
    expect(l2.concepts.map((c: any) => c.concept_id)).toEqual(["c-raro"]);
    const w1 = await report(prof, turma, `, p_world => 'sim-mundo'`);
    expect(w1.concepts.map((c: any) => c.concept_id)).not.toContain("c-raro");
  });
  it("por período", async () => {
    const recente = await report(prof, turma, `, p_from => now() - interval '200 minutes'`);
    expect(recente.timeline.reduce((n: number, d: any) => n + d.attempts, 0)).toBe(2); // Fabi e a de Dani em s4
    const nada = await report(prof, turma, `, p_to => now() - interval '2 days'`);
    expect(nada.concepts).toEqual([]);
  });
  it("modalidade inválida é recusada", async () => {
    expect((await as(prof, `select public.concept_report('${turma}', 'prova')`)).ok).toBe(false);
  });
});

describe("permissões", () => {
  it("só o professor da turma vê; outro professor, aluno e visitante não", async () => {
    expect((await as(prof2, `select public.concept_report('${turma}')`)).ok).toBe(false);
    expect((await as(alunos[0], `select public.concept_report('${turma}')`)).ok).toBe(false);
    expect((await as(outsider, `select public.concept_report('${turma}')`)).ok).toBe(false);
    await db.exec("set role anon;");
    const r = await db.query(`select public.concept_report('${turma}')`).catch((e: Error) => e);
    await db.exec("reset role;");
    expect(r instanceof Error).toBe(true);
  });
  it("a turma de outro professor não vaza dados para este", async () => {
    const r = await report(prof2, turma2);
    expect(r.concepts).toEqual([]);
    expect(r.student_concepts).toEqual([]);
  });
  it("professor lê o histórico de um aluno da turma, e o aluno só o próprio", async () => {
    const dani = alunos[3];
    expect((await as(prof, `select count(*)::int as n from public.attempts where user_id='${dani}'`)).rows[0].n).toBeGreaterThan(0);
    expect((await as(alunos[0], `select count(*)::int as n from public.attempts where user_id='${dani}'`)).rows[0].n).toBe(0);
  });
});

void t0;

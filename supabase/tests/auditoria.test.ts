/* eslint-disable @typescript-eslint/no-explicit-any -- consultas ao catálogo do Postgres, lidas de forma solta */
import type { PGlite } from "@electric-sql/pglite";
import { beforeAll, describe, expect, it } from "vitest";
import { xpFor } from "../../src/lib/gamification";
import { createDb } from "./helpers";

// Etapa E15: auditoria de permissões, cálculo de XP contra recálculo independente e desempenho.

let db: PGlite;
let prof: string, prof2: string, ana: string, bia: string;

async function as(uid: string | null, sql: string) {
  await db.exec(`set role ${uid ? "authenticated" : "anon"}; select set_config('request.jwt.claim.sub','${uid ?? ""}',false);`);
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

beforeAll(async () => {
  db = await createDb();
  prof = await newUser("p@x.com", "Prof");
  prof2 = await newUser("p2@x.com", "Prof Dois");
  ana = await newUser("ana@x.com", "Ana");
  bia = await newUser("bia@x.com", "Bia");
  await db.exec(`update public.profiles set role='professor' where id in ('${prof}','${prof2}')`);
});

describe("estrutura de segurança do banco", () => {
  it("toda tabela do esquema public tem RLS ligada", async () => {
    const r = await db.query<any>(
      `select c.relname from pg_class c join pg_namespace n on n.oid = c.relnamespace
       where n.nspname = 'public' and c.relkind = 'r' and not c.relrowsecurity`,
    );
    expect(r.rows.map((x: any) => x.relname)).toEqual([]);
  });
  it("visitante (anon) não tem permissão em nenhuma tabela", async () => {
    const r = await db.query<any>(`select table_name, privilege_type from information_schema.role_table_grants where table_schema = 'public' and grantee = 'anon'`);
    expect(r.rows).toEqual([]);
  });
  it("nenhum aluno tem permissão de escrever direto nas tabelas sensíveis", async () => {
    const sensiveis = ["attempts", "assessment_keys", "assessment_questions", "assessment_submissions", "mission_claims", "world_bonuses", "survey_responses", "survey_done", "exercise_progress_delete"];
    const r = await db.query<any>(
      `select table_name, privilege_type from information_schema.role_table_grants
       where table_schema = 'public' and grantee = 'authenticated' and table_name = any($1) and privilege_type in ('INSERT','UPDATE','DELETE')`,
      [sensiveis],
    );
    // (exercise_solutions aceita escrita só de professores, por RLS: confirmado no teste de comportamento abaixo)
    expect(r.rows.map((x: any) => `${x.table_name}:${x.privilege_type}`)).toEqual([]);
  });
  it("toda função SECURITY DEFINER fixa o search_path (evita sequestro de esquema)", async () => {
    const r = await db.query<any>(
      `select p.proname from pg_proc p join pg_namespace n on n.oid = p.pronamespace
       where n.nspname = 'public' and p.prosecdef
         and not exists (select 1 from unnest(coalesce(p.proconfig, '{}')) cfg where cfg like 'search_path=%')`,
    );
    expect(r.rows.map((x: any) => x.proname)).toEqual([]);
  });
  it("visitante só executa funções puras (sem acesso a dados)", async () => {
    const r = await db.query<any>(
      `select p.proname from pg_proc p join pg_namespace n on n.oid = p.pronamespace
       where n.nspname = 'public' and p.prokind = 'f' and has_function_privilege('anon', p.oid, 'execute')
         and p.prorettype <> 'trigger'::regtype order by 1`,
    );
    const permitidas = ["csv_cell", "norm_answer", "sus_score", "xp_base", "today_br", "ping"]; // ping: sinal de vida do plano gratuito, sem acesso a dados
    expect(r.rows.map((x: any) => x.proname).filter((n: string) => !permitidas.includes(n))).toEqual([]);
  });
});

describe("isolamento entre alunos e professores (dados simulados)", () => {
  beforeAll(async () => {
    await db.exec(`
      insert into public.exercises (id, module_id, kind, title, difficulty, statement, function_name, starter_code, tests, config, published)
        values ('aud-1','primeiros-passos','choice','x','facil','Q?',null,'','[]'::jsonb,'{"options":["a","b"],"correct":0}'::jsonb,true);
      insert into public.exercise_progress (user_id, exercise_id, attempts, solved) values ('${bia}','aud-1',1,true);
      insert into public.attempts (user_id, exercise_id, kind, passed, mode) values ('${bia}','aud-1','choice',true,'livre');
      insert into public.daily_activity (user_id, day, attempts, solved) values ('${bia}', current_date, 1, 1);
      insert into public.user_badges (user_id, badge_id) values ('${bia}', 'primeiro-passo');
      insert into public.ai_hints (user_id, exercise_id) values ('${bia}', 'aud-1');
      insert into public.survey_done (user_id, kind) values ('${bia}', 'sus');
      insert into public.survey_responses (kind, user_id, anonymous, answers) values ('sus', '${bia}', false, '{}');
      insert into public.mission_claims (user_id, mission_id, day, xp) values ('${bia}', 'resolver-2', current_date, 30);
    `);
  });
  const tabelas = ["exercise_progress", "attempts", "daily_activity", "user_badges", "ai_hints", "survey_done", "survey_responses", "mission_claims", "assessment_submissions", "class_members"];
  it("outro aluno não enxerga nenhuma linha da Bia", async () => {
    for (const t of tabelas) {
      const col = t === "class_members" ? "student_id" : "user_id";
      const r = await as(ana, `select count(*)::int as n from public.${t} where ${col} = '${bia}'`);
      expect(r.ok, t).toBe(true);
      expect(r.rows[0].n, t).toBe(0);
    }
  });
  it("professor sem turma com a Bia também não vê", async () => {
    for (const t of tabelas.filter((x) => x !== "class_members")) {
      const r = await as(prof2, `select count(*)::int as n from public.${t} where user_id = '${bia}'`);
      expect(r.rows[0].n, t).toBe(0);
    }
  });
  it("a Bia vê as próprias linhas", async () => {
    for (const t of ["exercise_progress", "attempts", "daily_activity", "user_badges", "ai_hints", "survey_done", "survey_responses", "mission_claims"]) {
      const r = await as(bia, `select count(*)::int as n from public.${t} where user_id = '${bia}'`);
      expect(r.rows[0].n, t).toBeGreaterThan(0);
    }
  });
  it("professor da turma da Bia vê o progresso e as tentativas dela, mas não as respostas anônimas nem o consentimento de outros", async () => {
    const c = await as(prof, "select * from public.create_class('Turma auditoria')");
    await as(bia, `select * from public.join_class('${String(c.rows[0].code)}')`);
    for (const t of ["exercise_progress", "attempts", "daily_activity", "ai_hints"]) {
      const r = await as(prof, `select count(*)::int as n from public.${t} where user_id = '${bia}'`);
      expect(r.rows[0].n, t).toBeGreaterThan(0);
    }
    // a resposta identificada não tem turma ligada, então o professor não a lê
    expect((await as(prof, `select count(*)::int as n from public.survey_responses where user_id = '${bia}'`)).rows[0].n).toBe(0);
    // medalhas, missões e controle de pesquisa continuam privados
    for (const t of ["user_badges", "mission_claims", "survey_done"]) {
      expect((await as(prof, `select count(*)::int as n from public.${t} where user_id = '${bia}'`)).rows[0].n, t).toBe(0);
    }
  });
  it("soluções de referência e gabaritos não são legíveis por alunos", async () => {
    expect((await as(ana, "select count(*)::int as n from public.exercise_solutions")).rows[0].n).toBe(0);
    expect((await as(ana, "select count(*)::int as n from public.assessment_keys")).rows[0].n).toBe(0);
    expect((await as(null, "select * from public.exercise_solutions")).ok).toBe(false);
  });
  it("aluno não escreve soluções de referência (só professor, por RLS)", async () => {
    expect((await as(ana, "insert into public.exercise_solutions (exercise_id, solution) values ('aud-1', 'x')")).ok).toBe(false);
    expect((await as(ana, "update public.exercise_solutions set solution = 'x'")).rows).toEqual([]);
  });
  it("aluno não vira professor nem altera campos protegidos do próprio perfil", async () => {
    expect((await as(ana, `update public.profiles set role = 'professor' where id = '${ana}'`)).ok).toBe(false);
    expect((await as(ana, `update public.profiles set consent_at = now() where id = '${ana}'`)).ok).toBe(false);
    expect((await as(ana, `select role from public.profiles where id = '${ana}'`)).rows[0].role).toBe("aluno");
  });
});

describe("XP: o banco confere com o cálculo independente", () => {
  it("todas as combinações de dificuldade, tipo e tentativas dão o mesmo XP no banco e na função pura", async () => {
    const dificuldades = ["facil", "medio", "dificil"] as const;
    const tipos = ["choice", "challenge"] as const;
    let n = 0;
    for (const d of dificuldades)
      for (const k of tipos)
        for (const tentativas of [1, 2, 5]) {
          const id = `xp-${n++}`;
          const aluno = await newUser(`xp${n}@x.com`, "XP");
          const config = k === "choice" ? `'{"options":["a","b"],"correct":0}'::jsonb` : `'{}'::jsonb`;
          await db.exec(`insert into public.exercises (id, module_id, kind, title, difficulty, statement, function_name, starter_code, tests, config, published)
            values ('${id}','primeiros-passos','${k}','x','${d}','Q?',${k === "choice" ? "null" : "'f'"},${k === "choice" ? "''" : "'function f() {}'"},${k === "choice" ? "'[]'::jsonb" : `'[{"args":[],"expected":1}]'::jsonb`},${config},true)`);
          await db.exec(`insert into public.exercise_progress (user_id, exercise_id, attempts, solved) values ('${aluno}','${id}',${tentativas},true)`);
          const xp = (await db.query<any>(`select xp from public.exercise_progress where user_id='${aluno}' and exercise_id='${id}'`)).rows[0].xp;
          expect(xp, `${d}/${k}/${tentativas}`).toBe(xpFor(d, tentativas, k === "challenge" ? "challenge" : undefined));
        }
    expect(n).toBe(18);
  });
});

describe("desempenho com volume realista", () => {
  it("relatório de conceitos e ranking respondem rápido com 40 alunos e 40 mil tentativas", async () => {
    const c = await as(prof, "select * from public.create_class('Turma grande')");
    const turma = String(c.rows[0].id);
    await db.exec(`
      insert into public.worlds (id, title) values ('perf-m','Mundo perf');
      insert into public.modules (id, title, focus, position, world_id) values ('perf-l','Lição perf','f',9100,'perf-m');
      insert into public.concepts (id, title, world_id) select 'perf-c' || n, 'Conceito ' || n, 'perf-m' from generate_series(1, 10) n;
      insert into public.exercises (id, module_id, kind, title, difficulty, statement, function_name, starter_code, tests, config, published)
        select 'perf-e' || n, 'perf-l', 'choice', 'E' || n, 'facil', 'Q?', null, '', '[]'::jsonb, '{"options":["a","b"],"correct":0}'::jsonb, true from generate_series(1, 60) n;
      insert into public.exercise_concepts (exercise_id, concept_id, weight)
        select 'perf-e' || n, 'perf-c' || (1 + n % 10), 1 + n % 3 from generate_series(1, 60) n;
    `);
    for (let i = 0; i < 40; i++) {
      const id = await newUser(`perf${i}@x.com`, `Aluno ${i}`);
      await db.exec(`insert into public.class_members (class_id, student_id) values ('${turma}', '${id}')`);
      await db.exec(`update public.profiles set show_in_ranking = true where id = '${id}'`);
      await db.exec(`insert into public.attempts (user_id, exercise_id, kind, passed, mode, created_at)
        select '${id}', 'perf-e' || (1 + g % 60), 'choice', (g % 3 = 0), 'livre', now() - (g || ' minutes')::interval from generate_series(1, 1000) g`);
    }
    const total = (await db.query<any>("select count(*)::int as n from public.attempts")).rows[0].n;
    expect(total).toBeGreaterThanOrEqual(40000);
    let t0 = Date.now();
    const rel = await as(prof, `select public.concept_report('${turma}') as r`);
    const tRelatorio = Date.now() - t0;
    expect(rel.ok, JSON.stringify(rel)).toBe(true);
    t0 = Date.now();
    const sa = await as(prof, `select public.sync_gamification()`).catch(() => null);
    void sa;
    const alunoId = (await db.query<any>(`select student_id from public.class_members where class_id='${turma}' limit 1`)).rows[0].student_id;
    t0 = Date.now();
    const rk = await as(alunoId, "select * from public.leaderboard(20)");
    const tRanking = Date.now() - t0;
    expect(rk.ok).toBe(true);
    expect(tRelatorio).toBeLessThan(8000);
    expect(tRanking).toBeLessThan(8000);
    console.log(`desempenho (PGlite, 40 alunos, ${total} tentativas): concept_report ${tRelatorio} ms, leaderboard ${tRanking} ms`);
  }, 120_000);
});

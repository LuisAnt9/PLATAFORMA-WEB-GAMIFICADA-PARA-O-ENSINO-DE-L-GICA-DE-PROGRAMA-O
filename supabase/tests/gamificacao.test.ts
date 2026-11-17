import type { PGlite } from "@electric-sql/pglite";
import { beforeAll, describe, expect, it } from "vitest";
import { createDb } from "./helpers";

// Etapa E9 (migration 0014): XP no servidor, missões diárias, bônus de mundo, conquistas e ranking.

let db: PGlite;
let ana: string, bia: string, caio: string, dani: string, prof: string;

async function as(uid: string, sql: string) {
  await db.exec(
    `set role authenticated; select set_config('request.jwt.claim.sub','${uid}',false);`,
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
/** Grava o progresso como o navegador faz (upsert na própria linha), mandando um XP inventado. */
const save = (uid: string, ex: string, attempts: number, solved: boolean, xp = 100) =>
  as(
    uid,
    `insert into public.exercise_progress (user_id, exercise_id, attempts, solved, first_try, xp)
     values ('${uid}', '${ex}', ${attempts}, ${solved}, ${attempts === 1 && solved}, ${xp})
     on conflict (user_id, exercise_id) do update
       set attempts = excluded.attempts, solved = excluded.solved, first_try = excluded.first_try, xp = excluded.xp`,
  );
const xpOf = async (uid: string, ex: string) =>
  (
    await db.query<{ xp: number }>(
      `select xp from public.exercise_progress where user_id='${uid}' and exercise_id='${ex}'`,
    )
  ).rows[0]?.xp;
const sync = async (uid: string) => {
  const r = await as(uid, "select public.sync_gamification() as s");
  expect(r.ok, JSON.stringify(r)).toBe(true);
  return r.rows[0].s as {
    bonus_xp: number;
    missions: { id: string; progress: number; claimed: boolean }[];
    new_worlds: string[];
    worlds_done: string[];
  };
};

const ex = (id: string, mod: string, difficulty: string, kind = "choice", published = true) =>
  kind === "choice"
    ? `('${id}', '${mod}', 'choice', '${id}', '${difficulty}', 'Q?', null, '', '[]'::jsonb,
       '{"options":["a","b"],"correct":0}'::jsonb, ${published})`
    : `('${id}', '${mod}', '${kind}', '${id}', '${difficulty}', 'Q?', 'f', 'function f() {}',
       '[{"args":[],"expected":1}]'::jsonb, '{}'::jsonb, ${published})`;

beforeAll(async () => {
  db = await createDb();
  ana = await newUser("ana@x.com", "Ana Souza");
  bia = await newUser("bia@x.com", "Bia Lima");
  caio = await newUser("caio@x.com", "Caio Melo");
  dani = await newUser("dani@x.com", "Dani Rocha");
  prof = await newUser("prof@x.com", "Prof");
  await db.exec(`update public.profiles set role='professor' where id='${prof}'`);
  await db.exec(`
    insert into public.worlds (id, title) values ('mw', 'Mundo de teste');
    insert into public.modules (id, title, focus, position, world_id)
      values ('ml1', 'Lição 1', 'f', 9001, 'mw'), ('ml2', 'Lição 2 (complementar)', 'f', 9002, 'mw');
    update public.modules set optional = true where id = 'ml2';
    insert into public.exercises (id, module_id, kind, title, difficulty, statement, function_name, starter_code, tests, config, published) values
      ${[
        ex("g-facil", "ml1", "facil"),
        ex("g-medio", "ml1", "medio"),
        ex("g-dificil", "ml1", "dificil"),
        ex("g-desafio", "ml1", "dificil", "challenge"),
        ex("g-comp", "ml2", "facil"),
        ex("g-rasc", "ml1", "facil", "choice", false),
      ].join(",\n")};
    insert into public.concepts (id, title, world_id) values ('gc', 'Conceito de teste', 'mw');
    insert into public.exercise_concepts (exercise_id, concept_id, weight) values
      ('g-facil', 'gc', 1), ('g-medio', 'gc', 1);
  `);
  // turmas: Ana e Bia na turma do professor; Caio e Dani em outra (de outro professor)
  const c = await as(prof, "select * from public.create_class('Turma A')");
  const code = String(c.rows[0].code ?? Object.values(c.rows[0])[1]);
  await as(ana, `select * from public.join_class('${code}')`);
  await as(bia, `select * from public.join_class('${code}')`);
  const prof2 = await newUser("prof2@x.com", "Prof Dois");
  await db.exec(`update public.profiles set role='professor' where id='${prof2}'`);
  const c2 = await as(prof2, "select * from public.create_class('Turma B')");
  const code2 = String(c2.rows[0].code ?? Object.values(c2.rows[0])[1]);
  await as(caio, `select * from public.join_class('${code2}')`);
  await as(dani, `select * from public.join_class('${code2}')`);
});

describe("XP calculado no servidor (D4)", () => {
  it("tabela de valores: fácil 20, médio 35, difícil 50, desafio 75; 1ª tentativa +50%", async () => {
    // 1ª tentativa (bônus)
    await save(ana, "g-facil", 1, true, 100);
    await save(ana, "g-medio", 1, true, 100);
    await save(ana, "g-dificil", 1, true, 1);
    await save(ana, "g-desafio", 1, true, 1);
    expect(await xpOf(ana, "g-facil")).toBe(30);
    expect(await xpOf(ana, "g-medio")).toBe(53); // 35 * 1,5 = 52,5 → 53
    expect(await xpOf(ana, "g-dificil")).toBe(75);
    expect(await xpOf(ana, "g-desafio")).toBe(113); // 75 * 1,5 = 112,5 → 113
    // com mais tentativas (sem bônus)
    await save(bia, "g-facil", 3, true);
    await save(bia, "g-medio", 2, true);
    await save(bia, "g-dificil", 5, true);
    await save(bia, "g-desafio", 4, true);
    expect(await xpOf(bia, "g-facil")).toBe(20);
    expect(await xpOf(bia, "g-medio")).toBe(35);
    expect(await xpOf(bia, "g-dificil")).toBe(50);
    expect(await xpOf(bia, "g-desafio")).toBe(75);
  });
  it("o navegador não consegue inventar XP; sem acertar, XP é zero", async () => {
    await save(caio, "g-facil", 2, false, 100);
    expect(await xpOf(caio, "g-facil")).toBe(0);
    await save(caio, "g-facil", 3, true, 100);
    expect(await xpOf(caio, "g-facil")).toBe(20);
  });
  it("reenviar um exercício já aprovado não muda o XP nem a data", async () => {
    const antes = (
      await db.query<{ solved_at: string }>(
        `select solved_at::text from public.exercise_progress where user_id='${bia}' and exercise_id='g-facil'`,
      )
    ).rows[0].solved_at;
    await save(bia, "g-facil", 9, true, 100);
    await save(bia, "g-facil", 1, true, 100);
    expect(await xpOf(bia, "g-facil")).toBe(20);
    const depois = (
      await db.query<{ solved_at: string }>(
        `select solved_at::text from public.exercise_progress where user_id='${bia}' and exercise_id='g-facil'`,
      )
    ).rows[0].solved_at;
    expect(depois).toBe(antes);
  });
  it("XP já gravado antes da migration não é recalculado", async () => {
    // uma linha antiga não passa pelo gatilho de novo enquanto resolvida: simulamos com update direto
    await db.exec(
      `alter table public.exercise_progress disable trigger set_progress_xp;
       insert into public.exercise_progress (user_id, exercise_id, attempts, solved, first_try, xp, solved_at)
         values ('${dani}', 'g-medio', 1, true, true, 30, now() - interval '30 days');
       alter table public.exercise_progress enable trigger set_progress_xp;`,
    );
    await save(dani, "g-medio", 1, true, 100);
    expect(await xpOf(dani, "g-medio")).toBe(30);
  });
});

describe("missões diárias", () => {
  it("'resolva 2 exercícios' concede 30 XP uma única vez no dia", async () => {
    let s = await sync(ana); // Ana já resolveu 4 hoje
    const m = s.missions.find((x) => x.id === "resolver-2")!;
    expect(m.claimed).toBe(true);
    expect(m.progress).toBe(2);
    const bonus1 = s.bonus_xp;
    s = await sync(ana);
    s = await sync(ana);
    expect(s.bonus_xp).toBe(bonus1);
    const n = (
      await db.query<{ n: number }>(
        `select count(*)::int as n from public.mission_claims where user_id='${ana}' and mission_id='resolver-2'`,
      )
    ).rows[0].n;
    expect(n).toBe(1);
  });
  it("com apenas 1 exercício hoje a missão ainda não foi cumprida", async () => {
    const s = await sync(caio);
    const m = s.missions.find((x) => x.id === "resolver-2")!;
    expect(m.progress).toBe(1);
    expect(m.claimed).toBe(false);
  });
  it("não há como pedir missão de outro dia ou de outra pessoa; a tabela não aceita escrita direta", async () => {
    const r = await as(
      caio,
      `insert into public.mission_claims (user_id, mission_id, day, xp) values ('${caio}', 'resolver-2', current_date, 30)`,
    );
    expect(r.ok).toBe(false);
    const x = await as(caio, `select * from public.mission_claims where user_id='${ana}'`);
    expect(x.rows).toEqual([]);
  });
  it("missão do conceito difícil: precisa de erro anterior em outro exercício do conceito", async () => {
    // Dani erra g-medio (conceito gc) e depois resolve g-facil (também gc), hoje
    await db.exec(`
      insert into public.attempts (user_id, exercise_id, kind, passed, created_at)
        values ('${dani}', 'g-medio', 'choice', false, now() - interval '1 hour');
    `);
    await save(dani, "g-facil", 2, true);
    const s = await sync(dani);
    expect(s.missions.find((x) => x.id === "conceito-com-dificuldade")!.claimed).toBe(true);
    // Caio resolveu g-facil hoje, mas nunca errou outro exercício do conceito
    const c = await sync(caio);
    expect(c.missions.find((x) => x.id === "conceito-com-dificuldade")!.claimed).toBe(false);
  });
});

describe("bônus de conclusão de mundo", () => {
  it("150 XP uma vez, só com 70% de cada lição obrigatória; complementar não conta", async () => {
    let s = await sync(caio); // só g-facil resolvido de 4 obrigatórios publicados
    expect(s.worlds_done).toEqual([]);
    await save(caio, "g-medio", 1, true);
    await save(caio, "g-dificil", 1, true);
    s = await sync(caio); // 3 de 4 = 75% (≥ 70%): concluído, sem resolver a lição complementar
    expect(s.new_worlds).toEqual(["mw"]);
    expect(s.worlds_done).toEqual(["mw"]);
    const antes = s.bonus_xp;
    s = await sync(caio);
    expect(s.new_worlds).toEqual([]);
    expect(s.bonus_xp).toBe(antes);
    const r = await db.query<{ n: number }>(
      `select count(*)::int as n from public.world_bonuses where user_id='${caio}'`,
    );
    expect(r.rows[0].n).toBe(1);
  });
  it("rascunhos não contam para concluir o mundo", async () => {
    const s = await sync(bia); // Bia resolveu os 4 publicados
    expect(s.worlds_done).toEqual(["mw"]);
  });
});

describe("conquistas com data", () => {
  it("o aluno registra e lê só as próprias", async () => {
    const a = await as(ana, "insert into public.user_badges (user_id, badge_id) values ('" + ana + "', 'primeiro-passo')");
    expect(a.ok).toBe(true);
    const outro = await as(ana, "insert into public.user_badges (user_id, badge_id) values ('" + bia + "', 'x')");
    expect(outro.ok).toBe(false);
    const dup = await as(ana, "insert into public.user_badges (user_id, badge_id) values ('" + ana + "', 'primeiro-passo')");
    expect(dup.ok).toBe(false); // não duplica
    expect((await as(bia, "select * from public.user_badges")).rows).toEqual([]);
    const mine = await as(ana, "select badge_id, earned_at from public.user_badges");
    expect(mine.rows).toHaveLength(1);
    expect(mine.rows[0].earned_at).toBeTruthy();
  });
});

describe("ranking opcional e restrito à turma (D11)", () => {
  const board = async (uid: string) =>
    (await as(uid, "select * from public.leaderboard(20)")).rows as {
      display_name: string;
      total_xp: string;
      is_me: boolean;
    }[];

  it("por padrão ninguém aparece", async () => {
    expect(await board(ana)).toEqual([]);
  });
  it("aluno escolhe aparecer; só vê quem é da própria turma e também escolheu", async () => {
    expect((await as(ana, `update public.profiles set show_in_ranking = true where id='${ana}'`)).ok).toBe(true);
    await as(bia, `update public.profiles set show_in_ranking = true where id='${bia}'`);
    await as(caio, `update public.profiles set show_in_ranking = true where id='${caio}'`);
    const b = await board(ana);
    expect(b.map((r) => r.display_name).sort()).toEqual(["Ana S.", "Bia L."]);
    expect(b.filter((r) => r.is_me)).toHaveLength(1);
    expect((await board(caio)).map((r) => r.display_name)).toEqual(["Caio M."]); // Dani não escolheu
  });
  it("quem não escolheu aparecer vê a turma, mas não é listado", async () => {
    const b = await board(dani);
    expect(b.map((r) => r.display_name)).toEqual(["Caio M."]);
    expect(b.some((r) => r.is_me)).toBe(false);
  });
  it("desistir de aparecer remove da lista", async () => {
    await as(bia, `update public.profiles set show_in_ranking = false where id='${bia}'`);
    expect((await board(ana)).map((r) => r.display_name)).toEqual(["Ana S."]);
  });
  it("o XP do ranking inclui missões e bônus de mundo", async () => {
    await as(bia, `update public.profiles set show_in_ranking = true where id='${bia}'`);
    await sync(bia);
    const b = await board(ana);
    const bia1 = b.find((r) => r.display_name === "Bia L.")!;
    // 20 + 35 + 50 + 75 = 180 de exercícios + 150 do mundo + 30 da missão "resolva 2"
    expect(Number(bia1.total_xp)).toBe(360);
  });
  it("não é possível mudar o papel nem o XP pelo perfil; professor vê a própria turma", async () => {
    expect((await as(ana, `update public.profiles set role='professor' where id='${ana}'`)).ok).toBe(false);
    const t = await board(prof);
    expect(t.map((r) => r.display_name).sort()).toEqual(["Ana S.", "Bia L."]);
  });
  it("visitante sem login não chama a função", async () => {
    await db.exec("set role anon;");
    const r = await db.query("select * from public.leaderboard(5)").catch((e: Error) => e);
    await db.exec("reset role;");
    expect(r instanceof Error).toBe(true);
  });
});

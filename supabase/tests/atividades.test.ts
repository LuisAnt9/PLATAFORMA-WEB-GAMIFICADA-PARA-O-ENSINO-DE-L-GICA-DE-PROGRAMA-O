/* eslint-disable @typescript-eslint/no-explicit-any -- as respostas JSON das funções do banco são lidas de forma solta nos testes */
import type { PGlite } from "@electric-sql/pglite";
import { beforeAll, describe, expect, it } from "vitest";
import { createDb } from "./helpers";

// Etapa E10 (migration 0015): atividades, avaliações e acompanhamento.

let db: PGlite;
let prof: string, prof2: string, ana: string, bia: string, caio: string;
let turma: string;

async function as(uid: string, sql: string) {
  await db.exec(
    `set role authenticated; select set_config('request.jwt.claim.sub','${uid}',false);`,
  );
  try {
    return { ok: true as const, rows: (await db.query<Record<string, unknown>>(sql)).rows };
  } catch (e) {
    return { ok: false as const, error: (e as Error).message, rows: [] as Record<string, unknown>[] };
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
const q = (s: string) => s.replace(/'/g, "''");
const create = (
  uid: string,
  cls: string,
  kind: "atividade" | "avaliacao",
  items: { exercise_id: string; points?: number }[],
  o: { from?: string; due?: string; rule?: string; title?: string } = {},
) =>
  as(
    uid,
    `select public.create_assignment('${cls}', '${kind}', '${q(o.title ?? "Teste")}', 'Instruções',
       ${o.from ? `'${o.from}'` : "now() - interval '1 hour'"}, ${o.due ? `'${o.due}'` : "now() + interval '7 days'"},
       true, '${o.rule ?? "so_nota"}', '${q(JSON.stringify(items))}'::jsonb) as id`,
  );
const idOf = (r: { rows: Record<string, unknown>[] }) => Number(r.rows[0].id);
const json = async (uid: string, sql: string) => {
  const r = await as(uid, sql);
  expect(r.ok, JSON.stringify(r)).toBe(true);
  return Object.values(r.rows[0])[0] as any;
};

const ex = (id: string, kind: string, config: object, published = true) =>
  kind === "choice" || kind === "interpretation" || kind === "blank" || kind === "order"
    ? `('${id}', 'primeiros-passos', '${kind}', '${id}', 'facil', 'Enunciado ${id}', null, '', '[]'::jsonb, '${JSON.stringify(config)}'::jsonb, ${published})`
    : `('${id}', 'primeiros-passos', '${kind}', '${id}', 'facil', 'Enunciado ${id}', 'f', 'function f() {}', '[{"args":[],"expected":1}]'::jsonb, '{}'::jsonb, ${published})`;

beforeAll(async () => {
  db = await createDb();
  prof = await newUser("p1@x.com", "Prof Um");
  prof2 = await newUser("p2@x.com", "Prof Dois");
  ana = await newUser("ana@x.com", "Ana Souza");
  bia = await newUser("bia@x.com", "Bia Lima");
  caio = await newUser("caio@x.com", "Caio Melo");
  await db.exec(`update public.profiles set role='professor' where id in ('${prof}','${prof2}')`);
  const c1 = await as(prof, "select * from public.create_class('Turma 1')");
  const code1 = String(c1.rows[0].code);
  turma = String(c1.rows[0].id);
  const c2 = await as(prof2, "select * from public.create_class('Turma 2')");
  await as(ana, `select * from public.join_class('${code1}')`);
  await as(bia, `select * from public.join_class('${code1}')`);
  await as(caio, `select * from public.join_class('${String(c2.rows[0].code)}')`);
  await db.exec(`
    insert into public.exercises (id, module_id, kind, title, difficulty, statement, function_name, starter_code, tests, config, published) values
      ${[
        ex("av-esc", "choice", { options: ["errada", { text: "certa", misconception: "x" }, "outra"], correct: 1 }),
        ex("av-lac", "blank", { template: "{{1}} (x) {}", blanks: [{ answers: ["if", "If"] }] }),
        ex("av-ord", "order", { items: ["primeiro", "segundo", "terceiro"] }),
        ex("av-int", "interpretation", { code: "console.log(1)", options: ["1", "2"], correct: 0 }),
        ex("at-cod", "code", {}),
        ex("at-rasc", "choice", { options: ["a", "b"], correct: 0 }, false),
      ].join(",\n")};
  `);
});

describe("criar atividades", () => {
  it("só o professor da turma cria; aluno e outro professor não", async () => {
    const item = [{ exercise_id: "at-cod" }];
    expect((await create(ana, turma, "atividade", item)).ok).toBe(false);
    expect((await create(prof2, turma, "atividade", item)).ok).toBe(false);
    expect((await create(prof, turma, "atividade", item)).ok).toBe(true);
  });
  it("valida prazo, itens e exercícios publicados", async () => {
    expect((await create(prof, turma, "atividade", [{ exercise_id: "at-cod" }], { due: "2000-01-01" })).ok).toBe(false);
    expect((await create(prof, turma, "atividade", [])).ok).toBe(false);
    expect((await create(prof, turma, "atividade", [{ exercise_id: "at-rasc" }])).ok).toBe(false);
    expect((await create(prof, turma, "atividade", [{ exercise_id: "nao-existe" }])).ok).toBe(false);
  });
  it("avaliação só aceita tipos corrigidos no banco (não aceita código)", async () => {
    const r = await create(prof, turma, "avaliacao", [{ exercise_id: "at-cod" }]);
    expect(r.ok).toBe(false);
    expect(r.error).toMatch(/corrigidas pelo banco/);
    // e nada fica gravado da tentativa falha
    expect((await db.query("select 1 from public.assignments where kind='avaliacao'")).rows).toHaveLength(0);
  });
  it("turma arquivada não recebe atividades", async () => {
    const c = await as(prof2, "select * from public.create_class('Arquivada')");
    await as(prof2, `update public.classes set archived = true where id='${c.rows[0].id}'`);
    expect((await create(prof2, String(c.rows[0].id), "atividade", [{ exercise_id: "at-cod" }])).ok).toBe(false);
    expect((await as(prof, `update public.classes set archived = true where id='${c.rows[0].id}'`)).rows).toEqual([]);
  });
});

describe("atividades para casa", () => {
  let id: number;
  beforeAll(async () => {
    id = idOf(await create(prof, turma, "atividade", [{ exercise_id: "av-esc" }, { exercise_id: "at-cod" }], { title: "Lição de casa" }));
  });
  it("aluno da turma vê; aluno de outra turma e visitante não", async () => {
    expect((await as(ana, `select id from public.assignments where id=${id}`)).rows).toHaveLength(1);
    expect((await as(caio, `select id from public.assignments where id=${id}`)).rows).toHaveLength(0);
    expect((await as(prof2, `select id from public.assignments where id=${id}`)).rows).toHaveLength(0);
  });
  it("atividade ainda não liberada fica invisível ao aluno", async () => {
    const f = idOf(await create(prof, turma, "atividade", [{ exercise_id: "at-cod" }], { from: "2099-01-01", due: "2099-02-01", title: "Futura" }));
    expect((await as(ana, `select id from public.assignments where id=${f}`)).rows).toHaveLength(0);
    expect((await as(prof, `select id from public.assignments where id=${f}`)).rows).toHaveLength(1);
    const mine = await json(ana, "select public.my_assignments()");
    expect(mine.map((m: any) => m.title)).not.toContain("Futura");
  });
  it("tentativas da atividade gravam mode=atividade e assignment_id; validação no servidor", async () => {
    const ok = await as(
      ana,
      `select public.record_attempt(p_exercise => 'av-esc', p_passed => false, p_selected => 1, p_mode => 'atividade', p_assignment_id => ${id})`,
    );
    expect(ok.ok, JSON.stringify(ok)).toBe(true);
    const row = (await db.query<{ mode: string; assignment_id: string; passed: boolean }>(
      `select mode, assignment_id::text, passed from public.attempts where user_id='${ana}' and exercise_id='av-esc'`,
    )).rows[0];
    expect(row).toEqual({ mode: "atividade", assignment_id: String(id), passed: true });
    // exercício fora da atividade, aluno de outra turma, modalidade inconsistente e avaliação direta
    const bad = (sql: string) => as(ana, `select public.record_attempt(${sql})`);
    expect((await bad(`p_exercise => 'av-ord', p_passed => true, p_answer => '[]', p_mode => 'atividade', p_assignment_id => ${id}`)).ok).toBe(false);
    expect((await bad(`p_exercise => 'av-esc', p_passed => true, p_selected => 1, p_mode => 'livre', p_assignment_id => ${id}`)).ok).toBe(false);
    expect((await bad(`p_exercise => 'av-esc', p_passed => true, p_selected => 1, p_mode => 'atividade'`)).ok).toBe(false);
    expect((await bad(`p_exercise => 'av-esc', p_passed => true, p_selected => 1, p_mode => 'avaliacao'`)).ok).toBe(false);
    const outro = await as(caio, `select public.record_attempt(p_exercise => 'av-esc', p_passed => true, p_selected => 1, p_mode => 'atividade', p_assignment_id => ${id})`);
    expect(outro.ok).toBe(false);
  });
  it("'Minhas atividades' mostra prazo e situação (em andamento → concluída)", async () => {
    let mine = await json(ana, "select public.my_assignments()");
    const a = mine.find((m: any) => m.id === id);
    expect(a).toMatchObject({ kind: "atividade", status: "em_andamento", items_total: 2, items_done: 0 });
    await db.exec(`insert into public.exercise_progress (user_id, exercise_id, attempts, solved) values ('${ana}','av-esc',1,true),('${ana}','at-cod',1,true)`);
    mine = await json(ana, "select public.my_assignments()");
    expect(mine.find((m: any) => m.id === id)).toMatchObject({ status: "concluida", items_done: 2 });
    expect((await json(bia, "select public.my_assignments()")).find((m: any) => m.id === id).status).toBe("nao_iniciada");
  });
  it("entrega depois do prazo aparece como atrasada", async () => {
    const late = idOf(await create(prof, turma, "atividade", [{ exercise_id: "at-cod" }], { from: "2020-01-01", due: "2020-02-01", title: "Antiga" }));
    // Bia nunca fez: atrasada; Ana tem at-cod resolvido agora (depois do prazo): concluída com atraso
    expect((await json(bia, "select public.my_assignments()")).find((m: any) => m.id === late).status).toBe("atrasada");
    expect((await json(ana, "select public.my_assignments()")).find((m: any) => m.id === late).status).toBe("concluida_atrasada");
  });
  it("relatório do professor: quem iniciou, concluiu, não iniciou; por exercício e conceito", async () => {
    const r = await json(prof, `select public.assignment_report(${id})`);
    const byName = Object.fromEntries(r.students.map((s: any) => [s.name, s]));
    expect(byName["Ana Souza"].status).toBe("concluida");
    expect(byName["Bia Lima"].status).toBe("nao_iniciada");
    expect(byName["Ana Souza"].attempts).toBe(1);
    const e = r.exercises.find((x: any) => x.exercise_id === "av-esc");
    expect(e).toMatchObject({ attempted: 1, solved: 1, attempts: 1 });
    expect(Array.isArray(r.concepts)).toBe(true);
  });
  it("professor só acompanha as próprias turmas", async () => {
    expect((await as(prof2, `select public.assignment_report(${id})`)).ok).toBe(false);
    expect((await as(ana, `select public.assignment_report(${id})`)).ok).toBe(false);
    const mine2 = await json(prof2, "select public.teacher_assignment_summaries()");
    expect(mine2.map((s: any) => s.id)).not.toContain(id);
    const mine1 = await json(prof, "select public.teacher_assignment_summaries()");
    const s = mine1.find((x: any) => x.id === id);
    expect(s).toMatchObject({ students: 2, started: 1, completed: 1 });
  });
  it("aluno não altera atividade, e escrever direto nas tabelas não funciona", async () => {
    expect((await as(ana, `update public.assignments set title='x' where id=${id}`)).rows).toEqual([]);
    expect((await as(ana, `insert into public.assignments (class_id, teacher_id, kind, title, due_at) values ('${turma}','${ana}','atividade','Falsa', now() + interval '1 day')`)).ok).toBe(false);
    expect((await as(prof2, `delete from public.assignments where id=${id}`)).rows).toEqual([]);
    expect((await db.query(`select 1 from public.assignments where id=${id}`)).rows).toHaveLength(1);
  });
});

describe("avaliações", () => {
  let id: number;
  let qs: { id: string; kind: string; payload: any }[];
  beforeAll(async () => {
    id = idOf(
      await create(
        prof, turma, "avaliacao",
        [
          { exercise_id: "av-esc", points: 3 },
          { exercise_id: "av-lac", points: 2 },
          { exercise_id: "av-ord", points: 2 },
          { exercise_id: "av-int", points: 1 },
        ],
        { rule: "gabarito_apos_prazo", title: "Prova 1" },
      ),
    );
    qs = (await json(ana, `select public.get_assessment(${id})`)).questions;
  });

  it("o aluno recebe as questões sem gabarito (sem 'correct', sem respostas, sem confusões)", async () => {
    expect(qs).toHaveLength(4);
    const txt = JSON.stringify(qs);
    expect(txt).not.toContain("correct");
    expect(txt).not.toContain("misconception");
    expect(txt).not.toContain('"If"');
    const esc = qs.find((x) => x.kind === "choice")!;
    expect(esc.payload.options).toEqual(["errada", "certa", "outra"]); // texto puro
    const ord = qs.find((x) => x.kind === "order")!;
    expect([...ord.payload.items].sort()).toEqual(["primeiro", "segundo", "terceiro"]);
  });
  it("o aluno não consegue ler a tabela do gabarito nem o exercício de origem", async () => {
    expect((await as(ana, "select * from public.assessment_keys")).rows).toEqual([]);
    expect((await as(bia, "select * from public.assessment_keys")).rows).toEqual([]);
    expect((await as(ana, "select source_exercise_id from public.assessment_questions")).ok).toBe(false);
    expect((await as(ana, `select * from public.assignment_items where assignment_id=${id}`)).rows).toEqual([]);
    // o professor da turma lê o gabarito; o outro professor não
    expect((await as(prof, "select * from public.assessment_keys")).rows.length).toBe(4);
    expect((await as(prof2, "select * from public.assessment_keys")).rows).toEqual([]);
  });
  it("aluno de outra turma não abre a avaliação", async () => {
    expect((await as(caio, `select public.get_assessment(${id})`)).ok).toBe(false);
    expect((await as(caio, `select public.submit_assessment(${id}, '{}'::jsonb)`)).ok).toBe(false);
  });
  it("corrige no banco, com nota ponderada, e grava tentativas em mode=avaliacao", async () => {
    const byKind = Object.fromEntries(qs.map((x) => [x.kind, x.id]));
    const answers = {
      [byKind.choice]: 1, // certa (3)
      [byKind.blank]: ["  if "], // normaliza espaços (2)
      [byKind.order]: ["segundo", "primeiro", "terceiro"], // errada (0)
      [byKind.interpretation]: 0, // certa (1)
    };
    const r = await json(ana, `select public.submit_assessment(${id}, '${q(JSON.stringify(answers))}'::jsonb)`);
    expect(r).toMatchObject({ score: 6, max: 8 });
    const at = (await db.query<{ mode: string; passed: boolean }>(
      `select mode, passed from public.attempts where user_id='${ana}' and assignment_id=${id} order by id`,
    )).rows;
    expect(at).toHaveLength(4);
    expect(at.every((a) => a.mode === "avaliacao")).toBe(true);
    expect(at.filter((a) => a.passed)).toHaveLength(3);
  });
  it("só uma entrega por aluno", async () => {
    const again = await as(ana, `select public.submit_assessment(${id}, '{}'::jsonb)`);
    expect(again.ok).toBe(false);
    expect(again.error).toMatch(/JA_ENTREGUE/);
    expect((await db.query(`select 1 from public.assessment_submissions where user_id='${ana}'`)).rows).toHaveLength(1);
  });
  it("regra 'gabarito depois do prazo': antes do prazo o aluno vê só a nota", async () => {
    const r = await json(ana, `select public.assessment_result(${id})`);
    expect(r.score).toBe(6);
    expect(r.details).toBeNull();
    // passando o prazo, o gabarito é liberado
    await db.exec(`alter table public.assignments disable trigger all; update public.assignments set due_at = now() - interval '1 minute', available_from = now() - interval '2 days' where id=${id}; alter table public.assignments enable trigger all;`);
    const after = await json(ana, `select public.assessment_result(${id})`);
    expect(after.details).toHaveLength(4);
    expect(after.details.find((d: any) => d.correct === false)).toBeTruthy();
  });
  it("prazo respeitado no servidor: depois do prazo não dá para entregar", async () => {
    const late = await as(bia, `select public.submit_assessment(${id}, '{}'::jsonb)`);
    expect(late.ok).toBe(false);
    expect(late.error).toMatch(/FORA_DO_PRAZO/);
    expect((await db.query(`select 1 from public.assessment_submissions where user_id='${bia}'`)).rows).toHaveLength(0);
  });
  it("antes da liberação a avaliação não aparece nem pode ser entregue", async () => {
    const f = idOf(await create(prof, turma, "avaliacao", [{ exercise_id: "av-esc" }], { from: "2099-01-01", due: "2099-02-01", title: "Futura" }));
    expect((await as(bia, `select public.get_assessment(${f})`)).ok).toBe(false);
    const sub = await as(bia, `select public.submit_assessment(${f}, '{}'::jsonb)`);
    expect(sub.ok).toBe(false);
    expect((await as(bia, `select * from public.assessment_questions where assignment_id=${f}`)).rows).toEqual([]);
  });
  it("regra 'nota e gabarito' mostra o gabarito na hora; 'só a nota' esconde", async () => {
    const mk = async (rule: string) => {
      const aid = idOf(await create(prof, turma, "avaliacao", [{ exercise_id: "av-esc" }], { rule, title: rule }));
      const qid = (await json(bia, `select public.get_assessment(${aid})`)).questions[0].id;
      const r = await json(bia, `select public.submit_assessment(${aid}, '{"${qid}": 0}'::jsonb)`);
      return r;
    };
    // Bia entrega duas avaliações diferentes (uma entrega por avaliação)
    const a = await mk("nota_e_gabarito");
    expect(a.score).toBe(0);
    expect(a.details).toHaveLength(1);
    expect(a.details[0].answer).toBe(1);
    const b = await mk("so_nota");
    expect(b.details).toBeNull();
  });
  it("professor vê as notas da turma no relatório", async () => {
    const r = await json(prof, `select public.assignment_report(${id})`);
    const ana1 = r.students.find((s: any) => s.name === "Ana Souza");
    expect(ana1).toMatchObject({ status: "entregue", score: 6, max_score: 8 });
    expect(r.students.find((s: any) => s.name === "Bia Lima").status).toBe("nao_entregue");
  });
});

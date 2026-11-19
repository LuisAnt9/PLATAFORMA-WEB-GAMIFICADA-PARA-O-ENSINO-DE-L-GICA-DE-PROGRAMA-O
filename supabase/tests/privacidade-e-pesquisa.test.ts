/* eslint-disable @typescript-eslint/no-explicit-any -- respostas JSON das funções do banco, lidas de forma solta nos testes */
import type { PGlite } from "@electric-sql/pglite";
import { beforeAll, describe, expect, it } from "vitest";
import { susScore } from "../../src/lib/surveys";
import { createDb } from "./helpers";

// Etapa E15 (migration 0017): privacidade (LGPD) e avaliação do TCC. Dados de SIMULAÇÃO.

let db: PGlite;
let prof: string, prof2: string, ana: string, bia: string, caio: string, dani: string, edu: string, fabi: string, gui: string;
let turma: string, turma2: string;

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
async function newUser(email: string, name: string, meta: object = {}) {
  const r = await db.query<{ id: string }>(
    `insert into auth.users(email, raw_user_meta_data) values ($1, $2) returning id`,
    [email, JSON.stringify({ name, ...meta })],
  );
  return r.rows[0].id;
}
const answers = (vals: number[]) => JSON.stringify(Object.fromEntries(vals.map((v, i) => [String(i + 1), v])));
const submit = (uid: string, kind: string, vals: number[], o: { comment?: string; anon?: boolean; cls?: string | null } = {}) =>
  as(uid, `select public.submit_survey('${kind}', '${answers(vals)}'::jsonb, ${o.comment === undefined ? "null" : `'${o.comment.replace(/'/g, "''")}'`}, ${o.anon ?? true}, ${o.cls === undefined || o.cls === null ? "null" : `'${o.cls}'`}) as s`);

beforeAll(async () => {
  db = await createDb();
  prof = await newUser("p@x.com", "Prof");
  prof2 = await newUser("p2@x.com", "Prof Dois");
  await db.exec(`update public.profiles set role='professor' where id in ('${prof}','${prof2}')`);
  const c1 = await as(prof, "select * from public.create_class('Turma P')");
  turma = String(c1.rows[0].id);
  const c2 = await as(prof2, "select * from public.create_class('Turma Q')");
  turma2 = String(c2.rows[0].id);
  const code = String(c1.rows[0].code);
  [ana, bia, caio, dani, edu, fabi, gui] = await Promise.all(
    ["ana", "bia", "caio", "dani", "edu", "fabi", "gui"].map((n) => newUser(`${n}@x.com`, n[0].toUpperCase() + n.slice(1))),
  );
  for (const u of [ana, bia, caio, dani, edu, fabi]) await as(u, `select * from public.join_class('${code}')`);
  await as(gui, `select * from public.join_class('${String(c2.rows[0].code)}')`);
});

describe("consentimento (LGPD)", () => {
  it("o cadastro com termo registra versão, data e declaração de idade", async () => {
    const id = await newUser("novo@x.com", "Novo", { consent_version: "2026-11", over_18: "false" });
    const p = (await db.query<any>(`select consent_at, consent_version, over_18 from public.profiles where id='${id}'`)).rows[0];
    expect(p.consent_at).toBeTruthy();
    expect(p.consent_version).toBe("2026-11");
    expect(p.over_18).toBe(false);
  });
  it("conta antiga fica sem consentimento até aceitar o termo", async () => {
    const p = (await db.query<any>(`select consent_at from public.profiles where id='${ana}'`)).rows[0];
    expect(p.consent_at).toBeNull();
    expect((await as(ana, "select public.accept_terms('2026-11', true)")).ok).toBe(true);
    const q = (await db.query<any>(`select consent_at, over_18 from public.profiles where id='${ana}'`)).rows[0];
    expect(q.consent_at).toBeTruthy();
    expect(q.over_18).toBe(true);
  });
  it("não dá para forjar o consentimento de outra pessoa nem pela atualização direta", async () => {
    expect((await as(bia, `update public.profiles set consent_at = now() where id='${bia}'`)).ok).toBe(false);
    expect((await as(bia, `update public.profiles set consent_at = now() where id='${caio}'`)).ok).toBe(false);
  });
  it("visitante não aceita termo", async () => {
    await db.exec("set role anon;");
    const r = await db.query("select public.accept_terms('x', true)").catch((e: Error) => e);
    await db.exec("reset role;");
    expect(r instanceof Error).toBe(true);
  });
});

describe("dica com IA: opção de desligar", () => {
  it("o aluno desliga e a cota recusa; ao religar, volta a funcionar", async () => {
    await db.exec(`insert into public.exercises (id, module_id, kind, title, difficulty, statement, function_name, starter_code, tests, config, published)
      values ('priv-1','primeiros-passos','choice','x','facil','Q?',null,'','[]'::jsonb,'{"options":["a","b"],"correct":0}'::jsonb,true)`);
    expect((await as(ana, "select * from public.use_ai_hint('priv-1')")).ok).toBe(true);
    expect((await as(ana, `update public.profiles set ai_hints_enabled = false where id='${ana}'`)).ok).toBe(true);
    const off = await as(ana, "select * from public.use_ai_hint('priv-1')");
    expect(off.ok).toBe(false);
    expect(off.error).toMatch(/IA_DESLIGADA/);
    await as(ana, `update public.profiles set ai_hints_enabled = true where id='${ana}'`);
    expect((await as(ana, "select * from public.use_ai_hint('priv-1')")).ok).toBe(true);
  });
  it("ninguém altera a opção de outra pessoa", async () => {
    await as(bia, `update public.profiles set ai_hints_enabled = false where id='${caio}'`);
    expect((await db.query<any>(`select ai_hints_enabled from public.profiles where id='${caio}'`)).rows[0].ai_hints_enabled).toBe(true);
  });
});

describe("exportar e excluir os próprios dados", () => {
  it("a exportação traz só os dados da própria pessoa", async () => {
    await db.exec(`insert into public.exercise_progress (user_id, exercise_id, attempts, solved) values ('${bia}','priv-1',1,true)`);
    await db.exec(`insert into public.attempts (user_id, exercise_id, kind, passed, mode) values ('${bia}','priv-1','choice',true,'livre'),('${caio}','priv-1','choice',false,'livre')`);
    const r = (await as(bia, "select public.export_my_data() as d")).rows[0].d as any;
    expect(r.perfil.name).toBe("Bia");
    expect(r.progresso).toHaveLength(1);
    expect(r.tentativas).toHaveLength(1);
    expect(JSON.stringify(r)).not.toContain(caio);
    expect(r.turmas[0].turma).toBe("Turma P");
  });
  it("excluir a conta apaga tudo que é do aluno e nada dos colegas", async () => {
    const antes = (await db.query<any>(`select count(*)::int as n from public.attempts where user_id='${caio}'`)).rows[0].n;
    expect(antes).toBe(1);
    await as(caio, "select public.accept_terms('x', true)");
    await as(caio, `select public.submit_survey('likert', '${answers([4, 4, 4, 4, 4, 4, 4, 4])}'::jsonb, null, false, '${turma}')`);
    expect((await as(caio, "select public.delete_my_account()")).ok).toBe(true);
    const tabelas = await db.query<{ table_name: string }>(
      `select table_name from information_schema.columns where table_schema='public' and column_name='user_id'`,
    );
    for (const t of tabelas.rows) {
      const n = (await db.query<any>(`select count(*)::int as n from public.${t.table_name} where user_id='${caio}'`)).rows[0].n;
      expect(n, t.table_name).toBe(0);
    }
    expect((await db.query<any>(`select count(*)::int as n from public.profiles where id='${caio}'`)).rows[0].n).toBe(0);
    expect((await db.query<any>(`select count(*)::int as n from auth.users where id='${caio}'`)).rows[0].n).toBe(0);
    expect((await db.query<any>(`select count(*)::int as n from public.attempts where user_id='${bia}'`)).rows[0].n).toBe(1);
    expect((await db.query<any>(`select count(*)::int as n from public.class_members where class_id='${turma}'`)).rows[0].n).toBe(5);
  });
});

describe("pontuação SUS", () => {
  it("a função do banco e a função pura dão o mesmo resultado, em todos os extremos", async () => {
    const casos = [
      [5, 1, 5, 1, 5, 1, 5, 1, 5, 1], // melhor possível: 100
      [1, 5, 1, 5, 1, 5, 1, 5, 1, 5], // pior possível: 0
      [3, 3, 3, 3, 3, 3, 3, 3, 3, 3], // neutro: 50
      [4, 2, 5, 1, 4, 2, 4, 2, 5, 1],
      [2, 4, 3, 5, 1, 3, 2, 4, 3, 2],
    ];
    expect(susScore(casos[0])).toBe(100);
    expect(susScore(casos[1])).toBe(0);
    expect(susScore(casos[2])).toBe(50);
    for (const c of casos) {
      const r = await db.query<any>(`select public.sus_score('${answers(c)}'::jsonb)::float8 as s`);
      expect(r.rows[0].s).toBeCloseTo(susScore(c), 5);
    }
  });
});

describe("questionários SUS e Likert", () => {
  it("resposta válida é gravada com a pontuação e só uma vez por aluno e questionário", async () => {
    const r = await submit(ana, "sus", [5, 1, 5, 1, 5, 1, 5, 1, 5, 1], { cls: turma });
    expect(r.ok, JSON.stringify(r)).toBe(true);
    expect(Number(r.rows[0].s)).toBe(100);
    const again = await submit(ana, "sus", [3, 3, 3, 3, 3, 3, 3, 3, 3, 3], { cls: turma });
    expect(again.ok).toBe(false);
    expect(again.error).toMatch(/JA_RESPONDIDO/);
    expect((await submit(ana, "likert", [5, 5, 5, 5, 5, 5, 5, 5], { cls: turma })).ok).toBe(true);
  });
  it("valida respostas, tipo, turma e quem responde", async () => {
    expect((await submit(bia, "sus", [5, 1, 5, 1, 5, 1, 5, 1, 5])).ok).toBe(false); // faltou uma
    expect((await submit(bia, "sus", [5, 1, 5, 1, 5, 1, 5, 1, 5, 6])).ok).toBe(false); // valor fora de 1 a 5
    expect((await submit(bia, "prova" as never, [1])).ok).toBe(false);
    expect((await submit(bia, "likert", [3, 3, 3, 3, 3, 3, 3, 3], { cls: turma2 })).ok).toBe(false); // turma que não é dela
    expect((await submit(prof, "sus", [3, 3, 3, 3, 3, 3, 3, 3, 3, 3])).ok).toBe(false); // professor não responde
    // nada ficou gravado pelas tentativas inválidas
    expect((await db.query<any>(`select count(*)::int as n from public.survey_done where user_id='${bia}'`)).rows[0].n).toBe(0);
  });
  it("resposta anônima não guarda o autor; a identificada guarda", async () => {
    await submit(bia, "sus", [4, 2, 4, 2, 4, 2, 4, 2, 4, 2], { anon: true, cls: turma, comment: "Gostei." });
    await submit(dani, "sus", [3, 3, 3, 3, 3, 3, 3, 3, 3, 3], { anon: false, cls: turma });
    const anon = (await db.query<any>(`select user_id from public.survey_responses where comment = 'Gostei.'`)).rows[0];
    expect(anon.user_id).toBeNull();
    const ident = (await db.query<any>(`select user_id from public.survey_responses where user_id='${dani}'`)).rows;
    expect(ident).toHaveLength(1);
    // a resposta anônima não pode ser ligada à Bia por nenhuma tabela
    const ligacoes = await db.query<any>(`select count(*)::int as n from public.survey_responses r where r.user_id = '${bia}'`);
    expect(ligacoes.rows[0].n).toBe(0);
  });
  it("aluno não lê respostas dos outros; professor lê só as da própria turma", async () => {
    expect((await as(edu, "select * from public.survey_responses")).rows).toEqual([]);
    const mine = (await as(ana, "select * from public.survey_responses")).rows;
    expect(mine.every((r) => r.user_id === ana)).toBe(true);
    expect((await as(prof, "select * from public.survey_responses")).rows.length).toBeGreaterThan(2);
    expect((await as(prof2, "select * from public.survey_responses")).rows).toEqual([]);
    expect((await as(ana, "insert into public.survey_responses (kind, anonymous, answers) values ('sus', true, '{}')")).ok).toBe(false);
  });
});

describe("exportação em CSV", () => {
  const csv = async (uid: string, args = "") => {
    const r = await as(uid, `select public.export_survey_csv(${args}) as c`);
    expect(r.ok, JSON.stringify(r)).toBe(true);
    return String(r.rows[0].c);
  };
  it("só professor exporta e só das próprias turmas", async () => {
    expect((await as(ana, "select public.export_survey_csv()")).ok).toBe(false);
    const meu = await csv(prof);
    expect(meu.split("\n").length).toBeGreaterThan(3);
    const outro = await csv(prof2);
    expect(outro.split("\n")).toHaveLength(1); // só o cabeçalho
  });
  it("traz o cabeçalho, o modo (anônima/identificada) e o nome só nas identificadas", async () => {
    const out = await csv(prof);
    const linhas = out.split("\n");
    expect(linhas[0]).toBe("id,data,questionario,modo,turma,nome,pontuacao_sus,q1,q2,q3,q4,q5,q6,q7,q8,q9,q10,comentario");
    const anon = linhas.find((l) => l.includes("Gostei."))!;
    expect(anon).toContain("anonima");
    expect(anon).not.toContain("Bia");
    const ident = linhas.find((l) => l.includes("identificada") && l.includes("Dani"))!;
    expect(ident).toBeTruthy();
    expect(ident).toContain(",sus,");
  });
  it("a pontuação exportada é a calculada pelo banco (Ana: 100)", async () => {
    const out = await csv(prof);
    const ana1 = out.split("\n").find((l) => l.includes(",sus,") && l.includes(",100.0,"));
    expect(ana1).toBeTruthy();
  });
  it("escapa aspas, vírgulas, quebras de linha e fórmulas do Excel", async () => {
    await submit(edu, "likert", [4, 4, 4, 4, 4, 4, 4, 4], { cls: turma, comment: '=HYPERLINK("http://x")', anon: true });
    await submit(fabi, "likert", [3, 3, 3, 3, 3, 3, 3, 3], { cls: turma, comment: 'Disse "ótimo", mas\ncom linha nova', anon: true });
    const out = await csv(prof);
    expect(out).toContain(`"'=HYPERLINK(""http://x"")"`); // prefixo ' e aspas duplicadas
    expect(out).toContain(`"Disse ""ótimo"", mas\ncom linha nova"`);
  });
  it("o filtro por turma funciona", async () => {
    expect((await csv(prof, `'${turma2}'`)).split("\n")).toHaveLength(1);
    expect((await csv(prof, `'${turma}'`)).split("\n").length).toBeGreaterThan(3);
  });
});

describe("resumo agregado", () => {
  it("com menos de 5 respostas só informa a contagem", async () => {
    const s = (await as(prof, "select public.survey_summary() as s")).rows[0].s as any;
    expect(s.sus).toEqual({ n: 3, sufficient: false });
  });
  it("com 5 ou mais, mostra a média SUS e a média por item", async () => {
    await submit(gui, "sus", [5, 1, 5, 1, 5, 1, 5, 1, 5, 1]);
    // mais duas respostas SUS identificadas na turma P: usa alunos que ainda não responderam
    await submit(edu, "sus", [3, 3, 3, 3, 3, 3, 3, 3, 3, 3], { cls: turma });
    await submit(fabi, "sus", [3, 3, 3, 3, 3, 3, 3, 3, 3, 3], { cls: turma });
    const s = (await as(prof, "select public.survey_summary() as s")).rows[0].s as any;
    expect(s.sus.sufficient).toBe(true);
    expect(s.sus.n).toBe(5);
    expect(s.sus.mean_score).toBeCloseTo((100 + susScore([4, 2, 4, 2, 4, 2, 4, 2, 4, 2]) + 50 + 50 + 50) / 5, 1);
    expect(Object.keys(s.sus.item_means)).toHaveLength(10);
    expect((await as(ana, "select public.survey_summary()")).ok).toBe(false);
  });
});

describe("comparação do uso da dica com IA (agregada)", () => {
  it("sem 5 alunos em cada grupo, não devolve números", async () => {
    const r = (await as(prof, "select public.ai_hint_comparison() as r")).rows[0].r as any;
    expect(r.sufficient).toBe(false);
    expect(JSON.stringify(r)).not.toContain(ana);
  });
  it("com grupos suficientes, devolve só médias e taxas (sem ids)", async () => {
    // junta 10 alunos simulados à turma: 5 com dica de IA e 5 sem
    for (let i = 0; i < 10; i++) {
      const id = await newUser(`sim${i}@x.com`, `Sim ${i}`);
      await db.query(`insert into public.class_members (class_id, student_id) values ('${turma}', '${id}')`);
      await db.query(`insert into public.attempts (user_id, exercise_id, kind, passed) values ('${id}', 'priv-1', 'choice', ${i % 2 === 0})`);
      if (i < 5) await db.query(`insert into public.ai_hints (user_id, exercise_id) values ('${id}', 'priv-1')`);
    }
    const r = (await as(prof, "select public.ai_hint_comparison() as r")).rows[0].r as any;
    expect(r.sufficient).toBe(true);
    expect(r.grupos.map((g: any) => g.grupo)).toEqual(["com", "sem"]);
    expect(JSON.stringify(r)).not.toMatch(/[0-9a-f]{8}-[0-9a-f]{4}-/); // nenhum identificador
    expect((await as(ana, "select public.ai_hint_comparison()")).ok).toBe(false);
    expect((await as(prof2, "select public.ai_hint_comparison() as r")).rows[0].r).toMatchObject({ sufficient: false });
  });
});

import type { PGlite } from "@electric-sql/pglite";
import { beforeAll, describe, expect, it } from "vitest";
import { createDb } from "./helpers";

// Aplica todas as migrations num Postgres embutido que imita o essencial do Supabase
// (schema auth, auth.uid(), papéis anon/authenticated) e testa as regras de segurança.

let db: PGlite;
let ana: string, bia: string, caio: string, prof: string;

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

async function newUser(email: string, name?: string) {
  const meta = name ? JSON.stringify({ name }) : "{}";
  const r = await db.query<{ id: string }>(
    `insert into auth.users(email, raw_user_meta_data) values ($1, $2) returning id`,
    [email, meta],
  );
  return r.rows[0].id;
}

beforeAll(async () => {
  db = await createDb();

  ana = await newUser("ana@x.com", "Ana Souza Lima");
  bia = await newUser("bia@x.com");
  caio = await newUser("caio@x.com", "Caio");
  prof = await newUser("prof@x.com", "Prof Lima");
  await db.exec(
    `update public.profiles set role='professor' where id='${prof}'`,
  );
});

describe("0001: perfis e progresso", () => {
  it("trigger cria perfil com nome do cadastro e fallback do e-mail", async () => {
    const names = (
      await db.query<{ name: string }>("select name from public.profiles")
    ).rows.map((r) => r.name);
    expect(names).toContain("Ana Souza Lima");
    expect(names).toContain("bia");
  });
  it("aluno vê só o próprio perfil; professor sem turma vê só o dele", async () => {
    expect((await as(ana, "select * from public.profiles")).rows).toHaveLength(
      1,
    );
    expect((await as(prof, "select * from public.profiles")).rows).toHaveLength(
      1,
    );
  });
  it("aluno não consegue virar professor, mas edita o próprio nome", async () => {
    expect(
      (
        await as(
          ana,
          `update public.profiles set role='professor' where id='${ana}'`,
        )
      ).ok,
    ).toBe(false);
    expect(
      (
        await as(
          ana,
          `update public.profiles set name='Ana Souza Lima' where id='${ana}'`,
        )
      ).ok,
    ).toBe(true);
    expect(
      (
        await as(
          ana,
          `update public.profiles set name='x' where id='${bia}' returning id`,
        )
      ).rows,
    ).toHaveLength(0);
  });
  it("progresso: só em nome próprio, XP limitado, resolvido fica travado", async () => {
    expect(
      (
        await as(
          ana,
          `insert into public.exercise_progress(user_id,exercise_id,attempts,solved,first_try,xp) values ('${ana}','soma',1,true,true,15)`,
        )
      ).ok,
    ).toBe(true);
    expect(
      (
        await as(
          ana,
          `insert into public.exercise_progress(user_id,exercise_id) values ('${bia}','soma')`,
        )
      ).ok,
    ).toBe(false);
    expect(
      (
        await as(
          ana,
          `insert into public.exercise_progress(user_id,exercise_id,xp) values ('${ana}','media',9999)`,
        )
      ).ok,
    ).toBe(false);
    await as(
      ana,
      `update public.exercise_progress set solved=false, xp=0 where user_id='${ana}' and exercise_id='soma'`,
    );
    const r = (
      await db.query<{ solved: boolean; xp: number }>(
        `select solved, xp from public.exercise_progress where user_id='${ana}'`,
      )
    ).rows[0];
    expect(r).toEqual({ solved: true, xp: 15 });
  });
  it("aluno não vê progresso alheio; professor sem turma também não; anônimo não lê", async () => {
    expect(
      (await as(bia, "select * from public.exercise_progress")).rows,
    ).toHaveLength(0);
    expect(
      (await as(prof, "select * from public.exercise_progress")).rows,
    ).toHaveLength(0);
    expect((await as(null, "select * from public.profiles")).ok).toBe(false);
  });
});

describe("0002: ranking", () => {
  beforeAll(async () => {
    await as(
      caio,
      `insert into public.exercise_progress(user_id,exercise_id,attempts,solved,first_try,xp) values ('${caio}','soma',2,true,false,10),('${caio}','media',1,true,true,15),('${caio}','fatorial',1,false,false,0)`,
    );
  });

  it("ordena por XP e abrevia o sobrenome", async () => {
    const rows = (await as(bia, "select * from public.leaderboard(20)")).rows;
    const nomes = rows.map((r) => r.display_name);
    expect(nomes[0]).toBe("Caio"); // 25 XP
    expect(nomes[1]).toBe("Ana L."); // 15 XP
    expect(Number(rows[0].total_xp)).toBe(25);
    expect(Number(rows[0].solved)).toBe(2);
  });
  it("nunca expõe e-mail nem identificadores", async () => {
    const rows = (await as(bia, "select * from public.leaderboard(20)")).rows;
    expect(Object.keys(rows[0]).sort()).toEqual([
      "display_name",
      "is_me",
      "pos",
      "solved",
      "total_xp",
    ]);
  });
  it("aluno sem acertos aparece só para si mesmo, com is_me", async () => {
    const mine = (
      await as(bia, "select * from public.leaderboard(20)")
    ).rows.filter((r) => r.is_me);
    expect(mine).toHaveLength(1);
    expect(mine[0].display_name).toBe("bia");
    const outros = (
      await as(caio, "select * from public.leaderboard(20)")
    ).rows.map((r) => r.display_name);
    expect(outros).not.toContain("bia");
  });
  it("professor fica fora do ranking", async () => {
    const nomes = (
      await as(ana, "select * from public.leaderboard(20)")
    ).rows.map((r) => r.display_name);
    expect(nomes).not.toContain("Prof L.");
  });
  it("mostra a própria posição mesmo fora do top N", async () => {
    const rows = (await as(ana, "select * from public.leaderboard(1)")).rows;
    expect(rows.map((r) => r.display_name)).toEqual(["Caio", "Ana L."]);
    expect(Number(rows.find((r) => r.is_me)?.pos)).toBe(2);
  });
  it("anônimo não executa a função", async () => {
    expect((await as(null, "select * from public.leaderboard(20)")).ok).toBe(
      false,
    );
  });
});

describe("0003: catálogo", () => {
  it("a migration traz os 4 módulos e 17 exercícios", async () => {
    const m = await db.query<{ n: number }>(
      "select count(*)::int as n from public.modules",
    );
    const e = await db.query<{ n: number }>(
      "select count(*)::int as n from public.exercises",
    );
    expect(m.rows[0].n).toBe(4);
    expect(e.rows[0].n).toBe(17);
  });
  it("aluno lê só exercícios publicados; professor lê todos", async () => {
    await db.exec(
      "update public.exercises set published=false where id='ordenar'",
    );
    expect(
      (await as(bia, "select id from public.exercises")).rows,
    ).toHaveLength(16);
    expect(
      (await as(prof, "select id from public.exercises")).rows,
    ).toHaveLength(17);
    await db.exec(
      "update public.exercises set published=true where id='ordenar'",
    );
  });
  it("aluno não cria nem edita exercícios e módulos", async () => {
    expect(
      (
        await as(
          bia,
          "update public.exercises set title='x' where id='soma' returning id",
        )
      ).rows,
    ).toHaveLength(0);
    const ins = `insert into public.exercises(id,module_id,title,difficulty,statement,function_name,starter_code,tests,created_by) values ('novo','fundamentos','N','facil','e','f','', '[{"args":[],"expected":1}]','${bia}')`;
    expect((await as(bia, ins)).ok).toBe(false);
    expect(
      (
        await as(
          bia,
          "update public.modules set title='x' where id='vetores' returning id",
        )
      ).rows,
    ).toHaveLength(0);
  });
  it("professor cria exercício em seu nome, mas não em nome de outro", async () => {
    const mk = (by: string) =>
      `insert into public.exercises(id,module_id,title,difficulty,statement,function_name,starter_code,tests,created_by) values ('dobro','fundamentos','Dobro','facil','Dobre','dobro','', '[{"args":[2],"expected":4}]','${by}')`;
    expect((await as(prof, mk(ana))).ok).toBe(false);
    expect((await as(prof, mk(prof))).ok).toBe(true);
  });
  it("validações rejeitam nome de função perigoso e testes vazios", async () => {
    const mk = (fn: string, tests: string) =>
      `insert into public.exercises(id,module_id,title,difficulty,statement,function_name,starter_code,tests,created_by) values ('x-'||md5(random()::text),'fundamentos','T','facil','e','${fn}','', '${tests}','${prof}')`;
    expect((await as(prof, mk("f(){}", '[{"args":[],"expected":1}]'))).ok).toBe(
      false,
    );
    expect((await as(prof, mk("ok", "[]"))).ok).toBe(false);
  });
  it("exercícios não podem ser apagados pela API", async () => {
    expect(
      (await as(prof, "delete from public.exercises where id='soma'")).ok,
    ).toBe(false);
  });
});

describe("0003: turmas", () => {
  let turma: string, codigo: string, prof2: string, turma2: string;

  beforeAll(async () => {
    prof2 = await newUser("prof2@x.com", "Outra Prof");
    await db.exec(
      `update public.profiles set role='professor' where id='${prof2}'`,
    );
  });

  it("aluno não cria turma; professor cria e recebe código de 6 caracteres", async () => {
    expect(
      (await as(ana, "select * from public.create_class('Minha')")).ok,
    ).toBe(false);
    const r = await as(prof, "select * from public.create_class('ADS 2026.1')");
    expect(r.ok).toBe(true);
    turma = r.rows[0].id as string;
    codigo = r.rows[0].code as string;
    expect(codigo).toMatch(/^[A-HJ-NP-Z2-9]{6}$/);
    const r2 = await as(
      prof2,
      "select * from public.create_class('Outra turma')",
    );
    turma2 = r2.rows[0].id as string;
  });
  it("não dá para criar turma por INSERT direto", async () => {
    expect(
      (
        await as(
          prof,
          `insert into public.classes(name,code,teacher_id) values ('Hack','AAAAAA','${prof}')`,
        )
      ).ok,
    ).toBe(false);
  });
  it("aluno não enxerga turmas nem códigos antes de entrar", async () => {
    expect((await as(ana, "select * from public.classes")).rows).toHaveLength(
      0,
    );
  });
  it("código inválido é recusado; professor não entra em turma", async () => {
    expect(
      (await as(ana, "select * from public.join_class('ZZZZZZ')")).ok,
    ).toBe(false);
    expect(
      (await as(prof2, `select * from public.join_class('${codigo}')`)).ok,
    ).toBe(false);
  });
  it("aluno entra com o código (minúsculo e com espaços também) e é idempotente", async () => {
    expect(
      (
        await as(
          ana,
          `select * from public.join_class('  ${codigo.toLowerCase()} ')`,
        )
      ).ok,
    ).toBe(true);
    expect(
      (await as(ana, `select * from public.join_class('${codigo}')`)).ok,
    ).toBe(true);
    expect(
      (await as(caio, `select * from public.join_class('${codigo}')`)).ok,
    ).toBe(true);
    const n = await db.query<{ n: number }>(
      `select count(*)::int as n from public.class_members where class_id='${turma}'`,
    );
    expect(n.rows[0].n).toBe(2);
  });
  it("aluno vê a própria turma, mas não a lista de colegas", async () => {
    expect((await as(ana, "select * from public.classes")).rows).toHaveLength(
      1,
    );
    expect(
      (await as(ana, "select * from public.class_members")).rows,
    ).toHaveLength(1);
  });
  it("professor vê os alunos e o progresso da própria turma", async () => {
    const perfis = (
      await as(prof, "select name from public.profiles order by name")
    ).rows.map((r) => r.name);
    expect(perfis).toEqual(["Ana Souza Lima", "Caio", "Prof Lima"]);
    expect(
      (await as(prof, "select * from public.exercise_progress")).rows.length,
    ).toBeGreaterThan(0);
    expect(
      (await as(prof, "select * from public.class_members")).rows,
    ).toHaveLength(2);
  });
  it("professor NÃO vê alunos de outro professor nem alunos sem turma", async () => {
    expect(
      (await as(prof2, "select * from public.profiles")).rows,
    ).toHaveLength(1);
    expect(
      (await as(prof2, "select * from public.exercise_progress")).rows,
    ).toHaveLength(0);
    expect(
      (
        await as(
          prof2,
          "select * from public.class_members where class_id='" + turma + "'",
        )
      ).rows,
    ).toHaveLength(0);
    expect(
      (await as(prof, `select * from public.profiles where id='${bia}'`)).rows,
    ).toHaveLength(0);
  });
  it("professor renomeia só a própria turma e não troca o código", async () => {
    expect(
      (
        await as(
          prof,
          `update public.classes set name='ADS 2026.2' where id='${turma}' returning id`,
        )
      ).rows,
    ).toHaveLength(1);
    expect(
      (
        await as(
          prof2,
          `update public.classes set name='x' where id='${turma}' returning id`,
        )
      ).rows,
    ).toHaveLength(0);
    expect(
      (
        await as(
          prof,
          `update public.classes set code='AAAAAA' where id='${turma}'`,
        )
      ).ok,
    ).toBe(false);
  });
  it("aluno sai da turma; professor remove aluno; outro professor não remove", async () => {
    expect(
      (
        await as(
          prof2,
          `delete from public.class_members where class_id='${turma}' returning student_id`,
        )
      ).rows,
    ).toHaveLength(0);
    expect(
      (
        await as(
          caio,
          `delete from public.class_members where class_id='${turma}' and student_id='${caio}' returning student_id`,
        )
      ).rows,
    ).toHaveLength(1);
    expect(
      (
        await as(
          prof,
          `delete from public.class_members where class_id='${turma}' and student_id='${ana}' returning student_id`,
        )
      ).rows,
    ).toHaveLength(1);
    expect((await as(prof, "select * from public.profiles")).rows).toHaveLength(
      1,
    );
  });
  it("anônimo não executa as funções de turma", async () => {
    expect((await as(null, "select * from public.create_class('x')")).ok).toBe(
      false,
    );
    expect(
      (await as(null, "select * from public.join_class('AAAAAA')")).ok,
    ).toBe(false);
    expect(turma2).toBeTruthy();
  });
});

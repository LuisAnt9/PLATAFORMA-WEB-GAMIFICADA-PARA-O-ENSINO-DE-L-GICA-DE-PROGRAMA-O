// Biblioteca do conteúdo em arquivos (content/): leitura, validação e geração do SQL de importação.
// Usada por `npm run content:check` e `npm run content:build` e testada em scripts/content-lib.test.mjs.
import fs from "node:fs";
import path from "node:path";
import vm from "node:vm";

export const TIPOS = {
  codigo: "code",
  escolha: "choice",
  lacuna: "blank",
  interpretacao: "interpretation",
  ordenacao: "order",
  corrigir: "fix",
  desafio: "challenge",
};
/** Tipos corrigidos rodando o código do aluno (têm função, testes e solução de referência). */
export const TIPOS_COM_CODIGO = ["codigo", "corrigir", "desafio"];
const DIFICULDADES = ["facil", "medio", "dificil"];
const ID = /^[a-z0-9-]{1,60}$/;
const FUNCAO = /^[A-Za-z_$][A-Za-z0-9_$]{0,39}$/;
const MARCADOR = /\{\{(\d+)\}\}/g;

/** Lê content/ (mundos, conceitos, lições e soluções). Não valida: isso é com validateContent. */
export function loadContent(root) {
  const read = (f) => JSON.parse(fs.readFileSync(path.join(root, f), "utf8"));
  const worlds = read("mundos.json");
  const concepts = read("conceitos.json");
  const lessons = [];
  for (const dir of fs
    .readdirSync(root)
    .filter((d) => /^mundo-\d+$/.test(d))
    .sort()) {
    for (const f of fs
      .readdirSync(path.join(root, dir))
      .filter((x) => x.endsWith(".json"))
      .sort()) {
      const file = `${dir}/${f}`;
      let data;
      try {
        data = read(file);
      } catch (e) {
        data = { __erroLeitura: e.message };
      }
      lessons.push({ file, data });
    }
  }
  const solutions = {};
  const solDir = path.join(root, "solucoes");
  if (fs.existsSync(solDir)) {
    for (const f of fs.readdirSync(solDir).filter((x) => x.endsWith(".js"))) {
      solutions[f.slice(0, -3)] = fs.readFileSync(path.join(solDir, f), "utf8");
    }
  }
  return { worlds, concepts, lessons, solutions };
}

/**
 * Roda os testes de uma função num contexto isolado (conteúdo do repositório, não de alunos), com a
 * mesma regra do site: o teste passa se não lançar erro, se o valor retornado bater com `esperado`
 * (quando houver) e se as linhas impressas com console.log baterem com `saida` (quando houver).
 * O código pode ler as `entradas` simuladas chamando `lerEntrada()`.
 */
export function runTests(source, functionName, tests) {
  const script = `${source}\n;(function(){
    const __fn = typeof ${functionName} === 'function' ? ${functionName} : undefined;
    const __tests = ${JSON.stringify(tests.map((t) => ({ args: t.entrada, inputs: t.entradas ?? [] })))};
    let __lines = [];
    let __inputs = [];
    let __next = 0;
    const __fmt = (v) => typeof v === 'string' ? v : v === undefined ? 'undefined' : (() => { try { const j = JSON.stringify(v); return j === undefined ? String(v) : j; } catch (e) { return String(v); } })();
    globalThis.console = { log: (...a) => { if (__lines.length < 200) __lines.push(a.map(__fmt).join(' ').slice(0, 2000)); } };
    globalThis.lerEntrada = () => (__next < __inputs.length ? __inputs[__next++] : undefined);
    return JSON.stringify(__tests.map(t => {
      __lines = []; __inputs = JSON.parse(JSON.stringify(t.inputs)); __next = 0;
      try {
        if (!__fn) return { erro: 'função não encontrada', linhas: __lines };
        const r = __fn(...JSON.parse(JSON.stringify(t.args)));
        return { recebido: r === undefined ? null : r, indefinido: r === undefined, linhas: __lines };
      } catch (e) { return { erro: String(e && e.message || e), linhas: __lines }; }
    }));
  })()`;
  let out;
  try {
    out = JSON.parse(vm.runInNewContext(script, {}, { timeout: 1500 }));
  } catch (e) {
    return tests.map(() => ({ passou: false, erro: String(e.message || e) }));
  }
  return tests.map((t, i) => {
    const o = out[i];
    if (o.erro) return { passou: false, erro: o.erro, linhas: o.linhas };
    const recebido = o.indefinido ? undefined : o.recebido;
    const valorOk =
      !("esperado" in t) ||
      JSON.stringify(recebido) === JSON.stringify(t.esperado);
    const saidaOk =
      t.saida === undefined ||
      JSON.stringify(o.linhas) === JSON.stringify(t.saida);
    return { passou: valorOk && saidaOk, recebido, linhas: o.linhas };
  });
}

const len = (s) => (typeof s === "string" ? s.length : 0);
const texto = (v) => typeof v === "string" && v.trim() !== "";

/** Valida o conteúdo inteiro. Devolve { errors, warnings, stats }. */
export function validateContent(content) {
  const errors = [];
  const warnings = [];
  const err = (where, msg) => errors.push(`${where}: ${msg}`);
  const warn = (where, msg) => warnings.push(`${where}: ${msg}`);

  const worldIds = new Set();
  content.worlds.forEach((w, i) => {
    const where = `mundos.json[${i}]`;
    if (!ID.test(w.id ?? "")) err(where, `id inválido "${w.id}"`);
    if (worldIds.has(w.id)) err(where, `mundo duplicado "${w.id}"`);
    worldIds.add(w.id);
    if (!texto(w.titulo) || len(w.titulo) > 100)
      err(where, "título vazio ou maior que 100 caracteres");
    if (len(w.objetivo) > 500) err(where, "objetivo maior que 500 caracteres");
  });

  const conceptIds = new Set();
  content.concepts.forEach((c, i) => {
    const where = `conceitos.json[${i}]`;
    if (!ID.test(c.id ?? "")) err(where, `id inválido "${c.id}"`);
    if (conceptIds.has(c.id)) err(where, `conceito duplicado "${c.id}"`);
    conceptIds.add(c.id);
    if (!texto(c.titulo) || len(c.titulo) > 100)
      err(where, "título vazio ou maior que 100 caracteres");
    if (len(c.descricao) > 500)
      err(where, "descrição maior que 500 caracteres");
    if (c.mundo != null && !worldIds.has(c.mundo))
      err(where, `mundo inexistente "${c.mundo}"`);
  });

  const lessonIds = new Set();
  const exerciseIds = new Set();
  const stats = {
    worlds: worldIds.size,
    concepts: conceptIds.size,
    lessons: 0,
    exercises: 0,
    byKind: {},
  };

  for (const { file, data: l } of content.lessons) {
    if (l.__erroLeitura) {
      err(file, `JSON inválido (${l.__erroLeitura})`);
      continue;
    }
    stats.lessons++;
    if (!/^[a-z0-9-]{1,40}$/.test(l.id ?? ""))
      err(file, `id da lição inválido "${l.id}" (até 40 caracteres)`);
    if (lessonIds.has(l.id)) err(file, `lição duplicada "${l.id}"`);
    lessonIds.add(l.id);
    if (!worldIds.has(l.mundo)) err(file, `mundo inexistente "${l.mundo}"`);
    if (!texto(l.titulo) || len(l.titulo) > 80)
      err(file, "título vazio ou maior que 80 caracteres");
    if (len(l.foco) > 200) err(file, "foco maior que 200 caracteres");
    if (len(l.intro) > 3000) err(file, "intro maior que 3000 caracteres");
    if (len(l.exemplo) > 3000) err(file, "exemplo maior que 3000 caracteres");
    if (len(l.revisao) > 1500) err(file, "revisão maior que 1500 caracteres");
    if (!Number.isInteger(l.posicao))
      err(file, "posicao deve ser um número inteiro");
    if (!Array.isArray(l.exercicios)) {
      err(file, "exercicios deve ser uma lista");
      continue;
    }
    if (l.exercicios.length === 0) warn(file, "lição sem exercícios");

    for (const e of l.exercicios) {
      const where = `${file} > ${e.id ?? "(sem id)"}`;
      stats.exercises++;
      if (!ID.test(e.id ?? "")) err(where, `id inválido "${e.id}"`);
      if (exerciseIds.has(e.id))
        err(where, `id de exercício duplicado "${e.id}"`);
      exerciseIds.add(e.id);
      stats.byKind[e.tipo] = (stats.byKind[e.tipo] ?? 0) + 1;

      if (!texto(e.titulo) || len(e.titulo) > 100)
        err(where, "título vazio ou maior que 100 caracteres");
      if (!texto(e.enunciado) || len(e.enunciado) > 2000)
        err(where, "enunciado vazio ou maior que 2000 caracteres");
      if (!DIFICULDADES.includes(e.dificuldade))
        err(where, `dificuldade inválida "${e.dificuldade}"`);
      if (len(e.dica) > 500) err(where, "dica maior que 500 caracteres");
      if (e.minilicao != null && len(e.minilicao) > 1500)
        err(where, "minilição maior que 1500 caracteres");
      if (typeof e.publicado !== "boolean")
        err(where, "publicado deve ser true ou false");
      if (!Number.isInteger(e.posicao))
        err(where, "posicao deve ser um número inteiro");

      if (!Array.isArray(e.conceitos) || e.conceitos.length === 0) {
        err(
          where,
          'exercício sem conceito (use "conceitos": [{ "id": "...", "peso": 1 }])',
        );
      } else {
        const seen = new Set();
        for (const c of e.conceitos) {
          if (!conceptIds.has(c.id))
            err(where, `conceito inexistente "${c.id}"`);
          if (seen.has(c.id)) err(where, `conceito repetido "${c.id}"`);
          seen.add(c.id);
          if (!Number.isInteger(c.peso) || c.peso < 1 || c.peso > 5)
            err(where, `peso do conceito "${c.id}" deve ser de 1 a 5`);
        }
      }

      if (!(e.tipo in TIPOS)) {
        err(
          where,
          `tipo inválido "${e.tipo}" (use ${Object.keys(TIPOS).join(", ")})`,
        );
      } else if (TIPOS_COM_CODIGO.includes(e.tipo)) {
        checkCode(e, where, content.solutions, err);
        if (e.tipo === "desafio" && (e.conceitos?.length ?? 0) < 2) {
          warn(where, "desafio integrador deveria avaliar vários conceitos");
        }
      } else if (e.tipo === "escolha" || e.tipo === "interpretacao") {
        checkChoice(e, where, l.diagnostica === true, err);
        if (
          e.tipo === "interpretacao" &&
          (!texto(e.codigo) || len(e.codigo) > 2000)
        ) {
          err(
            where,
            'interpretação precisa do campo "codigo" (até 2000 caracteres)',
          );
        }
      } else if (e.tipo === "ordenacao") {
        checkOrder(e, where, err);
      } else {
        checkBlank(e, where, err);
      }
      if (
        e.comentario != null &&
        (!TIPOS_COM_CODIGO.includes(e.tipo) ||
          !texto(e.comentario) ||
          len(e.comentario) > 2000)
      ) {
        err(
          where,
          "comentario só vale para exercícios com código e tem até 2000 caracteres",
        );
      }
    }
  }

  for (const id of Object.keys(content.solutions)) {
    if (!exerciseIds.has(id))
      warn(`solucoes/${id}.js`, "solução sem exercício correspondente");
  }
  return { errors, warnings, stats };
}

function checkCode(e, where, solutions, err) {
  if (!FUNCAO.test(e.funcao ?? ""))
    err(where, `nome de função inválido "${e.funcao}"`);
  if (typeof e.codigoInicial !== "string" || len(e.codigoInicial) > 4000)
    err(where, "codigoInicial ausente ou maior que 4000 caracteres");
  if (!Array.isArray(e.testes) || e.testes.length < 1 || e.testes.length > 30) {
    err(where, "testes deve ter de 1 a 30 casos");
    return;
  }
  let testesRuins = false;
  e.testes.forEach((t, i) => {
    const n = `teste ${i + 1}`;
    const semResultado = !("esperado" in t) && t.saida === undefined;
    const saidaRuim =
      t.saida !== undefined &&
      (!Array.isArray(t.saida) ||
        t.saida.length === 0 ||
        t.saida.some((x) => typeof x !== "string"));
    const entradasRuins =
      t.entradas !== undefined && !Array.isArray(t.entradas);
    if (!Array.isArray(t.entrada))
      err(where, `${n}: "entrada" deve ser uma lista`);
    if (semResultado) {
      err(
        where,
        `${n}: falta "esperado" (valor retornado) ou "saida" (linhas impressas)`,
      );
    }
    if (entradasRuins) err(where, `${n}: "entradas" deve ser uma lista`);
    if (saidaRuim) {
      err(
        where,
        `${n}: "saida" deve ser uma lista de textos, um por linha impressa`,
      );
    }
    if (!Array.isArray(t.entrada) || semResultado || entradasRuins || saidaRuim)
      testesRuins = true;
  });
  if (!FUNCAO.test(e.funcao ?? "") || testesRuins) return;

  const sol = solutions[e.id];
  if (sol === undefined) {
    err(where, `sem solução de referência (crie content/solucoes/${e.id}.js)`);
  } else if (sol.length > 4000) {
    err(where, "solução de referência maior que 4000 caracteres");
  } else {
    runTests(sol, e.funcao, e.testes).forEach((r, i) => {
      if (!r.passou)
        err(
          where,
          `a solução de referência NÃO passa no teste ${i + 1}${r.erro ? ` (${r.erro})` : ""}`,
        );
    });
  }
  const inicial = runTests(e.codigoInicial ?? "", e.funcao, e.testes);
  if (inicial.every((r) => r.passou)) {
    err(
      where,
      e.tipo === "corrigir"
        ? "o código com defeito já passa em todos os testes (os testes não reprovam o defeito)"
        : "o código inicial já passa em todos os testes (os testes não reprovam um código vazio)",
    );
  }
  if (
    e.tipo === "corrigir" &&
    !new RegExp(`function\\s+${e.funcao.replace(/\$/g, "\\$")}\\s*\\(`).test(
      e.codigoInicial ?? "",
    )
  ) {
    err(
      where,
      `o código com defeito precisa declarar "function ${e.funcao}(...)"`,
    );
  }
}

function optionText(o) {
  return typeof o === "string" ? o : o?.texto;
}

function checkChoice(e, where, diagnostica, err) {
  const ops = e.opcoes;
  if (!Array.isArray(ops) || ops.length < 2 || ops.length > 6) {
    err(where, "opcoes deve ter de 2 a 6 alternativas");
    return;
  }
  const textos = ops.map(optionText);
  if (textos.some((t) => !texto(t))) err(where, "há alternativa vazia");
  if (
    new Set(textos.map((t) => String(t).trim().toLowerCase())).size !==
    textos.length
  )
    err(where, "há alternativas repetidas");
  if (
    !Number.isInteger(e.correta) ||
    e.correta < 0 ||
    e.correta >= ops.length
  ) {
    err(
      where,
      "correta deve ser o número (a partir de 0) da alternativa certa",
    );
  }
  ops.forEach((o, i) => {
    if (typeof o === "object" && o !== null) {
      if (o.confusao != null && (!texto(o.confusao) || len(o.confusao) > 200))
        err(
          where,
          `confusão da alternativa ${i + 1} vazia ou maior que 200 caracteres`,
        );
      if (i === e.correta && o.confusao)
        err(where, `a alternativa correta (${i + 1}) não deve ter confusão`);
    }
    if (
      diagnostica &&
      i !== e.correta &&
      !(typeof o === "object" && texto(o?.confusao))
    ) {
      err(
        where,
        `lição diagnóstica: a alternativa errada ${i + 1} precisa de "confusao"`,
      );
    }
  });
}

function checkOrder(e, where, err) {
  const itens = e.itens;
  if (!Array.isArray(itens) || itens.length < 2 || itens.length > 10) {
    err(where, "itens deve ter de 2 a 10 passos, na ordem correta");
    return;
  }
  if (itens.some((i) => !texto(i))) err(where, "há passo vazio");
  if (new Set(itens.map((i) => String(i).trim())).size !== itens.length)
    err(where, "há passos repetidos");
}

function checkBlank(e, where, err) {
  if (!texto(e.modelo) || len(e.modelo) > 2000) {
    err(where, "modelo vazio ou maior que 2000 caracteres");
    return;
  }
  const numeros = [...e.modelo.matchAll(MARCADOR)].map((m) => Number(m[1]));
  const lacunas = e.lacunas;
  if (!Array.isArray(lacunas) || lacunas.length < 1 || lacunas.length > 10) {
    err(where, "lacunas deve ter de 1 a 10 itens");
    return;
  }
  if (numeros.length === 0)
    err(where, "o modelo não tem marcadores {{1}}, {{2}}...");
  const esperado = lacunas.map((_, i) => i + 1);
  if (
    new Set(numeros).size !== numeros.length ||
    [...numeros].sort((a, b) => a - b).join() !== esperado.join()
  ) {
    err(
      where,
      `os marcadores do modelo (${numeros.join(", ")}) não correspondem às ${lacunas.length} lacunas (1 a ${lacunas.length}, sem repetir)`,
    );
  }
  lacunas.forEach((l, i) => {
    if (
      !Array.isArray(l.respostas) ||
      l.respostas.length === 0 ||
      l.respostas.some((r) => !texto(r))
    ) {
      err(
        where,
        `lacuna ${i + 1} precisa de pelo menos uma resposta não vazia`,
      );
    }
  });
}

// ---------------------------------------------------------------------------------------------
// Geração do SQL de importação
// ---------------------------------------------------------------------------------------------

const TAG = "$c$";
const q = (v) => {
  if (v === null || v === undefined) return "null";
  const s = String(v);
  if (s.includes(TAG))
    throw new Error(
      `O texto contém "${TAG}", que não pode ser usado no conteúdo: ${s.slice(0, 40)}`,
    );
  return `${TAG}${s}${TAG}`;
};
const json = (v) => `${q(JSON.stringify(v))}::jsonb`;
const bool = (v) => (v ? "true" : "false");
const lines = (rows) => rows.map((r) => `  (${r.join(", ")})`).join(",\n");

/** Converte o exercício do formato dos arquivos para as colunas do banco. */
export function exerciseRow(e) {
  const kind = TIPOS[e.tipo];
  const comCodigo = TIPOS_COM_CODIGO.includes(e.tipo);
  let config = {};
  if (kind === "choice" || kind === "interpretation") {
    const comConfusao = e.opcoes.some(
      (o) => typeof o === "object" && o?.confusao,
    );
    config = {
      options: comConfusao
        ? e.opcoes.map((o) =>
            typeof o === "string"
              ? { text: o }
              : o.confusao
                ? { text: o.texto, misconception: o.confusao }
                : { text: o.texto },
          )
        : e.opcoes.map(optionText),
      correct: e.correta,
      ...(kind === "interpretation" ? { code: e.codigo } : {}),
    };
  } else if (kind === "order") {
    config = { items: e.itens.map((i) => i.trim()) };
  } else if (kind === "blank") {
    config = {
      template: e.modelo,
      blanks: e.lacunas.map((l) => ({ answers: l.respostas })),
    };
  }
  if (!TIPOS_COM_CODIGO.includes(e.tipo) && e.explicacao)
    config.explanation = e.explicacao;
  return {
    id: e.id,
    kind,
    title: e.titulo,
    difficulty: e.dificuldade,
    statement: e.enunciado,
    lesson: e.minilicao ?? null,
    function_name: comCodigo ? e.funcao : null,
    starter_code: comCodigo ? e.codigoInicial : "",
    tests: comCodigo
      ? e.testes.map((t) => ({
          args: t.entrada,
          ...("esperado" in t ? { expected: t.esperado } : {}),
          ...(t.entradas ? { inputs: t.entradas } : {}),
          ...(t.saida ? { output: t.saida } : {}),
        }))
      : [],
    config,
    hint: e.dica ?? "",
    position: e.posicao,
    published: e.publicado,
  };
}

/**
 * SQL idempotente: pode ser colado no SQL Editor quantas vezes quiser.
 *  - mundos e conceitos: sempre atualizados;
 *  - lições e exercícios novos: inseridos (exercícios entram como o arquivo manda: rascunho ou publicado);
 *  - lições e exercícios existentes: só atualizados se ainda são `origem = 'arquivo'` (ninguém editou no painel);
 *    `published` e `position` de exercícios já existentes nunca são alterados pelo importador.
 */
export function buildImportSql(content) {
  const exercises = content.lessons.flatMap(({ data: l }) =>
    l.exercicios.map((e) => ({ lesson: l, e, row: exerciseRow(e) })),
  );
  const ids = exercises.map((x) => q(x.e.id)).join(", ");
  const out = [];
  out.push(`-- GERADO por "npm run content:build" a partir de content/. Não edite à mão.
-- Importa mundos, conceitos, lições e exercícios. Pode ser executado várias vezes (idempotente).
-- Requer as migrations até a 0012. Não altera "published" nem "position" de exercícios que já existem
-- e não toca em lições/exercícios que o professor editou no painel (origem = 'painel').
`);

  out.push(`insert into public.worlds (id, title, objective, position) values
${lines(content.worlds.map((w, i) => [q(w.id), q(w.titulo), q(w.objetivo ?? ""), String(w.posicao ?? i + 1)]))}
on conflict (id) do update set title = excluded.title, objective = excluded.objective, position = excluded.position;
`);

  out.push(`insert into public.concepts (id, title, description, world_id, position) values
${lines(content.concepts.map((c, i) => [q(c.id), q(c.titulo), q(c.descricao ?? ""), q(c.mundo ?? null), String(c.posicao ?? i + 1)]))}
on conflict (id) do update set title = excluded.title, description = excluded.description,
  world_id = excluded.world_id, position = excluded.position;
`);

  out.push(`insert into public.modules (id, title, focus, intro, example, review, world_id, position, origem) values
${lines(content.lessons.map(({ data: l }) => [q(l.id), q(l.titulo), q(l.foco ?? ""), q(l.intro ?? ""), q(l.exemplo ?? ""), q(l.revisao ?? ""), q(l.mundo), String(l.posicao), q("arquivo")]))}
on conflict (id) do update set title = excluded.title, focus = excluded.focus, intro = excluded.intro,
  example = excluded.example, review = excluded.review, world_id = excluded.world_id, position = excluded.position
  where public.modules.origem = 'arquivo';
`);

  out.push(`insert into public.exercises
  (id, module_id, kind, title, difficulty, statement, lesson, function_name, starter_code, tests, config, hint, position, published, origem)
values
${lines(
  exercises.map(({ lesson, row: r }) => [
    q(r.id),
    q(lesson.id),
    q(r.kind),
    q(r.title),
    q(r.difficulty),
    q(r.statement),
    q(r.lesson),
    q(r.function_name),
    q(r.starter_code),
    json(r.tests),
    json(r.config),
    q(r.hint),
    String(r.position),
    bool(r.published),
    q("arquivo"),
  ]),
)}
on conflict (id) do update set module_id = excluded.module_id, kind = excluded.kind, title = excluded.title,
  difficulty = excluded.difficulty, statement = excluded.statement, lesson = excluded.lesson,
  function_name = excluded.function_name, starter_code = excluded.starter_code, tests = excluded.tests,
  config = excluded.config, hint = excluded.hint
  where public.exercises.origem = 'arquivo';
`);

  const solutions = exercises.filter(
    ({ e }) =>
      TIPOS_COM_CODIGO.includes(e.tipo) &&
      content.solutions[e.id] !== undefined,
  );
  if (solutions.length > 0) {
    out.push(`-- Soluções comentadas (só professores leem a tabela; o aluno recebe pela função get_solution depois de acertar).
insert into public.exercise_solutions (exercise_id, solution, commentary)
select v.exercise_id, v.solution, v.commentary
from (values
${lines(solutions.map(({ e }) => [q(e.id), q(content.solutions[e.id].trimEnd()), q(e.comentario ?? "")]))}
) as v (exercise_id, solution, commentary)
join public.exercises e on e.id = v.exercise_id and e.origem = 'arquivo'
on conflict (exercise_id) do update set solution = excluded.solution, commentary = excluded.commentary;
`);
  }

  const links = exercises.flatMap(({ e }) =>
    e.conceitos.map((c) => [q(e.id), q(c.id), String(c.peso)]),
  );
  out.push(`-- Vínculos exercício-conceito: só dos exercícios que o importador administra.
delete from public.exercise_concepts where exercise_id in (
  select id from public.exercises where origem = 'arquivo' and id in (${ids})
);
insert into public.exercise_concepts (exercise_id, concept_id, weight)
select v.exercise_id, v.concept_id, v.weight
from (values
${lines(links)}
) as v (exercise_id, concept_id, weight)
join public.exercises e on e.id = v.exercise_id and e.origem = 'arquivo'
on conflict (exercise_id, concept_id) do update set weight = excluded.weight;
`);

  out.push(`do $$
declare n integer;
begin
  select count(*) into n from public.exercises where origem = 'painel' and id in (${ids});
  if n > 0 then
    raise notice '% exercício(s) do conteúdo foram ignorados porque foram editados no painel do professor.', n;
  end if;
end $$;
`);
  return out.join("\n");
}

// E10: ciclo completo. O professor cria uma atividade e uma avaliação, o aluno resolve e o professor acompanha.
// Um "mini-backend" em memória é compartilhado entre os dois navegadores (professor e aluno).
import { BASE, OUT, launch } from "./helpers.mjs";
const b = await launch();
const b64=o=>Buffer.from(JSON.stringify(o)).toString("base64url");
const mkSession=uid=>{ const jwt=`${b64({alg:"HS256",typ:"JWT"})}.${b64({sub:uid,role:"authenticated",exp:4102444800})}.sig`; return {access_token:jwt,refresh_token:"r",token_type:"bearer",expires_in:3600,expires_at:4102444800,user:{id:uid,aud:"authenticated",role:"authenticated",email:"x@x.com",app_metadata:{},user_metadata:{},created_at:"2026-01-01T00:00:00Z"}}; };
const PROF="22222222-2222-2222-2222-222222222222", ALUNO="11111111-1111-1111-1111-111111111111";
let failed=0; const ok=(n,c)=>{console.log((c?"✓ ":"✗ FALHOU: ")+n); if(!c) failed++;};

const choice=(id,title,pos)=>({id,module_id:"m1",kind:"choice",lesson:null,title,difficulty:"facil",statement:"Enunciado "+title,function_name:null,starter_code:"",tests:[],config:{options:["errada","certa"],correct:1},hint:"",position:pos,published:true});
const exs=[choice("e1","Qual é o valor?",1),choice("e2","Outra pergunta",2),
  {id:"c1",module_id:"m1",kind:"code",lesson:null,title:"Dobro (código)",difficulty:"facil",statement:"d",function_name:"dobro",starter_code:"function dobro(n){}",tests:[{args:[2],expected:4}],config:{},hint:"",position:3,published:true}];
const mods=[{id:"m1",title:"Lição Alfa",focus:"F",intro:"",position:1}];

// ---- estado do mini-backend
const db={ assignments:[], items:{}, attempts:[], solved:new Set(), submissions:{}, nextId:1, patches:[] };
const hoursFromNow=h=>new Date(Date.now()+h*3600e3).toISOString();
function statusOf(a){
  if(a.kind==="avaliacao") return db.submissions[a.id]?"entregue":"nao_iniciada";
  const items=db.items[a.id]; const done=items.filter(i=>db.solved.has(i)).length;
  const started=db.attempts.some(t=>t.p_assignment_id===a.id);
  return done===items.length?"concluida":(started||done>0)?"em_andamento":"nao_iniciada";
}
const myAssignment=a=>({id:a.id,kind:a.kind,title:a.title,instructions:a.instructions,class_name:"Turma Teste",available_from:a.available_from,due_at:a.due_at,required:a.required,result_rule:a.result_rule,items_total:db.items[a.id].length,items_done:db.items[a.id].filter(i=>db.solved.has(i)).length,submitted_at:db.submissions[a.id]?.submitted_at??null,score:db.submissions[a.id]?.score??null,max_score:db.submissions[a.id]?.max??null,status:statusOf(a)});

async function newCtx(role){
  const uid=role==="professor"?PROF:ALUNO;
  const ctx=await b.newContext({viewport:{width:Number(process.env.E2E_W||1000),height:Number(process.env.E2E_H||1000)}});
  await ctx.addInitScript(s=>localStorage.setItem("sb-shmdjhfleduxefoodrfm-auth-token",JSON.stringify(s)),mkSession(uid));
  await ctx.route("**/*.supabase.co/**", async route=>{
    const req=route.request(), u=req.url(), m=req.method();
    const json=(body,code=200)=>route.fulfill({status:code,contentType:"application/json",headers:{"access-control-allow-origin":"*"},body:JSON.stringify(body)});
    if(m==="OPTIONS") return route.fulfill({status:204,headers:{"access-control-allow-origin":"*","access-control-allow-headers":"*","access-control-allow-methods":"*"}});
    const body=()=>{ try{ return JSON.parse(req.postData()||"{}"); }catch{ return {}; } };
    // --- RPCs de atividades
    if(u.includes("/rpc/create_assignment")){ const p=body(); const id=db.nextId++; db.assignments.push({id,kind:p.p_kind,title:p.p_title,instructions:p.p_instructions,available_from:p.p_available_from,due_at:p.p_due_at,required:p.p_required,result_rule:p.p_result_rule,payload:p}); db.items[id]=p.p_items.map(i=>i.exercise_id); return json(id); }
    if(u.includes("/rpc/teacher_assignment_summaries")) return json(db.assignments.map(a=>({id:a.id,kind:a.kind,title:a.title,class_id:"c1",class_name:"Turma Teste",available_from:a.available_from,due_at:a.due_at,required:a.required,archived:false,students:1,started:statusOf(a)==="nao_iniciada"?0:1,completed:["concluida","entregue"].includes(statusOf(a))?1:0})));
    if(u.includes("/rpc/my_assignments")) return json(db.assignments.map(myAssignment));
    if(u.includes("/rpc/assignment_report")){ const a=db.assignments.find(x=>x.id===body().p_assignment); const st=statusOf(a); const sub=db.submissions[a.id];
      return json({assignment:{id:a.id,kind:a.kind,title:a.title,instructions:a.instructions,class_id:"c1",class_name:"Turma Teste",available_from:a.available_from,due_at:a.due_at,required:a.required,result_rule:a.result_rule},
        students:[{id:ALUNO,name:"Ana Souza",items_total:db.items[a.id].length,items_done:db.items[a.id].filter(i=>db.solved.has(i)).length,attempts:db.attempts.filter(t=>t.p_assignment_id===a.id).length,last_attempt:null,duration_ms:120000,score:sub?.score??null,max_score:sub?.max??null,submitted_at:sub?.submitted_at??null,status:st}],
        exercises:db.items[a.id].map(i=>({exercise_id:i,title:exs.find(e=>e.id===i).title,attempted:db.attempts.some(t=>t.p_exercise===i&&t.p_assignment_id===a.id)?1:0,solved:db.solved.has(i)?1:0,attempts:db.attempts.filter(t=>t.p_exercise===i&&t.p_assignment_id===a.id).length})),
        concepts:[]}); }
    if(u.includes("/rpc/get_assessment")){ const a=db.assignments.find(x=>x.id===body().p_assignment); return json({id:a.id,title:a.title,instructions:a.instructions,due_at:a.due_at,result_rule:a.result_rule,questions:db.items[a.id].map((i,n)=>({id:100+n,kind:"choice",title:"Questão "+(n+1),statement:"Enunciado "+exs.find(e=>e.id===i).title,payload:{options:["errada","certa"]},points:1}))}); }
    if(u.includes("/rpc/assessment_result")){ const s=db.submissions[body().p_assignment]; return json(s?{score:s.score,max:s.max,submitted_at:s.submitted_at,late:false,details:null}:null); }
    if(u.includes("/rpc/submit_assessment")){ const p=body(); db.lastSubmission=p; const max=db.items[p.p_assignment].length; const score=Object.values(p.p_answers).filter(v=>v===1).length; db.submissions[p.p_assignment]={score,max,submitted_at:new Date().toISOString()}; return json({score,max,submitted_at:db.submissions[p.p_assignment].submitted_at,late:false,details:null}); }
    if(u.includes("/rpc/record_attempt")){ db.attempts.push(body()); return json(1); }
    if(u.includes("/rpc/sync_gamification")) return json({bonus_xp:0,missions:[],new_worlds:[],worlds_done:[]});
    if(u.includes("/rpc/log_activity")) return json(null);
    // --- tabelas
    if(u.includes("/rest/v1/assignment_items")){ const id=Number((u.match(/assignment_id=eq\.(\d+)/)||[])[1]); return json((db.items[id]||[]).map((e,i)=>({exercise_id:e,position:i+1}))); }
    if(u.includes("/rest/v1/exercise_progress")){ if(m!=="GET"){ const p=body(); if(p.solved) db.solved.add(p.exercise_id); return route.fulfill({status:201,headers:{"access-control-allow-origin":"*"},body:""}); } return json([...db.solved].map(id=>({exercise_id:id,attempts:1,solved:true,first_try:true,xp:30}))); }
    if(u.includes("/rest/v1/classes")){ const c={id:"c1",name:"Turma Teste",code:"ABC234",created_at:"2026-01-01T00:00:00Z",archived:false}; return u.includes("teacher_id=eq.")?json([c]):(req.headers()["accept"]?.includes("vnd.pgrst.object")?json(c):json([c])); }
    if(u.includes("/rest/v1/class_members")) return json([{class_id:"c1"}]);
    if(u.includes("/rest/v1/modules")) return json(mods);
    if(u.includes("/rest/v1/exercises")) return json(exs);
    if(u.includes("/rest/v1/profiles")) return json({id:uid,name:role==="professor"?"Prof Lima":"Ana Souza",role});
    if(u.includes("/rest/v1/daily_activity")) return json([]);
    return json([]);
  });
  const p=await ctx.newPage(); const errs=[]; p.on("pageerror",e=>errs.push(e.message));
  return {p,errs,ctx};
}
const main=p=>p.locator("main").innerText();

// ================= PROFESSOR: cria a atividade para casa =================
const T=await newCtx("professor");
{
  const {p,errs}=T;
  await p.goto(BASE+"/professor/atividades"); await p.waitForSelector("text=Você ainda não atribuiu nenhuma atividade");
  ok("professor vê a aba Atividades e a lista vazia", (await p.locator("nav[aria-label='Área do professor']").innerText()).includes("Atividades"));
  await p.click("a:has-text('Nova atividade')"); await p.waitForSelector("h1:has-text('Nova atividade')");
  await p.fill("input[placeholder^='Ex.:']","Lista 1"); 
  await p.waitForSelector("label:has-text('Qual é o valor?')");
  await p.locator("label:has-text('Qual é o valor?') input").check();
  await p.locator("label:has-text('Dobro (código)') input").check();
  await p.fill("textarea","Resolva os dois exercícios.");
  await p.click("button:has-text('Publicar atividade')");
  await p.waitForSelector("h1:has-text('Lista 1')");
  ok("atividade criada e relatório aberto", (await main(p)).includes("Ana Souza") && (await main(p)).includes("Não iniciada"));
  const pl=db.assignments[0].payload;
  ok("o pedido ao banco leva turma, tipo, itens e prazo depois da liberação", pl.p_kind==="atividade" && pl.p_class==="c1" && pl.p_items.length===2 && new Date(pl.p_due_at)>new Date(pl.p_available_from));
  ok("sem erros de página (professor cria)", errs.length===0);
}

// ================= ALUNO: vê, resolve com a modalidade atividade =================
const S=await newCtx("aluno");
{
  const {p,errs}=S;
  await p.goto(BASE+"/"); await p.waitForSelector("text=Atividades pendentes");
  ok("início do aluno mostra a atividade pendente com prazo", (await main(p)).includes("Lista 1") && (await main(p)).includes("Prazo:"));
  await p.click("nav >> text=Minhas atividades"); await p.waitForSelector("h1:has-text('Minhas atividades')");
  ok("Minhas atividades lista prazo e situação", (await main(p)).includes("Lista 1") && (await main(p)).includes("Não iniciada") && (await main(p)).includes("0/2 exercícios"));
  await p.click("a:has-text('Lista 1')"); await p.waitForSelector("h1:has-text('Lista 1')");
  ok("a atividade mostra instruções e exercícios", (await main(p)).includes("Resolva os dois exercícios.") && (await main(p)).includes("Qual é o valor?"));
  await p.click("a:has-text('Qual é o valor?')"); await p.waitForSelector("text=Enunciado Qual é o valor?");
  ok("o link do exercício leva a atividade na URL", p.url().includes("?atividade=1"));
  await p.locator("label:has-text('certa')").click();
  await p.click("button:has-text('Verificar resposta')"); await p.waitForSelector("text=Correto!");
  ok("a tentativa é registrada na modalidade atividade, ligada à atividade", db.attempts.length===1 && db.attempts[0].p_mode==="atividade" && db.attempts[0].p_assignment_id===1 && db.attempts[0].p_exercise==="e1");
  await p.click("a:has-text('Voltar à atividade')"); await p.waitForSelector("h1:has-text('Lista 1')");
  await p.waitForSelector("text=1/2 resolvidos");
  ok("de volta à atividade, o progresso foi atualizado", (await main(p)).includes("Em andamento"));
  // fora da atividade a modalidade continua livre
  await p.goto(BASE+"/exercicio/e2"); await p.waitForSelector("text=Enunciado Outra pergunta");
  await p.locator("label:has-text('errada')").click(); await p.click("button:has-text('Verificar resposta')"); await p.waitForSelector("text=Ainda não");
  ok("exercício aberto sem atividade segue como aprendizagem livre", db.attempts.at(-1).p_mode==="livre" && db.attempts.at(-1).p_assignment_id===null);
  db.solved.add("c1"); // o exercício de código é resolvido no navegador; aqui só concluímos a atividade
  ok("sem erros de página (aluno)", errs.length===0);
}

// ================= PROFESSOR acompanha =================
{
  const {p}=T;
  await p.goto(BASE+"/professor/atividades/1"); await p.waitForSelector("h1:has-text('Lista 1')");
  await p.waitForSelector("text=Concluída");
  const t=await main(p);
  ok("professor acompanha: aluno concluiu, com tentativas por exercício", t.includes("Ana Souza") && t.includes("Concluída") && t.includes("2/2"));
  ok("resumo mostra iniciaram/concluíram", t.includes("1/1") && t.includes("concluíram"));
  ok("desempenho por exercício aparece", t.includes("Qual é o valor?") && t.includes("Desempenho por conceito"));
  await p.goto(BASE+"/professor"); await p.waitForSelector("text=atividades atribuídas");
  ok("painel do professor resume as atividades", (await main(p)).includes("turmas ativas") && (await main(p)).includes("Lista 1"));
  await p.screenshot({path:OUT+"/shots/e10-painel.png",fullPage:true});
}

// ================= AVALIAÇÃO =================
{
  const {p}=T;
  await p.goto(BASE+"/professor/atividades/nova"); await p.waitForSelector("h1:has-text('Nova atividade')");
  await p.locator("label:has-text('Avaliação com nota') input").check();
  ok("na avaliação, exercício de código fica indisponível", await p.locator("label:has-text('Dobro (código)') input").isDisabled());
  await p.fill("input[placeholder^='Ex.:']","Prova 1");
  await p.locator("label:has-text('Qual é o valor?') input").check();
  await p.locator("label:has-text('Outra pergunta') input").check();
  ok("pontos por questão aparecem", await p.locator("input[type=number]").count()===2);
  await p.selectOption("select >> nth=1","nota_e_gabarito");
  await p.click("button:has-text('Publicar avaliação')"); await p.waitForSelector("h1:has-text('Prova 1')");
  ok("avaliação criada", db.assignments[1].kind==="avaliacao" && db.assignments[1].payload.p_result_rule==="nota_e_gabarito");
}
{
  const {p,errs}=S;
  await p.goto(BASE+"/atividades/2"); await p.waitForSelector("text=uma vez");
  const html=await p.content();
  ok("a prova chega sem o gabarito", !html.includes("\"correct\"") && (await main(p)).includes("Questão 1") && (await main(p)).includes("Questão 2"));
  await p.locator("input[type=radio]").nth(1).check();
  await p.locator("section:has-text('Questão 2') input[type=radio]").nth(1).check();
  await p.click("button:has-text('Entregar avaliação')");
  ok("pede confirmação antes de entregar (entrega única)", await p.locator("[role=alertdialog]").count()===1);
  await p.click("button:has-text('Sim, entregar')"); await p.waitForSelector("text=Nota: 2/2");
  ok("mostra a nota depois de entregar", true);
  ok("as respostas enviadas ao banco não incluem gabarito nem nota", Object.keys(db.lastSubmission).sort().join()==="p_answers,p_assignment");
  await p.reload(); await p.waitForSelector("text=Nota: 2/2");
  ok("ao voltar, o aluno vê a entrega e não a prova de novo", await p.locator("[role=alertdialog]").count()===0 && await p.locator("button:has-text('Entregar avaliação')").count()===0);
  ok("sem erros de página (avaliação)", errs.length===0);
}
{
  const {p}=T;
  await p.goto(BASE+"/professor/atividades/2"); await p.waitForSelector("text=Entregue");
  ok("professor vê a nota da avaliação", (await main(p)).includes("2/2"));
}

await b.close();
console.log(failed?`${failed} FALHA(S)`:"TODOS OS FLUXOS OK");
process.exit(failed?1:0);

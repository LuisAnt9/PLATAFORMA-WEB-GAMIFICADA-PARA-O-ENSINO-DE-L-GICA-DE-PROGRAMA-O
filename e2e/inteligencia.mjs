// E11: painel de dificuldades por conceito. DADOS DE SIMULAÇÃO (nada disto é de alunos reais).
import { BASE, OUT, launch } from "./helpers.mjs";
const b = await launch();
const b64=o=>Buffer.from(JSON.stringify(o)).toString("base64url");
const uid="22222222-2222-2222-2222-222222222222";
const jwt=`${b64({alg:"HS256",typ:"JWT"})}.${b64({sub:uid,role:"authenticated",exp:4102444800})}.sig`;
const session={access_token:jwt,refresh_token:"r",token_type:"bearer",expires_in:3600,expires_at:4102444800,user:{id:uid,aud:"authenticated",role:"authenticated",email:"p@x.com",app_metadata:{},user_metadata:{},created_at:"2026-01-01T00:00:00Z"}};
let failed=0; const ok=(n,c)=>{console.log((c?"✓ ":"✗ FALHOU: ")+n); if(!c) failed++;};
const ago=d=>new Date(Date.now()-d*864e5).toISOString();

const ex=(id,title,diff)=>({id,module_id:"m1",kind:"choice",lesson:null,title,difficulty:diff,statement:"s",function_name:null,starter_code:"",tests:[],config:{options:["a","b"],correct:0},hint:"",position:1,published:true});
const exercises=[ex("l1","Tabela verdade do E","facil"),ex("l2","Tabela verdade do OU","medio"),ex("l3","Combine E e OU","dificil"),ex("i1","Igualdade estrita","facil")];
const concepts=[{id:"k-log",title:"Operadores lógicos",description:"",world_id:"w1"},{id:"k-ig",title:"Igualdade",description:"",world_id:"w1"}];
const links=[["l1","k-log"],["l2","k-log"],["l3","k-log"],["i1","k-ig"]].map(([e,c])=>({exercise_id:e,concept_id:c,weight:1}));
const worlds=[{id:"w1",title:"Operadores",objective:"",position:3}];
const mods=[{id:"m1",title:"Lógicos",focus:"F",intro:"",world_id:"w1",position:1}];

const mkReport=(total)=>({
  students_total:total, min_students:5,
  concepts:[
    {concept_id:"k-log",title:"Operadores lógicos",world_id:"w1",attempts:42,exercises:3,students:total,sufficient:total>=5,error_rate:total>=5?0.62:null,bom:2,em_desenvolvimento:1,dificuldade:4,nao_avaliado:1},
    {concept_id:"k-ig",title:"Igualdade",world_id:"w1",attempts:24,exercises:2,students:total,sufficient:total>=5,error_rate:total>=5?0.18:null,bom:6,em_desenvolvimento:1,dificuldade:0,nao_avaliado:1},
  ],
  student_concepts:[
    {student_id:"s1",name:"Ana Souza",concept_id:"k-log",attempts:7,exercises:3,score:0.7,level:"dificuldade"},
    {student_id:"s1",name:"Ana Souza",concept_id:"k-ig",attempts:2,exercises:1,score:0.5,level:"nao_avaliado"},
  ],
  hardest_exercises:[{exercise_id:"l3",title:"Combine E e OU",attempts:14,errors:11,error_rate:11/14}],
  misconceptions:[{text:"confunde && com ||",count:9,students:5}],
  error_categories:[{category:"escolha_incorreta",count:20},{category:"sintaxe",count:3}],
  by_mode:[{mode:"atividade",attempts:20,errors:12},{mode:"livre",attempts:46,errors:19}],
  timeline:[{day:"2026-03-09",attempts:30,errors:15},{day:"2026-03-10",attempts:36,errors:16}],
});
const calls=[]; let total=8;
const attemptsDetail=[{id:1,exercise_id:"l1",passed:false,answer:"{\"selected\":1}",error_category:"escolha_incorreta",misconception:"confunde && com ||",mode:"livre",created_at:ago(3)},{id:2,exercise_id:"l2",passed:true,answer:null,error_category:null,misconception:null,mode:"atividade",created_at:ago(1)}];

const ctx=await b.newContext({viewport:{width:1100,height:1000}});
await ctx.addInitScript(s=>localStorage.setItem("sb-shmdjhfleduxefoodrfm-auth-token",JSON.stringify(s)),session);
await ctx.route("**/*.supabase.co/**", async route=>{
  const req=route.request(), u=req.url(), m=req.method(), acc=req.headers()["accept"]||"";
  const json=(body,code=200)=>route.fulfill({status:code,contentType:"application/json",headers:{"access-control-allow-origin":"*"},body:JSON.stringify(body)});
  if(m==="OPTIONS") return route.fulfill({status:204,headers:{"access-control-allow-origin":"*","access-control-allow-headers":"*","access-control-allow-methods":"*"}});
  if(u.includes("/rpc/concept_report")){ calls.push(JSON.parse(req.postData()||"{}")); return json(mkReport(total)); }
  if(u.includes("/rpc/teacher_assignment_summaries")) return json([]);
  if(u.includes("/rest/v1/attempts")) return json(attemptsDetail);
  if(u.includes("/rest/v1/worlds")) return json(worlds);
  if(u.includes("/rest/v1/exercise_concepts")) return json(links);
  if(u.includes("/rest/v1/concepts")) return json(concepts);
  if(u.includes("/rest/v1/modules")) return json(mods);
  if(u.includes("/rest/v1/exercises")) return json(exercises);
  if(u.includes("/rest/v1/profiles")) return u.includes("id=in.")?json([{id:"s1",name:"Ana Souza"}]):json({id:uid,name:"Prof Lima",role:"professor"});
  if(u.includes("/rest/v1/exercise_progress")) return u.includes("user_id=in.")?json([{user_id:"s1",exercise_id:"l1",attempts:3,solved:false,first_try:false,xp:0,solved_at:null,updated_at:ago(1)}]):json([]);
  if(u.includes("/rest/v1/classes")){ const c={id:"c1",name:"ADS 2026.2",code:"ABC234",created_at:ago(5),archived:false}; return u.includes("teacher_id=eq.")?json([c]):(acc.includes("vnd.pgrst.object")?json(c):json([c])); }
  if(u.includes("/rest/v1/class_members")) return u.includes("class_id=eq.")?json([{student_id:"s1",joined_at:ago(20)}]):json([{class_id:"c1"}]);
  return json([]);
});
const p=await ctx.newPage(); const errs=[]; p.on("pageerror",e=>errs.push(e.message));
const main=()=>p.locator("main").innerText();

// ---- turma com 8 alunos: painel completo
await p.goto(BASE+"/professor/turmas/c1"); await p.waitForSelector("role=tab[name='Conceitos']",{timeout:12000});
await p.click("role=tab[name='Conceitos']"); await p.waitForSelector("text=O que revisar");
let t=await main();
ok("recomendação em linguagem neutra com o conceito de maior erro", t.includes('A turma apresenta dificuldade em "Operadores lógicos"') && !/incapaz/i.test(t));
ok("a recomendação tem o botão de atividade de reforço", await p.locator("a:has-text('Criar atividade de reforço')").count()===1);
ok("tabela por conceito com taxa de erro e alunos sem domínio", t.includes("62%") && t.includes("4 de 7") && t.includes("18%"));
ok("a tabela é a versão acessível do gráfico (gráfico escondido de leitores de tela)", await p.locator("ul[aria-hidden=true]").count()>=1 && await p.locator("table").count()>=3);
ok("melhor compreendido aparece", t.includes("Melhor compreendidos: Igualdade"));
ok("erros recorrentes: confusão e tipos de erro", t.includes("confunde && com ||") && t.includes("9 respostas") && t.includes("Erro de sintaxe"));
ok("exercícios com mais respostas incorretas", t.includes("Combine E e OU") && t.includes("79%"));
ok("modalidades separadas", t.includes("Atividade") && t.includes("Aprendizagem livre"));
ok("evolução em tabela", t.includes("Tentativas e erros por dia"));
await p.screenshot({path:OUT+"/shots/e11-painel.png",fullPage:true});

// ---- filtros mudam a consulta
calls.length=0;
await p.selectOption("label:has-text('Modalidade') select","atividade"); await p.waitForTimeout(600);
await p.selectOption("label:has-text('Período') select","30"); await p.waitForTimeout(600);
await p.selectOption("label:has-text('Mundo') select","w1"); await p.waitForTimeout(600);
const last=calls.at(-1);
ok("filtros de modalidade, período e mundo vão para o banco", last.p_mode==="atividade" && last.p_world==="w1" && !!last.p_from && last.p_class==="c1");
ok("a lista de lições segue o mundo escolhido", await p.locator("label:has-text('Lição') select option").count()===2);

// ---- reforço: abre o formulário já preenchido
await p.click("a:has-text('Criar atividade de reforço')"); await p.waitForSelector("h1:has-text('Nova atividade')");
await p.waitForSelector("text=Atividade de reforço sobre");
ok("o formulário vem com título, turma e exercícios do conceito", (await p.inputValue("input[placeholder^='Ex.:']"))==="Reforço: Operadores lógicos");
const checked=await p.locator("fieldset input[type=checkbox]:checked").count();
ok("exercícios do conceito já escolhidos (3 do conceito, não o de Igualdade)", checked===3 && await p.locator("label:has-text('Igualdade estrita') input").isChecked()===false);

// ---- turma pequena: dados insuficientes
total=4;
await p.goto(BASE+"/professor/turmas/c1"); await p.click("role=tab[name='Conceitos']"); await p.waitForSelector("text=Dados insuficientes para o painel da turma");
t=await main();
ok("turma com 4 alunos: explica quantos faltam e não mostra taxa nem recomendação", t.includes("faltam 1") && !t.includes("62%") && t.includes("Nenhum conceito pede atenção"));
total=8;

// ---- análise individual
await p.goto(BASE+"/professor/turmas/c1/alunos/s1"); await p.waitForSelector("text=Ainda não demonstrou domínio");
t=await main();
ok("aluno: nível por conceito em linguagem neutra", t.includes("Operadores lógicos") && t.includes("Ainda não demonstrou domínio") && !/incapaz/i.test(t));
ok("conceito com poucos dados diz quanto falta", t.includes("faltam 1 tentativas e 1 exercícios"));
await p.click("button:has-text('Ver exercícios e respostas') >> nth=0"); await p.waitForSelector("text=Tabela verdade do E");
t=await main();
ok("ao abrir o conceito: exercícios, respostas, modalidade e evolução", t.includes("Errou: Alternativa incorreta") && t.includes("confunde && com ||") && t.includes("Atividade") && await p.locator("[role=img][aria-label='errou']").count()===1 && await p.locator("[role=img][aria-label='acertou']").count()===1);
ok("sem erros de página", errs.length===0);

await b.close();
console.log(failed?`${failed} FALHA(S)`:"TODOS OS FLUXOS OK");
process.exit(failed?1:0);

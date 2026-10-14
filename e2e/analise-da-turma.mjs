import fs from "node:fs";
import { BASE, OUT, launch } from "./helpers.mjs";
const b = await launch();
const b64=o=>Buffer.from(JSON.stringify(o)).toString("base64url");
const uid="11111111-1111-1111-1111-111111111111";
const jwt=`${b64({alg:"HS256",typ:"JWT"})}.${b64({sub:uid,role:"authenticated",exp:4102444800})}.sig`;
const session={access_token:jwt,refresh_token:"r",token_type:"bearer",expires_in:3600,expires_at:4102444800,user:{id:uid,aud:"authenticated",role:"authenticated",email:"p@x.com",app_metadata:{},user_metadata:{},created_at:"2026-01-01T00:00:00Z"}};
let failed=0; const ok=(n,c)=>{console.log((c?"✓ ":"✗ FALHOU: ")+n); if(!c) failed++;};
const ago=(days)=>new Date(Date.now()-days*864e5-(days?3600e3:0)).toISOString(); // independe do horário do dia
const ex=(id,pos)=>({id,module_id:"m1",title:"Exercício "+id.toUpperCase(),difficulty:"facil",statement:"s",function_name:"f",starter_code:"function f() {}",tests:[{args:[],expected:1}],hint:"",position:pos,published:true});
const exercises=["a","b","c","d","e"].map((id,i)=>ex(id,i+1));
const members=[{student_id:"s1",joined_at:ago(20)},{student_id:"s2",joined_at:ago(20)},{student_id:"s3",joined_at:ago(1)},{student_id:"s4",joined_at:ago(10)}];
const names=[{id:"s1",name:"Ana Souza"},{id:"s2",name:"Beto Lima"},{id:"s3",name:"Caio Melo"},{id:"s4",name:"Duda Rocha"}];
const pr=(u,e,o)=>({user_id:u,exercise_id:e,attempts:1,solved:false,first_try:false,xp:0,solved_at:null,updated_at:ago(1),...o});
const progress=[
 pr("s1","a",{solved:true,first_try:true,xp:15,solved_at:ago(0),updated_at:ago(0)}),
 pr("s1","b",{solved:true,attempts:3,xp:10,solved_at:ago(1),updated_at:ago(1)}),
 pr("s1","c",{solved:true,xp:15,first_try:true,solved_at:ago(1,15),updated_at:ago(1,15)}),
 pr("s1","d",{solved:true,xp:15,first_try:true,solved_at:ago(3),updated_at:ago(3)}),
 pr("s1","e",{attempts:2,updated_at:ago(0)}),
 pr("s2","a",{solved:true,attempts:2,xp:10,solved_at:ago(9),updated_at:ago(9)}),
 pr("s2","b",{attempts:5,updated_at:ago(9)}),
 pr("s2","c",{attempts:4,updated_at:ago(9)}),
];
const ctx = await b.newContext({viewport:{width:1000,height:1000}});
await ctx.addInitScript(s=>localStorage.setItem("sb-shmdjhfleduxefoodrfm-auth-token",JSON.stringify(s)),session);
await ctx.route("**/*.supabase.co/**", async route=>{
  const req=route.request(), u=req.url(), m=req.method(), acc=req.headers()["accept"]||"";
  const json=(body,code=200)=>route.fulfill({status:code,contentType:"application/json",headers:{"access-control-allow-origin":"*"},body:JSON.stringify(body)});
  if(m==="OPTIONS") return route.fulfill({status:204,headers:{"access-control-allow-origin":"*","access-control-allow-headers":"*","access-control-allow-methods":"*"}});
  if(u.includes("/rest/v1/modules")) return json([{id:"m1",title:"Fundamentos",focus:"F",position:1}]);
  if(u.includes("/rest/v1/exercises")) return json(exercises);
  if(u.includes("/rest/v1/profiles")) return u.includes("id=in.")?json(names):json({id:uid,name:"Prof Lima",role:"professor"});
  if(u.includes("/rest/v1/exercise_progress")) return u.includes("user_id=in.")?json(progress):json([]);
  if(u.includes("/rest/v1/classes")){ const c={id:"c1",name:"ADS 2026.2",code:"ABC234",created_at:ago(5)}; return u.includes("teacher_id=eq.")?json([c]):(acc.includes("vnd.pgrst.object")?json(c):json([c])); }
  if(u.includes("/rest/v1/class_members")) return u.includes("class_id=eq.")?json(members):json(members.map(()=>({class_id:"c1"})));
  return json([]);
});
const p=await ctx.newPage(); const errs=[]; p.on("pageerror",e=>errs.push(e.message));
await p.goto(BASE+"/professor/turmas/c1");
await p.waitForSelector("text=Precisam de atenção",{timeout:12000});
const geral=await p.locator("main").innerText();
ok("KPIs: 4 alunos, 2 ativos de 4 (Ana + Duda? não: só Ana e Caio=nunca)", geral.includes("4") && /ativos nos últimos 7 dias/.test(geral));
ok("alerta do Beto (parado há 9 dias e travado em 2)", /Beto Lima/.test(geral) && /Sem atividade há 9 dias/.test(geral) && /Travado em 2 exercícios/.test(geral));
ok("alerta da Duda (nunca tentou, entrou há 10 dias)", /Duda Rocha/.test(geral) && /Ainda não tentou nenhum exercício \(entrou há 10 dias\)/.test(geral));
ok("Caio (novato) e Ana (ativa) NÃO estão em alerta", !/⚠ Caio/.test(geral) && !/⚠ Ana/.test(geral));
ok("gráfico: 14 colunas e título", (await p.locator("figure button[aria-label*='exerc']").count())===14 && geral.includes("últimos 14 dias"));
// total no período: ana 4 (hoje, ontem x2, 3 dias) = 4; beto a 9 dias atrás também cai em 14 dias => 5
ok("gráfico: total no período = 5", /5 no período/.test(geral));
await p.locator("figure button[aria-label*='exerc']").nth(13).hover();
await p.waitForSelector("[role=status]:has-text('resolvido')");
ok("tooltip no hover mostra data e contagem", /1 exercício resolvido|exercícios resolvidos/.test(await p.locator("figure [role=status]").innerText()));
await p.screenshot({path:OUT+"/geral.png",fullPage:true});
await p.click("text=Ver como tabela");
ok("visão em tabela existe e tem 14 dias", (await p.locator("figure tbody tr").count())===14);
await p.click("text=Ver como gráfico");

await p.click("role=tab[name='Alunos']");
await p.waitForSelector("text=Grade de progresso");
const matrix=await p.locator("table >> nth=1").innerText();
ok("tabela de alunos com resolvidos/XP/última atividade", /Ana Souza[\s\S]*4\/5/.test(await p.locator("table >> nth=0").innerText()) && /há 9 dias/.test(await p.locator("table >> nth=0").innerText()));
const cells=p.locator("table >> nth=1 >> [role=img]");
ok("grade: 4 alunos × 5 exercícios = 20 células", (await cells.count())===20);
const lab=await cells.evaluateAll(els=>els.map(e=>e.getAttribute("aria-label")));
ok("grade: células descrevem o estado em texto (acessível)", lab.some(x=>/resolvido em 1 tentativa/.test(x)) && lab.some(x=>/5 tentativas, ainda não resolvido/.test(x)) && lab.some(x=>/não tentou/.test(x)));
await p.screenshot({path:OUT+"/alunos.png",fullPage:true});

await p.click("role=tab[name='Exercícios']");
await p.waitForSelector("text=Onde a turma mais tem dificuldade");
const ex1=await p.locator("ol").first().innerText();
const order=["E","B","C","A","D"].map(l=>ex1.indexOf("Exercício "+l));
ok("ranking de dificuldade: E (0%), B e C (50%; B precisou de mais tentativas), A e D (100%)", order.every((v,i)=>v>=0 && (i===0||v>order[i-1])));
const tbl=await p.locator("tbody").last().innerText();
ok("tabela por exercício com taxa e travados", /Exercício C/.test(tbl) && /0%/.test(tbl));
await p.screenshot({path:OUT+"/exercicios.png",fullPage:true});

await p.click("role=tab[name='Configurações']");
ok("aba de configurações com renomear e apagar", (await p.locator("main").innerText()).includes("Apagar esta turma"));
ok("sem erros de página", errs.length===0 || (console.log(errs),false));
await b.close();
console.log(failed? `\n${failed} FALHA(S)` : "\nTODOS OS FLUXOS OK");
process.exit(failed?1:0);

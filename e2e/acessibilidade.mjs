import fs from "node:fs";
import { createRequire } from "node:module";
import { BASE, OUT, launch } from "./helpers.mjs";
const b = await launch();
const axeSrc = fs.readFileSync(createRequire(import.meta.url).resolve("axe-core/axe.min.js"),"utf8");
const b64=o=>Buffer.from(JSON.stringify(o)).toString("base64url");
const uid="11111111-1111-1111-1111-111111111111";
const jwt=`${b64({alg:"HS256",typ:"JWT"})}.${b64({sub:uid,role:"authenticated",exp:4102444800})}.sig`;
const session={access_token:jwt,refresh_token:"r",token_type:"bearer",expires_in:3600,expires_at:4102444800,user:{id:uid,aud:"authenticated",role:"authenticated",email:"x@x.com",app_metadata:{},user_metadata:{},created_at:"2026-01-01T00:00:00Z"}};
const TZ="America/Fortaleza";
const dayOffset=n=>new Date(Date.now()+n*864e5).toLocaleDateString("sv-SE",{timeZone:TZ});
const ago=(days)=>new Date(Date.now()-days*864e5-(days?3600e3:0)).toISOString(); // independe do horário do dia
const exs=[
 {id:"ch1",module_id:"m1",kind:"choice",lesson:"Uma variável guarda um valor.",title:"Qual é o valor?",difficulty:"facil",statement:"x = 4; x = x + 3.\nQual o valor final?",function_name:null,starter_code:"",tests:[],config:{options:["4","3","7","43"],correct:2,explanation:"x vale 4 e depois 4 + 3 = 7."},hint:"Execute linha a linha.",position:1,published:true},
 {id:"bl1",module_id:"m1",kind:"blank",lesson:"Uma condicional faz o programa escolher um caminho.",title:"Complete a condicional",difficulty:"facil",statement:"Complete.",function_name:null,starter_code:"",tests:[],config:{template:"{{1}} (x > 0) {\n  return 1;\n} {{2}} {\n  return 0;\n}",blanks:[{answers:["if"]},{answers:["else"]}],explanation:"if e else."},hint:"Em inglês.",position:2,published:true},
 {id:"cd1",module_id:"m2",kind:"code",lesson:null,title:"Dobro de um número",difficulty:"medio",statement:"Escreva dobro(n).",function_name:"dobro",starter_code:"function dobro(n) {\n  // seu código aqui\n}\n",tests:[{args:[2],expected:4}],config:{},hint:"Multiplique por 2.",position:1,published:true},
 {id:"rasc",module_id:"m2",kind:"code",lesson:null,title:"Rascunho de teste",difficulty:"dificil",statement:"r",function_name:"r",starter_code:"function r() {}",tests:[{args:[],expected:1}],config:{},hint:"",position:2,published:false},
];
const members=[{student_id:"s1",joined_at:ago(20)},{student_id:"s2",joined_at:ago(20)},{student_id:"s3",joined_at:ago(1)}];
const names=[{id:"s1",name:"Ana Souza"},{id:"s2",name:"Beto Lima"},{id:"s3",name:"Caio Melo"}];
const pr=(u,e,o)=>({user_id:u,exercise_id:e,attempts:1,solved:false,first_try:false,xp:0,solved_at:null,updated_at:ago(1),...o});
const classProgress=[pr("s1","ch1",{solved:true,first_try:true,xp:15,solved_at:ago(0),updated_at:ago(0)}),pr("s1","bl1",{solved:true,attempts:3,xp:10,solved_at:ago(1),updated_at:ago(1)}),pr("s2","ch1",{attempts:5,updated_at:ago(9)}),pr("s2","cd1",{attempts:4,updated_at:ago(9)})];

async function ctxFor(role,{width,height,dark},loggedOut=false){
  const ctx=await b.newContext({viewport:{width,height},timezoneId:TZ,colorScheme:dark?"dark":"light",hasTouch:width<500,isMobile:width<500,deviceScaleFactor:1});
  if(!loggedOut) await ctx.addInitScript(s=>localStorage.setItem("sb-shmdjhfleduxefoodrfm-auth-token",JSON.stringify(s)),session);
  await ctx.route("**/*.supabase.co/**", async route=>{
    const req=route.request(), u=req.url(), m=req.method(), acc=req.headers()["accept"]||"";
    const json=(body,code=200)=>route.fulfill({status:code,contentType:"application/json",headers:{"access-control-allow-origin":"*"},body:JSON.stringify(body)});
    if(m==="OPTIONS") return route.fulfill({status:204,headers:{"access-control-allow-origin":"*","access-control-allow-headers":"*","access-control-allow-methods":"*"}});
    if(u.includes("/rest/v1/modules")) return json([{id:"m1",title:"Primeiros passos",focus:"Entender algoritmos",position:1},{id:"m2",title:"Fundamentos",focus:"Operações",position:2}]);
    if(u.includes("/rest/v1/exercises")) return json(role==="professor"?exs:exs.filter(e=>e.published));
    if(u.includes("/rest/v1/profiles")) return u.includes("id=in.")?json(names):json({id:uid,name:role==="professor"?"Prof Lima":"Luis Antônio Santos Moura",role});
    if(u.includes("/rest/v1/exercise_progress")) return u.includes("user_id=in.")?json(classProgress):json([{exercise_id:"ch1",attempts:2,solved:true,first_try:false,xp:10},{exercise_id:"cd1",attempts:2,solved:false,first_try:false,xp:0}]);
    if(u.includes("/rest/v1/daily_activity")) return json([dayOffset(0),dayOffset(-1),dayOffset(-2)].map(day=>({day})));
    if(u.includes("/rpc/leaderboard")) return json([{pos:1,display_name:"Caio M.",total_xp:120,solved:6,is_me:false},{pos:2,display_name:"Bia R.",total_xp:60,solved:4,is_me:false},{pos:3,display_name:"Luis A.",total_xp:25,solved:2,is_me:true}]);
    if(u.includes("/rest/v1/classes")){ const c={id:"c1",name:"Lógica de Programação — ADS 2026.2",code:"ABC234",created_at:ago(5)}; return u.includes("teacher_id=eq.")?json([c]):(acc.includes("vnd.pgrst.object")?json(c):json([c])); }
    if(u.includes("/rest/v1/class_members")) return u.includes("class_id=eq.")?json(members):json(members.map(()=>({class_id:"c1"})));
    return json([]);
  });
  return ctx;
}

const pages=[
  {name:"entrar",role:"aluno",path:"/entrar",out:true},
  {name:"trilha",role:"aluno",path:"/",wait:"text=Primeiros passos"},
  {name:"ex-escolha",role:"aluno",path:"/exercicio/ch1",wait:"text=Antes de começar"},
  {name:"ex-lacuna",role:"aluno",path:"/exercicio/bl1",wait:"input[aria-label='Lacuna 1']"},
  {name:"ex-codigo",role:"aluno",path:"/exercicio/cd1",wait:".cm-content"},
  {name:"ranking",role:"aluno",path:"/ranking",wait:"table"},
  {name:"perfil",role:"aluno",path:"/perfil",wait:"text=Sequência diária"},
  {name:"prof-turmas",role:"professor",path:"/professor",wait:"text=ABC234"},
  {name:"prof-turma-geral",role:"professor",path:"/professor/turmas/c1",wait:"text=Precisam de atenção"},
  {name:"prof-turma-alunos",role:"professor",path:"/professor/turmas/c1",tab:"Alunos",wait:"text=Grade de progresso"},
  {name:"prof-turma-exerc",role:"professor",path:"/professor/turmas/c1",tab:"Exercícios",wait:"text=Todos os exercícios"},
  {name:"prof-exercicios",role:"professor",path:"/professor/exercicios",wait:"text=Rascunho"},
  {name:"prof-editor-codigo",role:"professor",path:"/professor/exercicios/novo",wait:"text=Casos de teste"},
  {name:"prof-editor-escolha",role:"professor",path:"/professor/exercicios/novo",kind:"Múltipla escolha",wait:"text=Alternativas"},
  {name:"prof-editor-lacuna",role:"professor",path:"/professor/exercicios/novo",kind:"Completar a lacuna",wait:"text=Modelo com lacunas"},
];
const combos=[{label:"cel-claro",width:390,height:844,dark:false},{label:"cel-escuro",width:390,height:844,dark:true},{label:"pc-claro",width:1100,height:900,dark:false},{label:"pc-escuro",width:1100,height:900,dark:true}];
const only=process.argv[2]; // filtrar por nome
const results=[]; 
for(const combo of combos){
  for(const pg of pages){
    if(only && !pg.name.includes(only)) continue;
    const ctx=await ctxFor(pg.role,combo,pg.out);
    const p=await ctx.newPage(); const errs=[]; p.on("pageerror",e=>errs.push(e.message));
    try{
      await p.goto(BASE+pg.path);
      if(pg.out) await p.waitForSelector("form");
      else await p.waitForSelector(pg.wait ? "main >> "+pg.wait.replace(/^/,"") : "main",{timeout:15000}).catch(async()=>{ await p.waitForTimeout(3000); });
      if(pg.tab) await p.click(`role=tab[name='${pg.tab}']`);
      if(pg.kind) await p.getByRole("radio",{name:new RegExp("^"+pg.kind)}).check();
      if(pg.wait && !pg.out) await p.waitForSelector(pg.wait,{timeout:8000}).catch(()=>{});
      await p.waitForTimeout(400);
      await p.addScriptTag({content:axeSrc});
      const r=await p.evaluate(async()=>{ const x=await axe.run(document,{runOnly:{type:"tag",values:["wcag2a","wcag2aa","wcag21a","wcag21aa","wcag22aa","best-practice"]}}); return x.violations.map(v=>({id:v.id,impact:v.impact,help:v.help,n:v.nodes.length,nodes:v.nodes.slice(0,3).map(n=>({t:n.target.join(" "),s:(n.failureSummary||"").split("\n").slice(1,3).join(" | ").slice(0,200)}))})); });
      const overflow=await p.evaluate(()=>document.documentElement.scrollWidth>document.documentElement.clientWidth+1);
      await p.screenshot({path:`${OUT}/shots/${combo.label}-${pg.name}.png`,fullPage:true});
      results.push({combo:combo.label,page:pg.name,violations:r,overflow,errs});
    }catch(e){ results.push({combo:combo.label,page:pg.name,fatal:String(e).slice(0,200)}); }
    await ctx.close();
  }
}
fs.writeFileSync(OUT+"/audit.json",JSON.stringify(results,null,1));
// resumo agrupado por regra
const byRule={};
for(const r of results){ if(r.fatal){ console.log("FATAL",r.combo,r.page,r.fatal); continue;}
  if(r.overflow) console.log("ROLAGEM HORIZONTAL:",r.combo,r.page);
  if(r.errs?.length) console.log("ERRO DE PÁGINA:",r.combo,r.page,r.errs[0]);
  for(const v of r.violations){ const k=v.id; (byRule[k] ??= {impact:v.impact,help:v.help,where:new Set(),ex:null}).where.add(r.page+"@"+r.combo); byRule[k].ex ??= v.nodes[0]; } }
for(const [k,v] of Object.entries(byRule)) console.log(`\n[${v.impact}] ${k}: ${v.help}\n  em ${[...v.where].slice(0,6).join(", ")}${v.where.size>6?` (+${v.where.size-6})`:""}\n  ex: ${v.ex?.t} :: ${v.ex?.s}`);
if(!Object.keys(byRule).length) console.log("\nNenhuma violação do axe.");
await b.close();
// Falha (código 1) se houver violação, rolagem horizontal ou tela que não abriu.
process.exit(results.some((r) => r.fatal || r.overflow || r.violations?.length) ? 1 : 0);

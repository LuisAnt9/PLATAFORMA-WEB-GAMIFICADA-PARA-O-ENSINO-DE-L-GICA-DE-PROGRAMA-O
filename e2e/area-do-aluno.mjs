// Área do aluno (E8): início, mundos, lição em passos, progresso por conceito, conquistas e tema.
import { BASE, launch } from "./helpers.mjs";
const b = await launch();
const b64=o=>Buffer.from(JSON.stringify(o)).toString("base64url");
const uid="11111111-1111-1111-1111-111111111111";
const jwt=`${b64({alg:"HS256",typ:"JWT"})}.${b64({sub:uid,role:"authenticated",exp:4102444800})}.sig`;
const session={access_token:jwt,refresh_token:"r",token_type:"bearer",expires_in:3600,expires_at:4102444800,user:{id:uid,aud:"authenticated",role:"authenticated",email:"x@x.com",app_metadata:{},user_metadata:{},created_at:"2026-01-01T00:00:00Z"}};
let failed=0; const ok=(n,c)=>{console.log((c?"✓ ":"✗ FALHOU: ")+n); if(!c) failed++;};

const ex=(id,module_id,kind,title,position,extra={})=>({id,module_id,kind,lesson:null,title,difficulty:"facil",statement:"Enunciado "+title,function_name:kind==="code"?"f":null,starter_code:kind==="code"?"function f(){}":"",tests:kind==="code"?[{args:[],expected:1}]:[],config:kind==="choice"?{options:["a","b"],correct:0}:{},hint:"",position,published:true,...extra});
const worlds=[
  {id:"w1",title:"Mundo Um",objective:"Objetivo do mundo um.",position:1},
  {id:"w2",title:"Mundo Dois",objective:"Objetivo do mundo dois.",position:2},
  {id:"w3",title:"Mundo Três",objective:"Ainda sem conteúdo.",position:3},
];
const mods=[
  {id:"m1",title:"Lição Alfa",focus:"Entender o alfa",intro:"Explicação do alfa.",example:"const x = 1;\nconsole.log(x);\n\nPasso a passo: mostra 1.",review:"Resumo do alfa.",world_id:"w1",position:101},
  {id:"m2",title:"Lição Beta",focus:"Entender o beta",intro:"Explicação do beta.",example:"",review:"",world_id:"w1",position:102},
  {id:"m3",title:"Lição Gama",focus:"Entender o gama",intro:"Explicação do gama.",example:"",review:"",world_id:"w2",position:201},
];
const exs=[
  ex("a1","m1","choice","Alfa escolha",1), ex("a2","m1","interpretation","Alfa leitura",2),
  ex("a3","m1","code","Alfa código",3), ex("a4","m1","challenge","Alfa desafio",4),
  ex("b1","m2","choice","Beta escolha",1),
  ex("g1","m3","choice","Gama escolha",1),
];
const concepts=[{id:"k1",title:"Conceito Um",description:"",world_id:"w1"},{id:"k2",title:"Conceito Dois",description:"",world_id:"w1"}];
const links=[["a1","k1"],["a2","k1"],["a3","k2"]].map(([e,c])=>({exercise_id:e,concept_id:c,weight:1}));

const patches=[]; let rankingRows=[];
async function newCtx({solved=[],extra=[],colorScheme="light",days=[]}={}){
  const ctx=await b.newContext({viewport:{width:Number(process.env.E2E_W||1000),height:Number(process.env.E2E_H||1000)},colorScheme});
  await ctx.addInitScript(s=>localStorage.setItem("sb-shmdjhfleduxefoodrfm-auth-token",JSON.stringify(s)),session);
  await ctx.route("**/*.supabase.co/**", async route=>{
    const req=route.request(), u=req.url(), m=req.method();
    const json=(body,code=200)=>route.fulfill({status:code,contentType:"application/json",headers:{"access-control-allow-origin":"*"},body:JSON.stringify(body)});
    if(m==="OPTIONS") return route.fulfill({status:204,headers:{"access-control-allow-origin":"*","access-control-allow-headers":"*","access-control-allow-methods":"*"}});
    if(u.includes("/rpc/sync_gamification")) return json({bonus_xp:30,missions:[{id:"resolver-2",title:"Resolva 2 exercícios",description:"Resolva 2 exercícios hoje.",target:2,xp:30,progress:1,claimed:false},{id:"conceito",title:"Volte a um conceito difícil",description:"Resolva hoje um exercício de um conceito em que você já errou antes.",target:1,xp:30,progress:1,claimed:true}],new_worlds:[],worlds_done:[]});
    if(u.includes("/rpc/leaderboard")) return json(rankingRows);
    if(u.includes("/rest/v1/profiles") && m==="PATCH"){ patches.push(req.postData()); return route.fulfill({status:204,headers:{"access-control-allow-origin":"*"},body:""}); }
    if(u.includes("/rest/v1/worlds")) return json(worlds);
    if(u.includes("/rest/v1/exercise_concepts")) return json(links);
    if(u.includes("/rest/v1/concepts")) return json(concepts);
    if(u.includes("/rest/v1/modules")) return json(mods);
    if(u.includes("/rest/v1/exercises")) return json(exs);
    if(u.includes("/rest/v1/profiles")) return json({id:uid,name:"Luis Antônio",role:"aluno"});
    if(u.includes("/rest/v1/exercise_progress")){ if(m!=="GET") return route.fulfill({status:201,headers:{"access-control-allow-origin":"*"},body:""}); return json([...solved.map(id=>({exercise_id:id,attempts:1,solved:true,first_try:true,xp:10})),...extra]); }
    if(u.includes("/rest/v1/daily_activity")) return json(days.map(day=>({day})));
    return json([]);
  });
  const p=await ctx.newPage(); const errs=[]; p.on("pageerror",e=>errs.push(e.message));
  return {p,errs,ctx};
}
const main=p=>p.locator("main").innerText();

// ---- primeira vez do aluno
{
  const {p,errs}=await newCtx();
  await p.goto(BASE+"/"); await p.waitForSelector("text=Bem-vindo, Luis!",{timeout:12000});
  const nav=await p.locator("nav[aria-label=Principal]").innerText();
  ok("menu tem Início, Mundos, Conquistas e Meu progresso", ["Início","Mundos","Conquistas","Meu progresso","Perfil"].every(x=>nav.includes(x)));
  ok("início sugere Começar com a primeira atividade", (await p.locator("a:has-text('Começar')").getAttribute("href"))==="/exercicio/a1");
  ok("início mostra o nível e os mundos com conteúdo", (await main(p)).includes("Nível 2") && (await main(p)).includes("Mundo Um") && !(await main(p)).includes("Mundo Três"));
  await p.click("nav >> text=Mundos"); await p.waitForSelector("h1:has-text('Mundos')"); await p.waitForSelector("text=Mundo Três");
  const t=await main(p);
  ok("mundos: primeiro não iniciado, segundo bloqueado, terceiro em breve", t.includes("Não iniciado") && t.includes("Bloqueado") && t.includes("Em breve"));
  ok("mundo em breve não é link", await p.locator("a:has-text('Mundo Três')").count()===0);
  await p.click("a:has-text('Mundo Um')"); await p.waitForSelector("h1:has-text('Mundo Um')");
  ok("mundo lista as lições com progresso", (await main(p)).includes("Lição Alfa") && (await main(p)).includes("0/4 concluídos"));
  await p.click("a:has-text('Lição Alfa')"); await p.waitForSelector("h1:has-text('Lição Alfa')");
  const steps=await p.locator("nav[aria-label='Passos da lição'] button").allInnerTexts();
  ok("lição tem os 7 passos", steps.length===7 && steps[0].includes("Introdução") && steps[6].includes("Revisão"));
  ok("o primeiro passo está marcado como atual", (await p.locator("[aria-current=step]").innerText()).includes("Introdução"));
  ok("introdução mostra o que vai aprender", (await main(p)).includes("Entender o alfa"));
  ok("sem erros de página (primeira vez)", errs.length===0);
}

// ---- lição em passos: avançar, voltar, ir direto, voltar do exercício
{
  const {p,errs}=await newCtx();
  await p.goto(BASE+"/licao/m1"); await p.waitForSelector("h1:has-text('Lição Alfa')");
  await p.click("button:has-text('Próximo passo')");
  await p.waitForSelector("h2:has-text('Explicação')");
  ok("próximo passo mostra a explicação", (await main(p)).includes("Explicação do alfa."));
  await p.click("button:has-text('Próximo passo')");
  await p.waitForSelector("h2:has-text('Exemplo')");
  ok("exemplo mostra o código em bloco", (await p.locator("pre code").first().innerText()).includes("console.log(x)") && (await main(p)).includes("Passo a passo"));
  await p.click("button:has-text('Passo anterior')");
  await p.waitForSelector("h2:has-text('Explicação')");
  ok("passo anterior volta", true);
  await p.click("nav[aria-label='Passos da lição'] >> text=Prática");
  await p.waitForSelector("a:has-text('Alfa código')");
  ok("a prática lista só os exercícios de código", !(await main(p)).includes("Alfa escolha"));
  ok("a URL guarda o passo", p.url().includes("passo=pratica"));
  await p.click("a:has-text('Alfa código')"); await p.waitForSelector("text=Enunciado Alfa código");
  await p.click("a:has-text('Voltar à lição')"); await p.waitForSelector("h2:has-text('Prática')");
  ok("voltar à lição retorna ao mesmo passo", true);
  await p.goto(BASE+"/licao/m1?passo=desafio"); await p.waitForSelector("a:has-text('Alfa desafio')");
  ok("endereço direto abre o passo pedido", true);
  await p.goto(BASE+"/licao/m1?passo=invalido"); await p.waitForSelector("h2:has-text('Introdução')");
  ok("passo inválido volta para a introdução", true);
  await p.goto(BASE+"/exercicio/a1"); await p.waitForSelector("text=Enunciado Alfa escolha");
  ok("rota antiga /exercicio/[id] continua funcionando", true);
  ok("sem erros de página (lição)", errs.length===0);
}

// ---- continuar de onde parou + lição bloqueada
{
  const {p,errs}=await newCtx({solved:["a1"]});
  await p.goto(BASE+"/"); await p.waitForSelector("text=Olá, Luis!");
  ok("início oferece Continuar com a próxima atividade", (await p.locator("a:has-text('Continuar')").getAttribute("href"))==="/exercicio/a2");
  await p.goto(BASE+"/licao/m3"); await p.waitForSelector("text=ainda está bloqueada");
  ok("lição bloqueada explica e oferece caminho", (await main(p)).includes("70% de \"Lição Beta\"") || (await main(p)).includes("70%"));
  ok("lição bloqueada oferece modo prática", await p.locator("button:has-text('Ir para o modo prática')").count()===1);
  await p.click("button:has-text('Ir para o modo prática')"); await p.waitForSelector("h1:has-text('Lição Gama')");
  ok("modo prática abre a lição", true);
  await p.goto(BASE+"/licao/nao-existe"); await p.waitForSelector("text=Lição não encontrada");
  ok("lição inexistente mostra aviso", true);
  ok("sem erros de página (continuar)", errs.length===0);
}

// ---- meu progresso e conquistas
{
  const today=new Date(); const d=n=>{const x=new Date(today); x.setDate(x.getDate()-n); return x.toLocaleDateString("sv-SE");};
  const {p,errs}=await newCtx({solved:["a1"],extra:[{exercise_id:"a2",attempts:2,solved:true,first_try:false,xp:10},{exercise_id:"a3",attempts:5,solved:false,first_try:false,xp:0}],days:[d(0),d(1),d(9)]});
  await p.goto(BASE+"/progresso"); await p.waitForSelector("h1:has-text('Meu progresso')"); await p.waitForSelector("text=Conceito Um");
  const t=await main(p);
  ok("progresso por mundo", t.includes("Mundo Um") && t.includes("2/5"));
  ok("conceito com dados suficientes e bom desempenho", /Conceito Um[\s\S]*Em bom caminho/.test(t));
  ok("conceito com 1 exercício só: dados insuficientes", /Conceito Dois[\s\S]*Dados insuficientes/.test(t));
  ok("explica que não classifica o aluno", t.includes("não para te classificar"));
  ok("mostra dias de prática por semana", t.includes("Dias de prática por semana") && await p.locator("ul[class*='items-end'] li").count()===8);
  ok("histórico lista as atividades tentadas", t.includes("Alfa código") && t.includes("em andamento"));
  await p.goto(BASE+"/conquistas"); await p.waitForSelector("h1:has-text('Conquistas')");
  ok("conquistas mostra nível e medalhas", (await main(p)).includes("Nível") && (await main(p)).includes("Primeiro passo"));
  await p.goto(BASE+"/perfil"); await p.waitForSelector("text=Conta");
  ok("perfil aponta para conquistas e progresso", await p.locator("main a:has-text('Meu progresso')").count()===1);
  ok("sem erros de página (progresso)", errs.length===0);
}

// ---- gamificação: missões, XP com bônus, ranking opcional
{
  const {p,errs}=await newCtx({solved:["a1"]});
  await p.goto(BASE+"/"); await p.waitForSelector("text=Missões de hoje");
  const t=await main(p);
  ok("início mostra as missões do dia com progresso", t.includes("Resolva 2 exercícios") && t.includes("1/2") && t.includes("Cumprida"));
  ok("missão cumprida mostra o XP recebido", t.includes("+30 XP recebidos"));
  const header=await p.locator("header").innerText();
  ok("o XP do cabeçalho inclui o bônus (10 do exercício + 30 da missão = nível 2)", header.includes("Nível 2") && header.includes("40/"));
  await p.goto(BASE+"/conquistas"); await p.waitForSelector("text=Missões de hoje");
  ok("conquistas também lista as missões", (await main(p)).includes("Volte a um conceito difícil"));
  rankingRows=[{pos:1,display_name:"Caio M.",total_xp:120,solved:6,is_me:false}];
  await p.goto(BASE+"/ranking"); await p.waitForSelector("text=Caio M.");
  const box=p.getByRole("checkbox",{name:/Aparecer no ranking/});
  ok("ranking começa sem participar (opt-in) e explica a privacidade", !(await box.isChecked()) && (await main(p)).includes("Só aparecem colegas da sua turma"));
  patches.length=0;
  await box.click(); await p.waitForTimeout(800);
  ok("marcar a opção grava a escolha no perfil", patches.some(b=>b&&b.includes("show_in_ranking")&&b.includes("true")) && await box.isChecked());
  ok("sem erros de página (gamificação)", errs.length===0);
  rankingRows=[];
}

// ---- tema
{
  const {p,ctx}=await newCtx({colorScheme:"light"});
  await p.goto(BASE+"/"); await p.waitForSelector("text=Bem-vindo");
  ok("sistema claro: segue o sistema", !(await p.evaluate(()=>document.documentElement.classList.contains("dark"))));
  const btn=p.locator("button[aria-label='Tema escuro']");
  ok("alternância visível e desligada no tema claro", (await btn.getAttribute("aria-pressed"))==="false");
  await btn.click();
  ok("alternar muda para escuro", (await p.evaluate(()=>document.documentElement.classList.contains("dark"))) && (await btn.getAttribute("aria-pressed"))==="true");
  await p.reload(); await p.waitForSelector("text=Bem-vindo");
  ok("a escolha é lembrada ao recarregar", await p.evaluate(()=>document.documentElement.classList.contains("dark")));
  await p.locator("button[aria-label='Tema escuro']").click();
  ok("alternar de novo volta ao claro", !(await p.evaluate(()=>document.documentElement.classList.contains("dark"))));
  await ctx.close();
  const c3=await newCtx({colorScheme:"dark"});
  await c3.p.goto(BASE+"/"); await c3.p.waitForSelector("text=Bem-vindo");
  ok("sistema escuro: escuro", await c3.p.evaluate(()=>document.documentElement.classList.contains("dark")));
}

await b.close();
console.log(failed?`${failed} FALHA(S)`:"TODOS OS FLUXOS OK");
process.exit(failed?1:0);

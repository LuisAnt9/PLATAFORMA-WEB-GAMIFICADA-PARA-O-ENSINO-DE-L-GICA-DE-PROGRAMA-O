import { BASE, launch } from "./helpers.mjs";
const b = await launch();
const b64=o=>Buffer.from(JSON.stringify(o)).toString("base64url");
const uid="11111111-1111-1111-1111-111111111111";
const jwt=`${b64({alg:"HS256",typ:"JWT"})}.${b64({sub:uid,role:"authenticated",exp:4102444800})}.sig`;
const session={access_token:jwt,refresh_token:"r",token_type:"bearer",expires_in:3600,expires_at:4102444800,user:{id:uid,aud:"authenticated",role:"authenticated",email:"x@x.com",app_metadata:{},user_metadata:{},created_at:"2026-01-01T00:00:00Z"}};
let failed=0; const ok=(n,c)=>{console.log((c?"✓ ":"✗ FALHOU: ")+n); if(!c) failed++;};

const choice=(id,module_id,title,position)=>({id,module_id,kind:"choice",lesson:null,title,difficulty:"facil",statement:"Enunciado "+title,function_name:null,starter_code:"",tests:[],config:{options:["a","b"],correct:0},hint:"",position,published:true});
const exs=[choice("a1","m1","Alfa um",1),choice("a2","m1","Alfa dois",2),choice("a3","m1","Alfa três",3),choice("b1","m2","Beta um",1)];
const mods=[
  {id:"m1",title:"Módulo Alfa",focus:"F1",intro:"Conceito do módulo Alfa: leia antes.",position:1},
  {id:"m2",title:"Módulo Beta",focus:"F2",intro:"Conceito do Beta.",position:2},
];

async function newCtx(role,solvedIds=[]){
  const ctx=await b.newContext({viewport:{width:Number(process.env.E2E_W||1000),height:Number(process.env.E2E_H||1000)}});
  await ctx.addInitScript(s=>localStorage.setItem("sb-shmdjhfleduxefoodrfm-auth-token",JSON.stringify(s)),session);
  await ctx.route("**/*.supabase.co/**", async route=>{
    const req=route.request(), u=req.url(), m=req.method();
    const json=(body,code=200)=>route.fulfill({status:code,contentType:"application/json",headers:{"access-control-allow-origin":"*"},body:JSON.stringify(body)});
    if(m==="OPTIONS") return route.fulfill({status:204,headers:{"access-control-allow-origin":"*","access-control-allow-headers":"*","access-control-allow-methods":"*"}});
    if(u.includes("/rest/v1/modules")) return json(mods);
    if(u.includes("/rest/v1/exercises")) return json(exs);
    if(u.includes("/rest/v1/profiles")) return json({id:uid,name:role==="professor"?"Prof Lima":"Luis A",role});
    if(u.includes("/rest/v1/exercise_progress")){ if(m!=="GET") return route.fulfill({status:201,headers:{"access-control-allow-origin":"*"},body:""}); return json(solvedIds.map(id=>({exercise_id:id,attempts:1,solved:true,first_try:true,xp:15}))); }
    if(u.includes("/rest/v1/daily_activity")) return json([]);
    return json([]);
  });
  const p=await ctx.newPage(); const errs=[]; p.on("pageerror",e=>errs.push(e.message));
  return {p,errs};
}
const main=p=>p.locator("main").innerText();

// ---- aluno novo: lição 2 bloqueada
{
  const {p,errs}=await newCtx("aluno");
  await p.goto(BASE+"/mundos/outras-licoes"); await p.waitForSelector("text=Módulo Alfa",{timeout:12000});
  ok("modo aprendizado é o padrão", (await p.locator("[role=radio][aria-checked=true]").innerText())==="Modo aprendizado");
  ok("lição 2 aparece como bloqueada na lista", await p.locator("[role=img][aria-label='Bloqueada']").count()===1);
  await p.goto(BASE+"/licao/m2"); await p.waitForSelector("text=ainda está bloqueada");
  ok("lição bloqueada explica o que falta", (await main(p)).includes('Resolva pelo menos 70% de "Módulo Alfa"') && !(await main(p)).includes("Beta um"));
  await p.goto(BASE+"/licao/m1?passo=explicacao"); await p.waitForSelector("text=Conceito do módulo Alfa");
  ok("lição 1 mostra o conceito para ler", (await main(p)).includes("Conceito do módulo Alfa: leia antes."));
  await p.goto(BASE+"/"); await p.waitForSelector("a:has-text('Começar')",{timeout:12000});
  ok("botão Começar leva ao primeiro exercício liberado", (await p.locator("a:has-text('Começar')").getAttribute("href"))==="/exercicio/a1");

  await p.goto(BASE+"/exercicio/b1"); await p.waitForSelector("text=ainda está bloqueada");
  ok("endereço direto de exercício bloqueado mostra aviso", (await main(p)).includes('Resolva pelo menos 70% de "Módulo Alfa"'));
  await p.click("button:has-text('Ir para o modo prática')");
  await p.waitForSelector("text=Enunciado Beta um");
  ok("modo prática libera o exercício", true);
  await p.goto(BASE+"/mundos/outras-licoes"); await p.waitForSelector("text=Módulo Beta");
  ok("modo prática lembrado: tudo liberado", (await p.locator("[role=radio][aria-checked=true]").innerText())==="Modo prática" && await p.locator("[role=img][aria-label='Bloqueada']").count()===0);
  await p.click("[role=radio]:has-text('Modo aprendizado')");
  await p.waitForSelector("[role=img][aria-label='Bloqueada']");
  ok("voltar ao modo aprendizado trava de novo", true);
  ok("sem erros de página (aluno novo)", errs.length===0);
}
// ---- aluno que concluiu a lição 1: lição 2 abre
{
  const {p,errs}=await newCtx("aluno",["a1","a2","a3"]);
  await p.goto(BASE+"/licao/m2?passo=interpretacao"); await p.waitForSelector("text=Beta um",{timeout:12000});
  ok("lição 1 concluída libera a lição 2", !(await main(p)).includes("Resolva pelo menos 70%"));
  await p.click("a:has-text('Beta um')"); await p.waitForSelector("text=Enunciado Beta um");
  ok("exercício da lição liberada abre", true);
  ok("sem erros de página (aluno que concluiu)", errs.length===0);
}
// ---- professor: nada bloqueado, sem seletor de modo
{
  const {p,errs}=await newCtx("professor");
  await p.goto(BASE+"/licao/m2?passo=interpretacao"); await p.waitForSelector("text=Beta um",{timeout:12000});
  ok("professor vê tudo liberado e sem seletor de modo", (await p.locator("[role=radiogroup]").count())===0 && !(await main(p)).includes("Resolva pelo menos 70%"));
  ok("sem erros de página (professor)", errs.length===0);
}
// ---- lição complementar não trava a seguinte
{
  const mods2=[
    {id:"m1",title:"Módulo Alfa",focus:"F1",intro:"",position:1},
    {id:"m2",title:"Módulo Extra",focus:"F2",intro:"",position:2,optional:true},
    {id:"m3",title:"Módulo Gama",focus:"F3",intro:"",position:3},
  ];
  const exs2=[choice("a1","m1","Alfa um",1),choice("b1","m2","Extra um",1),choice("g1","m3","Gama um",1)];
  const ctx=await b.newContext({viewport:{width:Number(process.env.E2E_W||1000),height:Number(process.env.E2E_H||1000)}});
  await ctx.addInitScript(s=>localStorage.setItem("sb-shmdjhfleduxefoodrfm-auth-token",JSON.stringify(s)),session);
  await ctx.route("**/*.supabase.co/**", async route=>{
    const req=route.request(), u=req.url(), m=req.method();
    const json=(body,code=200)=>route.fulfill({status:code,contentType:"application/json",headers:{"access-control-allow-origin":"*"},body:JSON.stringify(body)});
    if(m==="OPTIONS") return route.fulfill({status:204,headers:{"access-control-allow-origin":"*","access-control-allow-headers":"*","access-control-allow-methods":"*"}});
    if(u.includes("/rest/v1/modules")) return json(mods2);
    if(u.includes("/rest/v1/exercises")) return json(exs2);
    if(u.includes("/rest/v1/profiles")) return json({id:uid,name:"Luis A",role:"aluno"});
    if(u.includes("/rest/v1/exercise_progress")) return json([{exercise_id:"a1",attempts:1,solved:true,first_try:true,xp:15}]);
    return json([]);
  });
  const p=await ctx.newPage();
  await p.goto(BASE+"/mundos/outras-licoes"); await p.waitForSelector("text=Módulo Gama",{timeout:12000});
  ok("lição marcada como complementar mostra o selo", (await main(p)).includes("Complementar"));
  ok("a lição seguinte à complementar libera sem concluí-la", await p.locator("[role=img][aria-label='Bloqueada']").count()===0);
  await p.goto(BASE+"/licao/m3"); await p.waitForSelector("text=O que você vai aprender");
  ok("lição depois da complementar abre", !(await main(p)).includes("ainda está bloqueada"));
}

await b.close();
console.log(failed?`${failed} FALHA(S)`:"TODOS OS FLUXOS OK");
process.exit(failed?1:0);

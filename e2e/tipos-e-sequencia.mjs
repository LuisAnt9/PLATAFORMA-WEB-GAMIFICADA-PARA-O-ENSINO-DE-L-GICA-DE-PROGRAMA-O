import fs from "node:fs";
import { BASE, OUT, launch } from "./helpers.mjs";
const b = await launch();
const b64=o=>Buffer.from(JSON.stringify(o)).toString("base64url");
const uid="11111111-1111-1111-1111-111111111111";
const jwt=`${b64({alg:"HS256",typ:"JWT"})}.${b64({sub:uid,role:"authenticated",exp:4102444800})}.sig`;
const session={access_token:jwt,refresh_token:"r",token_type:"bearer",expires_in:3600,expires_at:4102444800,user:{id:uid,aud:"authenticated",role:"authenticated",email:"x@x.com",app_metadata:{},user_metadata:{},created_at:"2026-01-01T00:00:00Z"}};
let failed=0; const ok=(n,c)=>{console.log((c?"✓ ":"✗ FALHOU: ")+n); if(!c) failed++;};
const TZ="America/Fortaleza";
const dayOffset=n=>new Date(Date.now()+n*864e5).toLocaleDateString("sv-SE",{timeZone:TZ});

const exs=[
 {id:"ch1",module_id:"m1",kind:"choice",lesson:"Uma variável guarda um valor.",title:"Qual é o valor?",difficulty:"facil",statement:"x = 4; x = x + 3.\nQual o valor final?",function_name:null,starter_code:"",tests:[],config:{options:["4","3","7","43"],correct:2,explanation:"x vale 4 e depois 4 + 3 = 7."},hint:"Execute linha a linha.",position:1,published:true},
 {id:"bl1",module_id:"m1",kind:"blank",lesson:null,title:"Complete a condicional",difficulty:"facil",statement:"Complete.",function_name:null,starter_code:"",tests:[],config:{template:"{{1}} (x > 0) {\n  return 1;\n} {{2}} {\n  return 0;\n}",blanks:[{answers:["if"]},{answers:["else"]}],explanation:"if e else."},hint:"Em inglês.",position:2,published:true},
 {id:"cd1",module_id:"m1",kind:"code",lesson:null,title:"Dobro",difficulty:"facil",statement:"d",function_name:"dobro",starter_code:"function dobro(n) {}",tests:[{args:[2],expected:4}],config:{},hint:"",position:3,published:true},
];

async function newCtx(role){
  const ctx = await b.newContext({viewport:{width:1000,height:1000},timezoneId:TZ});
  await ctx.addInitScript(s=>localStorage.setItem("sb-shmdjhfleduxefoodrfm-auth-token",JSON.stringify(s)),session);
  const st={upserts:[],activity:[],posts:[],patches:[],days:[dayOffset(-1),dayOffset(-2)]};
  await ctx.route("**/*.supabase.co/**", async route=>{
    const req=route.request(), u=req.url(), m=req.method();
    const json=(body,code=200)=>route.fulfill({status:code,contentType:"application/json",headers:{"access-control-allow-origin":"*"},body:JSON.stringify(body)});
    const empty=(code=201)=>route.fulfill({status:code,headers:{"access-control-allow-origin":"*"},body:""});
    if(m==="OPTIONS") return route.fulfill({status:204,headers:{"access-control-allow-origin":"*","access-control-allow-headers":"*","access-control-allow-methods":"*"}});
    if(u.includes("/rest/v1/modules")) return json([{id:"m1",title:"Primeiros passos",focus:"F",position:1}]);
    if(u.includes("/rest/v1/exercises")){ if(m==="POST"){ const row=JSON.parse(req.postData()); st.posts.push(row); exs.push({...row}); return empty(); } return json(exs); }
    if(u.includes("/rest/v1/profiles")) return json({id:uid,name:role==="professor"?"Prof Lima":"Luis A",role});
    if(u.includes("/rest/v1/exercise_progress")){ if(m==="POST"||m==="PATCH"){ st.upserts.push(JSON.parse(req.postData())); return empty(); } return json([]); }
    if(u.includes("/rest/v1/daily_activity")) return json(st.days.map(day=>({day})));
    if(u.includes("/rpc/log_activity")){ st.activity.push(JSON.parse(req.postData())); return json(null); }
    return json([]);
  });
  const p=await ctx.newPage(); const errs=[]; p.on("pageerror",e=>errs.push(e.message));
  return {p,st,errs};
}
const headerStreak=async p=>(await p.locator("header [aria-label^='Sequência']").first().getAttribute("aria-label"));

// ===================== ALUNO =====================
{
  const {p,st,errs}=await newCtx("aluno");
  await p.goto(BASE+"/");
  await p.waitForSelector("text=Qual é o valor?",{timeout:12000});
  ok("cabeçalho mostra a sequência atual de 2 dias", (await headerStreak(p))==="Sequência: 2 dias");
  const trail=await p.locator("main").innerText();
  ok("trilha mostra o tipo de cada exercício", trail.includes("Múltipla escolha") && trail.includes("Completar a lacuna") && trail.includes("Código"));

  await p.click("text=Qual é o valor?");
  await p.waitForSelector("text=Antes de começar");
  ok("mostra a mini-explicação antes do enunciado", (await p.locator("aside").innerText()).includes("Uma variável guarda um valor."));
  ok("enunciado preserva quebras de linha", await p.locator("p.whitespace-pre-line:has-text('x = 4; x = x + 3.')").count()===1);
  ok("verificar fica desabilitado sem escolher", await p.locator("button:has-text('Verificar resposta')").isDisabled());
  await p.locator("label:has-text('43')").click();
  await p.click("button:has-text('Verificar resposta')");
  await p.waitForSelector("text=Ainda não");
  ok("alternativa errada: mensagem de incentivo e sem revelar o gabarito", !(await p.locator("main").innerText()).includes("x vale 4"));
  ok("tentativa errada gravada (1 tentativa, não resolvido)", st.upserts.length===1 && st.upserts[0].attempts===1 && st.upserts[0].solved===false && st.upserts[0].xp===0);
  ok("registra a atividade do dia (sem resolver)", st.activity.length===1 && st.activity[0].p_solved===false && st.activity[0].p_day===dayOffset(0));
  ok("sequência sobe para 3 na hora", (await headerStreak(p))==="Sequência: 3 dias");
  ok("medalha de constância avisada mesmo sem acertar", (await p.locator("main").innerText()).includes("Nova medalha: Constância"));

  await p.locator("label:has-text('7')").first().click();
  await p.click("button:has-text('Verificar resposta')");
  await p.waitForSelector("text=Correto!");
  ok("acerto mostra a explicação e o XP (2ª tentativa = 10 XP)", (await p.locator("main").innerText()).includes("4 + 3 = 7") && (await p.locator("main").innerText()).includes("+10 XP"));
  ok("acerto gravado como resolvido com XP", st.upserts[1].solved===true && st.upserts[1].xp===10 && st.upserts[1].attempts===2);
  ok("segunda atividade do mesmo dia soma sem duplicar a sequência", st.activity.length===2 && st.activity[1].p_solved===true && (await headerStreak(p))==="Sequência: 3 dias");
  ok("sugere o próximo exercício", (await p.locator("main").innerText()).includes("Próximo: Complete a condicional"));

  await p.click("text=Próximo: Complete a condicional");
  await p.waitForSelector("input[aria-label='Lacuna 1']");
  ok("lacunas aparecem como campos dentro do código", await p.locator("input[aria-label^='Lacuna']").count()===2);
  await p.fill("input[aria-label='Lacuna 1']","iff"); await p.fill("input[aria-label='Lacuna 2']","else");
  await p.click("button:has-text('Verificar respostas')");
  await p.waitForSelector("text=1 de 2 lacunas corretas");
  ok("lacuna errada marcada, a certa também, sem revelar a resposta", (await p.locator("input[aria-label='Lacuna 1']").getAttribute("aria-invalid"))==="true" && !(await p.locator("main").innerText()).includes("Em inglês") === true);
  await p.fill("input[aria-label='Lacuna 1']"," if ");
  await p.click("button:has-text('Verificar respostas')");
  await p.waitForSelector("text=Tudo certo!");
  ok("resposta certa com espaços extras é aceita; XP de 2ª tentativa", st.upserts.at(-1).solved===true && st.upserts.at(-1).xp===10);

  await p.click("nav >> text=Perfil");
  await p.waitForSelector("text=Sequência diária");
  const perfil=await p.locator("main").innerText();
  ok("perfil: sequência atual e melhor", perfil.includes("🔥 3") && /Melhor sequência:\s*3/.test(perfil));
  ok("perfil: 14 dias com 3 marcados como praticados", await p.locator("ul[aria-label='Últimos 14 dias'] li[aria-label$=': praticou']").count()===3);
  await p.screenshot({path:OUT+"/perfil-streak.png",fullPage:true});
  ok("sem erros de página (aluno)", errs.length===0 || (console.log(errs),false));
}

// ===================== PROFESSOR =====================
{
  const {p,st,errs}=await newCtx("professor");
  await p.goto(BASE+"/professor/exercicios");
  await p.waitForSelector("text=Complete a condicional",{timeout:12000});
  ok("lista mostra o tipo de cada exercício", (await p.locator("main").innerText()).includes("Completar a lacuna") && (await p.locator("main").innerText()).includes("Múltipla escolha"));

  // ----- criar múltipla escolha -----
  await p.click("text=Novo exercício");
  await p.waitForSelector("text=Tipo de exercício");
  await p.locator("label:has-text('Múltipla escolha') input").check();
  ok("para múltipla escolha não aparecem função, testes nem solução de referência", await p.locator("h2:has-text('Solução de referência')").count()===0 && await p.locator("h2:has-text('Casos de teste')").count()===0);
  await p.getByLabel("Título",{exact:true}).fill("O que é uma variável?");
  await p.getByLabel("Enunciado",{exact:true}).fill("Escolha a definição correta.");
  await p.getByLabel("Antes de começar").fill("  Variável guarda um valor.  ");
  await p.fill("input[aria-label='Texto da alternativa 1']","Um valor que muda"); 
  await p.click("button:has-text('Salvar e publicar')");
  await p.waitForSelector("[role=alert] li");
  const errTxt=await p.locator("ul[role=alert]").innerText();
  ok("incompleto: lista de problemas (vazias e sem gabarito)", /vazias/.test(errTxt) && /correta/.test(errTxt));
  await p.fill("input[aria-label='Texto da alternativa 2']","Um tipo de computador");
  await p.click("text=+ Adicionar alternativa");
  await p.fill("input[aria-label='Texto da alternativa 3']","Uma linguagem");
  await p.locator("input[aria-label='Alternativa 1 é a correta']").check();
  await p.locator("label:has-text('Explicação ao acertar') textarea").fill("Isso mesmo.");
  ok("completo: a lista de pendências some e o botão de publicar está ativo, sem solução de referência", await p.locator("ul[role=alert]").count()===0 && await p.locator("button:has-text('Salvar e publicar')").isEnabled());
  await p.click("button:has-text('Salvar e publicar')");
  await p.waitForSelector("text=O que é uma variável?",{timeout:8000});
  const post=st.posts[0];
  ok("gravou kind=choice com config, sem função/testes", post.kind==="choice" && post.function_name===null && JSON.stringify(post.tests)==="[]" && post.starter_code==="" && post.published===true && post.created_by===uid);
  ok("config: alternativas aparadas, gabarito e explicação", JSON.stringify(post.config)===JSON.stringify({options:["Um valor que muda","Um tipo de computador","Uma linguagem"],correct:0,explanation:"Isso mesmo."}));
  ok("mini-explicação gravada aparada", post.lesson==="Variável guarda um valor.");

  // ----- criar lacunas -----
  await p.click("text=Novo exercício");
  await p.waitForSelector("text=Tipo de exercício");
  ok("o formulário novo recomeça vazio e do tipo padrão (código)", (await p.getByLabel("Título",{exact:true}).inputValue())==="" && await p.getByRole("radio",{name:/^Código/}).isChecked());
  await p.locator("label:has-text('Completar a lacuna') input").check();
  await p.getByLabel("Título",{exact:true}).fill("Complete o laço");
  await p.getByLabel("Enunciado",{exact:true}).fill("Complete.");
  await p.fill("textarea[aria-label='Modelo com lacunas']","sem lacunas ainda");
  await p.click("button:has-text('Salvar e publicar')");
  await p.waitForSelector("ul[role=alert]");
  ok("modelo sem lacunas é rejeitado com mensagem clara", /pelo menos uma lacuna/.test(await p.locator("ul[role=alert]").innerText()));
  await p.fill("textarea[aria-label='Modelo com lacunas']","for (let i = 0; i < 3; i{{1}}) {\n  s {{2}} i;\n}");
  await p.waitForSelector("text=Lacuna 2");
  ok("aparecem tantos campos de respostas quanto lacunas", await p.locator("label:has(textarea):has-text('Lacuna ')").count()===2);
  ok("pré-visualização mostra o modelo com as lacunas numeradas", (await p.locator("pre").last().innerText()).includes("for (let i = 0; i < 3; i"));
  await p.locator("label:has-text('Lacuna 1') textarea").fill("++\n+= 1");
  await p.locator("label:has-text('Lacuna 2') textarea").fill("+=");
  await p.click("button:has-text('Salvar e publicar')");
  await p.waitForSelector("text=Complete o laço",{timeout:8000});
  const blank=st.posts[1];
  ok("gravou kind=blank com modelo e respostas aceitas por lacuna", blank.kind==="blank" && JSON.stringify(blank.config)===JSON.stringify({template:"for (let i = 0; i < 3; i{{1}}) {\n  s {{2}} i;\n}",blanks:[{answers:["++","+= 1"]},{answers:["+="]}]}));
  ok("sem mini-explicação, a coluna lesson nem é enviada", !("lesson" in blank));

  // ----- editar -----
  await p.locator("li:has-text('Complete a condicional') >> text=Editar").click();
  await p.waitForSelector("text=Editar exercício");
  ok("edição de lacunas carrega modelo e respostas; tipo travado", (await p.locator("textarea[aria-label='Modelo com lacunas']").inputValue()).includes("{{2}}") && await p.getByRole("radio",{name:/^Completar a lacuna/}).isDisabled());
  ok("sem erros de página (professor)", errs.length===0 || (console.log(errs),false));
}
await b.close();
console.log(failed? `\n${failed} FALHA(S)` : "\nTODOS OS FLUXOS OK");
process.exit(failed?1:0);

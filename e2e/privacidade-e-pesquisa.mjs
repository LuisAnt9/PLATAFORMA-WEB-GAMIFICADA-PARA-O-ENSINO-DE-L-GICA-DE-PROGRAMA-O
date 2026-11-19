// E15: consentimento, privacidade (LGPD) e questionários SUS/Likert. Backend simulado em memória.
import fs from "node:fs";
import { BASE, launch } from "./helpers.mjs";
const b = await launch();
const b64=o=>Buffer.from(JSON.stringify(o)).toString("base64url");
const mkSession=uid=>{ const jwt=`${b64({alg:"HS256",typ:"JWT"})}.${b64({sub:uid,role:"authenticated",exp:4102444800})}.sig`; return {access_token:jwt,refresh_token:"r",token_type:"bearer",expires_in:3600,expires_at:4102444800,user:{id:uid,aud:"authenticated",role:"authenticated",email:"x@x.com",app_metadata:{},user_metadata:{},created_at:"2026-01-01T00:00:00Z"}}; };
let failed=0; const ok=(n,c)=>{console.log((c?"✓ ":"✗ FALHOU: ")+n); if(!c) failed++;};
const UID="11111111-1111-1111-1111-111111111111";
const ex={id:"e1",module_id:"m1",kind:"code",lesson:null,title:"Dobro",difficulty:"facil",statement:"d",function_name:"dobro",starter_code:"function dobro(n) {}",tests:[{args:[2],expected:4}],config:{},hint:"",position:1,published:true};

const st={ calls:[], patches:[], signup:null, done:[], summary:null, csvArgs:[] };
async function newCtx(role,{logged=true,consent=true,aiOff=false}={}){
  const ctx=await b.newContext({viewport:{width:Number(process.env.E2E_W||1000),height:Number(process.env.E2E_H||1000)},acceptDownloads:true});
  if(logged) await ctx.addInitScript(s=>localStorage.setItem("sb-shmdjhfleduxefoodrfm-auth-token",JSON.stringify(s)),mkSession(UID));
  const profile={id:UID,name:role==="professor"?"Prof Lima":"Luis A",role,show_in_ranking:false,consent_at:consent?"2026-11-01T00:00:00Z":null,consent_version:consent?"2026-11":null,over_18:true,ai_hints_enabled:!aiOff};
  await ctx.route("**/*.supabase.co/**", async route=>{
    const req=route.request(), u=req.url(), m=req.method();
    const json=(body,code=200)=>route.fulfill({status:code,contentType:"application/json",headers:{"access-control-allow-origin":"*"},body:JSON.stringify(body)});
    const empty=(code=204)=>route.fulfill({status:code,headers:{"access-control-allow-origin":"*"},body:""});
    const body=()=>{ try{ return JSON.parse(req.postData()||"{}"); }catch{ return {}; } };
    if(m==="OPTIONS") return route.fulfill({status:204,headers:{"access-control-allow-origin":"*","access-control-allow-headers":"*","access-control-allow-methods":"*"}});
    if(u.includes("/auth/v1/signup")){ st.signup=body(); return json({id:"22222222-2222-2222-2222-222222222222",aud:"authenticated",email:"novo@x.com",identities:[{}]}); }
    if(u.includes("/auth/v1/logout")) return empty();
    if(u.includes("/rpc/accept_terms")){ const p=body(); st.calls.push(["accept_terms",p]); profile.consent_at=new Date().toISOString(); profile.over_18=p.p_over_18; return json(null); }
    if(u.includes("/rpc/export_my_data")){ st.calls.push(["export_my_data"]); return json({perfil:{name:profile.name},progresso:[],tentativas:[]}); }
    if(u.includes("/rpc/delete_my_account")){ st.calls.push(["delete_my_account"]); return json(null); }
    if(u.includes("/rpc/submit_survey")){ const p=body(); st.calls.push(["submit_survey",p]); st.done.push({kind:p.p_kind}); return json(p.p_kind==="sus"?75:null); }
    if(u.includes("/rpc/survey_summary")) return json(st.summary??{sus:{n:3,sufficient:false},likert:{n:0,sufficient:false}});
    if(u.includes("/rpc/ai_hint_comparison")) return json({sufficient:false,com_ia:2,sem_ia:7,min:5});
    if(u.includes("/rpc/export_survey_csv")){ st.csvArgs.push(body()); return json('id,data,questionario,modo,turma,nome,pontuacao_sus,q1,q2,q3,q4,q5,q6,q7,q8,q9,q10,comentario\n1,"2026-11-10 10:00",sus,anonima,"Turma P","",75.0,4,2,4,2,4,2,4,2,4,2,"Gostei"'); }
    if(u.includes("/rpc/sync_gamification")) return json({bonus_xp:0,missions:[],new_worlds:[],worlds_done:[]});
    if(u.includes("/rest/v1/survey_done")) return json(st.done);
    if(u.includes("/rest/v1/profiles")){ if(m==="PATCH"){ const p=body(); st.patches.push(p); Object.assign(profile,p); return empty(); } return json(profile); }
    if(u.includes("/rest/v1/modules")) return json([{id:"m1",title:"Lição",focus:"F",position:1}]);
    if(u.includes("/rest/v1/exercises")) return json([ex]);
    if(u.includes("/rest/v1/classes")){ const c={id:"c1",name:"Turma P",code:"ABC234",created_at:"2026-01-01T00:00:00Z",archived:false}; return u.includes("teacher_id=eq.")?json([c]):json([c]); }
    if(u.includes("/rest/v1/class_members")) return json([{class_id:"c1"}]);
    return json([]);
  });
  const p=await ctx.newPage(); const errs=[]; p.on("pageerror",e=>errs.push(e.message));
  return {p,errs,ctx};
}
const main=p=>p.locator("main").innerText();

// ---- política aberta, cadastro com consentimento
{
  const {p,errs}=await newCtx("aluno",{logged:false});
  await p.goto(BASE+"/privacidade"); await p.waitForSelector("h1:has-text('Política de privacidade')");
  const t=await main(p);
  ok("a política abre sem login e traz as seções principais", t.includes("Quais dados guardamos") && t.includes("Dica com inteligência artificial") && t.includes("Menores de 18 anos") && t.includes("Por quanto tempo guardamos"));
  ok("avisa que o código vai ao Google e que dá para desligar", t.includes("enviados ao Google") && t.includes("desligar a dica com IA"));
  ok("explica como excluir a conta e baixar os dados", t.includes("Excluir minha conta") && t.includes("Baixar meus dados"));
  await p.goto(BASE+"/entrar"); await p.waitForSelector("form");
  await p.click("button:has-text('Não tem conta? Cadastre-se')");
  await p.fill("input[autocomplete=name]","Maria Souza"); await p.fill("input[type=email]","novo@x.com"); await p.fill("input[type=password]","segredo123");
  await p.click("button[type=submit]");
  await p.waitForSelector("form [role=alert]");
  ok("sem aceitar o termo e informar a idade, o cadastro é barrado", (await p.locator("form [role=alert]").innerText()).includes("aceite a política") && st.signup===null);
  await p.locator("label:has-text('Não, tenho menos de 18 anos') input").check();
  ok("menor de idade recebe o aviso do responsável", (await p.locator("form").innerText()).includes("autorização de um responsável"));
  await p.locator("label:has-text('Sim, tenho 18 anos ou mais') input").check();
  await p.locator("label:has-text('Li e concordo') input").check();
  await p.click("button[type=submit]"); await p.waitForTimeout(800);
  ok("o cadastro envia a versão do termo e a declaração de idade", st.signup?.data?.consent_version==="2026-11" && st.signup?.data?.over_18==="true" && st.signup?.data?.name==="Maria Souza");
  ok("sem erros de página (cadastro)", errs.length===0);
}

// ---- conta antiga precisa aceitar o termo
{
  const {p,errs}=await newCtx("aluno",{consent:false});
  await p.goto(BASE+"/"); await p.waitForSelector("h1:has-text('Antes de continuar')",{timeout:12000});
  ok("conta sem consentimento vê o termo antes de usar a plataforma", (await p.locator("main").innerText()).includes("política de privacidade") && await p.locator("nav[aria-label=Principal] >> text=Mundos").count()===1);
  ok("o botão fica desabilitado até informar a idade e aceitar", await p.getByRole("button",{name:"Aceitar e continuar"}).isDisabled());
  await p.locator("label:has-text('Sim, tenho 18 anos ou mais') input").check();
  await p.locator("label:has-text('Li e concordo') input").check();
  await p.getByRole("button",{name:"Aceitar e continuar"}).click();
  await p.waitForSelector("text=Bem-vindo",{timeout:10000});
  const c=st.calls.find(x=>x[0]==="accept_terms");
  ok("o aceite chama o banco com a versão e a idade e libera o acesso", c && c[1].p_version==="2026-11" && c[1].p_over_18===true);
  ok("sem erros de página (consentimento)", errs.length===0);
}

// ---- privacidade no perfil: IA, baixar dados, excluir conta
{
  const {p,errs}=await newCtx("aluno");
  await p.goto(BASE+"/perfil"); await p.waitForSelector("h2:has-text('Privacidade e dados')");
  const ai=p.getByRole("checkbox",{name:/Usar a dica com IA/});
  ok("dica com IA vem ligada e o texto avisa do envio ao Google", await ai.isChecked() && (await main(p)).includes("enviados ao Google"));
  await ai.click(); await p.waitForTimeout(700);
  ok("desligar a dica grava a escolha no perfil", st.patches.some(x=>x.ai_hints_enabled===false) && !(await ai.isChecked()));
  await p.goto(BASE+"/exercicio/e1"); await p.waitForSelector("text=A dica com IA está desligada");
  ok("no exercício, a dica com IA aparece desligada, com o caminho para religar", await p.getByRole("button",{name:/Dica com IA/}).isDisabled() && await p.locator("a:has-text('Ligar no Perfil')").count()===1);
  await p.goto(BASE+"/perfil"); await p.waitForSelector("h2:has-text('Privacidade e dados')");
  const [dl]=await Promise.all([p.waitForEvent("download"),p.getByRole("button",{name:"Baixar meus dados"}).click()]);
  const conteudo=fs.readFileSync(await dl.path(),"utf8");
  ok("baixar meus dados gera um arquivo JSON com o perfil", dl.suggestedFilename().endsWith(".json") && conteudo.includes("\"perfil\"") && st.calls.some(x=>x[0]==="export_my_data"));
  await p.click("button:has-text('Excluir minha conta')");
  const del=p.getByRole("button",{name:"Excluir definitivamente"});
  ok("excluir exige digitar EXCLUIR", await del.isDisabled());
  await p.fill("[role=alertdialog] input","excluir"); ok("digitar em minúsculas não basta", await del.isDisabled());
  await p.fill("[role=alertdialog] input","EXCLUIR"); await del.click();
  await p.waitForURL("**/entrar",{timeout:10000});
  ok("a exclusão chama o banco, encerra a sessão e leva para o login", st.calls.some(x=>x[0]==="delete_my_account"));
  ok("sem erros de página (privacidade)", errs.length===0);
}

// ---- questionário SUS
{
  const {p,errs}=await newCtx("aluno");
  await p.goto(BASE+"/pesquisa"); await p.waitForSelector("h1:has-text('Sua opinião')");
  await p.click("button:has-text('Responder (10 afirmações)')"); await p.waitForSelector("fieldset");
  await p.click("button:has-text('Enviar respostas')");
  ok("faltando respostas, avisa e não envia", (await p.locator("form [role=alert]").innerText()).includes("Responda todas") && !st.calls.some(x=>x[0]==="submit_survey"));
  const fieldsets=await p.locator("form fieldset").count();
  for(let i=0;i<10;i++) await p.locator(`input[name='sus-${i}']`).nth(i%2===0?3:1).check(); // 4 nos ímpares, 2 nos pares
  ok("cada afirmação tem a escala de 1 a 5 com rótulos", (await p.locator("form").innerText()).includes("Concordo totalmente") && fieldsets>=10);
  ok("por padrão a resposta é anônima", await p.locator("label:has-text('De forma anônima') input").isChecked());
  await p.fill("textarea","Gostei muito."); await p.click("button:has-text('Enviar respostas')");
  await p.waitForSelector("text=Respondido. Obrigado");
  const c=st.calls.find(x=>x[0]==="submit_survey");
  ok("envia as 10 respostas (1 a 5), o modo anônimo e o comentário", c[1].p_kind==="sus" && Object.keys(c[1].p_answers).length===10 && c[1].p_answers["1"]===4 && c[1].p_answers["2"]===2 && c[1].p_anonymous===true && c[1].p_comment==="Gostei muito.");
  ok("depois de responder, o questionário não reabre", await p.locator("button:has-text('Responder (10 afirmações)')").count()===0);
  await p.click("button:has-text('Responder (8 afirmações)')"); await p.waitForSelector("input[name='likert-0']");
  for(let i=0;i<8;i++) await p.locator(`input[name='likert-${i}']`).nth(4).check();
  await p.locator("label:has-text('Identificada') input").check();
  await p.click("button:has-text('Enviar respostas')"); await p.waitForTimeout(600);
  const l=st.calls.filter(x=>x[0]==="submit_survey").at(-1);
  ok("Likert identificado: 8 respostas e modo identificado", l[1].p_kind==="likert" && Object.keys(l[1].p_answers).length===8 && l[1].p_anonymous===false);
  ok("sem erros de página (questionário)", errs.length===0);
}

// ---- painel de pesquisa do professor
{
  const {p,errs}=await newCtx("professor");
  await p.goto(BASE+"/professor/pesquisa"); await p.waitForSelector("h1:has-text('Pesquisa')"); await p.waitForSelector("text=Dados insuficientes");
  let t=await main(p);
  ok("com poucas respostas mostra só a contagem (não identifica ninguém)", t.includes("3 respostas") && t.includes("o resumo aparece com 5 ou mais"));
  ok("a comparação com e sem IA explica o mínimo de alunos e o cuidado na leitura", t.includes("2 alunos com IA e 7 sem IA") && t.includes("não prova que a dica causa"));
  const [dl]=await Promise.all([p.waitForEvent("download"),p.getByRole("button",{name:"Baixar respostas (CSV)"}).click()]);
  const csv=fs.readFileSync(await dl.path(),"utf8");
  ok("o CSV baixado tem BOM (acentos no Excel), cabeçalho e as linhas", dl.suggestedFilename()==="respostas-pesquisa.csv" && csv.charCodeAt(0)===0xFEFF && csv.includes("id,data,questionario,modo,turma,nome,pontuacao_sus") && csv.includes("anonima"));
  st.summary={sus:{n:8,sufficient:true,mean_score:72.5,item_means:{},anonymous:5},likert:{n:8,sufficient:true,item_means:{"1":4.1,"2":3.9,"3":4.5,"4":3.2,"5":4,"6":4.2,"7":3.8,"8":4.6}}};
  await p.reload(); await p.waitForSelector("text=de 100");
  t=await main(p);
  ok("com 5 ou mais, mostra a média SUS, a faixa e a tabela Likert", t.includes("72.5") && t.includes("aceitável") && t.includes("4.6") && await p.locator("table").count()>=1);
  ok("sem erros de página (pesquisa do professor)", errs.length===0);
}

await b.close();
console.log(failed?`${failed} FALHA(S)`:"TODOS OS FLUXOS OK");
process.exit(failed?1:0);

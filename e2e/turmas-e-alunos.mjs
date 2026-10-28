import fs from "node:fs";
import { BASE, OUT, launch } from "./helpers.mjs";
const b = await launch();
const b64=o=>Buffer.from(JSON.stringify(o)).toString("base64url");
const uid="11111111-1111-1111-1111-111111111111";
const jwt=`${b64({alg:"HS256",typ:"JWT"})}.${b64({sub:uid,role:"authenticated",exp:4102444800})}.sig`;
const session={access_token:jwt,refresh_token:"r",token_type:"bearer",expires_in:3600,expires_at:4102444800,user:{id:uid,aud:"authenticated",role:"authenticated",email:"x@x.com",app_metadata:{},user_metadata:{},created_at:"2026-01-01T00:00:00Z"}};
let failed=0; const ok=(n,c)=>{console.log((c?"✓ ":"✗ FALHOU: ")+n); if(!c) failed++;};

async function newCtx(role){
  const ctx = await b.newContext({viewport:{width:1000,height:900}});
  await ctx.addInitScript(s=>localStorage.setItem("sb-shmdjhfleduxefoodrfm-auth-token",JSON.stringify(s)),session);
  const st={ myClasses:[], teacherClasses:[{id:"c1",name:"ADS 2026.1",code:"ABC234",created_at:"2026-10-01T00:00:00Z"}], upserts:[], calls:[] };
  await ctx.route("**/*.supabase.co/**", async route=>{
    const req=route.request(), u=req.url(), m=req.method(), acc=req.headers()["accept"]||"";
    const json=(body,code=200)=>route.fulfill({status:code,contentType:"application/json",headers:{"access-control-allow-origin":"*"},body:JSON.stringify(body)});
    if(m==="OPTIONS") return route.fulfill({status:204,headers:{"access-control-allow-origin":"*","access-control-allow-headers":"*","access-control-allow-methods":"*"}});
    st.calls.push(m+" "+u.split(".supabase.co")[1].split("?")[0]);
    if(u.includes("/rest/v1/modules")) return json([{id:"m1",title:"Fundamentos",focus:"Foco 1",position:1},{id:"m2",title:"Condicionais",focus:"Foco 2",position:2}]);
    if(u.includes("/rest/v1/exercises")) return json([
      {id:"soma",module_id:"m1",title:"Somar dois números",difficulty:"facil",statement:"Escreva soma(a,b).",function_name:"soma",starter_code:"function soma(a, b) {\n}\n",tests:[{args:[2,3],expected:5},{args:[1,1],expected:2}],hint:"use +",position:1,published:true},
      {id:"dobro",module_id:"m1",title:"Dobro",difficulty:"facil",statement:"d",function_name:"dobro",starter_code:"function dobro(n) {\n}\n",tests:[{args:[2],expected:4}],hint:"",position:2,published:true},
      ...(role==="professor"?[{id:"rasc",module_id:"m2",title:"Rascunho X",difficulty:"medio",statement:"r",function_name:"r",starter_code:"function r(){}",tests:[{args:[],expected:1}],hint:"",position:1,published:false}]:[]) ]);
    if(u.includes("/rest/v1/profiles")){ return u.includes("id=in.") ? json([{id:"s1",name:"Ana Souza"},{id:"s2",name:"Beto Lima"}]) : json({id:uid,name:role==="professor"?"Prof Lima":"Luis A",role}); }
    if(u.includes("/rest/v1/exercise_progress")){
      if(m==="POST"||m==="PATCH"){ st.upserts.push(JSON.parse(req.postData())); return route.fulfill({status:201,headers:{"access-control-allow-origin":"*"},body:""}); }
      if(u.includes("user_id=in.")) return json([{user_id:"s1",exercise_id:"soma",attempts:2,solved:true,first_try:false,xp:10,updated_at:new Date(Date.now()-3*864e5).toISOString()},{user_id:"s1",exercise_id:"dobro",attempts:1,solved:false,first_try:false,xp:0,updated_at:new Date().toISOString()}]);
      return json([]);
    }
    if(u.includes("/rpc/join_class")){ const body=JSON.parse(req.postData()); if(body.class_code!=="ABC234") return json({code:"P0001",message:"Código de turma inválido."},400); st.myClasses=[{id:"c1",name:"ADS 2026.1"}]; return json([{id:"c1",name:"ADS 2026.1"}]); }
    if(u.includes("/rpc/create_class")){ const body=JSON.parse(req.postData()); st.teacherClasses.unshift({id:"c2",name:body.class_name,code:"ZZZ999",created_at:new Date().toISOString()}); return json([{id:"c2",name:body.class_name,code:"ZZZ999"}]); }
    if(u.includes("/rest/v1/classes")){
      if(m==="PATCH"){ st.teacherClasses[0].name=JSON.parse(req.postData()).name; return route.fulfill({status:204,headers:{"access-control-allow-origin":"*"}}); }
      if(u.includes("teacher_id=eq.")) return json(st.teacherClasses);
      if(u.includes("id=eq.")) return acc.includes("vnd.pgrst.object") ? json(st.teacherClasses[0]) : json([st.teacherClasses[0]]);
      return json(st.myClasses);
    }
    if(u.includes("/rest/v1/class_members")){
      if(m==="DELETE"){ st.myClasses=[]; return route.fulfill({status:204,headers:{"access-control-allow-origin":"*"}}); }
      if(u.includes("class_id=eq.")) return json([{student_id:"s1",joined_at:"2026-10-02T00:00:00Z"},{student_id:"s2",joined_at:"2026-10-02T00:00:00Z"}]);
      return json([{class_id:"c1"},{class_id:"c1"}]);
    }
    return json({});
  });
  const p=await ctx.newPage(); const errs=[]; p.on("pageerror",e=>errs.push(e.message));
  return {p,st,errs,ctx};
}

// ===================== ALUNO =====================
{
  const {p,st,errs}=await newCtx("aluno");
  p.on("dialog",d=>d.accept());
  await p.goto(BASE+"/");
  await p.waitForSelector("text=Somar dois números",{timeout:10000});
  ok("trilha vem do banco (módulos e exercícios)", (await p.locator("main").innerText()).includes("Fundamentos") && !(await p.locator("main").innerText()).includes("Rascunho X"));
  ok("aluno não vê link Professor", !(await p.locator("nav").innerText()).includes("Professor"));
  await p.click("text=Somar dois números");
  await p.waitForSelector(".cm-content");
  await p.click(".cm-content"); await p.keyboard.press("Control+A"); await p.keyboard.insertText("function soma(a,b){return a+b}");
  await p.keyboard.press("Control+Enter");
  await p.waitForSelector("text=Todos os testes passaram",{timeout:8000});
  ok("executa e acerta com testes do banco; XP gravado", st.upserts.length===1 && st.upserts[0].exercise_id==="soma" && st.upserts[0].xp===15);
  ok("sugere o próximo exercício", (await p.locator("main").innerText()).includes("Próximo: Dobro"));
  await p.goto(BASE+"/exercicio/nao-existe");
  await p.waitForSelector("text=Exercício não encontrado",{timeout:8000});
  ok("exercício inexistente mostra aviso", true);
  await p.click("nav >> text=Perfil");
  await p.waitForSelector("text=Minhas turmas");
  await p.fill("input[placeholder=ABC234]","ZZZZZZ"); await p.click("button:has-text('Entrar')");
  await p.waitForSelector("text=Código de turma inválido.");
  ok("código inválido mostra a mensagem do banco", true);
  await p.fill("input[placeholder=ABC234]","abc234"); await p.click("button:has-text('Entrar')");
  await p.waitForSelector("text=Você entrou na turma ADS 2026.1.");
  ok("entra na turma com código (maiúsculas automáticas)", (await p.locator("main").innerText()).includes("Sair da turma"));
  await p.click("text=Sair da turma");
  await p.waitForSelector("text=Você ainda não está em nenhuma turma.");
  ok("sai da turma", true);
  ok("sem erros de página (aluno)", errs.length===0 || (console.log(errs),false));
}
// ===================== PROFESSOR =====================
{
  const {p,st,errs}=await newCtx("professor");
  p.on("dialog",d=>d.accept());
  await p.goto(BASE+"/");
  await p.waitForSelector("text=Somar dois números",{timeout:10000});
  ok("professor vê rascunho marcado na trilha", (await p.locator("main").innerText()).toLowerCase().includes("rascunho"));
  await p.click("nav >> text=Professor");
  await p.waitForSelector("text=ADS 2026.1");
  ok("lista turmas com código e nº de alunos", (await p.locator("main").innerText()).includes("ABC234") && (await p.locator("main").innerText()).includes("2 alunos"));
  await p.fill("input[placeholder^='Ex.:']","Turma Noite"); await p.click("button:has-text('Criar turma')");
  await p.waitForSelector("text=Turma Noite");
  ok("cria turma e mostra o código gerado", (await p.locator("main").innerText()).includes("ZZZ999"));
  await p.click("a:has-text('ADS 2026.1')");
  await p.click("role=tab[name='Alunos']");
  await p.waitForSelector("text=Ana Souza");
  const tbl=await p.locator("tbody").first().innerText();
  ok("detalhe da turma: alunos com XP/resolvidos/atividade", tbl.includes("Ana Souza") && tbl.includes("Beto Lima") && tbl.includes("10") && tbl.includes("1/2") && tbl.includes("hoje") && tbl.includes("nunca"));
  await p.click("role=tab[name='Configurações']");
  await p.fill("input[minlength='2']","ADS 2026.1 Manhã"); await p.click("button:has-text('Salvar')");
  await p.waitForSelector("text=Nome atualizado.");
  ok("renomeia a turma", (await p.locator("h1:visible").innerText()).includes("Manhã"));
  await p.screenshot({path:OUT+"/turma.png",fullPage:true});
  await p.goto(BASE+"/professor");
  ok("sem erros de página (professor)", errs.length===0 || (console.log(errs),false));
}
// ===================== ALUNO tentando área do professor =====================
{
  const {p}=await newCtx("aluno");
  await p.goto(BASE+"/professor");
  await p.waitForSelector("text=restrita a professores",{timeout:8000});
  ok("aluno em /professor vê aviso de acesso restrito", true);
}
await b.close();
console.log(failed? `\n${failed} FALHA(S)` : "\nTODOS OS FLUXOS OK");
process.exit(failed?1:0);

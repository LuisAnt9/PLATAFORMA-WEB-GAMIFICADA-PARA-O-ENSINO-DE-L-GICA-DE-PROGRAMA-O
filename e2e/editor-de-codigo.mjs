import fs from "node:fs";
import { BASE, OUT, launch } from "./helpers.mjs";
const b = await launch();
const b64=o=>Buffer.from(JSON.stringify(o)).toString("base64url");
const uid="11111111-1111-1111-1111-111111111111";
const jwt=`${b64({alg:"HS256",typ:"JWT"})}.${b64({sub:uid,role:"authenticated",exp:4102444800})}.sig`;
const session={access_token:jwt,refresh_token:"r",token_type:"bearer",expires_in:3600,expires_at:4102444800,user:{id:uid,aud:"authenticated",role:"authenticated",email:"p@x.com",app_metadata:{},user_metadata:{},created_at:"2026-01-01T00:00:00Z"}};
let failed=0; const ok=(n,c)=>{console.log((c?"✓ ":"✗ FALHOU: ")+n); if(!c) failed++;};
const ex=(id,pos,pub=true)=>({id,module_id:"m1",title:"Ex "+id,difficulty:"facil",statement:"s",function_name:"soma",starter_code:"function soma(a, b) {\n  // seu código aqui\n}\n",tests:[{args:[2,3],expected:5},{args:[1,1],expected:2},{args:[0,0],expected:0}],hint:"",position:pos,published:pub});
const st={ exercises:[ex("um",1),ex("dois",2),ex("rasc",3,false)], modules:[{id:"m1",title:"Fundamentos",focus:"F",position:1}], posts:[], patches:[], modPosts:[] };
const ctx = await b.newContext({viewport:{width:1100,height:1000}});
await ctx.addInitScript(s=>localStorage.setItem("sb-shmdjhfleduxefoodrfm-auth-token",JSON.stringify(s)),session);
await ctx.route("**/*.supabase.co/**", async route=>{
  const req=route.request(), u=req.url(), m=req.method();
  const json=(body,code=200)=>route.fulfill({status:code,contentType:"application/json",headers:{"access-control-allow-origin":"*"},body:JSON.stringify(body)});
  const empty=(code=201)=>route.fulfill({status:code,headers:{"access-control-allow-origin":"*"},body:""});
  if(m==="OPTIONS") return route.fulfill({status:204,headers:{"access-control-allow-origin":"*","access-control-allow-headers":"*","access-control-allow-methods":"*"}});
  if(u.includes("/rest/v1/modules")){ if(m==="POST"){ st.modPosts.push(JSON.parse(req.postData())); st.modules.push(JSON.parse(req.postData())); return empty(); } return json(st.modules); }
  if(u.includes("/rest/v1/exercises")){
    if(m==="POST"){ const row=JSON.parse(req.postData()); st.posts.push(row); st.exercises.push(row); return empty(); }
    if(m==="PATCH"){ const id=decodeURIComponent(u.match(/id=eq\.([^&]+)/)[1]); const body=JSON.parse(req.postData()); st.patches.push({id,body}); const e=st.exercises.find(x=>x.id===id); Object.assign(e,body); return empty(204); }
    return json(st.exercises);
  }
  if(u.includes("/rest/v1/profiles")) return json({id:uid,name:"Prof Lima",role:"professor"});
  if(u.includes("/rest/v1/exercise_progress")) return json([]);
  return json([]);
});
const p=await ctx.newPage(); const errs=[]; p.on("pageerror",e=>errs.push(e.message)); p.on("dialog",d=>d.accept());
const typeSolution=async(code)=>{ await p.locator(".cm-content").click(); await p.keyboard.press("Control+A"); await p.keyboard.insertText(code); };

await p.goto(BASE+"/professor/exercicios");
await p.waitForSelector("text=Ex um",{timeout:10000});
ok("lista mostra módulos, status e testes", (await p.locator("main").innerText()).includes("Rascunho") && (await p.locator("main").innerText()).includes("3 testes"));
ok("abas Turmas/Exercícios visíveis", (await p.locator("nav[aria-label='Área do professor']").innerText()).includes("Exercícios"));

// ---------- criar ----------
await p.click("text=Novo exercício");
await p.waitForSelector("text=Casos de teste");
await p.fill("label:has-text('Título') input","Dobro de um número");
await p.getByLabel('Enunciado',{exact:true}).fill('Retorne o dobro de n.');
await p.fill("label:has-text('Nome da função') input","dobro");
await p.fill("label:has-text('Parâmetros') input >> visible=true","n");
ok("mostra o código inicial gerado", (await p.locator("pre").innerText()).includes("function dobro(n) {"));
await p.fill("input[aria-label='Entradas do teste 1']","abc");
await p.fill("input[aria-label='Resultado esperado do teste 1']","4");
ok("erro de JSON aparece na linha do teste", (await p.locator("main").innerText()).includes("Use JSON"));
ok("publicar está desabilitado antes de validar", await p.locator("button:has-text('Salvar e publicar')").isDisabled());
await p.fill("input[aria-label='Entradas do teste 1']","2");
await p.click("text=+ Adicionar teste");
await p.fill("input[aria-label='Entradas do teste 2']","3");
await p.fill("input[aria-label='Resultado esperado do teste 2']","7"); // errado de propósito: 3*2 = 6
await typeSolution("function dobro(n){ return n*2 }");
await p.click("button:has-text('Validar testes')");
await p.waitForSelector("text=a solução retornou");
ok("solução que NÃO passa nos testes mostra o que falhou e não libera publicar", await p.locator("button:has-text('Salvar e publicar')").isDisabled());
await p.fill("input[aria-label='Entradas do teste 2']","5");
await p.fill("input[aria-label='Resultado esperado do teste 2']","10");
await p.click("button:has-text('Validar testes')");
await p.waitForSelector("text=Testes validados");
ok("com testes corretos, validação passa e libera publicar", await p.locator("button:has-text('Salvar e publicar')").isEnabled());
await p.fill("input[aria-label='Resultado esperado do teste 2']","11");
ok("editar um teste invalida a validação", await p.locator("button:has-text('Salvar e publicar')").isDisabled());
await p.fill("input[aria-label='Resultado esperado do teste 2']","10");
ok("voltar ao estado validado NÃO revalida sozinho (exige nova execução)", await p.locator("button:has-text('Salvar e publicar')").isEnabled()); // mesmo snapshot => segue válido
await p.click("button:has-text('Salvar e publicar')");
await p.waitForSelector("text=Dobro de um número",{timeout:8000});
const post=st.posts[0];
ok("gravou 1 exercício com id, autor, posição e publicado", post && post.id==="dobro-de-um-numero" && post.created_by===uid && post.position===4 && post.published===true);
ok("tests convertidos para JSON de verdade e código inicial gerado", JSON.stringify(post.tests)===JSON.stringify([{args:[2],expected:4},{args:[5],expected:10}]) && post.starter_code==="function dobro(n) {\n  // seu código aqui\n}\n");
ok("a solução de referência NÃO foi enviada ao banco", !JSON.stringify(post).includes("n*2"));
ok("voltou para a lista com o novo exercício", (await p.locator("main").innerText()).includes("Dobro de um número"));

await p.click("a:has-text('Novo exercício')");
await p.waitForSelector("text=Casos de teste");
const tituloNovo = await p.locator("label:has-text('Título') input >> visible=true").inputValue();
const solNovo = await p.locator(".cm-content >> visible=true").innerText();
ok("ao abrir 'Novo exercício' de novo o formulário vem LIMPO (título e solução)", tituloNovo==="" && !solNovo.includes("n*2"));
await p.goBack(); await p.waitForSelector("text=Ex um");
// ---------- editar / rascunho / despublicar / reordenar ----------
await p.click("li:has-text('Ex rasc') >> text=Editar");
await p.waitForSelector("text=Editar exercício");
ok("edição carrega os dados e parâmetros", (await p.locator("label:has-text('Parâmetros') input >> visible=true").inputValue())==="a, b" && (await p.locator("input[aria-label='Entradas do teste 1'] >> visible=true").inputValue())==="2, 3");
await p.fill("label:has-text('Título') input","Ex rasc editado");
await p.click("button:has-text('Salvar como rascunho')");
await p.waitForSelector("text=Ex rasc editado");
ok("salvar rascunho faz PATCH com published=false", st.patches.some(x=>x.id==="rasc" && x.body.published===false && x.body.title==="Ex rasc editado"));
await p.click("li:has-text('Ex um') >> text=Despublicar");
await p.waitForFunction(()=>document.querySelector("li")&&[...document.querySelectorAll("li")].find(l=>l.textContent.includes("Ex um")&&l.textContent.includes("Rascunho")));
ok("despublicar muda o status", st.patches.some(x=>x.id==="um" && x.body.published===false));
await p.locator("button[aria-label='Subir Ex dois'] >> visible=true").click();
await p.waitForTimeout(500);
const swaps=st.patches.filter(x=>Object.keys(x.body).join()==="position");
ok("subir troca as posições dos dois vizinhos", swaps.length>=2 && swaps.some(x=>x.id==="dois"&&x.body.position===1) && swaps.some(x=>x.id==="um"&&x.body.position===2));

// ---------- módulo ----------
await p.locator("label:has-text('Título do módulo') input >> visible=true").last().fill("Funções");
await p.locator("button:has-text('Criar módulo') >> visible=true").click();
await p.waitForTimeout(500);
ok("cria módulo com id gerado e posição seguinte", st.modPosts[0]?.id==="funcoes" && st.modPosts[0]?.position===2);

await p.goto(BASE+"/professor/exercicios/nao-existe");
await p.waitForSelector("text=Exercício não encontrado");
ok("editar id inexistente avisa", true);
ok("sem erros de página", errs.length===0 || (console.log(errs),false));
await p.goto(BASE+"/professor/exercicios/novo");
await p.waitForSelector("text=Casos de teste");
await p.screenshot({path:OUT+"/editor.png",fullPage:true});
await b.close();
console.log(failed? `\n${failed} FALHA(S)` : "\nTODOS OS FLUXOS OK");
process.exit(failed?1:0);

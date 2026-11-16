import { BASE, launch } from "./helpers.mjs";
const b = await launch();
const b64=o=>Buffer.from(JSON.stringify(o)).toString("base64url");
const uid="11111111-1111-1111-1111-111111111111";
const jwt=`${b64({alg:"HS256",typ:"JWT"})}.${b64({sub:uid,role:"authenticated",exp:4102444800})}.sig`;
const session={access_token:jwt,refresh_token:"r",token_type:"bearer",expires_in:3600,expires_at:4102444800,user:{id:uid,aud:"authenticated",role:"authenticated",email:"x@x.com",app_metadata:{},user_metadata:{},created_at:"2026-01-01T00:00:00Z"}};
let failed=0; const ok=(n,c)=>{console.log((c?"✓ ":"✗ FALHOU: ")+n); if(!c) failed++;};

const ITEMS=["Ferver a água","Colocar o pó no filtro","Despejar a água quente","Servir o café"];
const exs=[
 {id:"int1",module_id:"m1",kind:"interpretation",lesson:null,title:"Qual valor será impresso?",difficulty:"facil",statement:"Leia o código. Qual valor aparece na tela?",function_name:null,starter_code:"",tests:[],config:{code:"let x = 4;\nx = x + 3;\nconsole.log(x);",options:["4",{text:"3",misconception:"acha que x = x + 3 guarda só o 3"},"7"],correct:2,explanation:"4 + 3 = 7."},hint:"Acompanhe x linha por linha.",position:1,published:true},
 {id:"ord1",module_id:"m1",kind:"order",lesson:null,title:"Ordene os passos do café",difficulty:"facil",statement:"Coloque os passos na ordem certa.",function_name:null,starter_code:"",tests:[],config:{items:ITEMS,explanation:"A ordem importa."},hint:"O que vem antes?",position:2,published:true},
 {id:"fix1",module_id:"m1",kind:"fix",lesson:null,title:"Corrija a função dobro",difficulty:"facil",statement:"A função tem um defeito. Corrija.",function_name:"dobro",starter_code:"function dobro(n) {\n  return n + 2;\n}\n",tests:[{args:[3],expected:6},{args:[5],expected:10}],config:{},hint:"Teste com 3.",position:3,published:true},
 {id:"io2",module_id:"m1",kind:"challenge",lesson:null,title:"Valores especiais",difficulty:"medio",statement:"Imprima NaN, Infinity e -Infinity.",function_name:"especiais",starter_code:"function especiais() {\n}\n",tests:[{args:[],output:["NaN","Infinity","-Infinity","NaN 5"]}],config:{},hint:"",position:5,published:true},
 {id:"io1",module_id:"m1",kind:"challenge",lesson:null,title:"Saudação",difficulty:"medio",statement:"Leia o nome e cumprimente.",function_name:"saudacao",starter_code:"function saudacao() {\n}\n",tests:[{args:[],inputs:["Ana"],output:["Olá, Ana!"]},{args:[],inputs:["Beto"],output:["Olá, Beto!"]}],config:{},hint:"lerEntrada() lê o nome.",position:4,published:true},
];

async function newCtx(role,{viewport={width:1000,height:1100}}={}){
  const ctx=await b.newContext({viewport});
  await ctx.addInitScript(s=>localStorage.setItem("sb-shmdjhfleduxefoodrfm-auth-token",JSON.stringify(s)),session);
  const st={attempts:[],posts:[],patches:[],aiCalls:0,progress:[]};
  await ctx.route("**/api/dica",async route=>{ st.aiCalls++; await route.fulfill({status:200,contentType:"application/json",body:JSON.stringify({hint:"Pista da IA: pense no valor de x depois de cada linha.",remaining:9})}); });
  await ctx.route("**/*.supabase.co/**", async route=>{
    const req=route.request(), u=req.url(), m=req.method(), acc=req.headers()["accept"]||"";
    const json=(body,code=200)=>route.fulfill({status:code,contentType:"application/json",headers:{"access-control-allow-origin":"*"},body:JSON.stringify(body)});
    const empty=(code=201)=>route.fulfill({status:code,headers:{"access-control-allow-origin":"*"},body:""});
    if(m==="OPTIONS") return route.fulfill({status:204,headers:{"access-control-allow-origin":"*","access-control-allow-headers":"*","access-control-allow-methods":"*"}});
    if(u.includes("/rest/v1/modules")) return json([{id:"m1",title:"Primeiros passos",focus:"F",intro:"Intro da lição: uma variável guarda um valor.",position:1}]);
    if(u.includes("/rest/v1/concepts")) return json([{id:"c-var",title:"Introdução às variáveis",description:"",world_id:null},{id:"c-seq",title:"Sequência lógica",description:"",world_id:null}]);
    if(u.includes("/rest/v1/exercise_concepts")) return json([{exercise_id:"int1",concept_id:"c-var",weight:2},{exercise_id:"ord1",concept_id:"c-seq",weight:2}]);
    if(u.includes("/rest/v1/exercises")){ if(m==="POST"){ const row=JSON.parse(req.postData()); st.posts.push(row); return empty(); } return json(exs); }
    if(u.includes("/rest/v1/profiles")) return json({id:uid,name:role==="professor"?"Prof Lima":"Luis A",role});
    if(u.includes("/rest/v1/exercise_progress")){ if(m!=="GET"){ st.progress.push(JSON.parse(req.postData())); return empty(); } return json([]); }
    if(u.includes("/rest/v1/daily_activity")) return json([]);
    if(u.includes("/rpc/record_attempt")){ st.attempts.push(JSON.parse(req.postData())); return json(1); }
    if(u.includes("/rpc/get_solution")) return json([{solution:"function dobro(n) {\n  return n * 2;\n}",commentary:"O defeito estava no operador: o dobro é n * 2."}]);
    if(u.includes("/rpc/log_activity")) return json(null);
    return json([]);
  });
  const p=await ctx.newPage(); const errs=[]; p.on("pageerror",e=>errs.push(e.message));
  return {p,st,errs,ctx};
}
const main=p=>p.locator("main").innerText();
const typeCode=async(p,i,code)=>{ await p.locator(".cm-content").nth(i).click(); await p.keyboard.press("Control+A"); await p.keyboard.insertText(code); };
const runCode=async p=>{ await p.locator(".cm-content").first().focus(); await p.keyboard.press("Control+Enter"); };

// ===================== ALUNO =====================
{
  const {p,st,errs}=await newCtx("aluno");

  // ---- interpretação de código
  await p.goto(BASE+"/exercicio/int1"); await p.waitForSelector("[aria-label='Trecho de código']",{timeout:12000});
  const trecho=await p.locator("[aria-label='Trecho de código']").innerText();
  ok("interpretação mostra o trecho de código para ler", trecho.includes("x = x + 3") && trecho.includes("console.log(x)"));
  ok("interpretação aparece com o rótulo do tipo", (await main(p)).includes("Interpretação de código"));
  ok("verificar fica desabilitado sem escolher", await p.locator("button:has-text('Verificar resposta')").isDisabled());
  await p.locator("label:has-text('3')").first().click();
  await p.click("button:has-text('Verificar resposta')");
  await p.waitForSelector("text=Ainda não");
  ok("interpretação errada registrada com a alternativa marcada (o servidor acha a confusão)", st.attempts.length===1 && st.attempts[0].p_exercise==="int1" && st.attempts[0].p_selected===1 && st.attempts[0].p_hint_level===0);
  await p.locator("label:has-text('7')").first().click();
  await p.click("button:has-text('Verificar resposta')");
  await p.waitForSelector("text=Correto!");
  ok("acerto mostra a explicação", (await main(p)).includes("4 + 3 = 7") && st.attempts[1].p_selected===2 && st.attempts[1].p_passed===true);

  // ---- dicas em níveis (usa o mesmo exercício)
  const dicaConceito=p.getByRole("button",{name:"Dica do conceito"});
  const dicaIA=p.getByRole("button",{name:/Dica com IA/});
  ok("dica do conceito e dica com IA começam bloqueadas", await dicaConceito.isDisabled() && await dicaIA.isDisabled());
  await p.getByRole("button",{name:"Dica",exact:true}).click();
  ok("dica 1 mostra a dica do professor e libera a do conceito", (await main(p)).includes("Acompanhe x linha por linha.") && await dicaConceito.isEnabled() && await dicaIA.isDisabled());
  await dicaConceito.click();
  const t2=await main(p);
  ok("dica 2 mostra o conceito do exercício e a explicação da lição", t2.includes("Introdução às variáveis") && t2.includes("Reler a explicação da lição"));
  await p.click("summary:has-text('Reler a explicação da lição')");
  ok("a explicação da lição abre", (await main(p)).includes("uma variável guarda um valor"));
  ok("dica 2 libera a dica com IA", await dicaIA.isEnabled());
  await dicaIA.click(); await p.waitForSelector("text=Pista da IA");
  ok("dica com IA responde pelo servidor", st.aiCalls===1);
  await p.locator("label:has-text('4')").first().click();
  await p.click("button:has-text('Verificar resposta')");
  await p.waitForSelector("text=Ainda não");
  ok("a tentativa seguinte registra o nível 3 de dica", st.attempts.at(-1).p_hint_level===3);
  ok("sem erros de página (interpretação e dicas)", errs.length===0);

  // ---- ordenação, só pelo teclado
  await p.goto(BASE+"/exercicio/ord1"); await p.waitForSelector("button:has-text('Verificar ordem')");
  const ordem=async()=>p.locator("ol >> li").evaluateAll(l=>l.map(li=>li.querySelector("span.flex-1")?.textContent));
  const inicial=await ordem();
  ok("a ordem inicial é embaralhada (nunca a certa) e tem os 4 passos", inicial.length===4 && [...inicial].sort().join()===[...ITEMS].sort().join() && inicial.join()!==ITEMS.join());
  ok("ordenação aparece com o rótulo do tipo e sem revelar a ordem", (await main(p)).includes("Ordenação"));
  const nAntes=st.attempts.length;
  await p.getByRole("button",{name:/^Mover para baixo: /}).first().focus();
  const primeiro=(await ordem())[0];
  await p.keyboard.press("Enter");
  const depois=await ordem();
  ok("Enter no botão move o passo para baixo", depois[1]===primeiro && depois[0]!==primeiro);
  ok("o foco acompanha o passo movido", (await p.evaluate(()=>document.activeElement?.getAttribute("aria-label")||"")).includes(primeiro));
  ok("a nova posição é anunciada para leitores de tela", (await p.locator("p[role=status].sr-only").innerText()).includes("agora na posição 2 de 4"));
  await p.keyboard.press("Tab");
  // tenta verificar na ordem atual (errada) com o teclado
  await p.getByRole("button",{name:"Verificar ordem"}).focus(); await p.keyboard.press("Enter");
  await p.waitForSelector("text=posição certa");
  const a1=st.attempts[nAntes];
  ok("ordem errada registrada (passos na ordem do aluno, quantos já estavam no lugar)", a1.p_exercise==="ord1" && JSON.parse(a1.p_answer).length===4 && JSON.stringify(JSON.parse(a1.p_answer))!==JSON.stringify(ITEMS) && a1.p_tests_total===4);
  ok("mostra quantos passos estão na posição certa, sem revelar quais", /\d de 4 passos já estão na posição certa/.test(await main(p)));
  // monta a ordem certa só com o teclado
  for(let alvo=0;alvo<ITEMS.length;alvo++){
    let atual=(await ordem()).indexOf(ITEMS[alvo]);
    while(atual>alvo){
      await p.getByRole("button",{name:new RegExp("^Mover para cima: "+ITEMS[alvo])}).focus(); await p.keyboard.press("Space");
      atual--;
    }
  }
  ok("a ordem certa foi montada só com o teclado", (await ordem()).join()===ITEMS.join());
  await p.getByRole("button",{name:"Verificar ordem"}).focus(); await p.keyboard.press("Enter");
  await p.waitForSelector("text=Ordem correta!");
  ok("ordem certa: explicação, acerto e XP gravados", (await main(p)).includes("A ordem importa.") && st.attempts.at(-1).p_tests_passed===4 && JSON.stringify(JSON.parse(st.attempts.at(-1).p_answer))===JSON.stringify(ITEMS) && st.progress.at(-1).solved===true);
  ok("sem erros de página (ordenação)", errs.length===0);

  // ---- corrigir o erro + solução comentada
  const n2=st.attempts.length;
  await p.goto(BASE+"/exercicio/fix1"); await p.waitForSelector(".cm-content");
  ok("corrigir mostra o aviso e o código com defeito", (await main(p)).includes("tem um defeito") && (await p.locator(".cm-content").innerText()).includes("n + 2"));
  ok("a solução comentada não aparece antes de acertar", await p.getByRole("button",{name:"Ver solução comentada"}).count()===0);
  await runCode(p); await p.waitForSelector("text=esperado 6");
  ok("código com defeito reprova com esperado e recebido", (await main(p)).includes("recebido 5") && st.attempts[n2].p_error_category==="saida_incorreta" && st.attempts[n2].p_tests_passed===0);
  await typeCode(p,0,"function dobro(n) {\n  return n * 2;\n}"); await runCode(p);
  await p.waitForSelector("text=Todos os testes passaram");
  ok("corrigido: passa e registra o acerto", st.attempts.at(-1).p_passed===true);
  await p.getByRole("button",{name:"Ver solução comentada"}).click();
  await p.waitForSelector("text=Uma solução possível");
  const sol=await main(p);
  ok("solução comentada mostra o código e o comentário", sol.includes("return n * 2") && sol.includes("o dobro é n * 2"));

  // ---- segurança do executor
  const tenta=async(code,espera)=>{ await typeCode(p,0,code); await runCode(p); await p.waitForSelector(espera,{timeout:9000}); return main(p); };
  const n3=st.attempts.length;
  let t=await tenta("function dobro(n){ return fetch('https://example.com'); }","text=fetch não é permitido");
  ok("fetch (rede) é bloqueado", t.includes("fetch não é permitido") && st.attempts.at(-1).p_error_category==="execucao");
  t=await tenta("function dobro(n){ postMessage({ out: [{ received: 6 }, { received: 10 }] }); return 0; }","text=postMessage não é permitido");
  ok("não dá para forjar o resultado com postMessage", t.includes("postMessage não é permitido") && st.attempts.at(-1).p_passed===false && !t.includes("Todos os testes passaram"));
  t=await tenta("function dobro(n){ return import('https://example.com/x.js'); }","text=não é permitido nos exercícios");
  ok("import dinâmico é bloqueado antes de executar", st.attempts.at(-1).p_error_category==="execucao");
  t=await tenta("function dobro(n){ return document.title.length; }","text=document is not defined");
  ok("document/window não existem no isolamento", /document is not defined/.test(t));
  t=await tenta("function dobro(n){ while(true){} }","text=Tempo esgotado");
  ok("laço infinito: tempo esgotado sem travar a página", st.attempts.at(-1).p_error_category==="tempo");
  ok("as 5 tentativas de ataque foram registradas", st.attempts.length===n3+5);
  ok("sem erros de página (corrigir e segurança)", errs.length===0);

  // ---- entrada e saída (desafio)
  const n4=st.attempts.length;
  await p.goto(BASE+"/exercicio/io1"); await p.waitForSelector(".cm-content");
  ok("desafio aparece com o rótulo do tipo", (await main(p)).includes("Desafio"));
  await typeCode(p,0,"function saudacao() {\n  const nome = lerEntrada();\n  console.log('Oi, ' + nome);\n}"); await runCode(p);
  await p.waitForSelector("text=saída esperada");
  t=await main(p);
  ok("mostra entradas simuladas, saída esperada e saída obtida", t.includes('entradas: "Ana"') && t.includes('saída esperada: ["Olá, Ana!"]') && t.includes('saída obtida: ["Oi, Ana"]'));
  ok("saída errada é registrada como saída incorreta", st.attempts[n4].p_error_category==="saida_incorreta" && st.attempts[n4].p_tests_passed===0 && st.attempts[n4].p_tests_total===2);
  await typeCode(p,0,"function saudacao() {\n  const nome = lerEntrada();\n  console.log(`Olá, ${nome}!`);\n}"); await runCode(p);
  await p.waitForSelector("text=Todos os testes passaram");
  ok("saída certa passa", st.attempts.at(-1).p_passed===true && st.attempts.at(-1).p_tests_passed===2);
  await typeCode(p,0,"function saudacao() {\n  for (let i = 0; i < 100000; i++) console.log('x');\n}"); await runCode(p);
  await p.waitForSelector("text=saída esperada",{timeout:9000});
  ok("saída gigante é cortada e a página continua respondendo", (await main(p)).includes("saída obtida"));
  await p.goto(BASE+"/exercicio/io2"); await p.waitForSelector(".cm-content");
  await typeCode(p,0,"function especiais() {\n  console.log(0 / 0);\n  console.log(1 / 0);\n  console.log(-1 / 0);\n  console.log(0 / 0, 5);\n}"); await runCode(p);
  await p.waitForSelector("text=Todos os testes passaram",{timeout:9000});
  ok("console.log mostra NaN, Infinity e -Infinity como o console real (e não como null)", true);
  ok("sem erros de página (desafio)", errs.length===0);
}

// ===================== PROFESSOR: editor dos tipos novos =====================
{
  const {p,st,errs}=await newCtx("professor");
  const novo=async(tipo)=>{ await p.goto(BASE+"/professor/exercicios/novo"); await p.waitForSelector("text=Tipo de exercício",{timeout:12000}); await p.getByRole("radio",{name:new RegExp("^"+tipo)}).check(); };
  const comum=async(titulo)=>{ await p.getByLabel("Título",{exact:true}).fill(titulo); await p.getByLabel("Enunciado",{exact:true}).fill("Enunciado de teste."); };

  // interpretação
  await novo("Interpretação de código"); await comum("Interpretar x");
  ok("editor de interpretação pede o trecho de código e as alternativas", (await main(p)).includes("Trecho de código") && (await main(p)).includes("Alternativas"));
  await p.getByRole("button",{name:"Salvar como rascunho"}).click();
  await p.waitForSelector("text=Escreva o trecho de código");
  ok("incompleto: lista o que falta (trecho, alternativas, gabarito)", (await main(p)).includes("Marque qual alternativa é a correta") && st.posts.length===0);
  await p.getByLabel(/Trecho de código/).fill("let x = 2;\nconsole.log(x * 2);");
  await p.getByLabel("Texto da alternativa 1").fill("2");
  await p.getByLabel("Texto da alternativa 2").fill("4");
  await p.getByLabel("Alternativa 2 é a correta").check();
  await p.getByLabel(/Confusão que a alternativa 1 revela/).fill("imprime o valor sem multiplicar");
  await p.getByRole("button",{name:"Salvar como rascunho"}).click();
  await p.waitForSelector("text=Exercícios",{timeout:8000});
  const i=st.posts[0];
  ok("gravou kind=interpretation com o trecho e as alternativas com confusão", i.kind==="interpretation" && i.config.code==="let x = 2;\nconsole.log(x * 2);" && i.config.correct===1 && JSON.stringify(i.config.options)===JSON.stringify([{text:"2",misconception:"imprime o valor sem multiplicar"},{text:"4"}]) && i.function_name===null && i.tests.length===0 && i.published===false);

  // ordenação
  await novo("Ordenação"); await comum("Ordenar passos");
  ok("editor de ordenação começa com 2 passos e botões de mover", await p.getByLabel(/^Passo \d$/).count()===2);
  await p.getByLabel("Passo 1",{exact:true}).fill("Abrir a porta"); await p.getByLabel("Passo 2",{exact:true}).fill("Entrar");
  await p.getByRole("button",{name:"+ Adicionar passo"}).click();
  await p.getByLabel("Passo 3",{exact:true}).fill("Fechar a porta");
  await p.getByRole("button",{name:"Mover o passo 3 para cima"}).click();
  ok("mover passo reordena os campos", (await p.getByLabel("Passo 2",{exact:true}).inputValue())==="Fechar a porta" && (await p.getByLabel("Passo 3",{exact:true}).inputValue())==="Entrar");
  await p.getByRole("button",{name:"Mover o passo 2 para baixo"}).click();
  await p.getByLabel("Passo 2",{exact:true}).fill("Entrar"); await p.getByLabel("Passo 3",{exact:true}).fill("Entrar");
  await p.getByRole("button",{name:"Salvar como rascunho"}).click();
  await p.waitForSelector("text=Há passos repetidos");
  ok("passos repetidos são recusados com mensagem clara", st.posts.length===1);
  await p.getByLabel("Passo 3",{exact:true}).fill("Fechar a porta");
  await p.getByRole("button",{name:"Salvar como rascunho"}).click();
  await p.waitForSelector("text=Exercícios",{timeout:8000});
  const o=st.posts[1];
  ok("gravou kind=order com os passos na ordem certa", o.kind==="order" && JSON.stringify(o.config.items)===JSON.stringify(["Abrir a porta","Entrar","Fechar a porta"]) && o.function_name===null);

  // corrigir o erro
  await novo("Corrigir o erro"); await comum("Corrigir dobro");
  ok("editor de corrigir pede o código com defeito", (await main(p)).includes("Código com defeito"));
  await p.getByLabel("Nome da função").fill("dobro"); await p.getByLabel(/^Parâmetros/).fill("n");
  await p.getByLabel("Entradas do teste 1").fill("3"); await p.getByLabel("Resultado esperado do teste 1").fill("6");
  await typeCode(p,0,"function dobro(n) {\n  return n * 2;\n}");
  await typeCode(p,1,"function dobro(n) {\n  return n * 2;\n}");
  await p.getByRole("button",{name:/Validar testes/}).click();
  await p.waitForSelector("text=já passa em todos os testes");
  ok("código com defeito que já passa nos testes é recusado", (await main(p)).includes("os testes precisam reprovar o código com defeito") && await p.getByRole("button",{name:"Salvar e publicar"}).isDisabled());
  await typeCode(p,0,"function dobro(n) {\n  return n + 2;\n}");
  await p.getByRole("button",{name:/Validar testes/}).click();
  await p.waitForSelector("text=Testes validados");
  ok("com defeito de verdade e solução que passa: libera publicar", await p.getByRole("button",{name:"Salvar e publicar"}).isEnabled());
  await p.getByRole("button",{name:"Salvar e publicar"}).click();
  await p.waitForSelector("text=Exercícios",{timeout:8000});
  const f=st.posts[2];
  ok("gravou kind=fix com o código com defeito e os testes", f.kind==="fix" && f.function_name==="dobro" && f.starter_code.includes("n + 2") && JSON.stringify(f.tests)===JSON.stringify([{args:[3],expected:6}]) && f.published===true);
  ok("a solução de referência não é enviada ao banco", !JSON.stringify(f).includes("n * 2"));

  // desafio com entrada e saída
  await novo("Desafio"); await comum("Saudar");
  await p.getByLabel("Nome da função").fill("saudacao");
  await p.getByLabel("Entradas do teste 1").fill("");
  await p.locator("summary:has-text('Entrada e saída')").first().click();
  await p.getByLabel("Entradas simuladas do teste 1").fill('"Ana"');
  await p.getByLabel("Saída impressa esperada do teste 1").fill("Olá, Ana!");
  await typeCode(p,0,"function saudacao() {\n  console.log(`Olá, ${lerEntrada()}!`);\n}");
  await p.getByRole("button",{name:/Validar testes/}).click();
  await p.waitForSelector("text=Testes validados");
  ok("teste só com saída impressa valida sem resultado esperado", true);
  await p.getByRole("button",{name:"Salvar como rascunho"}).click();
  await p.waitForSelector("text=Exercícios",{timeout:8000});
  const d=st.posts[3];
  ok("gravou kind=challenge com entradas simuladas e saída esperada (sem 'expected')", d.kind==="challenge" && JSON.stringify(d.tests)===JSON.stringify([{args:[],inputs:["Ana"],output:["Olá, Ana!"]}]));
  ok("sem erros de página (professor)", errs.length===0);
}

await b.close();
console.log(failed?`${failed} FALHA(S)`:"TODOS OS FLUXOS OK");
process.exit(failed?1:0);

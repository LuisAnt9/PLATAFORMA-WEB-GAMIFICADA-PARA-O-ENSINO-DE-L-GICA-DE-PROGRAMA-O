// E15: execução segura de código do aluno. Complementa os testes da E3 (fetch, postMessage, import, document, laço infinito).
import { BASE, launch } from "./helpers.mjs";
const b = await launch();
const b64=o=>Buffer.from(JSON.stringify(o)).toString("base64url");
const uid="11111111-1111-1111-1111-111111111111";
const jwt=`${b64({alg:"HS256",typ:"JWT"})}.${b64({sub:uid,role:"authenticated",exp:4102444800})}.sig`;
const session={access_token:jwt,refresh_token:"r",token_type:"bearer",expires_in:3600,expires_at:4102444800,user:{id:uid,aud:"authenticated",role:"authenticated",email:"x@x.com",app_metadata:{},user_metadata:{},created_at:"2026-01-01T00:00:00Z"}};
let failed=0; const ok=(n,c)=>{console.log((c?"✓ ":"✗ FALHOU: ")+n); if(!c) failed++;};
const ex={id:"c1",module_id:"m1",kind:"code",lesson:null,title:"Dobro",difficulty:"facil",statement:"d",function_name:"dobro",starter_code:"function dobro(n) {\n}\n",tests:[{args:[3],expected:6}],config:{},hint:"",position:1,published:true};
const ctx=await b.newContext({viewport:{width:1000,height:1100}});
await ctx.addInitScript(s=>localStorage.setItem("sb-shmdjhfleduxefoodrfm-auth-token",JSON.stringify(s)),session);
const hits=[];
await ctx.route("**/*", async route=>{
  const u=route.request().url();
  if(!u.startsWith("http://localhost") && !u.includes(".supabase.co")){ hits.push(u); return route.abort(); } // qualquer saída para a internet é registrada e barrada
  return route.fallback();
});
await ctx.route("**/*.supabase.co/**", async route=>{
  const req=route.request(), u=req.url(), m=req.method();
  const json=(body,code=200)=>route.fulfill({status:code,contentType:"application/json",headers:{"access-control-allow-origin":"*"},body:JSON.stringify(body)});
  if(m==="OPTIONS") return route.fulfill({status:204,headers:{"access-control-allow-origin":"*","access-control-allow-headers":"*","access-control-allow-methods":"*"}});
  if(u.includes("/rest/v1/modules")) return json([{id:"m1",title:"Lição",focus:"F",position:1}]);
  if(u.includes("/rest/v1/exercises")) return json([ex]);
  if(u.includes("/rest/v1/profiles")) return json({id:uid,name:"Luis A",role:"aluno"});
  if(u.includes("/rpc/record_attempt")) return json(1);
  return json([]);
});
const p=await ctx.newPage(); const errs=[]; p.on("pageerror",e=>errs.push(e.message));
const main=()=>p.locator("main").innerText();
const typeCode=async code=>{ await p.locator(".cm-content").first().click(); await p.keyboard.press("Control+A"); await p.keyboard.insertText(code); };
const run=async()=>{ await p.locator(".cm-content").first().focus(); await p.keyboard.press("Control+Enter"); };
await p.goto(BASE+"/exercicio/c1"); await p.waitForSelector(".cm-content");

const tenta=async(code,espera,timeout=9000)=>{ await typeCode(code); await run(); await p.waitForSelector(espera,{timeout}); return main(); };
let t=await tenta("function dobro(n){ return new XMLHttpRequest().open('GET','https://example.com'); }","text=/não é permitido|not defined|XMLHttpRequest/i");
ok("XMLHttpRequest não existe no isolamento", /XMLHttpRequest/.test(t));
t=await tenta("function dobro(n){ return new WebSocket('wss://example.com'); }","text=WebSocket");
ok("WebSocket não existe no isolamento", /WebSocket/.test(t));
t=await tenta("function dobro(n){ return globalThis.fetch('https://example.com'); }","text=fetch não é permitido");
ok("globalThis.fetch também é bloqueado", /fetch não é permitido/.test(t));
t=await tenta("function dobro(n){ return self.fetch('https://example.com'); }","text=fetch não é permitido");
ok("self.fetch também é bloqueado", /fetch não é permitido/.test(t));
t=await tenta("function dobro(n){ importScripts('https://example.com/x.js'); return 1; }","text=não é permitido");
ok("importScripts é bloqueado", /não é permitido/.test(t));
t=await tenta("function dobro(n){ return (new Function('return fetch(\"https://example.com\")'))(); }","text=fetch não é permitido");
ok("new Function não recupera o fetch original", /fetch não é permitido/.test(t));
t=await tenta("function dobro(n){ return (async()=>{}).constructor('return fetch(\"https://example.com\")')(); }","text=/fetch não é permitido|Erro|erro/i");
ok("o construtor de função assíncrona também não escapa", !/Todos os testes passaram/.test(t));
t=await tenta("function dobro(n){ return localStorage.getItem('x'); }","text=localStorage");
ok("localStorage (dados do site) não existe no isolamento", /localStorage/.test(t));
t=await tenta("function dobro(n){ return navigator.sendBeacon('https://example.com', 'x'); }","text=/sendBeacon|não é permitido|erro|Erro/i");
ok("sendBeacon não envia nada para fora", !/Todos os testes passaram/.test(t));

// saída gigante: o executor limita as linhas e a página continua respondendo
const t0=Date.now();
t=await tenta("function dobro(n){ for(let i=0;i<200000;i++){ console.log('linha '+i); } return n*2; }","text=/Todos os testes passaram|Tempo esgotado/i",12000);
ok("saída enorme: a página não trava e responde em poucos segundos", Date.now()-t0<12000);
ok("a saída mostrada é limitada (não despeja centenas de milhares de linhas)", (await p.locator("main").innerText()).split("\n").length<2000);
// memória: um array enorme não derruba a aba
t=await tenta("function dobro(n){ const a=[]; while(true){ a.push(new Array(1e6).fill(1)); } }","text=/Tempo esgotado|Erro|erro|memória/i",15000);
ok("consumo de memória sem fim é interrompido e a página continua viva", (await p.locator(".cm-content").count())===1);
// depois de tudo, um código normal ainda funciona
t=await tenta("function dobro(n){ return n * 2; }","text=Todos os testes passaram");
ok("depois dos ataques, código normal volta a funcionar", /Todos os testes passaram/.test(t));
ok("nenhuma requisição saiu para a internet", hits.length===0);
// uma promessa rejeitada dentro do isolamento (o fetch bloqueado) aparece como erro do worker: é o bloqueio funcionando
ok("sem erros de página além dos bloqueios esperados", errs.every(e=>/não é permitido/.test(e)));

await b.close();
console.log(failed?`${failed} FALHA(S)`:"TODOS OS FLUXOS OK");
process.exit(failed?1:0);

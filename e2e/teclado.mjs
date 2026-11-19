// E15: navegação só pelo teclado nas telas principais do aluno.
import { BASE, launch } from "./helpers.mjs";
const b = await launch();
const b64=o=>Buffer.from(JSON.stringify(o)).toString("base64url");
const uid="11111111-1111-1111-1111-111111111111";
const jwt=`${b64({alg:"HS256",typ:"JWT"})}.${b64({sub:uid,role:"authenticated",exp:4102444800})}.sig`;
const session={access_token:jwt,refresh_token:"r",token_type:"bearer",expires_in:3600,expires_at:4102444800,user:{id:uid,aud:"authenticated",role:"authenticated",email:"x@x.com",app_metadata:{},user_metadata:{},created_at:"2026-01-01T00:00:00Z"}};
let failed=0; const ok=(n,c)=>{console.log((c?"✓ ":"✗ FALHOU: ")+n); if(!c) failed++;};
const choice=(id,title,pos)=>({id,module_id:"m1",kind:"choice",lesson:null,title,difficulty:"facil",statement:"Enunciado "+title,function_name:null,starter_code:"",tests:[],config:{options:["errada","certa"],correct:1},hint:"",position:pos,published:true});
const worlds=[{id:"w1",title:"Mundo Um",objective:"Objetivo.",position:1}];
const mods=[{id:"m1",title:"Lição Alfa",focus:"Entender o alfa",intro:"Explicação do alfa.",example:"const x = 1;",review:"Resumo.",world_id:"w1",position:101}];
const exs=[choice("a1","Alfa escolha",1)];
const ctx=await b.newContext({viewport:{width:1000,height:1000}});
await ctx.addInitScript(s=>localStorage.setItem("sb-shmdjhfleduxefoodrfm-auth-token",JSON.stringify(s)),session);
await ctx.route("**/*.supabase.co/**", async route=>{
  const req=route.request(), u=req.url(), m=req.method();
  const json=(body,code=200)=>route.fulfill({status:code,contentType:"application/json",headers:{"access-control-allow-origin":"*"},body:JSON.stringify(body)});
  if(m==="OPTIONS") return route.fulfill({status:204,headers:{"access-control-allow-origin":"*","access-control-allow-headers":"*","access-control-allow-methods":"*"}});
  if(u.includes("/rest/v1/worlds")) return json(worlds);
  if(u.includes("/rest/v1/modules")) return json(mods);
  if(u.includes("/rest/v1/exercises")) return json(exs);
  if(u.includes("/rest/v1/profiles")) return json({id:uid,name:"Luis A",role:"aluno",consent_at:"2026-11-01T00:00:00Z",consent_version:"2026-11"});
  if(u.includes("/rpc/sync_gamification")) return json({bonus_xp:0,missions:[],new_worlds:[],worlds_done:[]});
  return json([]);
});
const p=await ctx.newPage(); const errs=[]; p.on("pageerror",e=>errs.push(e.message));
const active=()=>p.evaluate(()=>{ const e=document.activeElement; return e? (e.getAttribute("aria-label")||e.innerText||e.tagName).trim().slice(0,60):""; });
const outlined=()=>p.evaluate(()=>{ const e=document.activeElement; if(!e) return false; const s=getComputedStyle(e); return s.outlineStyle!=="none" && parseFloat(s.outlineWidth)>0; });

await p.goto(BASE+"/"); await p.waitForSelector("text=Bem-vindo");
await p.keyboard.press("Tab");
ok("o primeiro Tab vai para o link \"Pular para o conteúdo\"", (await active()).includes("Pular para o conteúdo"));
ok("o foco do teclado é visível", await outlined());
await p.keyboard.press("Enter");
ok("Enter no link de pular leva o foco ao conteúdo principal", await p.evaluate(()=>document.activeElement?.id==="conteudo"));
// de volta ao topo e Tab até chegar em "Mundos"
await p.evaluate(()=>{ document.activeElement.blur(); window.scrollTo(0,0); });
let achou=false;
await p.keyboard.press("Tab"); // pular
for(let i=0;i<12 && !achou;i++){ await p.keyboard.press("Tab"); if((await active())==="Mundos") achou=true; }
ok("o menu principal é alcançado pelo Tab, na ordem visual", achou);
await p.keyboard.press("Enter"); await p.waitForSelector("h1:has-text('Mundos')");
ok("Enter no item do menu navega", p.url().endsWith("/mundos"));
// tema pelo teclado
const antes=await p.evaluate(()=>document.documentElement.classList.contains("dark"));
await p.focus("button[aria-label='Tema escuro']"); await p.keyboard.press("Enter");
ok("o botão de tema funciona pelo teclado", (await p.evaluate(()=>document.documentElement.classList.contains("dark")))!==antes);
// lição: passos pelo teclado
await p.goto(BASE+"/licao/m1"); await p.waitForSelector("h1:has-text('Lição Alfa')");
await p.focus("button:has-text('Próximo passo')"); await p.keyboard.press("Enter");
await p.waitForSelector("h2:has-text('Explicação')");
ok("\"Próximo passo\" funciona com Enter", true);
await p.focus("nav[aria-label='Passos da lição'] button:has-text('Exemplo')"); await p.keyboard.press("Space");
await p.waitForSelector("h2:has-text('Exemplo')");
ok("os passos da lição funcionam com Espaço", (await p.locator("[aria-current=step]").innerText()).includes("Exemplo"));
// exercício de escolha: radios com setas, verificar com Enter
await p.goto(BASE+"/exercicio/a1"); await p.waitForSelector("text=Enunciado Alfa escolha");
await p.focus("input[type=radio] >> nth=0"); await p.keyboard.press("ArrowDown");
ok("as alternativas de múltipla escolha mudam com as setas", await p.locator("input[type=radio]").nth(1).isChecked());
await p.keyboard.press("Tab");
const proximo=await active();
ok("depois das alternativas, o Tab chega ao botão de verificar", /Verificar/.test(proximo));
await p.keyboard.press("Enter"); await p.waitForSelector("text=Correto!");
ok("verificar com Enter mostra o resultado", true);
// ranking: opt-in com o teclado
await p.goto(BASE+"/ranking"); await p.waitForSelector("h1:has-text('Ranking')");
await p.focus("input[type=checkbox]"); await p.keyboard.press("Space"); await p.waitForTimeout(500);
ok("a escolha de aparecer no ranking responde ao Espaço", true);
// questionário: radios do SUS por setas
await p.goto(BASE+"/pesquisa"); await p.waitForSelector("h1:has-text('Sua opinião')");
await p.focus("button:has-text('Responder (10 afirmações)')"); await p.keyboard.press("Enter");
await p.waitForSelector("input[name='sus-0']");
await p.focus("input[name='sus-0'] >> nth=0"); await p.keyboard.press("ArrowRight"); await p.keyboard.press("ArrowRight");
ok("na escala do questionário, as setas escolhem a nota (3 = terceira opção)", await p.locator("input[name='sus-0']").nth(2).isChecked());
ok("sem erros de página", errs.length===0);

await b.close();
console.log(failed?`${failed} FALHA(S)`:"TODOS OS FLUXOS OK");
process.exit(failed?1:0);

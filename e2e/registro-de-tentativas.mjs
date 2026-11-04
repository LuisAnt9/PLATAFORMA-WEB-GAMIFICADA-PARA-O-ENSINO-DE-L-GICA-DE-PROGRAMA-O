import { BASE, launch } from "./helpers.mjs";
const b = await launch();
const b64=o=>Buffer.from(JSON.stringify(o)).toString("base64url");
const uid="11111111-1111-1111-1111-111111111111";
const jwt=`${b64({alg:"HS256",typ:"JWT"})}.${b64({sub:uid,role:"authenticated",exp:4102444800})}.sig`;
const session={access_token:jwt,refresh_token:"r",token_type:"bearer",expires_in:3600,expires_at:4102444800,user:{id:uid,aud:"authenticated",role:"authenticated",email:"x@x.com",app_metadata:{},user_metadata:{},created_at:"2026-01-01T00:00:00Z"}};
let failed=0; const ok=(n,c)=>{console.log((c?"✓ ":"✗ FALHOU: ")+n); if(!c) failed++;};

const exs=[{id:"soma",module_id:"m1",kind:"code",lesson:null,title:"Somar",difficulty:"facil",statement:"Some a e b.",function_name:"soma",starter_code:"function soma(a,b){}",tests:[{args:[2,3],expected:5},{args:[1,1],expected:2}],config:{},hint:"",position:1,published:true}];
const mods=[{id:"m1",title:"Fundamentos",focus:"F",intro:"",position:1}];

const ctx=await b.newContext({viewport:{width:1000,height:1000}});
await ctx.addInitScript(s=>localStorage.setItem("sb-shmdjhfleduxefoodrfm-auth-token",JSON.stringify(s)),session);
const attempts=[]; let failRecording=false;
await ctx.route("**/*.supabase.co/**", async route=>{
  const req=route.request(), u=req.url(), m=req.method();
  const json=(body,code=200)=>route.fulfill({status:code,contentType:"application/json",headers:{"access-control-allow-origin":"*"},body:JSON.stringify(body)});
  if(m==="OPTIONS") return route.fulfill({status:204,headers:{"access-control-allow-origin":"*","access-control-allow-headers":"*","access-control-allow-methods":"*"}});
  if(u.includes("/rest/v1/modules")) return json(mods);
  if(u.includes("/rest/v1/exercises")) return json(exs);
  if(u.includes("/rest/v1/profiles")) return json({id:uid,name:"Luis A",role:"aluno"});
  if(u.includes("/rpc/record_attempt")){ if(failRecording) return json({code:"42883",message:"function public.record_attempt does not exist"},404); attempts.push(JSON.parse(req.postData())); return json(1); }
  if(u.includes("/rest/v1/exercise_progress")){ if(m!=="GET") return route.fulfill({status:201,headers:{"access-control-allow-origin":"*"},body:""}); return json([]); }
  if(u.includes("/rest/v1/daily_activity")) return json([]);
  return json([]);
});
const p=await ctx.newPage(); const errs=[]; p.on("pageerror",e=>errs.push(e.message));
const run=async code=>{ await p.click(".cm-content"); await p.keyboard.press("Control+A"); await p.keyboard.insertText(code); await p.keyboard.press("Control+Enter"); };

await p.goto(BASE+"/exercicio/soma"); await p.waitForSelector(".cm-content",{timeout:12000});

await run("function soma(a,b){return a+");
await p.waitForSelector("text=Erro no código");
ok("erro de sintaxe: categoria 'sintaxe', nenhum teste rodou", attempts.length===1 && attempts[0].p_error_category==="sintaxe" && attempts[0].p_tests_passed===0 && attempts[0].p_tests_total===2 && attempts[0].p_passed===false);

await run("function soma(a,b){return naoExiste+1}");
await p.waitForSelector("text=erro:");
ok("erro lançado nos testes: categoria 'execucao'", attempts.length===2 && attempts[1].p_error_category==="execucao");

await run("function soma(a,b){return a-b}");
await p.waitForSelector("text=esperado");
ok("valor errado: categoria 'saida_incorreta' com contagem de testes", attempts.length===3 && attempts[2].p_error_category==="saida_incorreta" && attempts[2].p_tests_passed===0 && attempts[2].p_tests_total===2);

await run("function soma(a,b){while(true){}}");
await p.waitForSelector("text=Tempo esgotado",{timeout:8000});
ok("laço infinito: categoria 'tempo'", attempts.length===4 && attempts[3].p_error_category==="tempo");

await run("function soma(a,b){return a+b}");
await p.waitForSelector("text=Todos os testes passaram",{timeout:8000});
ok("acerto: sem categoria, todos os testes, código enviado", attempts.length===5 && attempts[4].p_passed===true && attempts[4].p_error_category===null && attempts[4].p_tests_passed===2 && attempts[4].p_answer.includes("return a+b"));
ok("tempo de cada tentativa registrado", attempts.every(a=>Number.isInteger(a.p_duration_ms) && a.p_duration_ms>=0));
ok("tudo na modalidade livre", attempts.every(a=>a.p_mode==="livre"));

// banco sem a migration: o aluno nem percebe
failRecording=true;
await run("function soma(a,b){return a*b}");
await p.waitForSelector("text=esperado");
ok("sem a função no banco, a correção continua normal e sem erro na tela", !(await p.locator("main [role=alert]").count()) && errs.length===0);

await b.close();
console.log(failed?`${failed} FALHA(S)`:"TODOS OS FLUXOS OK");
process.exit(failed?1:0);

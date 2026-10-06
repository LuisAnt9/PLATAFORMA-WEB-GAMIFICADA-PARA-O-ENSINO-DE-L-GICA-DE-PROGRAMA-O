# Lógica Gamificada

Plataforma web gamificada para o ensino de lógica de programação (TCC — IFPI Campus Picos, ADS).

## Rodando localmente

```bash
npm install
cp .env.example .env.local   # preencha com a URL e a chave publishable do Supabase
npm run dev                  # http://localhost:3000
```

### Banco de dados (Supabase)

1. Crie um projeto no Supabase (plano Free).
2. No **SQL Editor**, execute `supabase/migrations/0001_init.sql`.
3. Em **Authentication → Sign In / Providers → Email**, desative *Confirm email* durante o piloto
   (o envio de e-mails do plano gratuito tem limite baixo por hora).
4. Todo cadastro novo é **aluno**. Para promover um professor, no SQL Editor:

```sql
update public.profiles set role = 'professor'
where id = (select id from auth.users where email = 'professor@exemplo.com');
```

Use somente a chave **publishable**; a `secret`/`service_role` nunca deve ir ao código nem ao navegador.

Outros comandos: `npm run lint`, `npm test`, `npm run build`.

## Estado atual

- Trilha de 17 exercícios em JavaScript, organizada em 4 módulos (`src/lib/exercises.ts`).
- Correção automática no navegador, em Web Worker com limite de 2 s (`src/lib/runner.ts`).
- Feedback imediato por caso de teste.
- Gamificação: XP, níveis e medalhas (`src/lib/gamification.ts`). Cada medalha declara a dificuldade de aprendizagem a que responde.
- Editor com destaque de sintaxe (CodeMirror) e atalho Ctrl+Enter.
- Testes automatizados (Vitest): regras de gamificação e validação de todos os exercícios contra soluções de referência.
- Cadastro e login (Supabase Auth); progresso por usuário no Postgres com RLS (`supabase/migrations`).

## Próximos passos

1. Ranking e perfil do aluno.
2. Verificação de acertos no servidor (hoje o código roda no navegador).
3. Painel do professor (criar exercícios, acompanhar a turma).
4. Questionários SUS e Likert para a avaliação.

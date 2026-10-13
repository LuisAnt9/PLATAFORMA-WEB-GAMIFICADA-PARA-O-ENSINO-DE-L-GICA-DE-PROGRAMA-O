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
2. No **SQL Editor**, execute, em ordem, os arquivos de `supabase/migrations/` (`0001_init.sql` a `0005_exercise_kinds.sql`).
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

- Trilha de exercícios em JavaScript organizada em módulos, **carregada do banco** (`modules`/`exercises`). A migration 0003 traz os 17 exercícios iniciais.
- Correção automática no navegador, em Web Worker com limite de 2 s (`src/lib/runner.ts`).
- Feedback imediato por caso de teste.
- Gamificação: XP, níveis e medalhas (`src/lib/gamification.ts`). Cada medalha declara a dificuldade de aprendizagem a que responde.
- Editor com destaque de sintaxe (CodeMirror) e atalho Ctrl+Enter.
- Turmas: o professor cria a turma e recebe um código de 6 caracteres; o aluno entra pelo Perfil. O professor só enxerga alunos das próprias turmas (RLS).
- Área do professor (`/professor`): turmas, código de entrada e tabela de desempenho dos alunos.
- Análise da turma (`/professor/turmas/[id]`): visão geral (alunos ativos, conclusão média, alertas de inatividade e de alunos travados, gráfico de resolvidos por dia), grade aluno × exercício e estatísticas por exercício (taxa de acerto, tentativas, mais difíceis).
- Três tipos de exercício: **código** (testes em JavaScript), **múltipla escolha** e **completar a lacuna**, cada um com mini-explicação opcional ("Antes de começar") e explicação ao acertar.
- **Sequência diária** (streak) e medalhas de constância, em `daily_activity` (migration 0004).
- Editor de exercícios (`/professor/exercicios`): criar/editar com testes em JSON, validar com uma solução de referência (não salva) antes de publicar, rascunho, despublicar, reordenar e gerenciar módulos.
- Testes automatizados (Vitest): regras de gamificação, políticas de acesso do banco (PGlite) e validação dos exercícios da migration contra soluções de referência.
- Ranking anonimizado (nome abreviado) e página de perfil com estatísticas, medalhas e histórico.
- Cadastro e login (Supabase Auth); progresso por usuário no Postgres com RLS (`supabase/migrations`).

## Próximos passos

1. Questionários SUS e Likert dentro da plataforma e exportação dos dados (CSV) para a avaliação.
2. Verificação de acertos no servidor (hoje a correção roda no navegador e as respostas ficam legíveis).
3. Rotina para manter o projeto Supabase ativo (o plano gratuito pausa após ~7 dias sem uso).
4. Passada de design e acessibilidade.

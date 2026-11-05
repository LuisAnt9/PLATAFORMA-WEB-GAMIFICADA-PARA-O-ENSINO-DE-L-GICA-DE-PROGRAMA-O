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
2. No **SQL Editor**, para um projeto novo, cole e rode o arquivo único `supabase/setup-completo.sql` (gerado por `npm run db:bundle`). Ou execute, em ordem, os arquivos de `supabase/migrations/` (`0001_init.sql` a `0007_ping.sql`).
3. Em **Authentication → Sign In / Providers → Email**, desative *Confirm email* durante o piloto
   (o envio de e-mails do plano gratuito tem limite baixo por hora).
4. Todo cadastro novo é **aluno**. Para promover um professor, no SQL Editor:

```sql
update public.profiles set role = 'professor'
where id = (select id from auth.users where email = 'professor@exemplo.com');
```

Use somente a chave **publishable**; a `secret`/`service_role` nunca deve ir ao código nem ao navegador.

Outros comandos: `npm run lint`, `npm test`, `npm run build`, `npm run e2e` (testes de fluxo e acessibilidade; veja `e2e/README.md`).

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
- 31 exercícios extras prontos como **rascunho** (migration 0006), em 7 módulos; as soluções dos de código estão em `docs/gabarito-exercicios-extras.md`.
- Editor de exercícios (`/professor/exercicios`): criar/editar com testes em JSON, validar com uma solução de referência (não salva) antes de publicar, rascunho, despublicar, reordenar e gerenciar módulos.
- Testes automatizados (Vitest): regras de gamificação, políticas de acesso do banco (PGlite) e validação dos exercícios da migration contra soluções de referência.
- Ranking anonimizado (nome abreviado) e página de perfil com estatísticas, medalhas e histórico.
- Cadastro e login (Supabase Auth); progresso por usuário no Postgres com RLS (`supabase/migrations`).

- **Dica com IA (Gemini)**: botão "✨ Dica com IA" em cada exercício. Rota `/api/dica` no servidor (a chave `GEMINI_API_KEY` nunca vai ao navegador), pista sem a resposta pronta, limite de 10 dicas por aluno por dia e histórico em `ai_hints` (migration 0008) para a avaliação.

- **Modo aprendizado** (inspirado na trilha de conceitos do Exercism): os módulos abrem em ordem, resolvendo 70% de um para liberar o próximo; cada módulo tem um texto de "conceito" (migration 0009, editável pelo professor). O **modo prática** libera tudo; professores nunca têm bloqueio. A regra está em `src/lib/learning.ts`.

- **Base da análise pedagógica (migration 0010, etapa E1 do plano em `docs/plano/`)**: mundos (`worlds`) e lições, conceitos (`concepts`, `exercise_concepts`) e registro de **cada tentativa** em `attempts` (código enviado, testes aprovados, categoria do erro: sintaxe, execução, tempo ou saída incorreta; e, em múltipla escolha, a "confusão" da alternativa marcada). A escrita só ocorre por `record_attempt` (validada no servidor, máx. 60 por minuto) e o professor lê só os alunos das suas turmas.
  - *Tamanho no plano gratuito (500 MB):* cada tentativa ocupa cerca de 1 KB (a resposta é cortada em 4000 caracteres). 100 alunos × 500 tentativas ≈ 50 MB, então há folga para dezenas de milhares de tentativas por turma. Vale conferir o uso do banco no painel do Supabase a cada semestre.
  - As tentativas só existem **a partir da aplicação da migration**: não há histórico anterior.

- **Conteúdo em arquivos** (etapa E2): `content/` guarda mundos, conceitos, lições e exercícios (os 53 atuais, já ligados a conceitos e aos 7 mundos) e `content/solucoes/` as soluções de referência. `npm run content:check` valida tudo e `npm run content:build` gera `supabase/importar-conteudo.sql` (idempotente, colado no SQL Editor). A migration 0011 marca o que veio dos arquivos (`origem = 'arquivo'`) para o importador nunca sobrescrever o que o professor editou no painel. Veja `content/README.md`.

- **Tipos de exercício** (etapa E3): além de código, escolha e lacuna, há **interpretação de código**, **ordenação** (acessível pelo teclado), **corrigir o erro** e **desafio**. Exercícios de código podem ter **entrada simulada** (`lerEntrada()`) e **saída impressa** conferida (`console.log`). O executor roda isolado (sem rede, sem DOM, sem `import`, sem forjar o resultado). **Dicas em três níveis** (professor, conceito, IA) registradas nas tentativas e **solução comentada** liberada pelo banco só depois de acertar (migration 0012).

## Próximos passos

1. Questionários SUS e Likert dentro da plataforma e exportação dos dados (CSV) para a avaliação.
2. Verificação de acertos no servidor (hoje a correção roda no navegador e as respostas ficam legíveis).
3. (feito) Rotina diária que mantém o Supabase ativo: `.github/workflows/keep-alive.yml` + migration 0007.
4. (feito) Passada de design e acessibilidade: contraste, foco visível, alvos de toque de 44 px, link "pular para o conteúdo", títulos de página, cabeçalho adaptado ao celular, editor acessível com tema escuro e `prefers-reduced-motion`. Auditoria com axe-core em 60 combinações (telas × celular/computador × claro/escuro) sem violações.

# Especificação — Plataforma gamificada de ensino de lógica de programação

> Leia este arquivo inteiro antes de qualquer etapa. Ele vale para todas.

## 1. O que é

Plataforma web educacional, gamificada, para jovens e adultos iniciantes (inclusive quem nunca programou), com **JavaScript** como linguagem dos exercícios. Apoia o professor: turmas, atividades para casa, avaliações e, principalmente, **identificar quais conceitos os alunos ainda não compreenderam**.

Três pilares: **aprendizagem** (entender antes de programar), **engajamento** (gamificação sem ar infantil) e **acompanhamento pedagógico** (transformar erros em informação útil ao professor). Referências: a didática do modo aprendizado do Exercism e a gamificação do Duolingo, sem copiar interfaces.

## 2. Estado atual do projeto (não refazer)

Repositório: Next.js 16 (App Router), React 19, Tailwind v4, TypeScript, Supabase (Auth, Postgres com RLS, funções SECURITY DEFINER), Vercel, GitHub Actions. **Leia `AGENTS.md` e a documentação em `node_modules/next/dist/docs/` antes de escrever código: esta versão do Next.js tem mudanças.**

Já existe e funciona (preservar):
- Cadastro/login, perfis aluno/professor, progresso por exercício, XP, níveis, medalhas, sequência diária (streak), ranking, perfil.
- Exercícios do banco, com 3 tipos (código, múltipla escolha, completar lacuna), correção no navegador (Web Worker com limite de 2 s), dica do professor e **dica com IA (Gemini)** com limite diário.
- Módulos com texto de "conceito"; modo aprendizado (liberação por 70%) e modo prática.
- Turmas por código, análise da turma, grade aluno × exercício, editor de exercícios, rascunho/publicação.
- Visual limpo e profissional, acessibilidade auditada (axe) em celular/computador, claro/escuro.
- Testes: Vitest (unidade + banco com PGlite aplicando todas as migrations) e e2e (Playwright + axe) em `e2e/`.
- Migrations em `supabase/migrations/` (0001 a 0009); `npm run db:bundle` gera `supabase/setup-completo.sql`.

Restrições: orçamento **R$ 0** (Supabase Free, Vercel Hobby, GitHub Actions, Gemini gratuito), segurança por RLS, nunca expor chave `secret`/`service_role`, `.env.local` fora do git.

## 3. Regras de trabalho (todas as etapas)

1. **Incremental.** Não reescreva o que funciona. Migrations novas, nunca editar as aplicadas.
2. **Compatibilidade.** O site deve continuar funcionando se uma migration nova ainda não foi aplicada (padrão já usado: `select *`, colunas opcionais).
3. **Verifique antes de entregar:** `npm run lint`, `npx tsc --noEmit`, `npm test`, `npm run build` e `npm run e2e`, conferindo o código de saída de cada um. Para telas, rode a auditoria de acessibilidade.
4. **Todo código novo de banco tem teste** de políticas de acesso (aluno só vê o que é seu; professor só vê as próprias turmas).
5. **Conteúdo em português do Brasil**, linguagem simples, sem jargão sem explicar.
6. **Commits em português**, na branch indicada, sem criar pull request sem pedido.
7. Ao terminar, **pare**, resuma o que foi feito, o que foi verificado e o que depende de uma ação manual do usuário (por exemplo, rodar uma migration no Supabase).
8. Se algo da etapa conflitar com o que já existe, **pergunte** em vez de decidir sozinho.

## 4. Decisões já tomadas (alterar só se o usuário pedir)

| # | Decisão | Padrão adotado |
|---|---|---|
| D1 | Hierarquia | **Mundo > Lição > Exercício.** No banco, a tabela `modules` atual passa a ser a **lição** (ganha `world_id`); cria-se `worlds`. Na interface chama-se "Lição". Preserva o código existente. |
| D2 | Estrutura de uma lição | 7 passos: Introdução, Explicação e Exemplo (texto, campos `intro` e `example`), Interpretação (exercícios de ler código), Prática (exercícios progressivos), Desafio (1 por mundo, integrador), Revisão (campo `review`). |
| D3 | Liberação por domínio | Lição libera quando o aluno resolveu **70% dos exercícios** da anterior. Na E11 passa a considerar também o domínio dos conceitos. Modo prática libera tudo; professor nunca é bloqueado. |
| D4 | XP | Fácil 20, médio 35, difícil 50, desafio de lição 75, conclusão de mundo 150, missão diária 30. Bônus de 1ª tentativa mantido. XP já gravado não é recalculado. Sem XP repetido por reenviar exercício aprovado. |
| D5 | Entrada e saída | Entrada = parâmetros da função, ou lista de entradas simuladas; saída = valor retornado ou linhas do `console.log` capturadas. Nada de `prompt()`/DOM. |
| D6 | Correção e avaliações com nota | Exercícios de código são corrigidos no navegador (prática, **sem nota**). **Avaliações com nota** usam só tipos corrigidos no banco (múltipla escolha, lacuna, interpretação, ordenação), com o gabarito em tabela inacessível ao aluno. |
| D7 | Erros | O executor classifica código em: sintaxe, execução (ReferenceError, TypeError…), tempo esgotado, saída incorreta. "Conceitual" só existe em questões de escolha, onde cada alternativa errada traz a **confusão que revela** (campo `misconception`). |
| D8 | Mínimos estatísticos | Dificuldade de um aluno em um conceito só é afirmada com **≥ 3 tentativas em ≥ 2 exercícios** do conceito. Painel da turma só com **≥ 5 alunos**. Antes disso: "dados insuficientes". Nunca rotular um aluno como incapaz. |
| D9 | Dicas | Nível 1: dica escrita pelo professor. Nível 2: pista do conceito. Nível 3: dica com IA (já existe). Nunca entregar a solução. |
| D10 | Tema | Escuro como padrão para quem não tem preferência no sistema, com alternância claro/escuro. |
| D11 | Ranking | Opcional e **opt-in** por aluno, restrito à própria turma. |
| D12 | Avisos de prazo | Apenas dentro da plataforma (sem e-mail em massa). |
| D13 | Conteúdo | Escrito pelo Claude em arquivos versionados (`content/`), **revisado pelo professor** antes de publicar. Soluções de referência ficam em arquivo separado dos dados públicos (ver risco em E2). |
| D14 | Privacidade | Termo de consentimento no cadastro, possibilidade de exclusão dos dados, o aluno é avisado de que o código enviado à dica com IA vai ao Google. |

## 5. Currículo — sete mundos

Nomes descrevem o assunto (nada de nomes fantasiosos). Cada item numerado vira uma **lição**. Limite: lógica básica; **sem** DOM, APIs, frameworks, backend, orientação a objetos, assíncrono ou algoritmos avançados.

1. **Introdução à Lógica de Programação** (7 lições)
2. **Variáveis e Tipos de Dados** (13 lições)
3. **Operadores** (6 lições)
4. **Estruturas Condicionais** (9 lições)
5. **Estruturas de Repetição** (9 lições)
6. **Vetores e Matrizes** (12 lições)
7. **Funções e Modularização** (10 lições)

Os conteúdos exatos de cada mundo estão nas etapas E4 a E7 e E12 a E14.

## 6. Modelo pedagógico de dados (essencial)

O diferencial é saber **qual conceito** gera erro. Isso exige, desde a E1:
- Cada exercício ligado a **um ou mais conceitos** (`exercise_concepts`).
- Cada **tentativa** registrada (`attempts`), não só o melhor resultado.
- Cada alternativa errada de questão de escolha com **`misconception`** (a confusão que revela).
- Cada tentativa de código com a **categoria de erro** do executor.
- Cada tentativa com a **modalidade**: aprendizagem livre, atividade atribuída ou avaliação.

## 7. Fora do escopo

IA para classificar erros (a primeira versão usa regras), e-mails em massa, aplicativo nativo, execução de código dos alunos no servidor.

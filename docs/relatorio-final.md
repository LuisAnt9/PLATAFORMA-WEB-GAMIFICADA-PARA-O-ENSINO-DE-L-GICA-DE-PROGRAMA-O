# Relatório final de testes e pendências (etapa E15)

Data: 19/11/2026. Branch `claude/development-needed-6vi6j1`.

## 1. O que foi verificado

| Verificação | Resultado |
| --- | --- |
| `npm run lint` e `tsc --noEmit` | sem erros |
| Testes de unidade e de banco (Vitest + Postgres embutido) | **484 testes em 29 arquivos, todos passando** |
| `npm run content:check` | conteúdo válido: 7 mundos, 66 conceitos, 81 lições, 611 exercícios; toda solução de referência passa e todo código inicial reprova |
| Interpretações de código do conteúdo novo (Mundos 4 a 7) | o código de cada uma foi executado e bate com a alternativa marcada (28 + 37 + 37 + 26 conferidas) |
| `npm run build` | compila |
| Testes de navegador (e2e), em computador | 14 suítes, todas passando |
| Testes de navegador, em celular (390×844) | passando: área do aluno, atividades, inteligência, modo aprendizado e privacidade/pesquisa |
| Navegação só pelo teclado | passando (pular para o conteúdo, menu, lição, exercício, ranking e questionário) |
| Acessibilidade (axe, WCAG 2.2 AA), todas as telas, 4 combinações | **nenhuma violação** (ver 1.3) |

### 1.1 Permissões (testes de banco)
- Toda tabela do esquema `public` tem RLS ligada; visitante não tem permissão em nenhuma tabela e só executa funções puras e o `ping`.
- Toda função SECURITY DEFINER fixa o `search_path`.
- Um aluno não enxerga nenhuma linha de outro aluno em progresso, tentativas, atividade diária, medalhas, dicas de IA, missões, entregas e pesquisa.
- Professor sem turma com o aluno não vê nada; o professor da turma vê progresso e tentativas, mas **não** medalhas, missões nem a pesquisa de quem respondeu sem turma.
- Gabaritos de avaliação e soluções de referência não são legíveis por alunos; aluno não vira professor nem forja consentimento.
- Atividades e avaliações: prazo no servidor, entrega única, gabarito inacessível, avaliação só com tipos corrigidos no banco.

### 1.2 Cálculos conferidos contra recálculo independente
- **XP:** as 18 combinações de dificuldade × tipo × tentativas dão o mesmo valor no banco e na função pura.
- **Relatório de conceitos:** o resultado do SQL é igual ao das funções puras e ao recontado direto de `attempts`.
- **Pontuação SUS:** SQL e função pura iguais nos extremos (0, 50, 100) e em casos intermediários.
- **Desempenho:** com 40 alunos e 40 mil tentativas, o relatório de conceitos leva cerca de 300 ms e o ranking, 5 ms (Postgres embutido, mais lento que o real).

### 1.3 Acessibilidade
- Nas etapas anteriores, a suíte completa (4 combinações: celular/computador × claro/escuro) achou menu estourando a largura no celular, dois links sem sublinhado e um rótulo repetido. Tudo foi corrigido e reconferido.
- Telas novas da E15 (política, questionário do aluno e painel de pesquisa do professor): sem violações.
- **Suíte final completa** (todas as telas do aluno e do professor, 4 combinações de celular/computador × claro/escuro, com checagem de rolagem horizontal): **nenhuma violação do axe e nenhuma rolagem horizontal.**

### 1.4 Execução segura de código
Em navegador real: laço infinito (tempo esgotado), `fetch`, `XMLHttpRequest`, `WebSocket`, `importScripts`, `import()`, `new Function`, construtor de função assíncrona, `localStorage`, `sendBeacon`, `document`, `postMessage` forjado, 200 mil linhas de saída e consumo de memória sem fim. Tudo bloqueado ou interrompido, a página continua viva, **nenhuma requisição saiu para a internet** e o código normal volta a funcionar depois.

## 2. O que NÃO foi verificado (e por quê)
- **Nada foi testado no Supabase e na Vercel reais.** Todos os testes usam Postgres embutido (PGlite) e backend simulado nos testes de navegador. As migrations 0009 a 0017 ainda precisam ser aplicadas e conferidas por você.
- **Nenhum dado real de alunos.** Painéis, relatórios, SUS e comparação com IA foram validados com dados simulados.
- **Dica com IA ao vivo** (Gemini real): a rota está coberta por testes simulados; a chamada real depende da chave configurada na Vercel e não foi testada por mim.
- **Fluxo de confirmação de e-mail e recuperação de senha** do Supabase Auth: não testados.
- **Tela do termo de consentimento (conta antiga)** não está na suíte de acessibilidade (só nos testes funcionais).
- **Navegação por teclado em todas as telas do professor** e **leitores de tela reais** (NVDA, VoiceOver): não testados.
- **Fluxos completos em celular de professor** (criar atividade, painel de conceitos): só o layout foi verificado pelo axe; os fluxos completos de celular cobrem o aluno.
- **Teste de carga com muitos usuários simultâneos** e limites reais do plano gratuito: só estimativas (`docs/limites-do-plano-gratuito.md`).
- **Impressão/PDF, navegadores além do Chromium** (Firefox, Safari): não testados.
- Um teste de navegador (`tipos-e-sequencia`, "registra a atividade do dia") falhou uma vez na rodada completa e passou ao repetir: é instável perto da virada do dia/fuso (compara a data do navegador com a de Fortaleza). Não é defeito do site.

## 3. Ações manuais (nesta ordem)
1. **Supabase → SQL Editor:** aplicar as migrations pendentes, em ordem: `0009`, `0010`, `0011`, `0012`, `0013`, `0014`, `0015`, `0016`, `0017` (ou, num banco novo, `supabase/setup-completo.sql`).
2. Importar o conteúdo: `supabase/importar-conteudo.sql` (entra como **rascunho**).
3. **Revisar** os documentos `docs/revisao/mundo-1.md` a `mundo-7.md` e registrar o que foi aprovado e ajustado.
4. Publicar o que for aprovado: `supabase/publicar-mundo-1.sql` a `publicar-mundo-7.sql`.
5. **Vercel → Environment Variables:** conferir `NEXT_PUBLIC_SUPABASE_URL`, `NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY` e `GEMINI_API_KEY` (tipo Secret; nunca com `NEXT_PUBLIC_`). Se a primeira chave do Gemini apareceu em print, **exclua-a e crie outra**.
6. Tornar o **repositório do GitHub privado** (contém exercícios, soluções e gabaritos).
7. Conferir que o `ping` diário do GitHub Actions está ativo (`keep-alive.yml`).
8. Criar a conta de professor (mudar `role` para `professor` no Supabase) e uma turma de teste.

## 4. Pendências para a defesa
- [ ] Decisão do orientador/CEP sobre **menores de 18 anos** e a coleta de autorização dos responsáveis (o site só registra a declaração).
- [ ] Decidir se a pesquisa precisa de parecer do **CEP** e, se sim, anexar o termo (a política em `/privacidade` pode servir de base).
- [ ] Revisão do professor de **todo o conteúdo** (7 mundos, 600+ exercícios) antes de publicar. Esse é o maior item de trabalho humano que falta.
- [ ] Rodar com uma turma real, por tempo suficiente, para ter dados no painel de conceitos (precisa de 5+ alunos) e responder ao SUS/Likert (5+ respostas para o resumo).
- [ ] Escrever o texto do TCC com `docs/tcc/orientacoes.md` e o diagrama ER (`docs/tcc/diagrama-er.md`).
- [ ] Preparar a demonstração: um mundo publicado, uma turma de teste com dados e o painel de conceitos.
- [ ] Definir a política de retenção após a pesquisa (proposta: excluir contas inativas há mais de 12 meses).
- [ ] Decidir sobre as limitações: correção de código no navegador (não serve para prova com nota) e pausa do plano gratuito.

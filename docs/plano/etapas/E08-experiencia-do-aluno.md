# E8 — Experiência do aluno e progressão por domínio

> Antes de começar, leia `docs/plano/00-especificacao.md`. Depende da E4 (há conteúdo para navegar).

## Objetivo
Dar ao aluno uma área completa: painel, mundos, lições no formato de 7 passos e acompanhamento do próprio progresso.

## Navegação
Início · Mundos · Minhas atividades · Conquistas · Meu progresso · Perfil.

## Entregáveis
1. **Início (dashboard):** saudação, nível, XP, barra de progresso, sequência, próxima atividade, atividades pendentes e prazos (quando existirem, E10), conquistas recentes.
2. **Mundos:** os 7 mundos como cartões (concluído/em andamento/bloqueado), com a regra D3.
3. **Página da lição** com os 7 passos em sequência: introdução, explicação, exemplo (código comentado), interpretação, prática, desafio (quando houver), revisão. O aluno vê onde está e pode voltar a um passo.
4. **Meu progresso:** evolução ao longo do tempo, progresso por mundo, **desempenho por conceito do próprio aluno** (usa a regra D8: "dados insuficientes" até haver tentativas), sem rotular o aluno.
5. **Histórico de atividades.**
6. **Tema:** escuro como padrão para quem não tem preferência (D10), com alternância visível.
7. **Aprendizagem livre** (D, seção 9 do prompt original): o aluno explora e pratica por conta própria; registrada com `mode = livre`.

## Critérios de pronto
- [ ] Todas as telas em celular e computador, claro e escuro, sem violações do axe e sem rolagem horizontal.
- [ ] Rota antiga `/exercicio/[id]` continua funcionando.
- [ ] E2E de: primeira vez do aluno, continuar de onde parou, lição bloqueada, voltar a um passo.
- [ ] `lint`, `tsc`, `test`, `build`, `e2e` verdes.

## Ao terminar
Pare e mostre as telas (capturas) do fluxo de um aluno novo até concluir uma lição.

# E9 — Gamificação

> Antes de começar, leia `docs/plano/00-especificacao.md`. Depende da E8.

## Objetivo
Ampliar a gamificação **sem tornar a plataforma infantil nem excessivamente competitiva**, e sem substituir o domínio do conteúdo.

## Entregáveis
1. **XP (D4):** fácil 20, médio 35, difícil 50, desafio de lição 75, conclusão de mundo 150, missão diária 30. Bônus de 1ª tentativa mantido. **Nunca** XP repetido por reenviar exercício já aprovado. XP já gravado não é recalculado. Documentar o impacto da troca de valores.
2. **Níveis** com a curva atual (ou ajustada, com justificativa).
3. **Conquistas:** primeiro exercício, primeiro mundo finalizado, uma por mundo ("Mestre das variáveis", "Decisões inteligentes", "Mestre dos ciclos", e equivalentes para vetores, funções e introdução), Persistência (acertar após várias tentativas), Superação (acertar um conceito que antes era difícil), constância. Histórico de conquistas com data.
4. **Missões diárias:** definição fixa, por exemplo "resolva 2 exercícios hoje" e "pratique um conceito com dificuldade". Bônus de 30 XP uma vez por dia. Tabela e função no banco (sem confiar no navegador para o cálculo do XP).
5. **Sequência (streak):** já existe; manter.
6. **Ranking opt-in (D11):** o aluno escolhe aparecer; só vê a própria turma.
7. **Liberação por domínio, não por XP:** XP nunca libera conteúdo.

## Critérios de pronto
- [ ] Testes: XP não duplica; missão não concede duas vezes no mesmo dia; ranking respeita opt-in e turma (RLS).
- [ ] Textos e visual sóbrios, validados em acessibilidade.
- [ ] `lint`, `tsc`, `test`, `build`, `e2e` verdes.

## Ao terminar
Pare e mostre a tabela de XP final, a lista de conquistas e uma captura das missões.

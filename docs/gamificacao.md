# Gamificação (etapa E9)

Princípios: sóbria, sem ar infantil, nada excessivamente competitivo, e **o domínio do conteúdo vem antes
do XP**. O XP nunca libera lição: a liberação depende só de resolver 70% dos exercícios da lição anterior
(`src/lib/learning.ts`, coberto por teste).

## Tabela de XP (decisão D4)

| Origem | XP |
| --- | --- |
| Exercício fácil | 20 |
| Exercício médio | 35 |
| Exercício difícil | 50 |
| Desafio de lição (exercício do tipo "desafio") | 75 |
| Bônus de acertar de **primeira** | +50% do valor do exercício (arredondado) |
| Conclusão de um mundo (uma vez por mundo) | 150 |
| Missão diária cumprida (uma vez por dia, por missão) | 30 |

Com o bônus de primeira tentativa: fácil 30, médio 53, difícil 75, desafio 113.

### Regras que o banco garante (migration 0014)
- O **XP do exercício é calculado pelo banco** (gatilho `set_progress_xp`): o valor que o navegador envia é ignorado.
- **Sem XP repetido:** depois de resolvido, a linha fica travada (o XP, as tentativas e a data não mudam). Reenviar um exercício aprovado não rende nada.
- **Missões:** a função `sync_gamification()` confere o progresso do dia (fuso de Fortaleza) e concede o XP; a chave
  `(aluno, missão, dia)` impede conceder duas vezes no mesmo dia. O navegador só mostra o estado.
- **Mundo concluído:** todas as lições obrigatórias (as complementares não contam) com 70% dos exercícios publicados resolvidos; 150 XP uma única vez.
- O XP total é `XP dos exercícios + missões + mundos`; é a mesma conta no cabeçalho e no ranking.

### Impacto da troca de valores
- Os valores antigos eram 10 / 20 / 35 (com o mesmo bônus de 50%). **O XP já gravado não é recalculado**: quem já
  resolveu exercícios mantém o XP que tinha; só o que for resolvido depois da migration usa a tabela nova.
- Por isso, alunos antigos e novos podem diferir no XP por exercício. Isso não afeta a liberação das lições nem as medalhas.
- A curva de níveis foi **mantida** (limiar do nível n = 25 × (n−1)²): com os valores maiores, os níveis iniciais
  chegam um pouco mais rápido, o que é desejável para um aluno iniciante; as medalhas e a liberação por domínio
  seguram o ritmo.

## Missões diárias (definição fixa)
1. **Resolva 2 exercícios** hoje — 30 XP.
2. **Volte a um conceito difícil** — resolva hoje um exercício de um conceito em que você já errou antes
   (em outro exercício do mesmo conceito) — 30 XP.

Cada missão rende XP uma vez por dia. Tabelas: `missions` (definição), `mission_claims` (concedidas).

## Conquistas
Cada conquista é guardada com a **data** (`user_badges`). Medalhas não dão XP.

| Conquista | Como ganhar |
| --- | --- |
| Primeiro passo | Resolver o primeiro exercício |
| Persistente | Acertar um exercício depois de errar 3 ou mais vezes |
| De primeira | Acertar 3 exercícios na primeira tentativa |
| Constância | 3 dias seguidos de prática |
| Uma semana inteira | 7 dias seguidos de prática |
| Superação | Dominar um conceito em que teve dificuldade (3+ tentativas em um exercício) |
| Primeiro mundo concluído | Concluir o primeiro mundo |
| Pensador lógico | Concluir o Mundo 1 (introdução à lógica) |
| Mestre das variáveis | Concluir o Mundo 2 |
| Calculista dos operadores | Concluir o Mundo 3 |
| Decisões inteligentes | Concluir o Mundo 4 (estruturas condicionais) |
| Mestre dos ciclos | Concluir o Mundo 5 (repetição) |
| Organizador de dados | Concluir o Mundo 6 (vetores e matrizes) |
| Arquiteto de funções | Concluir o Mundo 7 (funções) |
| Todos os exercícios | Resolver todos os exercícios publicados |

As medalhas por lição ("Módulo: ...") foram retiradas: com dezenas de lições, a lista ficava longa e repetitiva.
Quem já tinha uma delas não perde nada de XP; a medalha apenas deixa de aparecer.

## Ranking (decisão D11)
- **Opt-in:** por padrão ninguém aparece (`profiles.show_in_ranking = false`). O aluno liga e desliga no
  Perfil ou na própria página do Ranking.
- **Só a própria turma:** a função `leaderboard` mostra apenas alunos que estão em uma turma do solicitante
  e que escolheram aparecer. Nomes abreviados; nunca e-mail nem identificadores.
- O professor vê o ranking das suas turmas (só dos alunos que escolheram aparecer).

## Limite conhecido
A correção de exercícios de código roda no navegador (Web Worker); o banco calcula o XP mas aceita o "resolvido"
enviado pelo navegador. Exercícios de escolha e de ordenação são conferidos pelo banco no registro de tentativas.
Para um uso com avaliação valendo nota, a correção de código precisaria ir para o servidor (fora do orçamento R$ 0).

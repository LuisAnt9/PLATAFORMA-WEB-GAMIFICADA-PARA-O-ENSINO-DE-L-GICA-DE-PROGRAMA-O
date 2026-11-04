# E12 — Conteúdo do Mundo 5: Estruturas de Repetição

> Antes de começar, leia `docs/plano/00-especificacao.md` e `content/README.md`. Depende de E7.

## Objetivo do mundo
Ensinar o aluno a automatizar tarefas repetitivas e compreender o funcionamento dos laços de repetição.

## Lições (cada uma vira um módulo/lição no banco e um conceito)

| # | Lição | Conceito (slug) |
|---|---|---|
| 1 | Introdução às estruturas de repetição | `m5-introducao` |
| 2 | Estrutura for | `m5-for` |
| 3 | Estrutura while | `m5-while` |
| 4 | Estrutura do...while | `m5-do-while` |
| 5 | Contadores | `m5-contadores` |
| 6 | Acumuladores | `m5-acumuladores` |
| 7 | Comando break | `m5-break` |
| 8 | Comando continue | `m5-continue` |
| 9 | Laços de repetição aninhados | `m5-aninhados` |

## O que produzir (para cada lição)
Seguir os **7 passos** da especificação (D2):
1. **Introdução e Explicação** (`intro`): linguagem simples, com situação do cotidiano, sem jargão sem explicar. Até ~1.200 caracteres.
2. **Exemplo** (`example`): código comentado, explicado passo a passo.
3. **Interpretação:** pelo menos **2** exercícios de ler um código e dizer o resultado.
4. **Prática:** pelo menos **3** exercícios progressivos (fácil → médio → difícil), variando os tipos (escolha, lacuna, ordenação, código, corrigir erro) conforme o conceito.
5. **Revisão** (`review`): resumo de 3 a 5 pontos.
Mínimo de **5 exercícios por lição**, com cerca de 40% fáceis, 40% médios e 20% difíceis.

Além das lições: **1 desafio integrador do mundo** (75 XP) e a conclusão do mundo (150 XP, E9).

**Desafio final:** Desenvolver um jogo de adivinhação com tentativas limitadas (entradas simuladas como palpites; saída com as dicas 'maior', 'menor' e 'acertou').

## Regras de qualidade
- Cada exercício ligado a **pelo menos um conceito** (`exercise_concepts`); o desafio integrador, a vários.
- Em toda questão de escolha/interpretação, **cada alternativa errada tem `misconception`**. Confusões esperadas neste mundo:
  - erro de um (off-by-one) no limite do laço
  - laço infinito por esquecer o passo
  - confundir contador com acumulador
  - achar que o do...while pode não executar nenhuma vez
  - confundir break com continue
  - errar quantas voltas o laço dá
  - achar que laços aninhados somam em vez de multiplicar
  - reiniciar o acumulador dentro do laço
- Dicas em níveis: dica do professor (sem entregar a resposta) e pista do conceito.
- Todo exercício de código tem **solução de referência**, passa em `npm run content:check` e os testes **reprovam o código inicial**.
- Aceitar diferentes soluções corretas (testes por comportamento, nunca por texto do código).
- Explicação ao acertar, curta e que ensine algo (não só "parabéns").
- Sem assuntos fora do escopo (DOM, APIs, frameworks, backend, orientação a objetos, assíncrono, algoritmos avançados).

## Observações técnicas
Use **acompanhamento de valores** (tabela de variáveis a cada volta) em exercícios de interpretação. Testes de código devem cobrir o laço que não executa nenhuma vez e o limite. O executor já tem limite de tempo para laços infinitos.

## Fluxo
1. Escreva os arquivos em `content/mundo-5/` e rode `npm run content:check` até passar.
2. **Revisão do professor:** o Claude entrega um resumo por lição (conceitos, nº de exercícios, desafio) e uma lista dos exercícios para o professor ler. **Nada é publicado antes da aprovação.** Importar como **rascunho** (`published = false`).
3. Gere a migration com `npm run content:build` e entregue ao usuário para rodar no Supabase.
4. Após a aprovação, publicar as lições aprovadas.

## Critérios de pronto
- [ ] 9 lições completas com os 7 passos e mínimo de 5 exercícios cada.
- [ ] `content:check` verde; testes do banco com a contagem esperada de lições e exercícios.
- [ ] Conceitos do mundo cadastrados e ligados.
- [ ] Revisão do professor registrada (o que foi aprovado e o que foi ajustado).
- [ ] `lint`, `tsc`, `test`, `build`, `e2e` verdes.

## Ao terminar
Pare e mostre: contagem de lições/exercícios por tipo e dificuldade, 3 exercícios de exemplo (um de cada tipo), e o que o professor precisa revisar.

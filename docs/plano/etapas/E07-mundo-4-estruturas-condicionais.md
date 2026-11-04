# E7 — Conteúdo do Mundo 4: Estruturas Condicionais

> Antes de começar, leia `docs/plano/00-especificacao.md` e `content/README.md`. Depende de E6.

## Objetivo do mundo
Ensinar o aluno a criar programas que tomam decisões de acordo com determinadas condições.

## Lições (cada uma vira um módulo/lição no banco e um conceito)

| # | Lição | Conceito (slug) |
|---|---|---|
| 1 | Introdução às estruturas condicionais | `m4-introducao` |
| 2 | Revisão dos operadores relacionais | `m4-revisao-relacionais` |
| 3 | Revisão dos operadores lógicos | `m4-revisao-logicos` |
| 4 | Estrutura if | `m4-if` |
| 5 | Estrutura if/else | `m4-if-else` |
| 6 | Estrutura else if | `m4-else-if` |
| 7 | Condicionais aninhadas | `m4-aninhadas` |
| 8 | Estrutura switch | `m4-switch` |
| 9 | Operador ternário (conteúdo complementar) | `m4-ternario` |

## O que produzir (para cada lição)
Seguir os **7 passos** da especificação (D2):
1. **Introdução e Explicação** (`intro`): linguagem simples, com situação do cotidiano, sem jargão sem explicar. Até ~1.200 caracteres.
2. **Exemplo** (`example`): código comentado, explicado passo a passo.
3. **Interpretação:** pelo menos **2** exercícios de ler um código e dizer o resultado.
4. **Prática:** pelo menos **3** exercícios progressivos (fácil → médio → difícil), variando os tipos (escolha, lacuna, ordenação, código, corrigir erro) conforme o conceito.
5. **Revisão** (`review`): resumo de 3 a 5 pontos.
Mínimo de **5 exercícios por lição**, com cerca de 40% fáceis, 40% médios e 20% difíceis.

Além das lições: **1 desafio integrador do mundo** (75 XP) e a conclusão do mundo (150 XP, E9).

**Desafio final:** Desenvolver um sistema que receba as notas de um aluno, calcule a média e informe a situação (aprovado, recuperação ou reprovado).

## Regras de qualidade
- Cada exercício ligado a **pelo menos um conceito** (`exercise_concepts`); o desafio integrador, a vários.
- Em toda questão de escolha/interpretação, **cada alternativa errada tem `misconception`**. Confusões esperadas neste mundo:
  - usar = no lugar de === na condição
  - esquecer o else ou as chaves
  - ordem errada em else if (a primeira condição verdadeira vence)
  - confundir && com ||
  - switch sem break (queda para o próximo caso)
  - condições que se sobrepõem
  - achar que todas as ramificações executam
  - não tratar o valor exatamente igual ao limite
- Dicas em níveis: dica do professor (sem entregar a resposta) e pista do conceito.
- Todo exercício de código tem **solução de referência**, passa em `npm run content:check` e os testes **reprovam o código inicial**.
- Aceitar diferentes soluções corretas (testes por comportamento, nunca por texto do código).
- Explicação ao acertar, curta e que ensine algo (não só "parabéns").
- Sem assuntos fora do escopo (DOM, APIs, frameworks, backend, orientação a objetos, assíncrono, algoritmos avançados).

## Observações técnicas
Combine código, interpretação (qual ramo executa para cada entrada) e **identificar e corrigir erro**. Revisões (lições 2 e 3) devem **reaproveitar conceitos** do mundo 3, não criar conceitos novos. Ternário e arrow functions são conteúdo complementar: não bloqueiam a liberação.

## Fluxo
1. Escreva os arquivos em `content/mundo-4/` e rode `npm run content:check` até passar.
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

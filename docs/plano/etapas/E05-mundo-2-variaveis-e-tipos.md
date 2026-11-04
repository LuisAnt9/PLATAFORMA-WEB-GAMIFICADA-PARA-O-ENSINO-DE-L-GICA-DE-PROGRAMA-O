# E5 — Conteúdo do Mundo 2: Variáveis e Tipos de Dados

> Antes de começar, leia `docs/plano/00-especificacao.md` e `content/README.md`. Depende de E4.

## Objetivo do mundo
Ensinar o aluno a armazenar, identificar e manipular informações.

## Lições (cada uma vira um módulo/lição no banco e um conceito)

| # | Lição | Conceito (slug) |
|---|---|---|
| 1 | Introdução às variáveis | `m2-introducao-variaveis` |
| 2 | Declaração de variáveis | `m2-declaracao` |
| 3 | Utilização de let e const | `m2-let-const` |
| 4 | Tipo String | `m2-string` |
| 5 | Tipo Number | `m2-number` |
| 6 | Tipo Boolean | `m2-boolean` |
| 7 | Manipulação de textos | `m2-manipulacao-textos` |
| 8 | Concatenação | `m2-concatenacao` |
| 9 | Template literals | `m2-template-literals` |
| 10 | Operações com números | `m2-operacoes-numeros` |
| 11 | Conversão de tipos | `m2-conversao-tipos` |
| 12 | Entrada e saída de informações | `m2-entrada-saida` |
| 13 | Utilização de console.log() | `m2-console-log` |

## O que produzir (para cada lição)
Seguir os **7 passos** da especificação (D2):
1. **Introdução e Explicação** (`intro`): linguagem simples, com situação do cotidiano, sem jargão sem explicar. Até ~1.200 caracteres.
2. **Exemplo** (`example`): código comentado, explicado passo a passo.
3. **Interpretação:** pelo menos **2** exercícios de ler um código e dizer o resultado.
4. **Prática:** pelo menos **3** exercícios progressivos (fácil → médio → difícil), variando os tipos (escolha, lacuna, ordenação, código, corrigir erro) conforme o conceito.
5. **Revisão** (`review`): resumo de 3 a 5 pontos.
Mínimo de **5 exercícios por lição**, com cerca de 40% fáceis, 40% médios e 20% difíceis.

Além das lições: **1 desafio integrador do mundo** (75 XP) e a conclusão do mundo (150 XP, E9).

**Desafio final:** Criar um pequeno programa que receba informações de uma pessoa (nome, idade, altura), armazene os dados em variáveis e apresente os resultados em frases formatadas.

## Regras de qualidade
- Cada exercício ligado a **pelo menos um conceito** (`exercise_concepts`); o desafio integrador, a vários.
- Em toda questão de escolha/interpretação, **cada alternativa errada tem `misconception`**. Confusões esperadas neste mundo:
  - achar que variável é o valor e não o nome da caixa
  - reatribuir uma const
  - confundir '5' + 3 (texto) com 5 + 3 (soma)
  - esquecer as aspas em textos
  - usar aspas simples no lugar de crases em template literals
  - achar que Number('abc') dá erro (dá NaN)
  - confundir console.log com return
  - confundir let e var/const
- Dicas em níveis: dica do professor (sem entregar a resposta) e pista do conceito.
- Todo exercício de código tem **solução de referência**, passa em `npm run content:check` e os testes **reprovam o código inicial**.
- Aceitar diferentes soluções corretas (testes por comportamento, nunca por texto do código).
- Explicação ao acertar, curta e que ensine algo (não só "parabéns").
- Sem assuntos fora do escopo (DOM, APIs, frameworks, backend, orientação a objetos, assíncrono, algoritmos avançados).

## Observações técnicas
Aqui entram **entrada e saída** (D5): a entrada vem por parâmetros ou entradas simuladas e a saída é conferida pelo `console.log` capturado. Cubra `typeof`, `NaN` e conversões `Number()`/`String()`.

## Fluxo
1. Escreva os arquivos em `content/mundo-2/` e rode `npm run content:check` até passar.
2. **Revisão do professor:** o Claude entrega um resumo por lição (conceitos, nº de exercícios, desafio) e uma lista dos exercícios para o professor ler. **Nada é publicado antes da aprovação.** Importar como **rascunho** (`published = false`).
3. Gere a migration com `npm run content:build` e entregue ao usuário para rodar no Supabase.
4. Após a aprovação, publicar as lições aprovadas.

## Critérios de pronto
- [ ] 13 lições completas com os 7 passos e mínimo de 5 exercícios cada.
- [ ] `content:check` verde; testes do banco com a contagem esperada de lições e exercícios.
- [ ] Conceitos do mundo cadastrados e ligados.
- [ ] Revisão do professor registrada (o que foi aprovado e o que foi ajustado).
- [ ] `lint`, `tsc`, `test`, `build`, `e2e` verdes.

## Ao terminar
Pare e mostre: contagem de lições/exercícios por tipo e dificuldade, 3 exercícios de exemplo (um de cada tipo), e o que o professor precisa revisar.

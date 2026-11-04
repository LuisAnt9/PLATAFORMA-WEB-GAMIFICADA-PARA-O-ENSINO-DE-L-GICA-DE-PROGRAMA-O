# E13 — Conteúdo do Mundo 6: Vetores e Matrizes

> Antes de começar, leia `docs/plano/00-especificacao.md` e `content/README.md`. Depende de E12.

## Objetivo do mundo
Ensinar o aluno a armazenar e organizar vários valores em uma única estrutura.

## Lições (cada uma vira um módulo/lição no banco e um conceito)

| # | Lição | Conceito (slug) |
|---|---|---|
| 1 | Introdução aos vetores | `m6-introducao-vetores` |
| 2 | Arrays em JavaScript | `m6-arrays` |
| 3 | Índices e posições | `m6-indices` |
| 4 | Propriedade length | `m6-length` |
| 5 | Inserção de elementos com push() | `m6-push` |
| 6 | Remoção de elementos com pop() | `m6-pop` |
| 7 | Utilização de shift() e unshift() | `m6-shift-unshift` |
| 8 | Percorrer arrays com for | `m6-percorrer-for` |
| 9 | Percorrer arrays com while | `m6-percorrer-while` |
| 10 | Introdução às matrizes | `m6-introducao-matrizes` |
| 11 | Arrays bidimensionais | `m6-bidimensionais` |
| 12 | Percorrer matrizes com laços aninhados | `m6-percorrer-matrizes` |

## O que produzir (para cada lição)
Seguir os **7 passos** da especificação (D2):
1. **Introdução e Explicação** (`intro`): linguagem simples, com situação do cotidiano, sem jargão sem explicar. Até ~1.200 caracteres.
2. **Exemplo** (`example`): código comentado, explicado passo a passo.
3. **Interpretação:** pelo menos **2** exercícios de ler um código e dizer o resultado.
4. **Prática:** pelo menos **3** exercícios progressivos (fácil → médio → difícil), variando os tipos (escolha, lacuna, ordenação, código, corrigir erro) conforme o conceito.
5. **Revisão** (`review`): resumo de 3 a 5 pontos.
Mínimo de **5 exercícios por lição**, com cerca de 40% fáceis, 40% médios e 20% difíceis.

Além das lições: **1 desafio integrador do mundo** (75 XP) e a conclusão do mundo (150 XP, E9).

**Desafio final:** Desenvolver um programa que armazene as notas de estudantes e calcule a média da turma (e, opcionalmente, a maior nota).

## Regras de qualidade
- Cada exercício ligado a **pelo menos um conceito** (`exercise_concepts`); o desafio integrador, a vários.
- Em toda questão de escolha/interpretação, **cada alternativa errada tem `misconception`**. Confusões esperadas neste mundo:
  - achar que o primeiro índice é 1
  - usar length em vez de length - 1 como último índice
  - confundir o efeito de push/pop/shift/unshift e o que cada um retorna
  - ultrapassar o limite ao percorrer (<= length)
  - confundir linha e coluna em matriz[i][j]
  - achar que atribuir um array a outra variável copia os dados
- Dicas em níveis: dica do professor (sem entregar a resposta) e pista do conceito.
- Todo exercício de código tem **solução de referência**, passa em `npm run content:check` e os testes **reprovam o código inicial**.
- Aceitar diferentes soluções corretas (testes por comportamento, nunca por texto do código).
- Explicação ao acertar, curta e que ensine algo (não só "parabéns").
- Sem assuntos fora do escopo (DOM, APIs, frameworks, backend, orientação a objetos, assíncrono, algoritmos avançados).

## Observações técnicas
Evite métodos fora do escopo (`map`, `filter`, `reduce`, `forEach`): o objetivo é a lógica com laços. Matrizes: use exercícios de interpretação com tabelas desenhadas em texto.

## Fluxo
1. Escreva os arquivos em `content/mundo-6/` e rode `npm run content:check` até passar.
2. **Revisão do professor:** o Claude entrega um resumo por lição (conceitos, nº de exercícios, desafio) e uma lista dos exercícios para o professor ler. **Nada é publicado antes da aprovação.** Importar como **rascunho** (`published = false`).
3. Gere a migration com `npm run content:build` e entregue ao usuário para rodar no Supabase.
4. Após a aprovação, publicar as lições aprovadas.

## Critérios de pronto
- [ ] 12 lições completas com os 7 passos e mínimo de 5 exercícios cada.
- [ ] `content:check` verde; testes do banco com a contagem esperada de lições e exercícios.
- [ ] Conceitos do mundo cadastrados e ligados.
- [ ] Revisão do professor registrada (o que foi aprovado e o que foi ajustado).
- [ ] `lint`, `tsc`, `test`, `build`, `e2e` verdes.

## Ao terminar
Pare e mostre: contagem de lições/exercícios por tipo e dificuldade, 3 exercícios de exemplo (um de cada tipo), e o que o professor precisa revisar.

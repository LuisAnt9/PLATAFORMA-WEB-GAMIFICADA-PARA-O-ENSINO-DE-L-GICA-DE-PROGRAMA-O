# E3 — Novos tipos de exercício e executor com entrada e saída

> Antes de começar, leia `docs/plano/00-especificacao.md`. Depende das E1 e E2.

## Objetivo
Oferecer todos os formatos de atividade previstos e permitir exercícios com **entrada e saída** (o que os mundos 2, 3 e 5 exigem).

## Tipos a implementar (os 3 atuais continuam)

| Tipo | Como funciona | Correção |
|---|---|---|
| **Interpretação de código** | Mostra um trecho e pergunta qual será a saída/valor. Variante da escolha, com bloco de código formatado e opções com `misconception`. | no banco (serve em avaliação) |
| **Ordenação de instruções** | O aluno ordena passos/linhas. **Acessível pelo teclado** (mover para cima/baixo com botões, sem depender de arrastar). Serve para sequência lógica, pseudocódigo e fluxogramas. | no banco |
| **Identificar e corrigir erro** | Mostra código com defeito; o aluno corrige no editor. Tem testes como o tipo código. | no navegador |
| **Completar código** | Já existe (lacunas). Revisar para código com mais de uma linha. | no banco |
| **Desafio integrador** | Exercício de código maior, com vários testes e vários conceitos. | no navegador |

## Entrada e saída (D5)
- Exercício de código pode declarar **entradas simuladas** (lista de valores que a função `lerEntrada()`/parâmetros consomem) e **saída esperada** (linhas do `console.log`).
- O executor captura `console.log` sem expor `console` real, com limite de linhas e de tamanho.
- Nada de `prompt()`, `alert()`, DOM, rede ou `import`: continuam bloqueados no isolamento.
- Resultado mostra: entrada usada, saída esperada, saída obtida.

## Dicas progressivas (D9)
Interface com níveis: 1) dica do professor, 2) pista do conceito, 3) dica com IA (já existe). Registrar qual nível foi usado em cada tentativa (campo novo em `attempts` ou tabela própria, via migration).

## Solução comentada
Após resolver, mostrar a solução comentada **quando existir**. Atenção ao risco de segurança: a solução só pode ser entregue ao aluno depois de acertar. Se estiver no mesmo registro legível, registrar que o aluno técnico pode lê-la antes, e propor (sem implementar sem pedido) mover para tabela com liberação por função.

## Critérios de pronto
- [ ] Cada tipo novo com: formulário no editor do professor (formulário guiado, validação), tela do aluno, teste de unidade, teste de banco, e2e e auditoria de acessibilidade (inclusive só com teclado).
- [ ] Executor: testes com laço infinito, tentativa de usar `fetch`/`document`/`import`, saída enorme e erro de sintaxe, todos tratados sem travar a página.
- [ ] `content:check` (E2) atualizado para os tipos novos.
- [ ] `lint`, `tsc`, `test`, `build`, `e2e` verdes.

## Ao terminar
Pare e mostre uma captura/descrição de cada tipo novo funcionando.

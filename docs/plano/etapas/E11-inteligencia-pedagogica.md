# E11 — Inteligência pedagógica: painel de dificuldades por conceito

> Antes de começar, leia `docs/plano/00-especificacao.md`. Depende de E1, E7 (conteúdo dos mundos 1 a 4 já com conceitos) e E10. **Esta é a funcionalidade mais importante do projeto.**

## Objetivo
Responder, para o professor: **"O que meus alunos ainda não compreenderam e o que preciso revisar?"**

## Regras de interpretação (D7, D8)
- Distinguir, quando possível: erro de **sintaxe**, de **execução**, de **saída incorreta**, **tempo esgotado**, e, nas questões de escolha, a **confusão** (`misconception`).
- Considerar a quantidade de tentativas e o histórico, não só a última resposta.
- Só afirmar dificuldade com **≥ 3 tentativas em ≥ 2 exercícios** do conceito; painel da turma só com **≥ 5 alunos**. Antes disso, mostrar "dados insuficientes" e quantas tentativas faltam.
- **Nunca** classificar um aluno como incapaz; linguagem neutra ("ainda não demonstrou domínio").
- Valores de exemplo do prompt original (65%, 52%…) são **só ilustração**: tudo vem de `attempts`.

## Cálculo
Definir e **documentar** em `docs/` a fórmula de:
- **taxa de erro do conceito** (por tentativa e por aluno), com peso de `exercise_concepts`;
- **domínio do aluno no conceito** (por exemplo: bom desempenho, em desenvolvimento, dificuldade, não avaliado), considerando as tentativas mais recentes com mais peso;
- **aluno com dificuldade** no conceito.
Implementar como **funções puras testadas** e como consultas/funções SQL equivalentes (resultado idêntico, verificado por teste).

## Entregáveis
1. **Painel de conceitos** (turma): tabela e gráfico de barras dos conceitos por taxa de erro e nº de alunos com dificuldade; conceitos melhor compreendidos; exercícios com mais respostas incorretas.
2. **Análise individual:** domínio por conceito do aluno; ao abrir um conceito, os exercícios, as respostas dadas e a evolução.
3. **Erros recorrentes:** padrões por `misconception` e por categoria de erro de código ("confunde `&&` e `||`", "não entende a diferença entre `=` e `===`", "erro de sintaxe frequente").
4. **Recomendações** por regras (modelos de frase, sem IA): ex.: "A turma apresenta dificuldade em operadores lógicos. Considere revisar AND e OR." com botão **criar atividade de reforço** que já preenche a E10 com exercícios do conceito.
5. **Relatórios visuais** com filtros por turma, aluno, mundo, lição e período: conceitos mais errados, desempenho por mundo, acertos × erros, evolução da turma, alunos com dificuldade por conceito, ranking de exercícios com mais erro.
6. **Separação por modalidade:** os indicadores distinguem livre, atividade e avaliação.

## Critérios de pronto
- [ ] Testes de unidade com casos de borda (poucos dados, só uma tentativa, aluno que errou e depois acertou).
- [ ] Teste de consistência: o número do painel é igual ao recalculado a partir de `attempts`.
- [ ] Permissões: professor só vê as próprias turmas.
- [ ] Teste com dados reais de uso (se houver) e, caso contrário, dados de simulação marcados como tal.
- [ ] Acessibilidade dos gráficos (versão em tabela). `lint`, `tsc`, `test`, `build`, `e2e` verdes.

## Ao terminar
Pare e mostre o painel com um conjunto de dados de exemplo e explique em linguagem simples como cada número é calculado.

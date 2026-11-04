# E15 — Testes finais, privacidade e avaliação do TCC

> Antes de começar, leia `docs/plano/00-especificacao.md`. Depende de todas as etapas.

## Objetivo
Garantir a qualidade do conjunto e preparar a avaliação de usabilidade prevista no TCC.

## Entregáveis

### Qualidade
- Testar todos os fluxos de aluno e de professor (e2e) em celular e computador.
- **Permissões:** auditar cada tabela e função (testes de banco), incluindo `attempts`, atividades, avaliações e gabaritos.
- **Execução segura de código:** testes de laço infinito, tentativa de acessar rede/DOM/importar, saída gigante.
- **Cálculos:** conferir XP, níveis, desempenho e relatórios contra recálculo independente.
- Desempenho e limites do plano gratuito (tamanho do banco, número de consultas).
- Revisão final de acessibilidade (axe + navegação só por teclado).

### Privacidade (LGPD) — D14
- Termo de consentimento no cadastro, política de privacidade em linguagem simples.
- Exclusão de conta e dos dados do aluno; retenção definida.
- Aviso de que o código enviado à dica com IA vai ao Google; opção de desligar a dica com IA.
- Atenção a **menores de 18 anos**: registrar a necessidade de consentimento do responsável, conforme orientação do orientador/CEP.

### Avaliação do TCC
- **Questionário SUS** (10 afirmações, escala de 1 a 5) e **escala Likert** sobre a experiência de aprendizagem, dentro da plataforma, respondidos de forma anônima ou identificada conforme o termo.
- Exportação **CSV** das respostas (professor/pesquisador) e cálculo da pontuação SUS (0 a 100).
- Instrumentação opcional para comparar uso e não uso da dica com IA (taxa de acerto, tentativas), sem expor dados individuais.
- Orientações para o texto do TCC: requisitos, casos de uso, diagrama ER, arquitetura, segurança, testes e limitações conhecidas (correção no navegador, plano gratuito que pausa por inatividade).

## Critérios de pronto
- [ ] Relatório de testes com o que foi verificado e o que não foi.
- [ ] Todas as ações manuais listadas (migrations, variáveis de ambiente).
- [ ] `lint`, `tsc`, `test`, `build`, `e2e` verdes.

## Ao terminar
Pare e entregue o relatório final e a lista de pendências para a defesa.

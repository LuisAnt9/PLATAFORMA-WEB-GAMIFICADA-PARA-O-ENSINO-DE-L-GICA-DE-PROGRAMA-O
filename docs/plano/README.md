# Plano de desenvolvimento por etapas

Este plano substitui o prompt único. Ele está dividido em uma **especificação** (o que é a plataforma e as decisões já tomadas) e **15 etapas** curtas, cada uma com entregáveis e critérios de pronto.

## Como usar

1. Mande para o Claude **uma etapa por vez**, nesta ordem. Cada arquivo de etapa já começa mandando ler a especificação.
2. Ao terminar uma etapa, o Claude para e mostra o resultado. Só mande a próxima depois de conferir.
3. As etapas de **conteúdo** (mundos) precisam da sua **revisão pedagógica** antes de serem publicadas: o Claude escreve, o professor aprova.

## Ordem

| Etapa | Assunto | Depende de |
|---|---|---|
| E1 | Fundação de dados: registro de cada tentativa, conceitos, hierarquia mundo > lição | — |
| E2 | Formato de conteúdo, importador e validação (migra os 53 exercícios atuais) | E1 |
| E3 | Novos tipos de exercício e executor com entrada e saída | E1, E2 |
| E4 | Conteúdo do Mundo 1 | E2, E3 |
| E5 | Conteúdo do Mundo 2 | E4 |
| E6 | Conteúdo do Mundo 3 | E5 |
| E7 | Conteúdo do Mundo 4 | E6 |
| E8 | Experiência do aluno e progressão por domínio | E4 |
| E9 | Gamificação | E8 |
| E10 | Ambiente do professor: atividades, avaliações e acompanhamento | E8 |
| E11 | Inteligência pedagógica: painel de dificuldades por conceito | E1, E7, E10 |
| E12 | Conteúdo do Mundo 5 | E7 |
| E13 | Conteúdo do Mundo 6 | E12 |
| E14 | Conteúdo do Mundo 7 | E13 |
| E15 | Testes finais, privacidade (LGPD) e avaliação do TCC (SUS/Likert) | todas |

As etapas E8 a E11 podem andar em paralelo com as de conteúdo, se você preferir intercalar. Só não coloque a E11 antes de haver conteúdo suficiente (mundos 1 a 4), senão o painel fica vazio.

## Tamanho real do trabalho

Os sete mundos somam **66 lições**. Com o mínimo de 5 exercícios por lição, mais os desafios, são de **350 a 450 exercícios** no total, e hoje a plataforma tem 53. O código é a parte menor: o gargalo é escrever e revisar conteúdo. Por isso cada mundo é uma etapa separada, e a revisão do professor é parte do critério de pronto.

# Inteligência pedagógica (etapa E11)

Responde, para o professor: **"O que meus alunos ainda não compreenderam e o que preciso revisar?"**
Todos os números vêm só da tabela `attempts` (cada tentativa de cada aluno). Nada é inventado: os valores
de exemplo do prompt original (65%, 52%...) eram só ilustração.

A fórmula existe em dois lugares com **o mesmo resultado**, e um teste confere isso com dados simulados:
- funções puras: `src/lib/concept-analytics.ts` (testadas em `src/lib/concept-analytics.test.ts`);
- função SQL `concept_report` (migration `0016_inteligencia_pedagogica.sql`; testada em `supabase/tests/inteligencia.test.ts`).

## Regras de segurança estatística (D8)
| Situação | O que aparece |
| --- | --- |
| Aluno com menos de **3 tentativas** ou em menos de **2 exercícios** do conceito | "Dados insuficientes" e quantas tentativas / exercícios faltam |
| Turma com menos de **5 alunos** | Painel agregado sem taxa de erro: "dados insuficientes" e quantos alunos faltam. A análise individual continua |
| Conceito com menos de 3 tentativas ou 2 exercícios na turma | "Dados insuficientes" |

Linguagem sempre neutra: o nível mais baixo se chama **"Ainda não demonstrou domínio"**. Nunca se rotula
uma pessoa; descreve-se o desempenho em um conceito neste momento.

## Como cada número é calculado

**Peso da ligação (`w`)**: cada exercício se liga a conceitos com um peso (1 a 3) em `exercise_concepts`.
Peso 3 = o conceito é central naquele exercício.

**Taxa de erro do conceito (turma)** = `Σ w · [errou] ÷ Σ w`, somando todas as tentativas de todos os alunos
da turma nos exercícios ligados ao conceito. Uma tentativa em um exercício com dois conceitos conta para os dois.

**Pontuação de erro do aluno no conceito** (`score`, de 0 a 1): as tentativas do aluno no conceito são ordenadas da
mais recente para a mais antiga. A tentativa de posição `i` (0 = a mais recente) tem peso `w · 0,8^i`.
`score = Σ peso · [errou] ÷ Σ peso`. Assim, **as tentativas recentes pesam mais**: quem errou no começo e depois
acertou tem pontuação baixa; quem acertava e passou a errar, alta.

**Nível do aluno no conceito**:
| Condição | Nível |
| --- | --- |
| menos de 3 tentativas ou menos de 2 exercícios | Dados insuficientes |
| `score` ≤ 0,25 | Bom desempenho |
| 0,25 < `score` ≤ 0,50 | Em desenvolvimento |
| `score` > 0,50 | Ainda não demonstrou domínio |

**Aluno com dificuldade em um conceito** = nível "Ainda não demonstrou domínio". O painel mostra "X de Y alunos",
onde Y conta só quem tem dados suficientes (bom + em desenvolvimento + dificuldade).

**Exercícios com mais respostas incorretas**: erros ÷ tentativas por exercício, só com 3 ou mais tentativas.

**Erros recorrentes**: contagem, entre as tentativas erradas, da confusão (`misconception`, nas questões de escolha) e da
categoria de erro (sintaxe, execução, tempo esgotado, saída incorreta, alternativa/lacuna/ordem incorreta).

### Exemplo (dados de simulação do teste)
Uma turma de 6 alunos; conceito "Operadores lógicos" ligado a `s1` (peso 1) e `s2` (peso 2).
- **Ana** e **Bia** acertam 5 de 5 tentativas → `score = 0` → *Bom desempenho*.
- **Caio** e **Dani** erram 6 de 6 → `score = 1` → *Ainda não demonstrou domínio*.
- **Edu** erra as 3 primeiras e acerta as 3 últimas. Pesos (recente → antigo): 1; 0,8; 0,64; 0,512; 0,41; 0,328.
  Erros: 0,512 + 0,41 + 0,328 = 1,25; total: 3,69 → `score ≈ 0,34` → *Em desenvolvimento* (e não "dificuldade").
- **Fabi** fez 1 tentativa → *Dados insuficientes*.
A taxa de erro da turma é a soma dos erros com peso dividida pela soma dos pesos de todas as tentativas.

## Recomendações (por regras, sem IA)
Modelos de frase em `src/lib/recommendations.ts`, só com dados suficientes (turma com 5+ alunos):
- conceito com taxa de erro ≥ 40% e pelo menos max(2, 25%) dos alunos avaliados sem domínio → "A turma apresenta dificuldade em ... Considere revisar" + botão **Criar atividade de reforço** (abre o formulário da E10 com a turma, o título e até 6 exercícios do conceito, dos mais simples aos mais difíceis);
- confusão com 3+ respostas de 2+ alunos → "Confusão frequente: ...";
- erros de código: sintaxe ≥ 40% (com 5+ erros), execução ≥ 40%, ou 3+ tempos esgotados.

## Telas
- **Turma → aba Conceitos**: o que revisar, tabela e gráfico por taxa de erro (o gráfico é escondido de leitores de tela e a tabela é a versão acessível), melhores compreendidos, erros recorrentes, exercícios com mais erros, tabela por modalidade e evolução por dia. Filtros: modalidade (livre, atividade, avaliação), período, mundo e lição.
- **Turma → aluno**: nível por conceito; ao abrir um conceito, os exercícios, as respostas dadas, a modalidade e a evolução (acertou/errou em ordem).
- Livre, atividade e avaliação nunca são misturadas sem o professor escolher: o filtro de modalidade e a tabela "Por modalidade".

## Limites
- Não há dados reais de uso ainda: os testes usam alunos e tentativas **simulados** (marcados no código).
- A pontuação mede o que o aluno fez na plataforma; não substitui a conversa com a turma.
- Exercícios de código mostram a categoria do erro, mas a "confusão" detalhada só existe nas questões de escolha.

## Ações manuais
Rodar a migration `0016_inteligencia_pedagogica.sql` no Supabase (depois da `0015`).

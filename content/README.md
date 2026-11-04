# Conteúdo da plataforma (arquivos versionados)

Aqui ficam os **mundos, conceitos, lições e exercícios** da plataforma, escritos em arquivos de texto. Em vez de digitar exercício por exercício no formulário, você edita estes arquivos, o computador confere tudo e gera o SQL que atualiza o banco.

```
content/
  mundos.json            os 7 mundos
  conceitos.json         os conceitos avaliados (66 no total)
  mundo-1/ ... mundo-7/  uma pasta por mundo, com um arquivo .json por lição
  solucoes/<id>.js       solução de referência de cada exercício de código
```

## Como adicionar uma lição

1. Crie `content/mundo-N/licao-NN-<id>.json` (copie uma existente, por exemplo `mundo-3/licao-01-fundamentos.json`).
2. Escreva a lição e os exercícios (formato abaixo).
3. Para cada exercício de código, crie `content/solucoes/<id-do-exercicio>.js` com a solução.
4. Rode `npm run content:check` e corrija os erros até aparecer **"Conteúdo válido."**
5. Rode `npm run content:build`. Isso gera `supabase/importar-conteudo.sql`.
6. No Supabase, abra o **SQL Editor**, cole o conteúdo desse arquivo e clique em **Run**. Pode rodar quantas vezes quiser.

> Exercícios novos entram como **rascunho** quando `"publicado": false`. Publique depois pelo painel do professor, depois de revisar.

## Formato de uma lição

```json
{
  "id": "condicionais",
  "mundo": "mundo-4",
  "titulo": "Estruturas condicionais",
  "foco": "Tomar decisões no fluxo do algoritmo",
  "posicao": 2,
  "diagnostica": false,
  "intro": "Texto de introdução e explicação, em linguagem simples.",
  "exemplo": "Código comentado, explicado passo a passo.",
  "revisao": "Resumo dos pontos principais.",
  "exercicios": [ ... ]
}
```

- `id`: letras minúsculas, números e hífen, até 40 caracteres. **Nunca mude o id** de uma lição ou exercício que já existe: o progresso dos alunos depende dele.
- `diagnostica: true` faz o validador exigir `confusao` em **toda** alternativa errada das questões de escolha da lição.

## Formato dos exercícios

Campos comuns a todos: `id`, `tipo` (`codigo`, `escolha` ou `lacuna`), `titulo`, `dificuldade` (`facil`, `medio`, `dificil`), `publicado`, `posicao`, `conceitos`, `enunciado`, e opcionais `minilicao` (texto "Antes de começar"), `dica` e `explicacao` (mostrada ao acertar, só escolha e lacuna).

**Conceitos** (obrigatório, pelo menos um): `"conceitos": [{ "id": "m3-logicos", "peso": 2 }]`. O peso vai de 1 (secundário) a 5 (principal). Os ids estão em `conceitos.json`.

### Código

```json
{
  "id": "soma", "tipo": "codigo", "titulo": "Somar dois números", "dificuldade": "facil",
  "publicado": true, "posicao": 1,
  "conceitos": [{ "id": "m3-aritmeticos", "peso": 2 }],
  "enunciado": "Escreva a função `soma(a, b)` que retorna a soma de dois números.",
  "funcao": "soma",
  "codigoInicial": "function soma(a, b) {\n  // seu código aqui\n}\n",
  "testes": [
    { "entrada": [2, 3], "esperado": 5 },
    { "entrada": [-1, 1], "esperado": 0 }
  ],
  "dica": "Use o operador + e não esqueça do `return`."
}
```

A solução fica em `content/solucoes/soma.js`. O validador exige que ela **passe** em todos os testes e que o `codigoInicial` **reprove** em pelo menos um (senão os testes não servem para nada). Escreva testes que aceitem qualquer solução correta: eles comparam o resultado, nunca o texto do código.

### Múltipla escolha (e interpretação de código)

```json
{
  "id": "operadores-e-ou", "tipo": "escolha", "titulo": "E ou OU?", "dificuldade": "facil",
  "publicado": true, "posicao": 1,
  "conceitos": [{ "id": "m3-logicos", "peso": 2 }],
  "enunciado": "Quanto vale `true && false`?",
  "opcoes": [
    "false",
    { "texto": "true", "confusao": "confunde && com ||" },
    { "texto": "undefined", "confusao": "acha que a operação não tem resultado" }
  ],
  "correta": 0,
  "explicacao": "O && só dá true quando os dois lados são true."
}
```

Cada alternativa é um texto simples ou `{ "texto", "confusao" }`. **A `confusao` é a ideia errada que aquela alternativa revela** (até 200 caracteres). É ela que permite ao painel do professor dizer "os alunos confundem && com ||". `correta` é o número da alternativa certa, **começando em 0**, e a alternativa certa não leva `confusao`.

### Completar a lacuna

```json
{
  "id": "completar-condicional", "tipo": "lacuna", "titulo": "Complete a condicional", "dificuldade": "facil",
  "publicado": true, "posicao": 1,
  "conceitos": [{ "id": "m4-if-else", "peso": 2 }],
  "enunciado": "Complete o código.",
  "modelo": "{{1}} (idade >= 18) {\n  return 'maior';\n} {{2}} {\n  return 'menor';\n}",
  "lacunas": [{ "respostas": ["if"] }, { "respostas": ["else"] }]
}
```

Os marcadores `{{1}}`, `{{2}}`... precisam corresponder às `lacunas`, na mesma quantidade. Cada lacuna aceita uma ou mais respostas.

## O que o validador confere

Exercício sem conceito, conceito ou mundo inexistente, ids repetidos, textos maiores do que o banco aceita, código sem solução ou com solução que não passa nos testes, testes que não reprovam o código inicial, alternativas repetidas, gabarito inválido, confusão ausente em lição diagnóstica, lacunas que não batem com o modelo.

## O que o importador faz (e o que ele nunca faz)

- **Cria** o que for novo e **atualiza** o que mudou nos arquivos.
- **Nunca sobrescreve** uma lição ou exercício que o professor **editou pelo painel** (ficam marcados como `origem = 'painel'`). Se isso acontecer com algum, o importador avisa quantos foram ignorados.
- **Nunca altera** `publicado` nem `posicao` de um exercício que já existe: publicar, despublicar e reordenar pelo painel valem sobre o arquivo.
- Dicas em níveis (dica do professor, pista do conceito) chegam na etapa E3.

## Atenção: as soluções ficam no repositório

`content/solucoes/` guarda as respostas dos exercícios de código. **Se o repositório do GitHub for público, qualquer pessoa (inclusive os alunos) pode lê-las.** Recomendação: deixe o repositório **privado** (GitHub → Settings → General → Danger Zone → Change visibility). O Vercel continua funcionando com repositório privado.

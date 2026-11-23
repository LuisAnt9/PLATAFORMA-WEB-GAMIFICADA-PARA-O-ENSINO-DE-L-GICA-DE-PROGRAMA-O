-- PARTE 3 de 4: soluções comentadas. Rode as partes em ordem (1, 2, 3, 4); cada uma pode ser repetida sem duplicar nada.

-- Soluções comentadas (só professores leem a tabela; o aluno recebe pela função get_solution depois de acertar).
insert into public.exercise_solutions (exercise_id, solution, commentary)
select v.exercise_id, v.solution, v.commentary
from (values
  ($c$exemplo-corrigir$c$, $c$function dobro(n) {
  return n * 2;
}$c$, $c$O defeito estava no operador: somar 2 só coincide com o dobro quando n vale 2. O dobro é n * 2.$c$),
  ($c$exemplo-entrada-saida$c$, $c$function saudacao() {
  const nome = lerEntrada();
  console.log(`Olá, ${nome}!`);
}$c$, $c$lerEntrada() entrega o nome; um template literal (com crases) monta a frase e console.log a imprime.$c$),
  ($c$eps-eco$c$, $c$function eco() {
  const valor = lerEntrada();
  console.log(valor);
}$c$, $c$O programa tem só duas etapas: a entrada (lerEntrada) e a saída (console.log). Aqui não há processamento, porque o valor é mostrado do jeito que chegou.$c$),
  ($c$eps-dobro$c$, $c$function dobro() {
  const n = lerEntrada();
  console.log(n * 2);
}$c$, $c$Agora o programa tem as três etapas: lê o número (entrada), multiplica por 2 (processamento) e mostra o resultado (saída).$c$),
  ($c$inverter-texto$c$, $c$function inverterTexto(s) {
  let r = "";
  for (let i = s.length - 1; i >= 0; i--) r += s[i];
  return r;
}$c$, $c$$c$),
  ($c$conta-vogais$c$, $c$function contaVogais(s) {
  let c = 0;
  for (const ch of s) if ("aeiou".includes(ch)) c++;
  return c;
}$c$, $c$$c$),
  ($c$palindromo$c$, $c$function ehPalindromo(s) {
  for (let i = 0, j = s.length - 1; i < j; i++, j--)
    if (s[i] !== s[j]) return false;
  return true;
}$c$, $c$$c$),
  ($c$declaracao-corrija-o-nome$c$, $c$function quadrado(numero) {
  let resultado = numero * numero;
  return resultado;
}$c$, $c$O defeito estava na grafia: Resultado (maiúsculo) não existe, porque a variável se chama resultado. Em JavaScript, maiúsculas e minúsculas contam.$c$),
  ($c$letconst-corrija-a-area$c$, $c$function areaDoCirculo(raio) {
  const PI = 3.14;
  let area = 0;
  area = PI * raio * raio;
  return area;
}$c$, $c$area foi declarada com const e depois recebeu outro valor. Como ela muda, deve ser let (ou ser declarada já com o resultado).$c$),
  ($c$string-corrija-as-aspas$c$, $c$function cidade() {
  return "Picos";
}$c$, $c$Sem aspas, Picos é entendido como o nome de uma variável que não existe. Entre aspas, vira um texto.$c$),
  ($c$number-media-de-dois$c$, $c$function media(a, b) {
  return (a + b) / 2;
}$c$, $c$A média é a soma dos valores dividida pela quantidade deles: (a + b) / 2. Os parênteses garantem que a soma aconteça antes da divisão.$c$),
  ($c$textos-inicial-em-maiuscula$c$, $c$function inicial(nome) {
  return nome.trim()[0].toUpperCase();
}$c$, $c$trim() remove os espaços das pontas, [0] pega a primeira letra e toUpperCase() a deixa em maiúscula. Os métodos podem ser encadeados.$c$),
  ($c$concat-nome-completo$c$, $c$function nomeCompleto(nome, sobrenome) {
  return nome + " " + sobrenome;
}$c$, $c$Concatenamos três partes: o nome, o espaço (" ") e o sobrenome.$c$),
  ($c$template-corrija-a-saudacao$c$, $c$function saudacao(nome) {
  return `Olá, ${nome}!`;
}$c$, $c$Com aspas comuns, o ${nome} não é substituído. Trocando por crases, o valor da variável entra no texto.$c$),
  ($c$template-apresentar$c$, $c$function apresentar(nome, idade) {
  return `${nome} tem ${idade} anos`;
}$c$, $c$O template literal `${nome} tem ${idade} anos` insere as duas variáveis no texto.$c$),
  ($c$operacoes-media-de-tres$c$, $c$function mediaDeTres(a, b, c) {
  return (a + b + c) / 3;
}$c$, $c$A média é (a + b + c) / 3. Os parênteses fazem a soma acontecer antes da divisão.$c$),
  ($c$conversao-corrija-a-soma$c$, $c$function somar(a, b) {
  return Number(a) + Number(b);
}$c$, $c$Com textos, o + junta ("23"). Convertendo cada valor com Number(), o + soma de verdade.$c$),
  ($c$conversao-somar-entradas$c$, $c$function somarEntradas() {
  const a = Number(lerEntrada());
  const b = Number(lerEntrada());
  console.log(a + b);
}$c$, $c$Sem a conversão, "4" + "6" daria "46". Com Number() em cada valor, a soma é feita entre números.$c$),
  ($c$es-boas-vindas$c$, $c$function boasVindas() {
  const nome = lerEntrada();
  console.log(`Bem-vindo, ${nome}!`);
}$c$, $c$A entrada fica na variável nome e a saída é montada com um template literal: `Bem-vindo, ${nome}!`.$c$),
  ($c$es-area-do-retangulo$c$, $c$function areaDoRetangulo() {
  const base = Number(lerEntrada());
  const altura = Number(lerEntrada());
  console.log(`Área: ${base * altura}`);
}$c$, $c$Lemos base e altura, convertemos para número, multiplicamos e mostramos a frase com o resultado.$c$),
  ($c$es-corrija-o-ano-que-vem$c$, $c$function anoQueVem() {
  const idade = Number(lerEntrada());
  console.log("Ano que vem: " + (idade + 1));
}$c$, $c$Como idade é texto, o + junta "20" e 1 (201). Convertendo com Number() e somando antes de juntar ao texto, o resultado é 21.$c$),
  ($c$es-media-das-notas$c$, $c$function mediaDasNotas() {
  const n1 = Number(lerEntrada());
  const n2 = Number(lerEntrada());
  const n3 = Number(lerEntrada());
  const media = (n1 + n2 + n3) / 3;
  console.log(`Média: ${media}`);
}$c$, $c$O programa lê as três notas, converte cada uma com Number(), calcula (n1 + n2 + n3) / 3 e mostra a frase.$c$),
  ($c$log-mostrar-os-dados$c$, $c$function mostrarDados() {
  const nome = lerEntrada();
  const idade = lerEntrada();
  console.log("Nome:", nome);
  console.log("Idade:", idade);
}$c$, $c$Duas chamadas de console.log geram duas linhas, e a vírgula coloca o espaço entre o rótulo e o valor.$c$),
  ($c$log-corrija-o-total$c$, $c$function mostrarTotal(preco, quantidade) {
  const total = preco * quantidade;
  console.log("Total:", total);
}$c$, $c$Com a vírgula, o console.log coloca o espaço sozinho. Também funcionaria incluir o espaço no texto: "Total: " + total.$c$),
  ($c$desafio2-ficha-da-pessoa$c$, $c$function ficha() {
  const nome = lerEntrada();
  const idade = Number(lerEntrada());
  const altura = Number(lerEntrada());
  console.log(`Nome: ${nome}`);
  console.log(`Idade: ${idade} anos`);
  console.log(`Altura: ${altura} m`);
  console.log(`Daqui a 10 anos, ${nome} terá ${idade + 10} anos.`);
}$c$, $c$O programa lê os três dados, converte a idade para número, soma 10 e monta cada frase com template literals.$c$),
  ($c$desafio2-corrija-o-resumo$c$, $c$function resumo() {
  const a = Number(lerEntrada());
  const b = Number(lerEntrada());
  const soma = a + b;
  const media = soma / 2;
  console.log(`Soma: ${soma}`);
  console.log(`Média: ${media}`);
}$c$, $c$Como as entradas são texto, a + b juntava os valores ("46"). Convertendo com Number(), a soma e a média passam a ser calculadas com números.$c$),
  ($c$soma$c$, $c$function soma(a, b) {
  return a + b;
}$c$, $c$$c$),
  ($c$media$c$, $c$function media(a, b, c) {
  return (a + b + c) / 3;
}$c$, $c$$c$),
  ($c$celsius$c$, $c$function celsiusParaFahrenheit(c) {
  return (c * 9) / 5 + 32;
}$c$, $c$$c$),
  ($c$area-retangulo$c$, $c$function areaRetangulo(b, a) {
  return b * a;
}$c$, $c$$c$),
  ($c$quadrado$c$, $c$function quadrado(n) {
  return n * n;
}$c$, $c$$c$),
  ($c$media-ponderada$c$, $c$function mediaPonderada(a, b) {
  return (a * 3 + b * 7) / 10;
}$c$, $c$$c$),
  ($c$arit-ultimo-digito$c$, $c$function ultimoDigito(n) {
  return n % 10;
}$c$, $c$n % 10 devolve o que sobra da divisão por 10, que é exatamente o último dígito.$c$),
  ($c$arit-corrija-o-quadrado$c$, $c$function quadrado(n) {
  return n ** 2;
}$c$, $c$Em JavaScript, ^ é outro operador (bit a bit), por isso 3 ^ 2 dá 1. A potência é escrita com **: n ** 2.$c$),
  ($c$atrib-corrija-o-total$c$, $c$function somarAoTotal(n) {
  let total = 10;
  total += n;
  return total;
}$c$, $c$total =+ n guarda o valor +n em total, apagando o 10. O operador de soma e atribuição é +=.$c$),
  ($c$atrib-aplicar-desconto$c$, $c$function aplicarDesconto(preco, percentual) {
  const desconto = preco * percentual / 100;
  preco -= desconto;
  return preco;
}$c$, $c$O desconto é preco * percentual / 100. Com preco -= desconto, o preço é atualizado e devolvido.$c$),
  ($c$rel-pode-votar$c$, $c$function podeVotar(idade) {
  return idade >= 16;
}$c$, $c$idade >= 16 resulta em true ou false, que é exatamente o que a função deve devolver.$c$),
  ($c$rel-corrija-a-igualdade$c$, $c$function saoIguais(a, b) {
  return a === b;
}$c$, $c$O == converte os tipos antes de comparar (5 == "5" e 0 == false são true). O === exige o mesmo tipo.$c$),
  ($c$log-pode-entrar$c$, $c$function podeEntrar(idade, temIngresso) {
  return idade >= 18 && temIngresso;
}$c$, $c$idade >= 18 && temIngresso só é true quando a comparação e temIngresso forem verdadeiros ao mesmo tempo.$c$),
  ($c$log-corrija-o-intervalo$c$, $c$function foraDoIntervalo(n) {
  return n < 0 || n > 100;
}$c$, $c$Com &&, as duas condições precisam valer juntas, o que nunca acontece. Com ||, basta que uma delas seja verdadeira.$c$),
  ($c$prec-celsius-para-fahrenheit$c$, $c$function fahrenheit(c) {
  return c * 9 / 5 + 32;
}$c$, $c$c * 9 / 5 + 32 faz a multiplicação e a divisão (da esquerda para a direita) antes de somar 32.$c$),
  ($c$prec-corrija-a-media$c$, $c$function media(a, b) {
  return (a + b) / 2;
}$c$, $c$Sem parênteses, só o b é dividido por 2. A média é (a + b) / 2.$c$),
  ($c$desafio3-calculadora$c$, $c$function calculadora() {
  const a = Number(lerEntrada());
  const b = Number(lerEntrada());
  console.log("Soma:", a + b);
  console.log("Subtração:", a - b);
  console.log("Multiplicação:", a * b);
  console.log("Divisão:", a / b);
  console.log("Resto:", a % b);
  console.log("Divisão por zero?", b === 0);
}$c$, $c$O programa converte as entradas, calcula cada operação e mostra o resultado. Com divisor 0 a divisão dá Infinity e o resto dá NaN, e a comparação b === 0 avisa o problema.$c$),
  ($c$desafio3-corrija-a-aprovacao$c$, $c$function aprovado(n1, n2, frequencia) {
  const media = (n1 + n2) / 2;
  return media >= 7 && frequencia >= 75;
}$c$, $c$Sem parênteses, só n2 era dividido por 2. A média correta é (n1 + n2) / 2, e o restante da função, com &&, já estava certo.$c$),
  ($c$par-ou-impar$c$, $c$function parOuImpar(n) {
  return n % 2 === 0 ? "par" : "impar";
}$c$, $c$$c$),
  ($c$maior-de-tres$c$, $c$function maiorDeTres(a, b, c) {
  let m = a;
  if (b > m) m = b;
  if (c > m) m = c;
  return m;
}$c$, $c$$c$),
  ($c$nota$c$, $c$function situacao(n) {
  if (n >= 7) return "aprovado";
  else if (n >= 5) return "recuperacao";
  return "reprovado";
}$c$, $c$$c$),
  ($c$bissexto$c$, $c$function ehBissexto(a) {
  return (a % 4 === 0 && a % 100 !== 0) || a % 400 === 0;
}$c$, $c$$c$),
  ($c$dentro-do-intervalo$c$, $c$function dentroDoIntervalo(n, min, max) {
  return n >= min && n <= max;
}$c$, $c$$c$),
  ($c$tipo-de-triangulo$c$, $c$function tipoTriangulo(a, b, c) {
  if (a === b && b === c) return "equilatero";
  if (a === b || a === c || b === c) return "isosceles";
  return "escaleno";
}$c$, $c$$c$),
  ($c$revrel-nota-passou$c$, $c$function passou(nota) {
  return nota >= 7;
}$c$, $c$nota >= 7 compara e devolve o booleano que a função deve retornar.$c$),
  ($c$revrel-corrija-o-igual$c$, $c$function ehDez(n) {
  return n === 10;
}$c$, $c$n = 10 guarda 10 em n e devolve 10. Para comparar, usamos ===: n === 10.$c$),
  ($c$revlog-tem-desconto$c$, $c$function temDesconto(idade) {
  return idade < 12 || idade >= 60;
}$c$, $c$idade < 12 || idade >= 60 é true quando a pessoa é criança ou idosa.$c$),
  ($c$revlog-corrija-o-fim-de-semana$c$, $c$function ehFimDeSemana(dia) {
  return dia === "sábado" || dia === "domingo";
}$c$, $c$Com &&, o dia teria que ser igual aos dois valores ao mesmo tempo, o que nunca acontece. Com ||, basta ser um dos dois.$c$),
  ($c$if-bonus-de-vendas$c$, $c$function bonus(vendas) {
  let valor = 0;
  if (vendas >= 1000) {
    valor = 100;
  }
  return valor;
}$c$, $c$O valor começa em 0 e o if o troca por 100 apenas quando vendas >= 1000.$c$),
  ($c$if-corrija-o-ponto-e-virgula$c$, $c$function classificar(idade) {
  let texto = "menor";
  if (idade >= 18) {
    texto = "maior";
  }
  return texto;
}$c$, $c$O ; depois da condição encerra o if (vazio), e o bloco seguinte passa a executar sempre. Sem o ;, o bloco pertence ao if.$c$),
  ($c$if-corrija-a-atribuicao$c$, $c$function ehDezoito(idade) {
  if (idade === 18) {
    return true;
  }
  return false;
}$c$, $c$idade = 18 guarda 18 na variável e a condição passa a valer 18 (verdadeira) sempre. Para comparar, use ===$c$),
  ($c$ifelse-par-ou-impar-funcao$c$, $c$function parOuImpar(n) {
  if (n % 2 === 0) {
    return "par";
  } else {
    return "impar";
  }
}$c$, $c$n % 2 === 0 identifica os pares. O else cobre todos os outros números (inclusive negativos ímpares).$c$),
  ($c$ifelse-o-maior-de-dois$c$, $c$function maior(a, b) {
  if (a > b) {
    return a;
  } else {
    return b;
  }
}$c$, $c$Se a > b, o maior é a; no caso contrário (inclusive empate), b serve.$c$),
  ($c$ifelse-corrija-o-else-que-faltou$c$, $c$function situacao(nota) {
  let texto = "";
  if (nota >= 7) {
    texto = "aprovado";
  } else {
    texto = "reprovado";
  }
  return texto;
}$c$, $c$A atribuição de "reprovado" ficava depois do if e sobrescrevia o resultado. Colocando-a dentro de um else, ela só executa quando a nota é menor que 7.$c$),
  ($c$elseif-classificar-nota$c$, $c$function classificarNota(nota) {
  if (nota >= 9) {
    return "A";
  } else if (nota >= 7) {
    return "B";
  } else if (nota >= 5) {
    return "C";
  } else {
    return "D";
  }
}$c$, $c$As condições vão da maior faixa para a menor, e o else cobre as notas abaixo de 5.$c$),
  ($c$elseif-sinal-do-numero$c$, $c$function sinal(n) {
  if (n > 0) {
    return "positivo";
  } else if (n < 0) {
    return "negativo";
  } else {
    return "zero";
  }
}$c$, $c$if (n > 0) cobre os positivos, else if (n < 0) os negativos, e o else, o zero.$c$),
  ($c$elseif-corrija-a-ordem$c$, $c$function faixa(nota) {
  if (nota >= 7) {
    return "Bom";
  } else if (nota >= 5) {
    return "Regular";
  } else {
    return "Insuficiente";
  }
}$c$, $c$nota >= 5 é verdadeira também para 8, então a faixa Bom nunca era alcançada. Testando >= 7 antes de >= 5, cada nota cai na faixa certa.$c$),
  ($c$aninhada-desconto-do-ingresso$c$, $c$function descontoDoIngresso(idade, estudante) {
  if (idade < 18) {
    return 100;
  } else {
    if (estudante) {
      return 50;
    } else {
      return 0;
    }
  }
}$c$, $c$Se a pessoa tem menos de 18 anos, o desconto é 100. Caso contrário, dentro do else, o desconto depende de ser estudante.$c$),
  ($c$aninhada-corrija-o-else-interno$c$, $c$function acesso(idade, temIngresso) {
  if (idade >= 18) {
    if (temIngresso) {
      return "entrou";
    } else {
      return "sem ingresso";
    }
  } else {
    return "menor";
  }
}$c$, $c$Faltava um else para o if interno: sem ele, o adulto sem ingresso não passava por nenhum return.$c$),
  ($c$switch-nome-do-dia$c$, $c$function nomeDoDia(numero) {
  switch (numero) {
    case 1:
      return "domingo";
    case 2:
      return "segunda";
    case 3:
      return "terca";
    case 4:
      return "quarta";
    case 5:
      return "quinta";
    case 6:
      return "sexta";
    case 7:
      return "sabado";
    default:
      return "invalido";
  }
}$c$, $c$Cada case devolve o nome; como return já encerra a função, o break não é necessário. O default trata os números fora da lista.$c$),
  ($c$switch-calculadora-de-operacao$c$, $c$function calcular(operacao, a, b) {
  switch (operacao) {
    case "+":
      return a + b;
    case "-":
      return a - b;
    case "*":
      return a * b;
    case "/":
      return a / b;
    default:
      return "operacao invalida";
  }
}$c$, $c$O switch compara o texto da operação com cada case. O default devolve a mensagem para operações desconhecidas.$c$),
  ($c$switch-corrija-o-break$c$, $c$function tipo(codigo) {
  let t = "";
  switch (codigo) {
    case 1:
      t = "fruta";
      break;
    case 2:
      t = "legume";
      break;
    default:
      t = "outro";
  }
  return t;
}$c$, $c$Sem break, a execução cai para os cases seguintes e o último valor (outro) sobrescreve os anteriores. Um break depois de cada atribuição resolve.$c$),
  ($c$ternario-par-ou-impar$c$, $c$function parOuImpar(n) {
  return n % 2 === 0 ? "par" : "impar";
}$c$, $c$O ternário escolhe o valor a devolver conforme n % 2 === 0.$c$),
  ($c$ternario-valor-absoluto$c$, $c$function absoluto(n) {
  return n < 0 ? -n : n;
}$c$, $c$Quando n < 0, o oposto -n é positivo; caso contrário, o próprio n já serve.$c$),
  ($c$ternario-corrija-a-ordem$c$, $c$function situacao(nota) {
  return nota >= 7 ? "aprovado" : "reprovado";
}$c$, $c$O valor depois do ? é usado quando a condição é verdadeira. Os dois textos estavam trocados.$c$),
  ($c$desafio4-sistema-de-notas$c$, $c$function sistemaDeNotas() {
  const n1 = Number(lerEntrada());
  const n2 = Number(lerEntrada());
  const n3 = Number(lerEntrada());
  const media = (n1 + n2 + n3) / 3;
  let situacao;
  if (media >= 7) {
    situacao = "Aprovado";
  } else if (media >= 5) {
    situacao = "Recuperação";
  } else {
    situacao = "Reprovado";
  }
  console.log("Média:", media);
  console.log("Situação:", situacao);
}$c$, $c$Depois de converter as entradas e calcular a média, a cadeia if / else if / else escolhe a situação. Os testes de fronteira (7 e 5) conferem se o >= foi usado corretamente.$c$),
  ($c$desafio4-corrija-o-desconto$c$, $c$function desconto(valor, cliente) {
  if (valor >= 100) {
    if (cliente === "vip") {
      return valor * 0.8;
    } else {
      return valor * 0.9;
    }
  } else {
    return valor;
  }
}$c$, $c$O desconto só existe a partir de 100; dentro dessa faixa, o cliente vip tem 20% e os demais 10%. A estrutura original decidia pelo valor e só olhava o cliente quando o valor era menor.$c$),
  ($c$somatorio$c$, $c$function somatorio(n) {
  let s = 0;
  for (let i = 1; i <= n; i++) s += i;
  return s;
}$c$, $c$$c$),
  ($c$fatorial$c$, $c$function fatorial(n) {
  let f = 1;
  for (let i = 2; i <= n; i++) f *= i;
  return f;
}$c$, $c$$c$),
  ($c$tabuada$c$, $c$function tabuada(n) {
  const r = [];
  for (let i = 1; i <= 10; i++) r.push(n * i);
  return r;
}$c$, $c$$c$),
  ($c$primo$c$, $c$function ehPrimo(n) {
  if (n < 2) return false;
  for (let i = 2; i < n; i++) if (n % i === 0) return false;
  return true;
}$c$, $c$$c$),
  ($c$soma-dos-pares$c$, $c$function somaPares(n) {
  let s = 0;
  for (let i = 2; i <= n; i += 2) s += i;
  return s;
}$c$, $c$$c$),
  ($c$potencia$c$, $c$function potencia(base, exp) {
  let r = 1;
  for (let i = 0; i < exp; i++) r *= base;
  return r;
}$c$, $c$$c$),
  ($c$conta-digitos$c$, $c$function contaDigitos(n) {
  let c = 1;
  while (n >= 10) {
    n = Math.floor(n / 10);
    c++;
  }
  return c;
}$c$, $c$$c$),
  ($c$mdc$c$, $c$function mdc(a, b) {
  while (b !== 0) {
    const r = a % b;
    a = b;
    b = r;
  }
  return a;
}$c$, $c$$c$),
  ($c$rep-intro-repetir-texto$c$, $c$function repetir(texto, vezes) {
  let resultado = "";
  for (let i = 0; i < vezes; i++) {
    resultado += texto;
  }
  return resultado;
}$c$, $c$Um laço que repete `vezes` vezes e, a cada volta, acrescenta o texto ao resultado. Com 0 vezes, o laço não executa e o resultado fica vazio.$c$),
  ($c$rep-intro-corrija-a-contagem$c$, $c$function contagem(n) {
  let texto = "";
  for (let i = 1; i <= n; i++) {
    texto += (texto === "" ? "" : " ") + i;
  }
  return texto;
}$c$, $c$Com i < n, o laço para antes de n. Trocando por i <= n, o último valor também entra (erro de um no limite).$c$),
  ($c$for-tabuada$c$, $c$function tabuada() {
  const n = Number(lerEntrada());
  for (let i = 1; i <= 10; i++) {
    console.log(n + " x " + i + " = " + n * i);
  }
}$c$, $c$Um for de 1 a 10 mostra uma linha por volta, usando o número lido e o valor do contador.$c$),
  ($c$for-contagem-regressiva$c$, $c$function regressiva(n) {
  let texto = "";
  for (let i = n; i >= 1; i--) {
    texto += (texto === "" ? "" : " ") + i;
  }
  return texto;
}$c$, $c$Um for que começa em n e usa i-- enquanto i >= 1 percorre os números de trás para frente.$c$),
  ($c$for-corrija-a-soma$c$, $c$function somarAte(n) {
  let soma = 0;
  for (let i = 1; i <= n; i++) {
    soma += i;
  }
  return soma;
}$c$, $c$Com i < n, o último valor (n) fica de fora. Usando i <= n, a soma inclui todos os números de 1 a n.$c$),
  ($c$for-fatorial$c$, $c$function fatorial(n) {
  let resultado = 1;
  for (let i = 1; i <= n; i++) {
    resultado *= i;
  }
  return resultado;
}$c$, $c$O resultado começa em 1 e é multiplicado por cada valor de 1 até n. Para n = 0 o laço não executa e o resultado continua 1.$c$),
  ($c$while-contar-digitos$c$, $c$function contarDigitos(n) {
  let digitos = 0;
  while (n > 0) {
    n = Math.floor(n / 10);
    digitos++;
  }
  return digitos;
}$c$, $c$A cada volta o último dígito é removido (divisão inteira por 10) e o contador sobe um. O laço termina quando n chega a 0.$c$),
  ($c$while-corrija-a-condicao$c$, $c$function somaDe1Ate(n) {
  let i = 1;
  let soma = 0;
  while (i <= n) {
    soma += i;
    i++;
  }
  return soma;
}$c$, $c$A condição i > n é falsa desde o início, então o corpo nunca roda. O correto é continuar enquanto i <= n.$c$),
  ($c$while-passos-de-collatz$c$, $c$function passos(n) {
  let contador = 0;
  while (n !== 1) {
    if (n % 2 === 0) {
      n = n / 2;
    } else {
      n = 3 * n + 1;
    }
    contador++;
  }
  return contador;
}$c$, $c$Enquanto n for diferente de 1, aplica-se a regra (par ou ímpar) e conta-se um passo. Para n = 1 o laço não executa.$c$),
  ($c$dowhile-somar-ate-zero$c$, $c$function somarAteZero() {
  let soma = 0;
  let valor;
  do {
    valor = Number(lerEntrada());
    soma += valor;
  } while (valor !== 0);
  console.log(soma);
}$c$, $c$Um do...while lê o número, soma e só então confere se foi o 0. Assim a leitura acontece antes do teste, como o problema pede.$c$),
  ($c$dowhile-corrija-o-limite$c$, $c$function contarAte(n) {
  let i = 1;
  let texto = "";
  do {
    texto += (texto === "" ? "" : " ") + i;
    i++;
  } while (i <= n);
  return texto;
}$c$, $c$Com i < n o laço para antes de incluir n. A condição correta é i <= n.$c$),
  ($c$dowhile-validar-nota$c$, $c$function validarNota() {
  let nota;
  do {
    nota = Number(lerEntrada());
  } while (nota < 0 || nota > 10);
  console.log("Nota válida:", nota);
}$c$, $c$Um do...while lê a nota e repete enquanto ela for menor que 0 ou maior que 10. Quando sai do laço, a nota é válida.$c$),
  ($c$contador-contar-pares$c$, $c$function contarPares(n) {
  let pares = 0;
  for (let i = 1; i <= n; i++) {
    if (i % 2 === 0) {
      pares++;
    }
  }
  return pares;
}$c$, $c$Um contador começa em 0 e sobe 1 para cada par encontrado entre 1 e n.$c$),
  ($c$contador-contar-vogais$c$, $c$function contarVogais(texto) {
  let vogais = 0;
  for (let i = 0; i < texto.length; i++) {
    if ("aeiou".includes(texto[i].toLowerCase())) {
      vogais++;
    }
  }
  return vogais;
}$c$, $c$O laço percorre cada letra e, se ela é uma vogal, o contador sobe 1.$c$),
  ($c$contador-corrija-o-inicio$c$, $c$function contarMultiplos(n, k) {
  let contador = 0;
  for (let i = 1; i <= n; i++) {
    if (i % k === 0) {
      contador++;
    }
  }
  return contador;
}$c$, $c$Um contador começa em 0: antes de olhar os números, nada foi contado. Começando em 1, o resultado fica sempre um a mais.$c$),
  ($c$contador-contar-divisores$c$, $c$function contarDivisores(n) {
  let divisores = 0;
  for (let i = 1; i <= n; i++) {
    if (n % i === 0) {
      divisores++;
    }
  }
  return divisores;
}$c$, $c$Um contador sobe para cada i de 1 até n que divide n sem deixar resto.$c$),
  ($c$acumulador-soma-dos-pares$c$, $c$function somaDosPares(n) {
  let soma = 0;
  for (let i = 1; i <= n; i++) {
    if (i % 2 === 0) {
      soma += i;
    }
  }
  return soma;
}$c$, $c$O acumulador começa em 0 e soma cada par encontrado entre 1 e n.$c$),
  ($c$acumulador-somar-tres-entradas$c$, $c$function somarTres() {
  let soma = 0;
  for (let i = 0; i < 3; i++) {
    soma += Number(lerEntrada());
  }
  console.log(soma);
}$c$, $c$Um for de 3 voltas lê cada número, converte e soma ao acumulador. Ao final, mostra o total.$c$),
  ($c$acumulador-corrija-o-produto$c$, $c$function produtoAte(n) {
  let produto = 1;
  for (let i = 1; i <= n; i++) {
    produto *= i;
  }
  return produto;
}$c$, $c$Para multiplicar, o acumulador deve começar em 1 (o elemento neutro do produto). Começando em 0, o resultado é sempre 0.$c$),
  ($c$acumulador-media-das-entradas$c$, $c$function media() {
  const quantidade = Number(lerEntrada());
  let soma = 0;
  for (let i = 0; i < quantidade; i++) {
    soma += Number(lerEntrada());
  }
  console.log(soma / quantidade);
}$c$, $c$O acumulador soma os números lidos em um for e, depois do laço, a soma é dividida pela quantidade.$c$),
  ($c$break-primeiro-divisor$c$, $c$function primeiroDivisor(n) {
  let divisor = n;
  for (let i = 2; i <= n; i++) {
    if (n % i === 0) {
      divisor = i;
      break;
    }
  }
  return divisor;
}$c$, $c$O laço testa 2, 3, 4... e o break encerra no primeiro divisor. Se nenhum antes de n divide, o próprio n é o primeiro divisor.$c$),
  ($c$break-somar-ate-negativo$c$, $c$function somarAteNegativo() {
  let soma = 0;
  while (true) {
    const n = Number(lerEntrada());
    if (n < 0) {
      break;
    }
    soma += n;
  }
  console.log(soma);
}$c$, $c$O laço lê cada número e, ao encontrar um negativo, o break encerra antes de somá-lo.$c$),
  ($c$break-corrija-o-primeiro$c$, $c$function primeiroMultiploDe7(limite) {
  let achado = -1;
  for (let i = 1; i <= limite; i++) {
    if (i % 7 === 0) {
      achado = i;
      break;
    }
  }
  return achado;
}$c$, $c$Sem break, o laço continua e sobrescreve achado com os múltiplos seguintes. O break encerra na primeira ocorrência.$c$),
  ($c$break-eh-primo$c$, $c$function ehPrimo(n) {
  if (n < 2) {
    return false;
  }
  let primo = true;
  for (let i = 2; i < n; i++) {
    if (n % i === 0) {
      primo = false;
      break;
    }
  }
  return primo;
}$c$, $c$O laço procura um divisor entre 2 e n - 1; ao achar um, o break (ou return) encerra. Se não achar e n > 1, n é primo.$c$),
  ($c$continue-soma-sem-multiplos-de-tres$c$, $c$function somaSemMultiplosDeTres(n) {
  let soma = 0;
  for (let i = 1; i <= n; i++) {
    if (i % 3 === 0) {
      continue;
    }
    soma += i;
  }
  return soma;
}$c$, $c$O laço soma cada i ao acumulador, exceto os múltiplos de 3, que caem no continue.$c$),
  ($c$continue-sem-vogais$c$, $c$function semVogais(texto) {
  let resultado = "";
  for (let i = 0; i < texto.length; i++) {
    if ("aeiou".includes(texto[i].toLowerCase())) {
      continue;
    }
    resultado += texto[i];
  }
  return resultado;
}$c$, $c$O laço percorre as letras; vogais são puladas e as demais são acrescentadas ao resultado.$c$),
  ($c$continue-corrija-o-laco$c$, $c$function somarImpares(n) {
  let i = 0;
  let soma = 0;
  while (i < n) {
    i++;
    if (i % 2 === 0) {
      continue;
    }
    soma += i;
  }
  return soma;
}$c$, $c$Com o continue antes de i++, quando i é par o contador nunca avança. Atualize i antes do continue (por exemplo, no início do laço, somando 1).$c$),
  ($c$aninhados-retangulo$c$, $c$function retangulo(linhas, colunas) {
  for (let i = 0; i < linhas; i++) {
    let linha = "";
    for (let j = 0; j < colunas; j++) {
      linha += "*";
    }
    console.log(linha);
  }
}$c$, $c$O laço externo percorre as linhas; o interno acrescenta um asterisco por coluna; ao fim de cada linha, ela é mostrada.$c$),
  ($c$aninhados-tabela-de-multiplicacao$c$, $c$function tabela() {
  for (let i = 1; i <= 3; i++) {
    let linha = "";
    for (let j = 1; j <= 3; j++) {
      linha += (j === 1 ? "" : " ") + i * j;
    }
    console.log(linha);
  }
}$c$, $c$O laço externo escolhe a linha (i) e o interno percorre as colunas (j), juntando os produtos em um texto que é mostrado ao fim da linha.$c$),
  ($c$aninhados-corrija-o-triangulo$c$, $c$function triangulo(n) {
  for (let i = 1; i <= n; i++) {
    let linha = "";
    for (let j = 1; j <= i; j++) {
      linha += "*";
    }
    console.log(linha);
  }
}$c$, $c$Com j <= n, todas as linhas têm n asteriscos. Com j <= i, a linha i tem i asteriscos.$c$),
  ($c$aninhados-contar-pares$c$, $c$function contarPares(n) {
  let pares = 0;
  for (let i = 1; i <= n; i++) {
    for (let j = i + 1; j <= n; j++) {
      pares++;
    }
  }
  return pares;
}$c$, $c$O laço interno começa em i + 1, então cada par é contado uma só vez. Um contador soma 1 a cada par.$c$),
  ($c$desafio5-adivinhacao$c$, $c$function adivinhar(segredo, tentativas) {
  for (let i = 1; i <= tentativas; i++) {
    const palpite = Number(lerEntrada());
    if (palpite === segredo) {
      console.log("Acertou! Tentativas: " + i);
      return;
    } else if (palpite < segredo) {
      console.log("O número é maior");
    } else {
      console.log("O número é menor");
    }
  }
  console.log("Fim de jogo! O número era " + segredo);
}$c$, $c$Um for percorre as tentativas, lendo e comparando cada palpite. No acerto, o jogo encerra com o número de tentativas usadas; se o laço acaba, revela o número.$c$),
  ($c$desafio5-corrija-o-resumo$c$, $c$function resumo(n) {
  let soma = 0;
  let pares = 0;
  for (let i = 1; i <= n; i++) {
    if (i % 2 === 0) {
      pares++;
      continue;
    }
    soma += i;
  }
  return soma + " " + pares;
}$c$, $c$O pares++ ficava depois do continue, então nunca executava. Colocando-o antes do continue, cada par é contado e depois a volta é pulada.$c$),
  ($c$soma-vetor$c$, $c$function somaVetor(v) {
  let s = 0;
  for (let i = 0; i < v.length; i++) s += v[i];
  return s;
}$c$, $c$$c$),
  ($c$inverter-vetor$c$, $c$function inverter(v) {
  const r = [];
  for (let i = v.length - 1; i >= 0; i--) r.push(v[i]);
  return r;
}$c$, $c$$c$),
  ($c$maior-vetor$c$, $c$function maiorElemento(v) {
  let m = v[0];
  for (const x of v) if (x > m) m = x;
  return m;
}$c$, $c$$c$),
  ($c$busca-linear$c$, $c$function buscar(v, x) {
  for (let i = 0; i < v.length; i++) if (v[i] === x) return i;
  return -1;
}$c$, $c$$c$),
  ($c$ordenar$c$, $c$function ordenar(v) {
  const r = [...v];
  for (let i = 0; i < r.length; i++)
    for (let j = 0; j < r.length - 1 - i; j++)
      if (r[j] > r[j + 1]) {
        const t = r[j];
        r[j] = r[j + 1];
        r[j + 1] = t;
      }
  return r;
}$c$, $c$$c$),
  ($c$conta-pares$c$, $c$function contaPares(v) {
  let c = 0;
  for (const x of v) if (x % 2 === 0) c++;
  return c;
}$c$, $c$$c$),
  ($c$media-do-vetor$c$, $c$function mediaVetor(v) {
  let s = 0;
  for (const x of v) s += x;
  return s / v.length;
}$c$, $c$$c$),
  ($c$segundo-maior$c$, $c$function segundoMaior(v) {
  let a = -Infinity,
    b = -Infinity;
  for (const x of v) {
    if (x > a) {
      b = a;
      a = x;
    } else if (x < a && x > b) {
      b = x;
    }
  }
  return b;
}$c$, $c$$c$),
  ($c$vet-intro-soma-de-tres$c$, $c$function somaDeTres(v) {
  return v[0] + v[1] + v[2];
}$c$, $c$Os elementos ficam nas posições 0, 1 e 2; basta somá-los.$c$),
  ($c$vet-intro-corrija-a-posicao$c$, $c$function somaDosDois(v) {
  return v[0] + v[1];
}$c$, $c$A contagem começa em 0: os elementos estão nas posições 0 e 1. Usar v[2] acessa uma posição que não existe (undefined).$c$),
  ($c$arr-inverter-tres$c$, $c$function inverterTres(v) {
  return [v[2], v[1], v[0]];
}$c$, $c$Um novo array é criado com os elementos lidos das posições 2, 1 e 0.$c$),
  ($c$arr-corrija-a-atribuicao$c$, $c$function dobrarSegundo(v) {
  v[1] = v[1] * 2;
  return v;
}$c$, $c$v[1] * 2 só calcula o valor e o descarta. É preciso atribuir o resultado: v[1] = v[1] * 2.$c$),
  ($c$ind-segundo$c$, $c$function segundo(v) {
  return v[1];
}$c$, $c$O segundo elemento está na posição de índice 1: v[1].$c$),
  ($c$ind-trocar-duas-posicoes$c$, $c$function trocar(v, i, j) {
  const auxiliar = v[i];
  v[i] = v[j];
  v[j] = auxiliar;
  return v;
}$c$, $c$Com uma variável auxiliar guardando v[i], os dois valores podem ser trocados sem perder nenhum.$c$),
  ($c$ind-corrija-o-ultimo$c$, $c$function ultimo(v) {
  return v[v.length - 1];
}$c$, $c$Os índices vão de 0 a length - 1. v[v.length] está uma posição além do fim; o certo é v[v.length - 1].$c$),
  ($c$len-esta-vazio$c$, $c$function estaVazio(v) {
  return v.length === 0;
}$c$, $c$Um array vazio tem length 0; basta comparar v.length === 0.$c$),
  ($c$len-ultimo-elemento$c$, $c$function ultimoElemento(v) {
  if (v.length === 0) {
    return "vazio";
  }
  return v[v.length - 1];
}$c$, $c$Se length é 0 devolvemos "vazio"; senão, o último elemento está em v[v.length - 1].$c$),
  ($c$len-corrija-o-ultimo-indice$c$, $c$function ultimoIndice(v) {
  return v.length - 1;
}$c$, $c$length é a quantidade; o último índice é length - 1.$c$),
  ($c$push-lista-de-pares$c$, $c$function pares(n) {
  const resultado = [];
  for (let i = 1; i <= n; i++) {
    if (i % 2 === 0) {
      resultado.push(i);
    }
  }
  return resultado;
}$c$, $c$O array começa vazio; a cada número par encontrado, push o adiciona no final.$c$),
  ($c$push-copiar-positivos$c$, $c$function positivos(v) {
  const resultado = [];
  for (let i = 0; i < v.length; i++) {
    if (v[i] > 0) {
      resultado.push(v[i]);
    }
  }
  return resultado;
}$c$, $c$O laço percorre v e push guarda no novo array apenas os elementos maiores que zero.$c$),
  ($c$push-corrija-os-quadrados$c$, $c$function quadrados(n) {
  const resultado = [];
  for (let i = 1; i <= n; i++) {
    resultado.push(i * i);
  }
  return resultado;
}$c$, $c$push devolve o novo tamanho e não o array; atribuí-lo a resultado destrói o array. Basta chamar resultado.push(i * i) sem atribuir.$c$),
  ($c$push-sem-repetidos$c$, $c$function semRepetidos(v) {
  const resultado = [];
  for (let i = 0; i < v.length; i++) {
    let jaTem = false;
    for (let j = 0; j < resultado.length; j++) {
      if (resultado[j] === v[i]) {
        jaTem = true;
      }
    }
    if (!jaTem) {
      resultado.push(v[i]);
    }
  }
  return resultado;
}$c$, $c$Para cada elemento, um laço (ou includes) verifica se ele já foi guardado; só se não foi, push o adiciona.$c$),
  ($c$pop-remover-ultimos$c$, $c$function removerUltimos(v, n) {
  for (let i = 0; i < n && v.length > 0; i++) {
    v.pop();
  }
  return v;
}$c$, $c$Um laço repete pop() n vezes (no máximo o tamanho do array); em array vazio pop não causa erro.$c$),
  ($c$pop-corrija-o-retorno$c$, $c$function retirarUltimo(v) {
  return v.pop();
}$c$, $c$pop já devolve o elemento removido; basta retornar v.pop() (ou guardar o resultado e retorná-lo).$c$),
  ($c$shift-rotacionar$c$, $c$function rotacionar(v) {
  if (v.length > 0) {
    v.push(v.shift());
  }
  return v;
}$c$, $c$shift tira o primeiro elemento e push o coloca no final. Com array vazio, nada é movido.$c$),
  ($c$shift-corrija-o-inicio$c$, $c$function adicionarNoInicio(v, x) {
  v.unshift(x);
  return v;
}$c$, $c$push adiciona no final. Para adicionar no início, use unshift.$c$),
  ($c$shift-primeiros-n$c$, $c$function retirarPrimeiros(v, n) {
  const retirados = [];
  for (let i = 0; i < n && v.length > 0; i++) {
    retirados.push(v.shift());
  }
  return retirados;
}$c$, $c$Um laço repete até n vezes (ou até esvaziar): shift retira o primeiro e push o guarda no resultado.$c$),
  ($c$for-vet-somar$c$, $c$function somar(v) {
  let soma = 0;
  for (let i = 0; i < v.length; i++) {
    soma += v[i];
  }
  return soma;
}$c$, $c$O acumulador soma cada elemento durante o laço; com array vazio o laço não executa e o resultado é 0.$c$),
  ($c$for-vet-maior$c$, $c$function maior(v) {
  let maior = v[0];
  for (let i = 1; i < v.length; i++) {
    if (v[i] > maior) {
      maior = v[i];
    }
  }
  return maior;
}$c$, $c$Guardamos o maior visto até agora (começando por v[0]) e o atualizamos sempre que um elemento maior aparece.$c$),
  ($c$for-vet-contar-maiores$c$, $c$function contarMaiores(v, limite) {
  let contador = 0;
  for (let i = 0; i < v.length; i++) {
    if (v[i] > limite) {
      contador++;
    }
  }
  return contador;
}$c$, $c$Um contador sobe 1 para cada elemento maior que o limite.$c$),
  ($c$for-vet-corrija-a-media$c$, $c$function media(v) {
  let soma = 0;
  for (let i = 0; i < v.length; i++) {
    soma += v[i];
  }
  return soma / v.length;
}$c$, $c$Com i <= v.length o laço soma undefined na última volta. A condição correta é i < v.length.$c$),
  ($c$for-vet-segundo-maior$c$, $c$function segundoMaior(v) {
  let primeiro = -Infinity;
  let segundo = -Infinity;
  for (let i = 0; i < v.length; i++) {
    if (v[i] > primeiro) {
      segundo = primeiro;
      primeiro = v[i];
    } else if (v[i] > segundo) {
      segundo = v[i];
    }
  }
  return segundo;
}$c$, $c$O laço mantém o maior e o segundo maior vistos até agora, atualizando os dois conforme cada elemento.$c$),
  ($c$while-vet-primeiro-negativo$c$, $c$function primeiroNegativo(v) {
  let i = 0;
  while (i < v.length && v[i] >= 0) {
    i++;
  }
  return i < v.length ? i : -1;
}$c$, $c$O laço avança i enquanto i < v.length e v[i] >= 0. Ao sair, se i < v.length achamos o negativo; senão, devolvemos -1.$c$),
  ($c$while-vet-somar-ate-zero$c$, $c$function somarAteZero(v) {
  let i = 0;
  let soma = 0;
  while (i < v.length && v[i] !== 0) {
    soma += v[i];
    i++;
  }
  return soma;
}$c$, $c$O while soma v[i] e avança i enquanto i < v.length e v[i] !== 0.$c$),
  ($c$while-vet-corrija-a-busca$c$, $c$function posicaoDe(v, x) {
  let i = 0;
  while (i < v.length && v[i] !== x) {
    i++;
  }
  return i < v.length ? i : -1;
}$c$, $c$Faltava avançar o índice dentro do laço: com i++ a condição eventualmente fica falsa.$c$),
  ($c$while-vet-todos-crescentes$c$, $c$function crescente(v) {
  let i = 1;
  while (i < v.length && v[i] > v[i - 1]) {
    i++;
  }
  return i >= v.length;
}$c$, $c$O laço avança enquanto cada par estiver em ordem; se algum par violar a regra, a resposta é false.$c$),
  ($c$mat-intro-criar-2x2$c$, $c$function criar2x2(a, b, c, d) {
  return [[a, b], [c, d]];
}$c$, $c$A matriz é um array cujos dois elementos são as linhas [a, b] e [c, d].$c$),
  ($c$mat-intro-corrija-contar-linhas$c$, $c$function contarLinhas(m) {
  return m.length;
}$c$, $c$As linhas são os elementos de m, então m.length é o número de linhas. m[0].length conta as colunas.$c$),
  ($c$bid-elemento-em$c$, $c$function elementoEm(m, i, j) {
  return m[i][j];
}$c$, $c$m[i][j] lê o elemento da linha i, coluna j.$c$),
  ($c$bid-soma-da-linha$c$, $c$function somaDaLinha(m, i) {
  let soma = 0;
  for (let j = 0; j < m[i].length; j++) {
    soma += m[i][j];
  }
  return soma;
}$c$, $c$A linha m[i] é um array comum; um acumulador soma cada um dos seus elementos.$c$),
  ($c$bid-ultima-linha$c$, $c$function ultimaLinha(m) {
  return m[m.length - 1];
}$c$, $c$O número de linhas é m.length e o índice da última é m.length - 1.$c$),
  ($c$bid-corrija-linha-e-coluna$c$, $c$function valorEm(m, i, j) {
  return m[i][j];
}$c$, $c$Os índices estavam trocados. A linha vem primeiro: m[i][j].$c$),
  ($c$bid-coluna$c$, $c$function coluna(m, j) {
  const resultado = [];
  for (let i = 0; i < m.length; i++) {
    resultado.push(m[i][j]);
  }
  return resultado;
}$c$, $c$Um laço visita cada linha i e adiciona m[i][j] ao resultado com push.$c$),
  ($c$pm-soma-matriz$c$, $c$function somaMatriz(m) {
  let soma = 0;
  for (let i = 0; i < m.length; i++) {
    for (let j = 0; j < m[i].length; j++) {
      soma += m[i][j];
    }
  }
  return soma;
}$c$, $c$Dois laços visitam todas as posições e o acumulador soma cada elemento.$c$),
  ($c$pm-contar-valor$c$, $c$function contarValor(m, x) {
  let contador = 0;
  for (let i = 0; i < m.length; i++) {
    for (let j = 0; j < m[i].length; j++) {
      if (m[i][j] === x) {
        contador++;
      }
    }
  }
  return contador;
}$c$, $c$O contador começa em 0 e sobe 1 sempre que o elemento visitado é igual a x.$c$),
  ($c$pm-mostrar-matriz$c$, $c$function mostrarMatriz(m) {
  for (let i = 0; i < m.length; i++) {
    let linha = "";
    for (let j = 0; j < m[i].length; j++) {
      linha += (j === 0 ? "" : " ") + m[i][j];
    }
    console.log(linha);
  }
}$c$, $c$Para cada linha, o laço interno monta o texto com os elementos; depois de visitar a linha toda, o texto é mostrado.$c$),
  ($c$pm-corrija-o-maior$c$, $c$function maiorDaMatriz(m) {
  let maior = m[0][0];
  for (let i = 0; i < m.length; i++) {
    for (let j = 0; j < m[i].length; j++) {
      if (m[i][j] > maior) {
        maior = m[i][j];
      }
    }
  }
  return maior;
}$c$, $c$Começando em 0, o resultado nunca fica negativo. O maior deve começar com o primeiro elemento da matriz (m[0][0]).$c$),
  ($c$pm-diagonal-principal$c$, $c$function somaDiagonal(m) {
  let soma = 0;
  for (let i = 0; i < m.length; i++) {
    soma += m[i][i];
  }
  return soma;
}$c$, $c$Um único laço com m[i][i] soma os elementos em que linha e coluna coincidem.$c$),
  ($c$pm-transposta$c$, $c$function transposta(m) {
  const resultado = [];
  for (let j = 0; j < m[0].length; j++) {
    const linha = [];
    for (let i = 0; i < m.length; i++) {
      linha.push(m[i][j]);
    }
    resultado.push(linha);
  }
  return resultado;
}$c$, $c$Para cada coluna j de m, monta-se uma nova linha com os elementos m[0][j], m[1][j], ... e ela é adicionada ao resultado.$c$),
  ($c$desafio6-notas-da-turma$c$, $c$function analisarTurma() {
  const quantidade = Number(lerEntrada());
  const notas = [];
  for (let i = 0; i < quantidade; i++) {
    notas.push(Number(lerEntrada()));
  }
  let soma = 0;
  let maior = notas[0];
  for (let i = 0; i < notas.length; i++) {
    soma += notas[i];
    if (notas[i] > maior) {
      maior = notas[i];
    }
  }
  const media = soma / notas.length;
  let acima = 0;
  for (let i = 0; i < notas.length; i++) {
    if (notas[i] > media) {
      acima++;
    }
  }
  console.log("Média:", media);
  console.log("Maior nota:", maior);
  console.log("Acima da média:", acima);
}$c$, $c$As notas vão para um vetor com push. Um primeiro laço soma e encontra a maior; com a média pronta, um segundo laço conta as notas maiores que ela.$c$),
  ($c$desafio6-corrija-a-media$c$, $c$function mediaDaTurma(notas) {
  let soma = 0;
  for (let i = 0; i < notas.length; i++) {
    soma += notas[i];
  }
  return soma / notas.length;
}$c$, $c$soma = notas[i] substitui o acumulador em cada volta. O correto é somar: soma += notas[i].$c$),
  ($c$maior-de-dois$c$, $c$function maiorDeDois(a, b) {
  return a > b ? a : b;
}$c$, $c$$c$),
  ($c$hipotenusa$c$, $c$function hipotenusa(a, b) {
  return Math.sqrt(a * a + b * b);
}$c$, $c$$c$),
  ($c$func-intro-ola-mundo$c$, $c$function ola() {
  return "Olá, mundo!";
}$c$, $c$A função devolve o texto com return.$c$),
  ($c$decl-triplo$c$, $c$function triplo(n) {
  return n * 3;
}$c$, $c$A função devolve n * 3.$c$),
  ($c$decl-eh-par$c$, $c$function ehPar(n) {
  return n % 2 === 0;
}$c$, $c$A função devolve o resultado da comparação n % 2 === 0, que já é true ou false.$c$),
  ($c$cham-quadruplo$c$, $c$function dobro(n) {
  return n * 2;
}

function quadruplo(n) {
  return dobro(dobro(n));
}$c$, $c$dobro(dobro(n)) dobra o valor duas vezes, resultando no quádruplo.$c$),
  ($c$cham-corrija-a-chamada$c$, $c$function dobro(n) {
  return n * 2;
}

function quadruplo(n) {
  return dobro(n) + dobro(n);
}$c$, $c$O segundo dobro estava sem parênteses: era só uma referência à função, e não uma chamada. O correto é dobro(n) + dobro(n).$c$),
  ($c$cham-contar-pares-com-ajudante$c$, $c$function ehPar(n) {
  return n % 2 === 0;
}

function contarPares(v) {
  let contador = 0;
  for (let i = 0; i < v.length; i++) {
    if (ehPar(v[i])) {
      contador++;
    }
  }
  return contador;
}$c$, $c$O laço percorre o array e, para cada elemento, chama ehPar; um contador soma 1 quando ela devolve true.$c$),
  ($c$par-area-do-retangulo$c$, $c$function area(base, altura) {
  return base * altura;
}$c$, $c$A função multiplica base por altura.$c$),
  ($c$par-media-de-tres$c$, $c$function mediaDeTres(a, b, c) {
  return (a + b + c) / 3;
}$c$, $c$(a + b + c) / 3: os parênteses garantem que a soma é feita antes da divisão.$c$),
  ($c$par-corrija-o-parametro$c$, $c$function calcularArea(base, altura) {
  return base * altura;
}$c$, $c$O corpo usava base duas vezes e deixava altura de fora. O correto é base * altura.$c$),
  ($c$arg-potencia$c$, $c$function potencia(base, expoente) {
  let resultado = 1;
  for (let i = 0; i < expoente; i++) {
    resultado *= base;
  }
  return resultado;
}$c$, $c$Um acumulador começa em 1 e é multiplicado pela base a cada volta, expoente vezes.$c$),
  ($c$arg-corrija-a-ordem$c$, $c$function diferenca(a, b) {
  return a - b;
}

function faltaPara10(n) {
  return diferenca(10, n);
}$c$, $c$A ordem dos argumentos estava invertida. diferenca(10, n) calcula 10 - n.$c$),
  ($c$ret-maior-de-idade$c$, $c$function ehMaiorDeIdade(idade) {
  return idade >= 18;
}$c$, $c$return idade >= 18 devolve o resultado da comparação.$c$),
  ($c$ret-corrija-o-return$c$, $c$function dobro(n) {
  return n * 2;
}$c$, $c$console.log só mostra o valor. Para entregá-lo a quem chamou, use return n * 2.$c$),
  ($c$ret-classificar-nota$c$, $c$function classificar(nota) {
  if (nota >= 7) {
    return "aprovado";
  } else if (nota >= 5) {
    return "recuperacao";
  } else {
    return "reprovado";
  }
}$c$, $c$Os if/else if devolvem o texto da faixa correspondente e o return encerra a função.$c$),
  ($c$ret-primeiro-par$c$, $c$function primeiroPar(v) {
  for (let i = 0; i < v.length; i++) {
    if (v[i] % 2 === 0) {
      return v[i];
    }
  }
  return -1;
}$c$, $c$O return dentro do if encerra a função no primeiro par. Se o laço termina sem achar, o return -1 final é executado.$c$),
  ($c$pr-calcular-total$c$, $c$function calcularTotal(preco, quantidade) {
  let total = preco * quantidade;
  if (quantidade >= 10) {
    total = total - total / 10;
  }
  return total;
}$c$, $c$O total é preco * quantidade. Com 10 ou mais, subtrai-se 10% dele; os dois caminhos terminam em return.$c$),
  ($c$pr-contar-vogais-com-ajudante$c$, $c$function ehVogal(letra) {
  return "aeiou".includes(letra.toLowerCase());
}

function contarVogais(texto) {
  let vogais = 0;
  for (let i = 0; i < texto.length; i++) {
    if (ehVogal(texto[i])) {
      vogais++;
    }
  }
  return vogais;
}$c$, $c$O laço percorre as letras e um contador soma 1 sempre que ehVogal devolve true.$c$),
  ($c$pr-corrija-o-caminho$c$, $c$function ehPar(n) {
  if (n % 2 === 0) {
    return true;
  }
  return false;
}$c$, $c$Quando n é ímpar, nenhum return é executado e a função devolve undefined. Falta devolver false nesse caminho.$c$),
  ($c$pr-menor-e-maior$c$, $c$function menorEMaior(v) {
  let menor = v[0];
  let maior = v[0];
  for (let i = 1; i < v.length; i++) {
    if (v[i] < menor) {
      menor = v[i];
    }
    if (v[i] > maior) {
      maior = v[i];
    }
  }
  return [menor, maior];
}$c$, $c$O laço atualiza o menor e o maior valor; no final, a função devolve os dois em um array.$c$),
  ($c$glob-corrija-a-dependencia$c$, $c$let taxa = 0.1;

function precoFinal(valor, taxa2) {
  return valor + valor * taxa2;
}$c$, $c$A função ignorava o parâmetro e lia a variável global taxa (0.1). Usando o parâmetro, ela depende só do que recebe.$c$),
  ($c$loc-corrija-o-uso-fora$c$, $c$function calcular(n) {
  const dobro = n * 2;
  return dobro;
}

function mostrarDobro(n) {
  return calcular(n);
}$c$, $c$dobro é local de calcular. Para usar o valor, é preciso guardar (ou devolver) o resultado da chamada: return calcular(n).$c$),
  ($c$loc-corrija-o-acumulador$c$, $c$function somaDosQuadrados(n) {
  let total = 0;
  for (let i = 1; i <= n; i++) {
    total += i * i;
  }
  return total;
}$c$, $c$total era global e guardava o resultado das chamadas anteriores. Declarado dentro da função, ele recomeça em 0 a cada chamada.$c$),
  ($c$arrow-quadrado$c$, $c$const quadrado = (n) => n * n;$c$, $c$(n) => n * n devolve o quadrado de n.$c$),
  ($c$arrow-par-ou-impar$c$, $c$const parOuImpar = (n) => (n % 2 === 0 ? "par" : "impar");$c$, $c$(n) => n % 2 === 0 ? "par" : "impar" devolve o texto conforme a condição.$c$),
  ($c$arrow-corrija-o-retorno$c$, $c$function dobro(n) {
  const calcular = (x) => x * 2;
  return calcular(n);
}$c$, $c$Com chaves, o return é obrigatório. Basta remover as chaves ((n) => n * 2) ou escrever return n * 2.$c$),
  ($c$desafio7-calculadora$c$, $c$function somar(a, b) {
  return a + b;
}

function subtrair(a, b) {
  return a - b;
}

function multiplicar(a, b) {
  return a * b;
}

function dividir(a, b) {
  if (b === 0) {
    return "Divisão por zero";
  }
  return a / b;
}

function calcular(operacao, a, b) {
  switch (operacao) {
    case "+":
      return somar(a, b);
    case "-":
      return subtrair(a, b);
    case "*":
      return multiplicar(a, b);
    case "/":
      return dividir(a, b);
    default:
      return "Operação inválida";
  }
}$c$, $c$As quatro funções fazem as contas e dividir trata o divisor zero. calcular usa um switch (ou if/else if) para chamar a função certa e devolve o resultado, com um caminho final para operações inválidas.$c$),
  ($c$desafio7-executar-calculadora$c$, $c$function calcular(operacao, a, b) {
  switch (operacao) {
    case "+":
      return a + b;
    case "-":
      return a - b;
    case "*":
      return a * b;
    case "/":
      return b === 0 ? "Divisão por zero" : a / b;
    default:
      return "Operação inválida";
  }
}

function executar() {
  const operacao = lerEntrada();
  const a = Number(lerEntrada());
  const b = Number(lerEntrada());
  console.log("Resultado:", calcular(operacao, a, b));
}$c$, $c$executar lê a operação e os dois números (convertidos com Number), chama calcular e mostra o valor devolvido.$c$),
  ($c$desafio7-corrija-a-calculadora$c$, $c$function somar(a, b) {
  return a + b;
}

function subtrair(a, b) {
  return a - b;
}

function multiplicar(a, b) {
  return a * b;
}

function calcular(operacao, a, b) {
  if (operacao === "+") {
    return somar(a, b);
  } else if (operacao === "-") {
    return subtrair(a, b);
  } else if (operacao === "*") {
    return multiplicar(a, b);
  }
  return "Operação inválida";
}$c$, $c$subtrair calculava b - a (ordem trocada) e multiplicar só mostrava o valor com console.log, devolvendo undefined. Corrigindo para a - b e return a * b, as duas passam a devolver o resultado.$c$)
) as v (exercise_id, solution, commentary)
join public.exercises e on e.id = v.exercise_id and e.origem = 'arquivo'
on conflict (exercise_id) do update set solution = excluded.solution, commentary = excluded.commentary;


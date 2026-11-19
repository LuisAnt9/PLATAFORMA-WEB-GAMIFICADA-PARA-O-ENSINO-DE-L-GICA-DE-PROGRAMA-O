function somar(a, b) {
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
}

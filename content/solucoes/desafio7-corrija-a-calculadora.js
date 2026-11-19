function somar(a, b) {
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
}

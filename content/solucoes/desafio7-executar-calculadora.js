function calcular(operacao, a, b) {
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
}

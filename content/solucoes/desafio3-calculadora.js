function calculadora() {
  const a = Number(lerEntrada());
  const b = Number(lerEntrada());
  console.log("Soma:", a + b);
  console.log("Subtração:", a - b);
  console.log("Multiplicação:", a * b);
  console.log("Divisão:", a / b);
  console.log("Resto:", a % b);
  console.log("Divisão por zero?", b === 0);
}

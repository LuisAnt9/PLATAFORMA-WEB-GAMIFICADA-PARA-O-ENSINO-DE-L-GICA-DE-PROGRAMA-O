function somarAteZero() {
  let soma = 0;
  let valor;
  do {
    valor = Number(lerEntrada());
    soma += valor;
  } while (valor !== 0);
  console.log(soma);
}

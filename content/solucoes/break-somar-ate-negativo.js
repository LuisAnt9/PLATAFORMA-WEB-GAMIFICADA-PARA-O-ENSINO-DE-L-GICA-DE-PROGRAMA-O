function somarAteNegativo() {
  let soma = 0;
  while (true) {
    const n = Number(lerEntrada());
    if (n < 0) {
      break;
    }
    soma += n;
  }
  console.log(soma);
}

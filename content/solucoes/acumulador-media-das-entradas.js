function media() {
  const quantidade = Number(lerEntrada());
  let soma = 0;
  for (let i = 0; i < quantidade; i++) {
    soma += Number(lerEntrada());
  }
  console.log(soma / quantidade);
}

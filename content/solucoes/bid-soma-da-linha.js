function somaDaLinha(m, i) {
  let soma = 0;
  for (let j = 0; j < m[i].length; j++) {
    soma += m[i][j];
  }
  return soma;
}

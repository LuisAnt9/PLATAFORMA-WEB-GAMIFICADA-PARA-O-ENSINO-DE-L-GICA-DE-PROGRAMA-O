function somaDiagonal(m) {
  let soma = 0;
  for (let i = 0; i < m.length; i++) {
    soma += m[i][i];
  }
  return soma;
}

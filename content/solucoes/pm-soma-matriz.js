function somaMatriz(m) {
  let soma = 0;
  for (let i = 0; i < m.length; i++) {
    for (let j = 0; j < m[i].length; j++) {
      soma += m[i][j];
    }
  }
  return soma;
}

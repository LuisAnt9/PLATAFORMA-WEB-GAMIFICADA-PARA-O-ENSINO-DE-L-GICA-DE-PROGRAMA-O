function maiorDaMatriz(m) {
  let maior = m[0][0];
  for (let i = 0; i < m.length; i++) {
    for (let j = 0; j < m[i].length; j++) {
      if (m[i][j] > maior) {
        maior = m[i][j];
      }
    }
  }
  return maior;
}

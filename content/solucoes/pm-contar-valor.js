function contarValor(m, x) {
  let contador = 0;
  for (let i = 0; i < m.length; i++) {
    for (let j = 0; j < m[i].length; j++) {
      if (m[i][j] === x) {
        contador++;
      }
    }
  }
  return contador;
}

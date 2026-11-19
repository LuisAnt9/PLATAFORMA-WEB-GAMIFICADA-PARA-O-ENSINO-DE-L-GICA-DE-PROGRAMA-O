function mostrarMatriz(m) {
  for (let i = 0; i < m.length; i++) {
    let linha = "";
    for (let j = 0; j < m[i].length; j++) {
      linha += (j === 0 ? "" : " ") + m[i][j];
    }
    console.log(linha);
  }
}

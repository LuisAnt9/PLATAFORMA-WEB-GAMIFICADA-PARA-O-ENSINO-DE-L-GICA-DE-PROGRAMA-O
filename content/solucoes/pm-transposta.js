function transposta(m) {
  const resultado = [];
  for (let j = 0; j < m[0].length; j++) {
    const linha = [];
    for (let i = 0; i < m.length; i++) {
      linha.push(m[i][j]);
    }
    resultado.push(linha);
  }
  return resultado;
}

function positivos(v) {
  const resultado = [];
  for (let i = 0; i < v.length; i++) {
    if (v[i] > 0) {
      resultado.push(v[i]);
    }
  }
  return resultado;
}

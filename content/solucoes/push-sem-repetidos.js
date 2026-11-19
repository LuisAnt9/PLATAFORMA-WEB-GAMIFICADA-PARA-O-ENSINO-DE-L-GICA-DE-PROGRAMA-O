function semRepetidos(v) {
  const resultado = [];
  for (let i = 0; i < v.length; i++) {
    let jaTem = false;
    for (let j = 0; j < resultado.length; j++) {
      if (resultado[j] === v[i]) {
        jaTem = true;
      }
    }
    if (!jaTem) {
      resultado.push(v[i]);
    }
  }
  return resultado;
}

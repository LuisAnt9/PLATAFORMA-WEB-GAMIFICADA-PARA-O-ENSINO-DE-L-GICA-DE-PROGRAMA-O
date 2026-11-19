function contarMaiores(v, limite) {
  let contador = 0;
  for (let i = 0; i < v.length; i++) {
    if (v[i] > limite) {
      contador++;
    }
  }
  return contador;
}

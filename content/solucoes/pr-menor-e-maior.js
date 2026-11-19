function menorEMaior(v) {
  let menor = v[0];
  let maior = v[0];
  for (let i = 1; i < v.length; i++) {
    if (v[i] < menor) {
      menor = v[i];
    }
    if (v[i] > maior) {
      maior = v[i];
    }
  }
  return [menor, maior];
}

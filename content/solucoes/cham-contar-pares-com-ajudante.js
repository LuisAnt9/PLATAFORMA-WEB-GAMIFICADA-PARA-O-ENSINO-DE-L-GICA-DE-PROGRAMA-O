function ehPar(n) {
  return n % 2 === 0;
}

function contarPares(v) {
  let contador = 0;
  for (let i = 0; i < v.length; i++) {
    if (ehPar(v[i])) {
      contador++;
    }
  }
  return contador;
}

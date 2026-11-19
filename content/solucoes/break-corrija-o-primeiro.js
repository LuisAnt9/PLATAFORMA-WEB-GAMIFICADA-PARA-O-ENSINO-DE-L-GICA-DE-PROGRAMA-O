function primeiroMultiploDe7(limite) {
  let achado = -1;
  for (let i = 1; i <= limite; i++) {
    if (i % 7 === 0) {
      achado = i;
      break;
    }
  }
  return achado;
}

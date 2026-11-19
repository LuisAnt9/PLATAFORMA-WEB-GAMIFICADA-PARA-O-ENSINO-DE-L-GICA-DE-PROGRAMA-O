function tabuada() {
  const n = Number(lerEntrada());
  for (let i = 1; i <= 10; i++) {
    console.log(n + " x " + i + " = " + n * i);
  }
}

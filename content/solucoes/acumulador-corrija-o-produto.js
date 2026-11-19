function produtoAte(n) {
  let produto = 1;
  for (let i = 1; i <= n; i++) {
    produto *= i;
  }
  return produto;
}

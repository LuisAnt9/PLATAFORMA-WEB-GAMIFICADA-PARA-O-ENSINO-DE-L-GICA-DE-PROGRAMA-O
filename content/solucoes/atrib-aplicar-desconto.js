function aplicarDesconto(preco, percentual) {
  const desconto = preco * percentual / 100;
  preco -= desconto;
  return preco;
}

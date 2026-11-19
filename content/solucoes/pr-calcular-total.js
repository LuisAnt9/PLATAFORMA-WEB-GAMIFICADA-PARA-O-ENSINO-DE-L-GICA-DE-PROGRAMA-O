function calcularTotal(preco, quantidade) {
  let total = preco * quantidade;
  if (quantidade >= 10) {
    total = total - total / 10;
  }
  return total;
}

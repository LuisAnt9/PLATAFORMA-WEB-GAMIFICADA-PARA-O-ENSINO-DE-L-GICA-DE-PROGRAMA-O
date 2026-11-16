function desconto(valor, cliente) {
  if (valor >= 100) {
    if (cliente === "vip") {
      return valor * 0.8;
    } else {
      return valor * 0.9;
    }
  } else {
    return valor;
  }
}

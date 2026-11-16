function descontoDoIngresso(idade, estudante) {
  if (idade < 18) {
    return 100;
  } else {
    if (estudante) {
      return 50;
    } else {
      return 0;
    }
  }
}

function acesso(idade, temIngresso) {
  if (idade >= 18) {
    if (temIngresso) {
      return "entrou";
    } else {
      return "sem ingresso";
    }
  } else {
    return "menor";
  }
}

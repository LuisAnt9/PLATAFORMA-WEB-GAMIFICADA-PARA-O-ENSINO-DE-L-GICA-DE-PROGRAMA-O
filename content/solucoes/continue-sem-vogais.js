function semVogais(texto) {
  let resultado = "";
  for (let i = 0; i < texto.length; i++) {
    if ("aeiou".includes(texto[i].toLowerCase())) {
      continue;
    }
    resultado += texto[i];
  }
  return resultado;
}

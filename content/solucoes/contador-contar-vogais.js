function contarVogais(texto) {
  let vogais = 0;
  for (let i = 0; i < texto.length; i++) {
    if ("aeiou".includes(texto[i].toLowerCase())) {
      vogais++;
    }
  }
  return vogais;
}

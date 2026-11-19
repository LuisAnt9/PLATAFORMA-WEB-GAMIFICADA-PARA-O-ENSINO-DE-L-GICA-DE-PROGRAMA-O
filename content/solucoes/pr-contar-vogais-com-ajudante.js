function ehVogal(letra) {
  return "aeiou".includes(letra.toLowerCase());
}

function contarVogais(texto) {
  let vogais = 0;
  for (let i = 0; i < texto.length; i++) {
    if (ehVogal(texto[i])) {
      vogais++;
    }
  }
  return vogais;
}

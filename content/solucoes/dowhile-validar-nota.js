function validarNota() {
  let nota;
  do {
    nota = Number(lerEntrada());
  } while (nota < 0 || nota > 10);
  console.log("Nota válida:", nota);
}

function retangulo(linhas, colunas) {
  for (let i = 0; i < linhas; i++) {
    let linha = "";
    for (let j = 0; j < colunas; j++) {
      linha += "*";
    }
    console.log(linha);
  }
}

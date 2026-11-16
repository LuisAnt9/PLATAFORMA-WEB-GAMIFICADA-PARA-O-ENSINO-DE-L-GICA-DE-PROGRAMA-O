function tipo(codigo) {
  let t = "";
  switch (codigo) {
    case 1:
      t = "fruta";
      break;
    case 2:
      t = "legume";
      break;
    default:
      t = "outro";
  }
  return t;
}

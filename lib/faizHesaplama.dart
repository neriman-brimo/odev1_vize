double FHesapla(
    String FaizTuru, double faizOrani, int krediSuresi, int krediTutari) {
  double faizOraniYuzde = faizOrani / 100.0;
  double toplamFaiz = 0;
  switch (FaizTuru) {
    case "İhtiyaç":
      toplamFaiz = (krediTutari * faizOraniYuzde * krediSuresi) / 12;
      break;
    case "Konut":
      toplamFaiz = (krediTutari * faizOraniYuzde * krediSuresi) / 1200;
      break;
    case "Taşıt":
      toplamFaiz = (krediTutari * faizOraniYuzde * krediSuresi) / 1200;
      break;
    case "Ticari":
      toplamFaiz = (krediTutari * faizOraniYuzde * krediSuresi) / 1200;
      break;
    default:
      print("Hatalı faiz türü");
  }

  return toplamFaiz;
}

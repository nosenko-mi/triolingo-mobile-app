import 'dart:math';


// String getString(template, ) {

// }

extension DoubleRoundExtension on double {
  double roundTo(int places) {
    double mod = pow(10.0, places).toDouble();
    return (this * mod).roundToDouble() / mod;
  }

  String toFixed(int places) {
    return toStringAsFixed(places);
  }
}



String cleanText(String html) {
  return html
      .replaceAll(RegExp(r'<[^>]*>'), '') // видалити всі теги
      .replaceAll('&nbsp;', ' ')
      .replaceAll('&amp;', '&')
      .trim();
}





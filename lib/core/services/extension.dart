inCaps(String text) {
  return '${text[0].toUpperCase()}${text.substring(1)}';
}

String kPoint(String number) {
  final int _number = int.parse(number);
  if (_number > 1000) {
    String hsl = (_number / 1000).toDouble().toStringAsFixed(1) + 'k';
    return hsl;
  } else
    return _number.toString();
}

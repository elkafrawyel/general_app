import 'dart:ui';

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

extension RgbColor on Color {
  static Color fromRgbString(String rgbString, {double opacity = 1}) {
    List<int> values = rgbString
        .split(',')
        .map((element) => int.parse(element.trim()))
        .toList();
    return Color.fromRGBO(values[0], values[1], values[2], opacity);
  }
}

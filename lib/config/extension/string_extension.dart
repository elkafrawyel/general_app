import 'dart:convert';
import 'package:intl/intl.dart';

extension StringX on String {
  // ─────────────────────────────── JSON helpers

  /// 🧾 Check if valid JSON
  bool get isJson {
    try {
      json.decode(this);
      return true;
    } catch (_) {
      return false;
    }
  }

  /// 🧾 Decode JSON safely
  dynamic get jsonDecodeSafe => isJson ? json.decode(this) : null;

  /// 🧾 Pretty JSON (for logs)
  String get prettyJson {
    try {
      final obj = json.decode(this);
      return const JsonEncoder.withIndent('  ').convert(obj);
    } catch (_) {
      return this;
    }
  }

  // ─────────────────────────────── Numbers & Currency

  /// 🔢 Convert to int safely
  int get toInt => int.tryParse(this) ?? 0;

  /// 🔢 Convert to double safely
  double get toDouble => double.tryParse(this) ?? 0.0;

  /// 💰 Format number string as currency
  String toCurrency({
    String locale = 'en',
    String symbol = 'EGP ',
    int decimalDigits = 2,
  }) {
    final value = double.tryParse(this);
    if (value == null) return this;

    return NumberFormat.currency(
      locale: locale,
      symbol: symbol,
      decimalDigits: decimalDigits,
    ).format(value);
  }

  // ─────────────────────────────── URL helpers

  /// 🔗 Is valid URL
  bool get isUrl => Uri.tryParse(this)?.hasAbsolutePath ?? false;

  /// 🌐 Encode URL
  String get urlEncode => Uri.encodeFull(this);

  /// 🌐 Decode URL
  String get urlDecode => Uri.decodeFull(this);

  // ─────────────────────────────── Text formatting

  /// 🧹 Remove extra spaces
  String get clean => trim().replaceAll(RegExp(r'\s+'), ' ');

  /// ✂️ Capitalize first letter
  String get capitalize =>
      isEmpty ? this : this[0].toUpperCase() + substring(1);

  /// 🔠 Capitalize each word
  String get capitalizeWords => split(' ').map((e) => e.capitalize).join(' ');

  /// 🔒 Mask sensitive data
  String get mask =>
      length <= 4 ? this : replaceRange(0, length - 4, '*' * (length - 4));

  /// ⏳ Limit length
  String limit(int max, {String suffix = '...'}) =>
      length <= max ? this : substring(0, max) + suffix;

  /// 🚫 Remove all spaces
  String get noSpaces => replaceAll(' ', '');
}

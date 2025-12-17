import 'package:intl/intl.dart';

extension DateX on DateTime {
  // ─────────────────────────────── Formatting

  /// 2025-12-17
  String get yyyyMMdd => DateFormat('yyyy-MM-dd').format(this);

  /// 17-12-2025
  String get ddMMyyyy => DateFormat('dd-MM-yyyy').format(this);

  /// 17/12/2025
  String get ddMMyyyySlash => DateFormat('dd/MM/yyyy').format(this);

  /// 21:45
  String get HHmm => DateFormat('HH:mm').format(this);

  /// 09:45 PM
  String get hhmmA => DateFormat('hh:mm a').format(this);

  /// 17-12-2025 21:45
  String get fullDateTime => DateFormat('dd-MM-yyyy HH:mm').format(this);

  // ─────────────────────────────── Checks

  /// Is today
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Is yesterday
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  /// Is tomorrow
  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year &&
        month == tomorrow.month &&
        day == tomorrow.day;
  }

  /// Is in the past
  bool get isPast => isBefore(DateTime.now());

  /// Is in the future
  bool get isFuture => isAfter(DateTime.now());

  // ─────────────────────────────── Calculations

  /// Difference in days
  int daysFromNow() => difference(DateTime.now()).inDays;

  /// Add days
  DateTime addDays(int days) => add(Duration(days: days));

  /// Subtract days
  DateTime subtractDays(int days) => subtract(Duration(days: days));

  // ─────────────────────────────── Helpers

  /// Start of day (00:00)
  DateTime get startOfDay => DateTime(year, month, day);

  /// End of day (23:59:59)
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59);
}

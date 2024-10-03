import 'package:general_app/config/clients/storage/storage_client.dart';
import 'package:intl/intl.dart';

class DateHelper {
  String getTimeFromDateString(String? dateString, {DateFormat? dateFormat}) {
    if (dateString == null) {
      return '';
    } else {
      return DateFormat(
        dateFormat?.pattern ?? DateFormat.HOUR_MINUTE,
        StorageClient().getAppLanguage(),
      ).format(
        DateTime.parse(dateString),
      );
    }
  }

  String getTimeFromDate(DateTime? date, {DateFormat? dateFormat}) {
    if (date == null) {
      return '';
    } else {
      return DateFormat(
        dateFormat?.pattern ?? DateFormat.HOUR_MINUTE,
        StorageClient().getAppLanguage(),
      ).format(date);
    }
  }

  String getDateFromDateString(String? dateString, {DateFormat? dateFormat}) {
    if (dateString == null) {
      return '';
    } else {
      return DateFormat(
        dateFormat?.pattern ?? DateFormat.YEAR_ABBR_MONTH_WEEKDAY_DAY,
        StorageClient().getAppLanguage(),
      ).format(
        DateTime.parse(dateString),
      );
    }
  }

  String getDateFromDate(DateTime? date, {DateFormat? dateFormat}) {
    if (date == null) {
      return '';
    } else {
      return DateFormat(
        dateFormat?.pattern ?? DateFormat.YEAR_ABBR_MONTH_WEEKDAY_DAY,
        StorageClient().getAppLanguage(),
      ).format(date);
    }
  }

  bool isToday(String dateString) {
    String todayDate = getDateFromDate(
      DateTime.now(),
      dateFormat: DateFormat('EE, dd MMMM'),
    );
    String newDate = getDateFromDateString(
      dateString,
      dateFormat: DateFormat('EE, dd MMMM'),
    );

    return todayDate == newDate;
  }

  bool isYesterday(String dateString) {
    String yesterdayDate = getDateFromDate(
      DateTime.now().subtract(const Duration(days: 1)),
      dateFormat: DateFormat('EE, dd MMMM'),
    );
    String newDate = getDateFromDateString(
      dateString,
      dateFormat: DateFormat('EE, dd MMMM'),
    );

    return yesterdayDate == newDate;
  }
}

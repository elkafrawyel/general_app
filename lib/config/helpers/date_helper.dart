import 'package:app_widgets_example/config/clients/storage/storage_client.dart';
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
}

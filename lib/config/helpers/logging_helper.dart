import 'package:get/utils.dart';
import 'package:logger/logger.dart';

class AppLogger {
  static void log(dynamic message, {Level? level}) {
    Logger(
      printer: PrettyPrinter(
          methodCount: 0,
          // Number of method calls to be displayed
          errorMethodCount: 8,
          // Number of method calls if stacktrace is provided
          lineLength: 1000,
          // Width of the output
          colors: true,
          // Colorful log messages
          printEmojis: true,
          // Print an emoji for each log message
          // Should each log print contain a timestamp
          dateTimeFormat: DateTimeFormat.none,
          noBoxingByDefault: true),
    ).log(
      level ?? Level.info,
      message,
    );
  }

  static void getxLog(String message) {
    Get.log(message);
  }
}

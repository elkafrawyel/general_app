import 'package:logger/logger.dart';

class AppLogger {
  static void log(String? message, {Level? level}) {
    Logger(
      printer: PrettyPrinter(),
    ).log(
      level ?? Level.info,
      message,
    );
  }
}

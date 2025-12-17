import 'package:flutter/foundation.dart';

class AppLogger {
  AppLogger._();

  // ───────────────────────────────── ANSI
  static const _reset = '\x1B[0m';

  static String _rgb(int r, int g, int b) => '\x1B[38;2;$r;$g;${b}m';

  // ───────────────────────────────── Colors
  static final _info = _rgb(52, 152, 219); // Blue
  static final _success = _rgb(46, 204, 113); // Green
  static final _warning = _rgb(241, 196, 15); // Yellow
  static final _error = _rgb(231, 76, 60); // Red
  static final _debug = _rgb(155, 89, 182); // Purple

  // ───────────────────────────────── Helpers
  static bool get _enabled => kDebugMode;

  static String _time() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:'
        '${now.minute.toString().padLeft(2, '0')}:'
        '${now.second.toString().padLeft(2, '0')}';
  }

  static String _ctx(String? ctx) => ctx == null ? '' : ' [$ctx]';

  // ───────────────────────────────── Logs
  static void info(String message, {String? ctx}) {
    _print('ℹ️ INFO', message, _info, ctx);
  }

  static void success(String message, {String? ctx}) {
    _print('✅ SUCCESS', message, _success, ctx);
  }

  static void warning(String message, {String? ctx}) {
    _print('⚠️ WARNING', message, _warning, ctx);
  }

  static void debug(String message, {String? ctx}) {
    _print('🐞 DEBUG', message, _debug, ctx);
  }

  static void error(
    String message, {
    String? ctx,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _print('❌ ERROR', message, _error, ctx);

    if (error != null) {
      debugPrint('$_error$error$_reset');
    }

    if (stackTrace != null) {
      debugPrint('$_error$stackTrace$_reset');
    }
  }

  // ───────────────────────────────── Printer
  static void _print(
    String tag,
    String message,
    String color,
    String? ctx,
  ) {
    if (!_enabled) return;

    debugPrint(
      '$color[${_time()}] $tag${_ctx(ctx)} → $message$_reset',
    );
  }
}

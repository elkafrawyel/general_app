import 'dart:async';

class TimeDebuncer {
  /// private constructor
  TimeDebuncer._();

  /// the one and only instance of this singleton
  static final instance = TimeDebuncer._();

  Timer? _debounce;

  debounce(Duration duration, Function() action) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(duration, () {
      action();
    });
  }

  cancel() => _debounce?.cancel();
}

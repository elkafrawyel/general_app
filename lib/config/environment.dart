class Environment {
  static const AppMode appMode = AppMode.live;
  final String _liveBaseUrl =
      'https://jsonplaceholder.typicode.com/';
  final String _testBaseUrl =
      'https://jsonplaceholder.typicode.com/';

  url() {
    switch (appMode) {
      case AppMode.testing:
      case AppMode.staging:
        return _testBaseUrl;
      case AppMode.live:
        return _liveBaseUrl;
    }
  }
}

enum AppMode {
  testing,
  staging,
  live,
}

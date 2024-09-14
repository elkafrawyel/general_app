class Environment {
  static const AppMode appMode = AppMode.live;
  final String _liveBaseUrl =
      'http://mohammedzakii-001-site3.htempurl.com/api/';
  final String _testBaseUrl =
      'http://mohammedzakii-001-site3.htempurl.com/api/';

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

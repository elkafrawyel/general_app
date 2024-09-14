class ConfigData<T> {
  String apiEndPoint;
  String emptyListMessage;
  T Function(dynamic) fromJson;
  Map<String, dynamic>? parameters;
  bool isPostRequest;

  ConfigData({
    required this.apiEndPoint,
    this.emptyListMessage = 'Empty Data',
    required this.fromJson,
    this.parameters,
    this.isPostRequest = false,
  });
}

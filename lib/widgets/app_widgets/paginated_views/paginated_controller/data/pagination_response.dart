import 'meta.dart';

class PaginationResponse<T> {
  PaginationResponse({
    this.data,
    this.meta,
  });

  PaginationResponse.fromJson(
    dynamic json, {
    required T Function(dynamic) fromJson,
  }) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  List<T>? data;
  Meta? meta;
}

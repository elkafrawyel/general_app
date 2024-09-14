import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:general_app/config/clients/storage/storage_client.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../environment.dart';
import '../../helpers/network_helper.dart';
import '../../operation_reply.dart';

enum DioMethods { get, post, patch, put, delete }

class APIClient {
  static const _requestTimeOut = Duration(seconds: 30);

  static const testToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJ6YWtpaWkiLCJqdGkiOiI2NjJiMzYxNi1iNTUyLTQ3NTgtYmJhNS0yODFjYWVjZmY3MmEiLCJlbWFpbCI6Inpha2lpaUBnbWFpbC5jb20iLCJ1c2VyX2lkIjoiZWY5NTQyMTEtYjNiMS00MjM0LTkyMjMtMGM3YjhjNTBjZjU5IiwidGltZSI6IjHigI_igI8vOeKAj-KAjy8yMDI0IDg6MjQ6MTgg2YUiLCJleHAiOjE3Mjc4MDM0NTgsImlzcyI6IlNlY3VyZUFwaSIsImF1ZCI6IlNlY3VyZUFwaVVzZXIifQ.fUj6eNT7bDwaidaQrjXfrrZ5br9PhK6sQ0ODgo4lBvQ';

  /// private constructor
  APIClient._();

  /// the one and only instance of this singleton
  static final instance = APIClient._();

  final Dio _client = Dio(
    BaseOptions(
      baseUrl: Environment().url(),
      headers: {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.cacheControlHeader: 'no-Cache',
        HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        HttpHeaders.authorizationHeader: 'Bearer $testToken',
        // HttpHeaders.authorizationHeader: 'Bearer ${StorageClient().apiToken()}',
        HttpHeaders.acceptLanguageHeader: StorageClient().getAppLanguage()
      },
      followRedirects: false,
      validateStatus: (status) => status! <= 500,
      connectTimeout: _requestTimeOut,
      receiveTimeout: _requestTimeOut,
    ),
  )..interceptors.add(
      PrettyDioLogger(
        request: true,
        requestBody: true,
        requestHeader: true,
        error: true,
        maxWidth: 1000,
      ),
    );

  void updateAcceptedLanguageHeader(String language) {
    _client.options.headers[HttpHeaders.acceptLanguageHeader] = language;
  }

  void updateTokenHeader(String? token, {String? tokenType}) {
    if (token == null) {
      _client.options.headers.remove(HttpHeaders.authorizationHeader);
      return;
    }
    _client.options.headers[HttpHeaders.authorizationHeader] =
        '${tokenType ?? 'Bearer'} $token';
  }

  Future<OperationReply<T>> get<T>({
    required String endPoint,
    required T Function(dynamic) fromJson,
  }) async {
    if (await NetworkHelper.isConnected()) {
      try {
        Response response = await _client.get(endPoint);
        if (NetworkHelper.isSuccess(response)) {
          return OperationReply.success(result: fromJson(response.data));
        } else {
          return NetworkHelper.handleCommonNetworkCases(response).as<T>();
        }
      } catch (error) {
        return OperationReply.failed(message: error.toString());
      }
    } else {
      return OperationReply.connectionDown();
    }
  }

  Future<OperationReply<T>> post<T>({
    required String endPoint,
    required T Function(dynamic) fromJson,
    required Map<String, dynamic> requestBody,
    List<MapEntry<String, File>> files = const [],
    Function(double percentage)? onUploadProgress,
    Function(double percentage)? onDownloadProgress,
  }) async {
    if (await NetworkHelper.isConnected()) {
      try {
        bool haveFiles = false;
        FormData formData = FormData.fromMap({});
        if (files.isNotEmpty) {
          haveFiles = true;
          formData = FormData.fromMap(requestBody);
          formData.files.addAll(files
              .map(
                (e) => MapEntry(
                  e.key,
                  MultipartFile.fromFileSync(e.value.path,
                      filename: e.value.path.split("/").last),
                ),
              )
              .toList());
        }
        Response response = await _client.post(
          endPoint,
          data: haveFiles ? formData : requestBody,
          onReceiveProgress: (received, total) {
            int percentage = ((received / total) * 100).floor();

            if (onDownloadProgress != null) {
              onDownloadProgress((received / total));
            }
            debugPrint('Downloading ....$percentage');
          },
          onSendProgress: (sent, total) {
            int percentage = ((sent / total) * 100).floor();
            if (onUploadProgress != null) {
              onUploadProgress((sent / total));
            }
            debugPrint('Uploading ....$percentage');
          },
        );
        if (NetworkHelper.isSuccess(response)) {
          return OperationReply.success(result: fromJson(response.data));
        } else {
          return NetworkHelper.handleCommonNetworkCases(response).as<T>();
        }
      } catch (error) {
        return OperationReply.failed(message: error.toString());
      }
    } else {
      return OperationReply.connectionDown();
    }
  }

  Future<OperationReply<T>> put<T>({
    required String endPoint,
    required T Function(dynamic) fromJson,
    required Map<String, dynamic> requestBody,
    List<MapEntry<String, File>> files = const [],
  }) async {
    if (await NetworkHelper.isConnected()) {
      try {
        bool haveFiles = false;
        FormData formData = FormData.fromMap({});
        if (files.isNotEmpty) {
          haveFiles = true;
          formData = FormData.fromMap(requestBody);
          formData.files.addAll(files
              .map(
                (e) => MapEntry(
                  e.key,
                  MultipartFile.fromFileSync(e.value.path,
                      filename: e.value.path.split("/").last),
                ),
              )
              .toList());
        }
        Response response = await _client.put(
          endPoint,
          data: haveFiles ? formData : requestBody,
          onReceiveProgress: (received, total) {
            int percentage = ((received / total) * 100).floor();
            debugPrint('Downloading ....$percentage');
          },
          onSendProgress: (sent, total) {
            int percentage = ((sent / total) * 100).floor();
            debugPrint('Uploading ....$percentage');
          },
        );
        if (NetworkHelper.isSuccess(response)) {
          return OperationReply.success(result: fromJson(response.data));
        } else {
          return NetworkHelper.handleCommonNetworkCases(response).as<T>();
        }
      } catch (error) {
        return OperationReply.failed(message: error.toString());
      }
    } else {
      return OperationReply.connectionDown();
    }
  }

  Future<OperationReply<T>> delete<T>({
    required String endPoint,
    required T Function(dynamic) fromJson,
    required Map<String, dynamic> requestBody,
    List<MapEntry<String, File>> files = const [],
  }) async {
    if (await NetworkHelper.isConnected()) {
      try {
        Response response = await _client.delete(endPoint, data: requestBody);
        if (NetworkHelper.isSuccess(response)) {
          return OperationReply.success(result: fromJson(response.data));
        } else {
          return NetworkHelper.handleCommonNetworkCases(response).as<T>();
        }
      } catch (error) {
        return OperationReply.failed(message: error.toString());
      }
    } else {
      return OperationReply.connectionDown();
    }
  }

  Future<OperationReply<T>> patch<T>({
    required String endPoint,
    required T Function(dynamic) fromJson,
    required Map<String, dynamic> requestBody,
    List<MapEntry<String, File>> files = const [],
  }) async {
    if (await NetworkHelper.isConnected()) {
      try {
        Response response = await _client.patch(endPoint, data: requestBody);
        if (NetworkHelper.isSuccess(response)) {
          return OperationReply.success(result: fromJson(response.data));
        } else {
          return NetworkHelper.handleCommonNetworkCases(response).as<T>();
        }
      } catch (error) {
        return OperationReply.failed(message: error.toString());
      }
    } else {
      return OperationReply.connectionDown();
    }
  }
}

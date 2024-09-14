import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:general_app/config/clients/storage/storage_client.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_utils/get_utils.dart';

import '../operation_reply.dart';

class NetworkHelper {
  static const int noInternetConnectionCode = 415;

  static bool isSuccess(Response response) {
    return response.statusCode! >= 200 && response.statusCode! < 300;
  }

  static Future<bool> isConnected() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    // This condition is for demo purposes only to explain every connection type.
    // Use conditions which work for your requirements.
    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      // Mobile network available.
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      // Wi-fi is available.
      // Note for Android:
      // When both mobile and Wi-Fi are turned on system will return Wi-Fi only as active network type
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.ethernet)) {
      // Ethernet connection available.
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.vpn)) {
      // Vpn connection active.
      // Note for iOS and macOS:
      // There is no separate network interface type for [vpn].
      // It returns [other] on any device (also simulator)
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.bluetooth)) {
      // Bluetooth connection available.
      return false;
    } else if (connectivityResult.contains(ConnectivityResult.other)) {
      // Connected to a network which is not in the above mentioned networks.
      return false;
    } else if (connectivityResult.contains(ConnectivityResult.none)) {
      // No available network types
      return false;
    } else {
      return false;
    }
  }

  ///Don't forget to cast it to function return type using [as] method
  static OperationReply handleCommonNetworkCases(Response response) {
    bool isAr = Get.locale?.languageCode == 'ar';
    Map? body;
    try {
      body = response.data;

      if (body != null && body['errors'] != null) {
        // handle api errors
        String errorMessage = '';
        Map<String, dynamic> errorMap = body['errors'];
        errorMap.forEach((key, value) {
          List errors = value;
          errorMessage = errorMessage + errors.first.toString();
        });
        return OperationReply(OperationStatus.failed, message: errorMessage);
      } else if (body != null &&
          body['message'] != null &&
          body['message'].length < 255) {
        if (body['message'].toString().contains('Unauthenticated')) {
          StorageClient().signOut();
          return OperationReply(
            OperationStatus.failed,
            message: 'Unauthenticated',
          );
        }
        String errorMessage = '';
        if (body['message'].toString().isNotEmpty) {
          errorMessage = body['message'].toString();
        } else if (body['exception'] != null &&
            body['exception'].toString().isNotEmpty) {
          errorMessage = body['exception'].toString();
        }
        return OperationReply.failed(message: errorMessage);
      } else if (body != null && body['error'] != null) {
        String errorMessage = '';
        if (body['error'] is String) {
          errorMessage = body['error'];
          return OperationReply(OperationStatus.failed, message: errorMessage);
        } else {
          Map<String, dynamic> errorMap = body['error'];
          errorMap.forEach(
              (key, value) => errorMessage = errorMessage + value.toString());
          return OperationReply(OperationStatus.failed, message: errorMessage);
        }
      } else {
        return OperationReply.failed(
            message: isAr ? 'حدث خطأ ما' : 'General Error');
      }
    } catch (e) {
      return OperationReply.failed(
          message: isAr ? 'حدث خطأ ما' : 'General Error');
    }
  }
}

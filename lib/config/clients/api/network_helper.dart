import 'package:dio/dio.dart';
import 'package:general_app/config/clients/api/api_result.dart';
import 'package:general_app/config/clients/storage/storage_client.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_utils/get_utils.dart';

class NetworkHelper {
  static const int unAuthenticatedCode = 415;
  static const int serverErrorCode = 500;
  static const int notFoundCode = 404;

  static bool isSuccess(Response response) {
    return response.statusCode! >= 200 && response.statusCode! < 300;
  }

  ///Don't forget to cast it to function return type using [as] method
  static ApiFailure<T> handleCommonNetworkCases<T>(Response response) {
    bool isAr = Get.locale?.languageCode == 'ar';
    Map? body;
    String errorMessage = '';
    try {
      body = response.data;

      if (response.statusCode == unAuthenticatedCode) {
        StorageClient().signOut();
        return ApiFailure(isAr ? 'يجب تسجيل الدخول' : 'Unauthenticated');
      } else if (response.statusCode == notFoundCode) {
        return ApiFailure(isAr ? 'رابط غير موجود' : 'Not Found Error ');
      } else if (response.statusCode == serverErrorCode) {
        return ApiFailure(isAr ? 'خطأ في السيرفر' : 'Server Error');
      } else if (body != null && body['errors'] != null) {
        // handle laravel post request api errors
        Map<String, dynamic> errorMap = body['errors'];
        errorMap.forEach((key, value) {
          List errors = value;
          errorMessage = errorMessage + errors.first.toString();
        });
        return ApiFailure(errorMessage);
      } else if (body != null && body['error'] != null) {
        String errorMessage = '';
        if (body['error'] is String) {
          errorMessage = body['error'];
          return ApiFailure(errorMessage);
        } else {
          Map<String, dynamic> errorMap = body['error'];
          errorMap.forEach(
            (key, value) => errorMessage = errorMessage + value.toString(),
          );
          return ApiFailure(errorMessage);
        }
      } else {
        return ApiFailure(isAr ? 'حدث خطأ ما' : 'General Error');
      }
    } catch (e) {
      return ApiFailure(isAr ? 'حدث خطأ ما' : 'General Error');
    }
  }

  static ApiFailure<T> handleDioError<T>(DioException error) {
    bool isAr = Get.locale?.languageCode == 'ar';

    if (error.type == DioExceptionType.connectionError) {
      return ApiFailure(isAr ? 'لا يوجد إتصال بالانترنت' : 'Network Error');
    } else if (error.type == DioExceptionType.connectionTimeout) {
      return const ApiFailure('Request Timedout');
    } else if (error.type == DioExceptionType.badCertificate) {
      return const ApiFailure('Bad Certificate');
    } else if (error.type == DioExceptionType.badResponse) {
      return const ApiFailure('Bad Response');
    } else {
      return const ApiFailure('Unexpected Error');
    }
  }
}

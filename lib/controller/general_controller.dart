import 'package:get/get.dart';

import 'package:general_app/config/clients/api/api_result.dart';

abstract class GeneralController extends GetxController {
  ApiResult _apiResult = const ApiStart();

  ApiResult get apiResult => _apiResult;

  set apiResult(ApiResult value) {
    _apiResult = value;
    update();
  }

  Future<void> refreshApiCall();
}

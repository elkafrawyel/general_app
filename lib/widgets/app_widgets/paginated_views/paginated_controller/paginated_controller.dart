import 'package:general_app/config/clients/api/api_client.dart';
import 'package:general_app/config/clients/api/api_result.dart';
import 'package:get/get.dart';

import 'data/config_data.dart';
import 'data/pagination_response.dart';

class PaginationController<T> extends GetxController {
  PaginationController(this.configData);

  num page = 1;
  num perPage = 10;
  bool isLastPage = false;
  bool _loadingMore = false, _loadingMoreEnd = false;
  bool paginate = true;
  final _page = 'pageNumber';
  final _perPage = 'pageSize';
  final _paginate = 'paginate';

  PaginationResponse<T>? paginationResponse;
  List<T> paginationList = [];

  ApiResult _apiResult = const ApiStart();

  ApiResult get apiResult => _apiResult;

  set apiResult(ApiResult value) {
    _apiResult = value;
    update();
  }

  ConfigData<T> configData;

  bool get loadingMore => _loadingMore;

  set loadingMore(bool value) {
    _loadingMore = value;
    update();
  }

  get loadingMoreEnd => _loadingMoreEnd;

  set loadingMoreEnd(value) {
    _loadingMoreEnd = value;
    update();
  }

  @override
  onInit() {
    super.onInit();
    callApi();
  }

  Future callApi({bool loading = true}) async {
    if (loading) {
      apiResult = const ApiLoading();
    }
    if (configData.isPostRequest) {
      apiResult = await APIClient.instance.post(
        endPoint: '${configData.apiEndPoint}?$_paginate=$paginate',
        fromJson: (json) => PaginationResponse<T>.fromJson(
          json,
          fromJson: configData.fromJson,
        ),
        requestBody: (configData.parameters ?? {})
          ..addAll({
            _page: page,
            _perPage: perPage,
          }),
      );
    } else {
      String path =
          '${configData.apiEndPoint}?$_paginate=$paginate&$_page=$page&$_perPage=$perPage';
      if ({configData.parameters ?? {}}.isNotEmpty) {
        configData.parameters?.forEach((key, value) {
          path += '&$key=$value';
        });
      }

      apiResult = await APIClient.instance.get(
        endPoint: path,
        fromJson: (json) => PaginationResponse<T>.fromJson(
          json,
          fromJson: configData.fromJson,
        ),
      );
    }

    if (apiResult.isSuccess()) {
      paginationResponse = apiResult.getData();
      paginationList = paginationResponse?.data ?? [];
      isLastPage = paginationList.length < perPage;

      if (paginationList.isEmpty) {
        apiResult = ApiEmpty(configData.emptyListMessage);
      } else {
        apiResult = ApiSuccess(paginationList);
      }
    }
  }

  void callMoreData() async {
    if (loadingMoreEnd || loadingMore) {
      return;
    }
    page++;
    if (isLastPage) {
      loadingMoreEnd = true;
      return;
    }
    loadingMore = true;
    if (configData.isPostRequest) {
      apiResult = await APIClient.instance.post(
        endPoint: '${configData.apiEndPoint}?$_paginate=$paginate',
        fromJson: (json) => PaginationResponse<T>.fromJson(
          json,
          fromJson: configData.fromJson,
        ),
        requestBody: (configData.parameters ?? {})
          ..addAll({
            _page: page,
            _perPage: perPage,
          }),
      );
    } else {
      String path =
          '${configData.apiEndPoint}?$_paginate=$paginate&$_page=$page&$_perPage=$perPage';
      if ({configData.parameters ?? {}}.isNotEmpty) {
        configData.parameters?.forEach((key, value) {
          path += '&$key=$value';
        });
      }

      apiResult = await APIClient.instance.get(
        endPoint: path,
        fromJson: (json) => PaginationResponse<T>.fromJson(
          json,
          fromJson: configData.fromJson,
        ),
      );
    }

    if (apiResult is ApiSuccess) {
      paginationResponse = apiResult.getData();

      isLastPage = (paginationResponse?.data ?? []).length < perPage;

      paginationList.addAll(paginationResponse?.data ?? []);

      if (paginationList.isEmpty) {
        apiResult = ApiEmpty(configData.emptyListMessage);
      } else {
        apiResult = ApiSuccess(paginationList);
      }
    }
    loadingMore = false;
  }

  Future<void> refreshApiCall({bool loading = true}) async {
    page = 1;
    loadingMoreEnd = false;
    loadingMore = false;
    paginationList.clear();
    await callApi(loading: loading);
  }
}

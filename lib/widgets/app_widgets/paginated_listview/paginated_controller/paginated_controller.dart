import 'package:app_widgets_example/config/clients/api/api_client.dart';
import 'package:get/get.dart';

import '../../../../config/operation_reply.dart';
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

  OperationReply _operationReply = OperationReply.init();

  OperationReply get operationReply => _operationReply;

  set operationReply(OperationReply value) {
    _operationReply = value;
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
      operationReply = OperationReply.loading();
    }
    if (configData.isPostRequest) {
      operationReply = await APIClient.instance.post(
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

      operationReply = await APIClient.instance.get(
        endPoint: path,
        fromJson: (json) => PaginationResponse<T>.fromJson(
          json,
          fromJson: configData.fromJson,
        ),
      );
    }

    if (operationReply.isSuccess()) {
      paginationResponse = operationReply.result;
      paginationList = paginationResponse?.data ?? [];
      isLastPage = paginationList.length < perPage;

      if (paginationList.isEmpty) {
        operationReply = OperationReply.empty(
          message: configData.emptyListMessage,
        );
      } else {
        operationReply = OperationReply.success();
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
      operationReply = await APIClient.instance.post(
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

      operationReply = await APIClient.instance.get(
        endPoint: path,
        fromJson: (json) => PaginationResponse<T>.fromJson(
          json,
          fromJson: configData.fromJson,
        ),
      );
    }

    if (operationReply.isSuccess()) {
      paginationResponse = operationReply.result;

      isLastPage = (paginationResponse?.data ?? []).length < perPage;

      paginationList.addAll(paginationResponse?.data ?? []);

      if (paginationList.isEmpty) {
        operationReply = OperationReply.empty();
      } else {
        operationReply = OperationReply.success();
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

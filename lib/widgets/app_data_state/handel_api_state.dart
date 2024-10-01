import 'package:flutter/material.dart';
import 'package:general_app/config/clients/api/api_result.dart';
import 'package:general_app/widgets/app_data_state/app_empty_view.dart';
import 'package:general_app/widgets/app_data_state/app_error_view.dart';
import 'package:general_app/widgets/app_data_state/app_loading_view.dart';
import '../../controller/general_controller.dart';

class HandleApiState extends StatelessWidget {
  final GeneralController? generalController;
  final ApiResult? apiResult;
  final Widget child;
  final Widget? shimmerLoader;
  final Widget? emptyView;

  const HandleApiState.controller({
    super.key,
    required this.generalController,
    required this.child,
    this.apiResult,
    this.shimmerLoader,
    this.emptyView,
  });

  const HandleApiState.apiResult({
    super.key,
    required this.apiResult,
    required this.child,
    this.generalController,
    this.shimmerLoader,
    this.emptyView,
  });

  @override
  Widget build(BuildContext context) {
    if (generalController != null) {
      if (generalController!.apiResult is ApiStart) {
        return const SizedBox();
      } else if (generalController!.apiResult is ApiLoading) {
        return shimmerLoader ?? const AppLoadingView();
      } else if (generalController!.apiResult is ApiFailure) {
        return AppErrorView(
          error: generalController!.apiResult.getError(),
          retry: generalController!.refreshApiCall,
        );
      } else if (generalController!.apiResult is ApiEmpty) {
        return emptyView ??
            AppEmptyView(
              emptyText: generalController!.apiResult.getError(),
            );
      } else if (generalController!.apiResult is ApiSuccess) {
        return child;
      } else {
        return const SizedBox();
      }
    } else if (apiResult != null) {
      if (apiResult is ApiStart) {
        return const SizedBox();
      } else if (apiResult is ApiLoading) {
        return shimmerLoader ?? const AppLoadingView();
      } else if (apiResult is ApiFailure) {
        return AppErrorView(
          error: apiResult!.getError(),
          retry: generalController!.refreshApiCall,
        );
      } else if (apiResult is ApiEmpty) {
        return emptyView ??
            AppEmptyView(
              emptyText: apiResult!.getError(),
            );
      } else if (generalController!.apiResult is ApiSuccess) {
        return child;
      } else {
        return const SizedBox();
      }
    } else {
      return const SizedBox();
    }
  }
}

import 'package:flutter/material.dart';
import 'package:general_app/widgets/app_data_state/app_disconnect_view.dart';
import 'package:general_app/widgets/app_data_state/app_empty_view.dart';
import 'package:general_app/widgets/app_data_state/app_error_view.dart';
import 'package:general_app/widgets/app_data_state/app_loading_view.dart';

import '../../config/operation_reply.dart';
import '../../controller/general_controller.dart';

class HandleApiState extends StatelessWidget {
  final GeneralController? generalController;
  final OperationReply? operationReply;
  final Widget child;
  final Widget? shimmerLoader;
  final Widget? emptyView;

  const HandleApiState.controller({
    super.key,
    required this.generalController,
    required this.child,
    this.operationReply,
    this.shimmerLoader,
    this.emptyView,
  });

  const HandleApiState.operation({
    super.key,
    required this.operationReply,
    required this.child,
    this.generalController,
    this.shimmerLoader,
    this.emptyView,
  });

  @override
  Widget build(BuildContext context) {
    if (generalController != null) {
      switch (generalController!.operationReply.status) {
        case OperationStatus.init:
          return const SizedBox();
        case OperationStatus.loading:
          return shimmerLoader ?? const AppLoadingView();
        case OperationStatus.success:
          return child;
        case OperationStatus.failed:
          return AppErrorView(
            error: generalController!.operationReply.message,
            retry: generalController!.refreshApiCall,
          );
        case OperationStatus.empty:
          return emptyView ??
              AppEmptyView(
                emptyText: generalController!.operationReply.message,
              );
        case OperationStatus.disConnected:
          return AppDisconnectView(
            retry: generalController!.refreshApiCall,
          );
        default:
          return const SizedBox();
      }
    } else if (operationReply != null) {
      switch (operationReply!.status) {
        case OperationStatus.init:
          return const SizedBox();
        case OperationStatus.loading:
          return shimmerLoader ?? const AppLoadingView();
        case OperationStatus.success:
          return child;
        case OperationStatus.failed:
          return AppErrorView(error: operationReply!.message);
        case OperationStatus.disConnected:
          return AppDisconnectView(
            retry: generalController?.refreshApiCall,
          );
        case OperationStatus.empty:
          return emptyView ??
              AppEmptyView(
                emptyText: generalController?.operationReply.message,
              );
        default:
          return const SizedBox();
      }
    } else {
      return const SizedBox();
    }
  }
}

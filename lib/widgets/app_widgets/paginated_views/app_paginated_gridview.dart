import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:general_app/config/clients/storage/storage_client.dart';
import 'package:general_app/config/extension/space_extension.dart';
import 'package:general_app/config/theme/color_extension.dart';
import 'package:general_app/widgets/app_widgets/app_text.dart';
import 'package:general_app/widgets/app_widgets/paginated_views/paginated_controller/data/config_data.dart';
import 'package:general_app/widgets/app_widgets/paginated_views/paginated_controller/paginated_controller.dart';
import 'package:get/get.dart';

class AppPaginatedGridView<T> extends StatefulHookWidget {
  final Widget Function(T item) child;
  final Widget? shimmerLoading;
  final Widget? emptyView;
  final ConfigData<T> configData;
  final int crossAxisCount;

  const AppPaginatedGridView({
    super.key,
    required this.child,
    required this.configData,
    required this.crossAxisCount,
    this.shimmerLoading,
    this.emptyView,
  });

  @override
  State<AppPaginatedGridView<T>> createState() =>
      _AppPaginatedGridviewState<T>();
}

class _AppPaginatedGridviewState<T> extends State<AppPaginatedGridView<T>> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaginationController<T>>(
      init: PaginationController<T>(
        widget.configData,
      ),
      dispose: (state) {
        _scrollController.dispose();
      },
      initState: (state) {
        _scrollController.addListener(
          () {
            if (_scrollController.position.pixels ==
                _scrollController.position.maxScrollExtent) {
              state.controller?.callMoreData();
            }
          },
        );
      },
      builder: (controller) {
        return widget.shimmerLoading == null &&
                controller.operationReply.isLoading()
            ? const Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : RefreshIndicator(
                onRefresh: controller.refreshApiCall,
                child: controller.operationReply.isEmpty()
                    ? widget.emptyView ?? const SizedBox()
                    : Column(
                        children: [
                          Expanded(
                            child: GridView.builder(
                              controller: _scrollController,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: widget.crossAxisCount,
                              ),
                              itemCount:
                                  controller.operationReply.isLoading() &&
                                          widget.shimmerLoading != null
                                      ? 20
                                      : controller.paginationList.length,
                              itemBuilder: (BuildContext context, int index) {
                                if (controller.operationReply.isLoading()) {
                                  return widget.shimmerLoading;
                                } else {
                                  return widget
                                      .child(controller.paginationList[index]);
                                }
                              },
                            ),
                          ),
                          Offstage(
                            offstage: !controller.loadingMore &&
                                !controller.loadingMoreEnd,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 28.0,
                                  top: 18.0,
                                ),
                                child: controller.loadingMoreEnd
                                    ? _loadingMoreEndView()
                                    : controller.loadingMore
                                        ? _loadingMoreView()
                                        : const SizedBox(),
                              ),
                            ),
                          )
                        ],
                      ),
              );
      },
    );
  }

  Widget _loadingMoreView() => Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator.adaptive(),
            10.pw,
            AppText(
              text: StorageClient().isAr()
                  ? 'يتم تحميل مزيد من البيانات'
                  : 'Loading more data from',
              maxLines: 2,
              centerText: true,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: context.kHintTextColor,
            ),
          ],
        ),
      );

  Widget _loadingMoreEndView() => Center(
        child: AppText(
          text: StorageClient().isAr()
              ? 'لا يوجد المزيد من البيانات'
              : 'End of the data',
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: context.kHintTextColor,
        ),
      );
}

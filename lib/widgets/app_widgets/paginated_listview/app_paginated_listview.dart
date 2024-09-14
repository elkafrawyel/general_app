import 'package:app_widgets_example/config/clients/storage/storage_client.dart';
import 'package:app_widgets_example/config/extension/space_extension.dart';
import 'package:app_widgets_example/widgets/app_widgets/app_text.dart';
import 'package:app_widgets_example/widgets/app_widgets/paginated_listview/paginated_controller/data/config_data.dart';
import 'package:app_widgets_example/widgets/app_widgets/paginated_listview/paginated_controller/paginated_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppPaginatedListview<T> extends StatefulWidget {
  final Widget Function(T item) child;
  final Widget? shimmerLoading;
  final Widget? emptyView;
  final ConfigData configData;

  const AppPaginatedListview({
    super.key,
    required this.child,
    required this.configData,
    this.shimmerLoading,
    this.emptyView,
  });

  @override
  State<AppPaginatedListview<T>> createState() =>
      _AppPaginatedListviewState<T>();
}

class _AppPaginatedListviewState<T> extends State<AppPaginatedListview<T>> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaginationController>(
      init: PaginationController(
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
                    : ListView.builder(
                        controller: _scrollController,
                        itemCount: controller.operationReply.isLoading() &&
                                widget.shimmerLoading != null
                            ? 10
                            : controller.paginationList.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          if (controller.operationReply.isLoading()) {
                            return widget.shimmerLoading;
                          } else {
                            if (index < controller.paginationList.length) {
                              return widget
                                  .child(controller.paginationList[index]);
                            } else {
                              return Center(
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
                              );
                            }
                          }
                        },
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
            ),
          ],
        ),
      );

  Widget _loadingMoreEndView() => Center(
        child: AppText(
          text: StorageClient().isAr()
              ? 'لا يوجد المزيد من البيانات'
              : 'End of the data',
        ),
      );
}

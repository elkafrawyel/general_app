import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:general_app/config/clients/storage/storage_client.dart';
import 'package:general_app/config/extension/space_extension.dart';
import 'package:general_app/config/theme/color_extension.dart';
import 'package:general_app/widgets/app_data_state/handel_api_state.dart';
import 'package:general_app/widgets/app_widgets/app_text.dart';
import 'package:general_app/widgets/app_widgets/paginated_views/paginated_controller/data/config_data.dart';
import 'package:general_app/widgets/app_widgets/paginated_views/paginated_controller/paginated_controller.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

import '../../../config/helpers/date_helper.dart';
import '../data/message_model.dart';

/// =============================Important====================================
/// The model of data using this class must override
/// toString method and return the date of the notification or chat message
/// so this widgt can used to group the cards.

class AppPaginatedGroupedListview<T> extends StatefulWidget {
  final Widget Function(T item) child;
  final Widget? shimmerLoading;
  final Widget? emptyView;
  final ConfigData<T> configData;

  const AppPaginatedGroupedListview({
    super.key,
    required this.child,
    required this.configData,
    this.shimmerLoading,
    this.emptyView,
  });

  @override
  State<AppPaginatedGroupedListview<T>> createState() =>
      _AppPaginatedGroupedListviewState<T>();
}

class _AppPaginatedGroupedListviewState<T>
    extends State<AppPaginatedGroupedListview<T>> {
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
        return Column(
          children: [
            Expanded(
              child: HandleApiState.apiResult(
                apiResult: controller.apiResult,
                shimmerLoader: widget.shimmerLoading == null
                    ? null
                    : ListView.builder(
                        controller: _scrollController,
                        itemCount: 10,
                        itemBuilder: (BuildContext context, int index) =>
                            widget.shimmerLoading,
                      ),
                child: RefreshIndicator(
                  backgroundColor: context.kPrimaryColor,
                  color: context.kColorOnPrimary,
                  onRefresh: controller.refreshApiCall,
                  child: controller.apiResult.isEmpty()
                      ? widget.emptyView ?? const SizedBox()
                      : GroupedListView<T, DateTime?>(
                          controller: _scrollController,
                          physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics(),
                          ),
                          reverse: true,
                          order: GroupedListOrder.DESC,
                          useStickyGroupSeparators: false,
                          floatingHeader: false,
                          padding: const EdgeInsets.all(8),
                          elements: controller.paginationList.reversed.toList(),
                          groupBy: (T item) {
                            DateTime? date = DateTime.tryParse(item.toString());
                            return date == null
                                ? null
                                : DateTime(
                                    date.year,
                                    date.month,
                                    date.day,
                                  );
                          },
                          groupHeaderBuilder: (T item) {
                            if (item.toString().isEmpty) {
                              return const SizedBox();
                            }

                            String dateString =
                                DateHelper().getDateFromDateString(
                              item.toString(),
                              dateFormat: DateFormat('EE, dd MMMM'),
                            );

                            String headerText =
                                DateHelper().isToday(item.toString())
                                    ? StorageClient().isAr()
                                        ? 'اليوم'
                                        : "Today"
                                    : DateHelper().isYesterday(item.toString())
                                        ? StorageClient().isAr()
                                            ? 'أمس'
                                            : "Yesterday"
                                        : dateString;
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4.0,
                              ),
                              child: Align(
                                alignment: AlignmentDirectional.center,
                                child: Card(
                                  elevation: 1.0,
                                  color: context.kBackgroundColor,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                    child: AppText(
                                      text: headerText,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          itemBuilder: (context, T item) {
                            return widget.child(item);
                          },
                        ),
                ),
              ),
            ),
            SafeArea(
              child: MessageBar(
                messageBarHintText: StorageClient().isAr()
                    ? 'اكتب رسالتك هنا'
                    : 'Type your message here',
                sendButtonColor: context.kPrimaryColor,
                onSend: (String message) => _addMessage(message, controller),
                actions: [
                  InkWell(
                    child: Icon(
                      Icons.add,
                      color: context.kPrimaryColor,
                      size: 24,
                    ),
                    onTap: () {},
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: InkWell(
                      child: Icon(
                        Icons.camera_alt,
                        color: context.kPrimaryColor,
                        size: 24,
                      ),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  _addMessage(String message, PaginationController paginationController) {
    paginationController.paginationList.insert(
      0,
      MessageModel(
        title: message,
        creationDate: DateTime.now().toIso8601String(),
      ),
    );

    paginationController.update();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:general_app/config/theme/color_extension.dart';
import 'package:general_app/screens/notifications/components/notification_cardview.dart';
import 'package:general_app/screens/notifications/components/shimmer_notification_cardview.dart';
import 'package:general_app/widgets/app_widgets/app_appbar.dart';
import 'package:general_app/widgets/app_widgets/paginated_views/app_paginated_listview.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../config/res.dart';
import '../../widgets/app_widgets/paginated_views/paginated_controller/data/config_data.dart';
import 'data/notification_model.dart';

class NotificationsScreen extends StatefulHookWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.kBackgroundColor,
      appBar: const AppAppbar(
        title: 'paginated listView',
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AppPaginatedListview<NotificationModel>(
          configData: ConfigData<NotificationModel>(
            apiEndPoint: Res.apiNotifications,
            emptyListMessage: 'empty_notifications'.tr,
            fromJson: NotificationModel.fromJson,
            isPostRequest: true,
          ),
          child: (NotificationModel item) => NotificationCardView(
            notificationModel: item,
          ),
          // crossAxisCount: 2,
          shimmerLoading: const ShimmerNotificationCardView(),
          emptyView: Center(
            child: Icon(
              Icons.hourglass_empty,
              color: context.kHintTextColor,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:general_app/config/theme/color_extension.dart';
import 'package:general_app/screens/notifications/compnents/notification_cardview.dart';
import 'package:general_app/screens/notifications/compnents/shimmer_notification_cardview.dart';
import 'package:general_app/widgets/app_widgets/app_appbar.dart';
import 'package:general_app/widgets/app_widgets/paginated_listview/app_paginated_listview.dart';

import '../../config/res.dart';
import '../../widgets/app_widgets/paginated_listview/paginated_controller/data/config_data.dart';
import 'data/notification_model.dart';

class NotificationsScreen extends StatefulWidget {
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
          configData: ConfigData(
            apiEndPoint: Res.apiNotifications,
            // emptyListMessage: 'empty_notifications'.tr,
            fromJson: NotificationModel.fromJson,
            isPostRequest: true,
          ),
          child: (NotificationModel item) => NotificationCardView(
            notificationModel: item,
          ),
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

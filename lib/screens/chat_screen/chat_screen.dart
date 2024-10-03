import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:general_app/config/theme/color_extension.dart';
import 'package:general_app/screens/chat_screen/components/message_bubble.dart';
import 'package:general_app/screens/chat_screen/data/message_model.dart';
import 'package:general_app/widgets/app_widgets/app_appbar.dart';
import 'package:general_app/screens/chat_screen/components/app_paginated_grouped_listview.dart';
import 'package:general_app/widgets/app_widgets/paginated_views/paginated_controller/paginated_controller.dart';
import 'package:get/get.dart';

import '../../config/clients/api/api_result.dart';
import '../../config/clients/storage/storage_client.dart';
import '../../config/helpers/logging_helper.dart';
import '../../config/res.dart';
import '../../widgets/app_widgets/paginated_views/paginated_controller/data/config_data.dart';
import '../notifications/components/shimmer_notification_cardview.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  PaginationController? paginationController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: const AppAppbar(
        title: 'User Name',
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AppPaginatedGroupedListview<MessageModel>(
          configData: ConfigData<MessageModel>(
            apiEndPoint: Res.apiNotifications,
            emptyListMessage: 'empty_notifications'.tr,
            fromJson: MessageModel.fromJson,
            isPostRequest: true,
          ),
          child: (MessageModel item) => MessageBubble(
            messageModel: item,
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

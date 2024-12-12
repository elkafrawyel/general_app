import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:firebase_messaging_platform_interface/src/remote_message.dart';
import 'package:flutter/material.dart';
import 'package:general_app/config/clients/storage/storage_client.dart';
import 'package:general_app/config/notifications/notification_mixin.dart';
import 'package:general_app/config/theme/color_extension.dart';
import 'package:general_app/screens/chat_screen/components/message_bubble.dart';
import 'package:general_app/screens/chat_screen/data/message_model.dart';
import 'package:general_app/widgets/app_widgets/app_appbar.dart';
import 'package:general_app/widgets/app_widgets/paginated_views/app_paginated_grouped_listview.dart';
import 'package:general_app/widgets/app_widgets/paginated_views/paginated_controller/paginated_controller.dart';
import 'package:get/get.dart';

import '../../config/res.dart';
import '../../widgets/app_widgets/paginated_views/paginated_controller/data/config_data.dart';
import '../notifications/components/shimmer_notification_cardview.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with FCMNotificationMixin {
  late PaginationController paginationController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: context.kBackgroundColor,
      appBar: const AppAppbar(
        title: 'User Name',
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
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
                instance: (paginationController) =>
                    this.paginationController = paginationController,
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
          ),
          SafeArea(
            child: MessageBar(
              messageBarHintText: StorageClient().isAr()
                  ? 'اكتب رسالتك هنا'
                  : 'Type your message here',
              sendButtonColor: context.kPrimaryColor,
              messageBarColor: context.kBackgroundColor,
              onSend: (String message) => _addMessage(message),
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
      ),
    );
  }

  _addMessage(String message) {
    paginationController.paginationList.insert(
      0,
      MessageModel(
        title: message,
        creationDate: DateTime.now().toIso8601String(),
      ),
    );

    paginationController.update();
  }

  @override
  void onNotify(RemoteMessage notification) {
    _addMessage(notification.notification?.title ?? 'title here ');
  }
}

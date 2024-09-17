import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:general_app/screens/messages/controller/messages_controller.dart';
import 'package:general_app/widgets/app_data_state/handel_api_state.dart';
import 'package:general_app/widgets/app_widgets/app_appbar.dart';
import 'package:general_app/widgets/app_widgets/app_text.dart';

import '../../config/notifications/notification_mixin.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen>
    with FCMNotificationMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppAppbar(title: 'FCM Messages'),
      body: GetBuilder<MessagesController>(
        builder: (controller) {
          return HandleApiState.operation(
            operationReply: controller.operationReply,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(28.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: controller.messages
                      .map(
                        (element) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AppText(
                            text: element,
                            maxLines: 10,
                            fontSize: 16,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void onNotify(RemoteMessage notification) {
    Get.find<MessagesController>()
        .addMessage(notification.notification?.title ?? 'Empty');
  }
}

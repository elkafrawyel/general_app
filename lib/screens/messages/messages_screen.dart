import 'package:flutter/material.dart';
import 'package:general_app/screens/messages/controller/messages_controller.dart';
import 'package:general_app/widgets/app_widgets/app_appbar.dart';
import 'package:general_app/widgets/app_widgets/app_text.dart';
import 'package:get/get.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppAppbar(title: 'FCM Messages'),
      body: GetBuilder<MessagesController>(
        builder: (controller) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(
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
          );
        },
      ),
    );
  }
}

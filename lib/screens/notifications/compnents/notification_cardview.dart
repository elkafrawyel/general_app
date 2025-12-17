import 'package:flutter/material.dart';
import 'package:general_app/config/extension/space_extension.dart';
import 'package:general_app/screens/notifications/data/notification_model.dart';
import 'package:general_app/widgets/app_widgets/app_text.dart';

import '../../../config/helpers/app_logger.dart';
import '../../../widgets/app_widgets/app_card.dart';

class NotificationCardView extends StatelessWidget {
  final NotificationModel notificationModel;

  const NotificationCardView({
    super.key,
    required this.notificationModel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppLogger.info(notificationModel.title ?? '');
      },
      child: AppCard(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: notificationModel.title ?? '',
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              10.ph,
              AppText(
                text: notificationModel.description ?? '',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                maxLines: 3,
              ),
              10.ph,
            ],
          ),
        ),
      ),
    );
  }
}

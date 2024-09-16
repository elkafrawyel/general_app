import 'package:flutter/material.dart';
import 'package:general_app/config/clients/storage/storage_client.dart';
import 'package:general_app/config/extension/space_extension.dart';
import 'package:general_app/config/theme/color_extension.dart';
import 'package:general_app/widgets/app_widgets/app_button.dart';
import 'package:lottie/lottie.dart';

import '../../config/res.dart';
import '../app_widgets/app_text.dart';

class AppDisconnectView extends StatelessWidget {
  final Function()? retry;

  const AppDisconnectView({
    super.key,
    this.retry,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.top,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(Res.disconnectAnimation),
            AppText(
              text: StorageClient().isAr()
                  ? 'تأكد من اتصالك بشبكة'
                  : 'Make sure you connected to a network',
              color: context.kHintTextColor,
              fontSize: 16,
            ),
            30.ph,
            if (retry != null)
              AppButton(
                text: StorageClient().isAr() ? 'إاعادة المحاولة' : 'Retry',
                onPressed: retry,
              ),
          ],
        ),
      ),
    );
  }
}

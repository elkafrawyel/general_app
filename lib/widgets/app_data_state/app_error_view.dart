import 'package:flutter/cupertino.dart';
import 'package:general_app/config/clients/storage/storage_client.dart';
import 'package:general_app/widgets/app_widgets/app_button.dart';
import 'package:general_app/widgets/app_widgets/app_text.dart';
import 'package:lottie/lottie.dart';

import '../../config/res.dart';

class AppErrorView extends StatelessWidget {
  final String? error;
  final Function()? retry;

  const AppErrorView({
    super.key,
    this.error,
    this.retry,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Lottie.asset(Res.errorAnimation),
        ),
        if (error != null)
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 38.0),
              child: AppText(
                text: error!,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                maxLines: 10,
                centerText: true,
              ),
            ),
          ),
        if (retry != null)
          AppButton(
            text: StorageClient().isAr() ? 'إعادة المحاولة' : 'Retry',
            onPressed: retry,
          )
      ],
    );
  }
}

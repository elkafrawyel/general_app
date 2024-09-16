import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../config/res.dart';
import '../app_widgets/app_text.dart';

class AppEmptyView extends StatelessWidget {
  final String? emptyText;

  const AppEmptyView({
    super.key,
    required this.emptyText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(child: Lottie.asset(Res.emptyAnimation)),
        if (emptyText != null)
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: AppText(
                text: emptyText!,
                fontSize: 18,
                maxLines: 3,
                centerText: true,
              ),
            ),
          ),
      ],
    );
  }
}

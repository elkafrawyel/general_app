import 'package:flutter/material.dart';
import 'package:general_app/config/extension/space_extension.dart';
import 'package:general_app/widgets/app_widgets/app_shimmer.dart';

import '../../../widgets/app_widgets/app_card.dart';

class ShimmerNotificationCardView extends StatelessWidget {
  const ShimmerNotificationCardView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppShimmer.rectangular(
              height: 13,
              width: MediaQuery.sizeOf(context).width * 0.6,
            ),
            10.ph,
            AppShimmer.rectangular(
              height: 13,
              width: MediaQuery.sizeOf(context).width * 0.8,
            ),
            10.ph,
          ],
        ),
      ),
    );
  }
}

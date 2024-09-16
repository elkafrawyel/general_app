import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../config/res.dart';

class AppLoadingView extends StatelessWidget {
  const AppLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        Res.loadingAnimation,
      ),
    );
  }
}

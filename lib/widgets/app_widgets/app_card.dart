import 'package:app_widgets_example/config/theme/color_extension.dart';
import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final Widget child;

  const AppCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.kBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: context.kSecondaryColor,
          width: 1.0,
        ),
      ),
      child: child,
    );
  }
}

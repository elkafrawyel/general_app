import 'package:flutter/material.dart';
import 'package:general_app/config/theme/color_extension.dart';

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

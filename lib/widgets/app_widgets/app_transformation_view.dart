import 'package:flutter/material.dart';

class AppTransformationView extends StatelessWidget {
  final Widget child;

  const AppTransformationView({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationY(
          Directionality.of(context) == TextDirection.rtl ? 3.1416 : 0),
      child: child,
    );
  }
}

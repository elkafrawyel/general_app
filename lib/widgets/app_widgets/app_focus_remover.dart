import 'package:flutter/material.dart';

class AppFocusRemover extends StatelessWidget {
  final Widget _child;

  const AppFocusRemover({super.key, required Widget child}) : _child = child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: _child,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
    );
  }
}

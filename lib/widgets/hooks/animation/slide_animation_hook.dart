import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

Widget useSlideAnimationHook({
  required Widget child,
  Duration? duration,
  double? horizontalOffset,
  double? verticalOffset,
}) =>
    use(
      _SlideAnimationHook(
        child: child,
        duration: duration,
        horizontalOffset: horizontalOffset,
        verticalOffset: verticalOffset,
      ),
    );

class _SlideAnimationHook extends Hook<Widget> {
  final Widget child;
  final Duration? duration;
  final double? horizontalOffset;
  final double? verticalOffset;

  const _SlideAnimationHook({
    this.duration,
    this.horizontalOffset,
    this.verticalOffset,
    required this.child,
  });

  @override
  HookState<Widget, _SlideAnimationHook> createState() =>
      _SlideAnimationHookState();
}

class _SlideAnimationHookState extends HookState<Widget, _SlideAnimationHook> {
  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: 1,
      duration: hook.duration ?? const Duration(milliseconds: 1000),
      child: SlideAnimation(
        horizontalOffset: hook.horizontalOffset ?? 0,
        verticalOffset: hook.verticalOffset ?? 0,
        child: hook.child,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

Widget useFadeInSlideAnimationHook({
  required Widget child,
  Duration? duration,
  double? horizontalOffset,
  double? verticalOffset,
}) =>
    use(
      _FadeInSlideAnimationHook(
        child: child,
        duration: duration,
        horizontalOffset: horizontalOffset,
        verticalOffset: verticalOffset,
      ),
    );

class _FadeInSlideAnimationHook extends Hook<Widget> {
  final Widget child;
  final Duration? duration;
  final double? horizontalOffset;
  final double? verticalOffset;

  const _FadeInSlideAnimationHook({
    this.duration,
    this.horizontalOffset,
    this.verticalOffset,
    required this.child,
  });

  @override
  HookState<Widget, _FadeInSlideAnimationHook> createState() =>
      _FadeInSlideAnimationHookState();
}

class _FadeInSlideAnimationHookState
    extends HookState<Widget, _FadeInSlideAnimationHook> {
  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: 1,
      duration: hook.duration ?? const Duration(milliseconds: 1000),
      child: SlideAnimation(
        horizontalOffset: hook.horizontalOffset ?? 0,
        verticalOffset: hook.verticalOffset ?? 0,
        child: FadeInAnimation(
          child: hook.child,
        ),
      ),
    );
  }
}

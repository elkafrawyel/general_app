import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

Widget useFadeInAnimationHook({
  required Widget child,
  Duration? duration,
}) =>
    use(
      _FadeInAnimationHook(
        child: child,
        duration: duration,
      ),
    );

class _FadeInAnimationHook extends Hook<Widget> {
  final Widget child;
  final Duration? duration;

  const _FadeInAnimationHook({
    this.duration,
    required this.child,
  });

  @override
  HookState<Widget, _FadeInAnimationHook> createState() =>
      _FadeInAnimationHookState();
}

class _FadeInAnimationHookState
    extends HookState<Widget, _FadeInAnimationHook> {
  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: 1,
      duration: hook.duration ?? const Duration(milliseconds: 1000),
      child: FadeInAnimation(
        child: hook.child,
      ),
    );
  }
}

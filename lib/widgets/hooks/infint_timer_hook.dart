import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

String useInfiniteTimer(BuildContext context) =>
    use(const _InfiniteTimerHook());

class _InfiniteTimerHook extends Hook<String> {
  const _InfiniteTimerHook();

  @override
  HookState<String, _InfiniteTimerHook> createState() =>
      _InfiniteTimerHookState();
}

class _InfiniteTimerHookState extends HookState<String, _InfiniteTimerHook> {
  late Timer _timer;
  int seconds = 0;

  @override
  void initHook() {
    super.initHook();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        seconds = timer.tick;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  String build(BuildContext context) {
    String text =
        '${'${(seconds / 60).floor()}'.padLeft(2, '0')}:${'${seconds % 60}'.padLeft(2, '0')}';
    return text;
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:general_app/config/theme/color_extension.dart';
import 'package:general_app/widgets/app_widgets/app_text.dart';

Widget useCountDownTimer(
  BuildContext context, {
  required int seconds,
  required Function() onTimerFinished,
}) =>
    use(
      _CountDownTimerHook(
        seconds: seconds,
        onTimerFinished: onTimerFinished,
      ),
    );

class _CountDownTimerHook extends Hook<Widget> {
  final int seconds;
  final Function() onTimerFinished;

  const _CountDownTimerHook({
    required this.seconds,
    required this.onTimerFinished,
  });

  @override
  HookState<Widget, _CountDownTimerHook> createState() =>
      _InfiniteTimerHookState();
}

class _InfiniteTimerHookState extends HookState<Widget, _CountDownTimerHook> {
  late Timer _timer;
  int seconds = 0;

  @override
  void initHook() {
    super.initHook();
    seconds = hook.seconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        seconds--;
        if (seconds == 0) {
          _timer.cancel();
          hook.onTimerFinished();
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    String time =
        '${'${(seconds / 60).floor()}'.padLeft(2, '0')}:${'${seconds % 60}'.padLeft(2, '0')}';
    return AppText(
      text: time,
      // color: seconds <= 5 ? context.kErrorColor : null,
      fontSize: 50,
      fontWeight: FontWeight.bold,
    );
  }
}

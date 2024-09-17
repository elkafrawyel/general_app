import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../widgets/app_widgets/app_button.dart';
import '../../widgets/hooks/countdown_timer_hook.dart';

class SendCodeButton extends StatefulHookWidget {
  const SendCodeButton({super.key});

  @override
  State<SendCodeButton> createState() => _SendCodeButtonState();
}

class _SendCodeButtonState extends State<SendCodeButton> {
  bool showResendButton = false;
  bool showSendCode = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: showSendCode
          ? AppButton(
              text: 'Send',
              onPressed: () {
                setState(() {
                  showSendCode = false;
                });
              },
            )
          : showResendButton
              ? AppButton(
                  text: 'Resend',
                  onPressed: () {
                    setState(() {
                      showResendButton = false;
                    });
                  },
                )
              : useCountDownTimer(
                  context,
                  seconds: 10,
                  onTimerFinished: () {
                    setState(() {
                      showResendButton = true;
                    });
                  },
                ),
    );
  }
}

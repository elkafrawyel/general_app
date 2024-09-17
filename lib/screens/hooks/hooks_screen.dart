import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:general_app/config/res.dart';
import 'package:general_app/screens/hooks/send_code_button.dart';
import 'package:general_app/widgets/hooks/animation/fadein_animation_hook.dart';
import 'package:general_app/widgets/hooks/animation/fadein_slide_animation_hook.dart';
import 'package:general_app/widgets/hooks/animation/slide_animation_hook.dart';

import '../../widgets/app_widgets/app_appbar.dart';
import '../../widgets/app_widgets/app_text.dart';
import '../../widgets/hooks/infint_timer_hook.dart';

class HooksScreen extends StatefulHookWidget {
  const HooksScreen({super.key});

  @override
  State<HooksScreen> createState() => _HooksScreenState();
}

class _HooksScreenState extends State<HooksScreen> {
  @override
  Widget build(BuildContext context) {
    String infiniteTimer = useInfiniteTimer(context);

    return Scaffold(
      appBar: const AppAppbar(title: 'Hooks Screen'),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: AppText(
                  text: infiniteTimer,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SendCodeButton(),
              useFadeInSlideAnimationHook(
                child: Image.asset(
                  Res.logo,
                  width: 100,
                  height: 100,
                ),
                verticalOffset: 200,
                duration: const Duration(milliseconds: 1000),
              ),
              useFadeInAnimationHook(
                child: Image.asset(
                  Res.logo,
                  width: 100,
                  height: 100,
                ),
                duration: const Duration(milliseconds: 1000),
              ),
              useSlideAnimationHook(
                child: Image.asset(
                  Res.logo,
                  width: 100,
                  height: 100,
                ),
                verticalOffset: 200,
                duration: const Duration(milliseconds: 1000),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

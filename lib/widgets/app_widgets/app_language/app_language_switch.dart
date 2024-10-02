import 'package:flutter/material.dart';
import 'package:general_app/config/clients/storage/storage_client.dart';
import 'package:general_app/config/theme/color_extension.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../config/language/language_model.dart';

class AppLanguageSwitch extends StatefulWidget {
  const AppLanguageSwitch({super.key});

  @override
  State<AppLanguageSwitch> createState() => _AppLanguageSwitchState();
}

class _AppLanguageSwitchState extends State<AppLanguageSwitch> {
  int index = StorageClient().isAr() ? 1 : 0;

  @override
  Widget build(BuildContext context) {
    const radius = 8.0;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: context.kPrimaryColor,
          ),
          borderRadius: BorderRadius.circular(radius),
        ),
        child: ToggleSwitch(
          initialLabelIndex: index,
          cornerRadius: radius,
          animate: true,
          animationDuration: 300,
          activeFgColor: Colors.white,
          inactiveFgColor: context.kTextColor,
          inactiveBgColor: context.kBackgroundColor,
          totalSwitches: LanguageData.languageList().length,
          labels: LanguageData.languageList().map((e) => e.name).toList(),
          activeBgColors: [
            [context.kPrimaryColor],
            [context.kPrimaryColor],
          ],
          onToggle: (int? index) async {
            if (index == null) {
              return;
            }
            await LanguageData.changeLanguage(
              LanguageData.languageList()[index],
            );
            setState(() {
              this.index = index;
            });
          },
        ),
      ),
    );
  }
}

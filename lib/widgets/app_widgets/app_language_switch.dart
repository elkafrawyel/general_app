import 'package:app_widgets_example/config/clients/storage/storage_client.dart';
import 'package:app_widgets_example/config/theme/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../config/language/language_model.dart';

class AppLanguageSwitch extends StatefulWidget {
  const AppLanguageSwitch({super.key});

  @override
  State<AppLanguageSwitch> createState() => _AppLanguageSwitchState();
}

class _AppLanguageSwitchState extends State<AppLanguageSwitch> {
  int index = StorageClient().isAr() ? 1 : 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: ToggleSwitch(
          minWidth: 70.0,
          initialLabelIndex: index,
          cornerRadius: 8.0,
          activeFgColor: Colors.white,
          inactiveFgColor: Colors.white,
          inactiveBgColor: context.kHintTextColor,
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

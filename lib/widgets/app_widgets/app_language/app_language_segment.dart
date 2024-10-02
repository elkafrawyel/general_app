import 'package:flutter/material.dart';
import 'package:general_app/config/clients/storage/storage_client.dart';
import 'package:general_app/config/language/language_model.dart';
import 'package:general_app/config/theme/color_extension.dart';

class AppLanguageSegment extends StatefulWidget {
  const AppLanguageSegment({super.key});

  @override
  State<AppLanguageSegment> createState() => _AppLanguageSegmentState();
}

class _AppLanguageSegmentState extends State<AppLanguageSegment> {
  @override
  Widget build(BuildContext context) {
    return SegmentedButton<LanguageData>(
      style: SegmentedButton.styleFrom(
        backgroundColor: context.kBackgroundColor,
        foregroundColor: context.kTextColor,
        selectedForegroundColor: Colors.white,
        selectedBackgroundColor: context.kPrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        side: BorderSide(color: context.kPrimaryColor),
      ),
      showSelectedIcon: false,
      segments: LanguageData.languageList()
          .map(
            (e) => ButtonSegment<LanguageData>(
              value: e,
              label: Text(
                e.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          )
          .toList(),
      selected: <LanguageData>{
        LanguageData.languageList().firstWhere(
          (lang) => lang.languageCode == StorageClient().getAppLanguage(),
        ),
      },
      onSelectionChanged: (Set<LanguageData> newSelection) async {
        await LanguageData.changeLanguage(newSelection.first);
        setState(() {});
      },
    );
  }
}

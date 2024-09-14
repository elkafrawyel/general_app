import 'package:app_widgets_example/config/clients/api/api_client.dart';
import 'package:app_widgets_example/config/clients/storage/storage_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageData {
  static const supportedLocales = [Locale('en', 'US'), Locale('ar', 'SA')];
  final String flag;
  final String name;
  final String languageCode;

  static LanguageData selectedLanguage = languageList()
      .where(
        (element) =>
            element.languageCode.toLowerCase() ==
            (
              Get.locale?.languageCode.toLowerCase() ??
                  Get.deviceLocale!.languageCode.toLowerCase(),
            ),
      )
      .first;

  LanguageData(this.flag, this.name, this.languageCode);

  static List<LanguageData> languageList() {
    return <LanguageData>[
      LanguageData("🇺🇸", "English", 'en'),
      LanguageData("🇸🇦", "العربية", "ar"),
    ];
  }

  @override
  String toString() => name;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LanguageData &&
          runtimeType == other.runtimeType &&
          flag == other.flag &&
          name == other.name &&
          languageCode == other.languageCode;

  @override
  int get hashCode => flag.hashCode ^ name.hashCode ^ languageCode.hashCode;

  static Future<void> changeLanguage(LanguageData value) async {
    await Get.updateLocale(Locale(value.languageCode));
    await StorageClient().save(StorageClientKeys.language, value.languageCode);
    APIClient.instance.updateAcceptedLanguageHeader(value.languageCode);
  }
}

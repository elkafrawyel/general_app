import 'package:app_widgets_example/config/clients/storage/storage_client.dart';
import 'package:get/get.dart';

import 'app_colors.dart';

class ThemeController extends GetxController {
  final Rx<AppColors> appColors = AppColors.lightModeColors.obs;
  RxBool isDarkMode = false.obs;
  bool hasDarkMode = false;

  @override
  onInit() {
    super.onInit;
    _applySavedColors();
  }

  Future toggleAppTheme() async {
    bool? isDarkMode = StorageClient().get(StorageClientKeys.isDarkMode);
    if (isDarkMode ?? false) {
      await StorageClient().save(StorageClientKeys.isDarkMode, false);
      _updateColorsTheme(AppColors.lightModeColors);
    } else {
      await StorageClient().save(StorageClientKeys.isDarkMode, true);
      _updateColorsTheme(AppColors.darkModeColors);
    }
  }

  void _applySavedColors() async {
    if (hasDarkMode) {
      bool? isDarkMode = StorageClient().get(StorageClientKeys.isDarkMode);
      _updateColorsTheme(
        (isDarkMode ?? false)
            ? AppColors.darkModeColors
            : AppColors.lightModeColors,
      );
    } else {
      _updateColorsTheme(
        AppColors.lightModeColors,
      );
    }
  }

  void _updateColorsTheme(AppColors appNewColors) {
    appColors.value = appNewColors;
  }
}

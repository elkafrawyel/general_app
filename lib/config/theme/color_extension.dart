import 'package:flutter/material.dart';

import 'app_colors.dart';

extension ThemeExtensions on BuildContext {
  AppColors get _dynamicColors => Theme.of(this).extension<AppColors>()!;

  Color get kPrimaryColor => _dynamicColors.kPrimaryColor;

  Color get kSecondaryColor => _dynamicColors.kSecondaryColor;

  Color get kBackgroundColor => _dynamicColors.kBackgroundColor;

  Color get kTextColor => _dynamicColors.kTextColor;

  Color get kColorOnPrimary => _dynamicColors.kColorOnPrimaryColor;

  Color get kHintTextColor => _dynamicColors.kHintColor;

  Color get kErrorColor => _dynamicColors.kErrorColor;

  Color get kSuccessColor => _dynamicColors.kErrorColor;

  Color get kTextFieldColor => _dynamicColors.kTextFieldColor;
}

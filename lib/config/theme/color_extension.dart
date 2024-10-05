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

  TextStyle? get h1 => Theme.of(this).textTheme.displayLarge;
  TextStyle? get h2 => Theme.of(this).textTheme.displayMedium;
  TextStyle? get h3 => Theme.of(this).textTheme.displaySmall;
  TextStyle? get h4 => Theme.of(this).textTheme.headlineMedium;
  TextStyle? get h5 => Theme.of(this).textTheme.headlineSmall;
  TextStyle? get h6 => Theme.of(this).textTheme.titleLarge;

  TextStyle? get sub1 => Theme.of(this).textTheme.titleMedium;
  TextStyle? get sub2 => Theme.of(this).textTheme.titleSmall;

  TextStyle? get body1 => Theme.of(this).textTheme.bodyLarge;
  TextStyle? get body2 => Theme.of(this).textTheme.bodyMedium;

  TextStyle? get button => Theme.of(this).textTheme.labelLarge;

  // * PrimaryTextTheme
  TextStyle? get pH1 => Theme.of(this).primaryTextTheme.displayLarge;
  TextStyle? get pH2 => Theme.of(this).primaryTextTheme.displayMedium;
  TextStyle? get pH3 => Theme.of(this).primaryTextTheme.displaySmall;
  TextStyle? get pH4 => Theme.of(this).primaryTextTheme.headlineMedium;
  TextStyle? get pH5 => Theme.of(this).primaryTextTheme.headlineSmall;
  TextStyle? get pH6 => Theme.of(this).primaryTextTheme.titleLarge;

  TextStyle? get pSub1 => Theme.of(this).primaryTextTheme.titleMedium;
  TextStyle? get pSub2 => Theme.of(this).primaryTextTheme.titleSmall;

  TextStyle? get pBody1 => Theme.of(this).primaryTextTheme.bodyLarge;
  TextStyle? get pBody2 => Theme.of(this).primaryTextTheme.bodyMedium;

  TextStyle? get pButton => Theme.of(this).primaryTextTheme.labelLarge;
}

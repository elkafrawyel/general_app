import 'package:flutter/material.dart';

import '../extension/color_extension.dart';

class AppColors extends ThemeExtension<AppColors> {
  // Dynamic colors
  final Color kPrimaryColor;
  final Color kSecondaryColor;
  final Color kBackgroundColor;
  final Color kTextColor;
  final Color kColorOnPrimaryColor;
  final Color kHintColor;
  final Color kErrorColor;
  final Color kSuccessColor;
  final Color kTextFieldColor;

  /// dynamic colors
  const AppColors({
    required this.kPrimaryColor,
    required this.kSecondaryColor,
    required this.kBackgroundColor,
    required this.kTextColor,
    required this.kColorOnPrimaryColor,
    required this.kHintColor,
    required this.kErrorColor,
    required this.kSuccessColor,
    required this.kTextFieldColor,
  });

  factory AppColors.fromColors({
    required String primaryColor,
    required String secondaryColor,
    required String backgroundColor,
    required String textColor,
    required String textOnPrimaryColor,
    required String hintColor,
    required String errorColor,
    required String successColor,
    required String textFieldColor,
  }) {
    return AppColors(
      kPrimaryColor: primaryColor.contains('#')
          ? HexColor.fromHex(
              primaryColor,
            )
          : RgbColor.fromRgbString(
              primaryColor,
            ),
      kSecondaryColor: secondaryColor.contains('#')
          ? HexColor.fromHex(
              secondaryColor,
            )
          : RgbColor.fromRgbString(
              secondaryColor,
            ),
      kBackgroundColor: backgroundColor.contains('#')
          ? HexColor.fromHex(
              backgroundColor,
            )
          : RgbColor.fromRgbString(
              backgroundColor,
            ),
      kTextColor: textColor.contains('#')
          ? HexColor.fromHex(
              textColor,
            )
          : RgbColor.fromRgbString(
              textColor,
            ),
      kColorOnPrimaryColor: textOnPrimaryColor.contains('#')
          ? HexColor.fromHex(
              textOnPrimaryColor,
            )
          : RgbColor.fromRgbString(
              textOnPrimaryColor,
            ),
      kHintColor: hintColor.contains('#')
          ? HexColor.fromHex(
              hintColor,
            )
          : RgbColor.fromRgbString(
              hintColor,
            ),
      kErrorColor: errorColor.contains('#')
          ? HexColor.fromHex(
              errorColor,
            )
          : RgbColor.fromRgbString(
              errorColor,
            ),
      kSuccessColor: successColor.contains('#')
          ? HexColor.fromHex(
              successColor,
            )
          : RgbColor.fromRgbString(
              successColor,
            ),
      kTextFieldColor: textFieldColor.contains('#')
          ? HexColor.fromHex(
              textFieldColor,
            )
          : RgbColor.fromRgbString(
              textFieldColor,
            ),
    );
  }

  @override
  ThemeExtension<AppColors> copyWith({
    Color? primaryColor,
    Color? primaryLightColor,
    Color? backgroundColor,
    Color? textColor,
    Color? textOnPrimaryColor,
    Color? hintColor,
    Color? errorColor,
    Color? successColor,
    Color? textFieldColor,
  }) {
    return AppColors(
      kPrimaryColor: primaryColor ?? kPrimaryColor,
      kSecondaryColor: primaryLightColor ?? kSecondaryColor,
      kBackgroundColor: backgroundColor ?? kBackgroundColor,
      kTextColor: textColor ?? kTextColor,
      kColorOnPrimaryColor: textOnPrimaryColor ?? kColorOnPrimaryColor,
      kHintColor: hintColor ?? kHintColor,
      kErrorColor: errorColor ?? kErrorColor,
      kSuccessColor: successColor ?? kSuccessColor,
      kTextFieldColor: textFieldColor ?? kTextFieldColor,
    );
  }

  @override
  ThemeExtension<AppColors> lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      kPrimaryColor: Color.lerp(kPrimaryColor, other.kPrimaryColor, t)!,
      kSecondaryColor: Color.lerp(kSecondaryColor, other.kSecondaryColor, t)!,
      kBackgroundColor:
          Color.lerp(kBackgroundColor, other.kBackgroundColor, t)!,
      kHintColor: Color.lerp(kHintColor, other.kHintColor, t)!,
      kColorOnPrimaryColor:
          Color.lerp(kColorOnPrimaryColor, other.kColorOnPrimaryColor, t)!,
      kTextColor: Color.lerp(kTextColor, other.kTextColor, t)!,
      kErrorColor: Color.lerp(kErrorColor, other.kErrorColor, t)!,
      kSuccessColor: Color.lerp(kSuccessColor, other.kSuccessColor, t)!,
      kTextFieldColor: Color.lerp(kTextFieldColor, other.kTextFieldColor, t)!,
    );
  }

  static AppColors lightModeColors = const AppColors(
    kPrimaryColor: Color(0xff117554),
    kSecondaryColor: Color(0xffD6BD98),
    kBackgroundColor: Colors.white,
    kTextColor: Colors.black,
    kColorOnPrimaryColor: Colors.white,
    kHintColor: Colors.black45,
    kErrorColor: Colors.red,
    kSuccessColor: Colors.green,
    kTextFieldColor: Colors.white60,
  );

  static AppColors darkModeColors = const AppColors(
    kPrimaryColor: Color(0xff034503),
    kSecondaryColor: Color(0xff3C3D37),
    kBackgroundColor: Color(0xff1E201E),
    kTextColor: Colors.white,
    kColorOnPrimaryColor: Colors.white,
    kHintColor: Colors.white24,
    kErrorColor: Colors.red,
    kSuccessColor: Colors.green,
    kTextFieldColor: Colors.black45,
  );
}

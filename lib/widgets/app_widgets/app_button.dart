import 'package:flutter/material.dart';
import 'package:general_app/config/theme/color_extension.dart';

import 'app_text.dart';

class AppButton extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final Color? textColor;
  final Color? backgroundColor;
  final EdgeInsetsDirectional? padding;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 5.0,
        disabledBackgroundColor: context.kHintTextColor,
        backgroundColor: backgroundColor ?? context.kPrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        padding: padding,
      ),
      onPressed: onPressed,
      child: AppText(
        text: text,
        color: textColor ?? context.kColorOnPrimary,
      ),
    );
  }
}

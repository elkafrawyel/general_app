import 'package:flutter/material.dart';
import 'package:general_app/config/theme/color_extension.dart';

import '../../config/constants.dart';

class AppText extends StatelessWidget {
  final String text;
  final Color? color;
  final int? maxLines;
  final bool centerText;
  final double fontSize;
  final FontWeight? fontWeight;
  final bool lineThrough;
  final bool underLine;

  const AppText({
    super.key,
    required this.text,
    this.color,
    this.maxLines,
    this.centerText = false,
    this.fontSize = kDefaultFontSize,
    this.fontWeight,
    this.lineThrough = false,
    this.underLine = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color ?? context.kTextColor,
        fontSize: fontSize,
        fontFamily: Constants.fontFamily,
        fontWeight: fontWeight,
        decoration: lineThrough
            ? TextDecoration.lineThrough
            : underLine
                ? TextDecoration.underline
                : TextDecoration.none,
        decorationThickness: 1,
        decorationColor: color ?? Colors.black,
      ),
      textAlign: centerText ? TextAlign.center : TextAlign.start,
      maxLines: maxLines,
    );
  }
}

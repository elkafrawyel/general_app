import 'package:flutter/material.dart';
import 'package:general_app/config/theme/color_extension.dart';

import 'app_text.dart';

class AppAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color? backgroundColor;
  final Color? textColor;
  final bool? centerTitle;
  final List<Widget>? actions;

  const AppAppbar({
    super.key,
    required this.title,
    this.backgroundColor,
    this.textColor,
    this.centerTitle,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: AppText(
        text: title,
        color: textColor ?? context.kColorOnPrimary,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: Theme.of(context).iconTheme.copyWith(
            color: textColor ?? context.kColorOnPrimary,
          ),
      backgroundColor: backgroundColor ?? context.kPrimaryColor,
      centerTitle: centerTitle,
      actions: actions,
      surfaceTintColor: Colors.transparent,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

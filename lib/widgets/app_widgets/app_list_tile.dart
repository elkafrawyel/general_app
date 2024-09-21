import 'package:flutter/material.dart';
import 'package:general_app/config/constants.dart';
import 'package:general_app/config/theme/color_extension.dart';
import 'package:general_app/widgets/app_widgets/app_text.dart';

class AppListTile extends StatelessWidget {
  final Widget? leading;
  final Widget? trailing;
  final String? title;
  final String? body;
  final Function()? onTap;
  final bool? selected;

  const AppListTile({
    super.key,
    this.leading,
    this.title,
    this.body,
    this.trailing,
    this.onTap,
    this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          kRadius,
        ),
      ),
      selectedColor: context.kPrimaryColor,
      iconColor: context.kTextColor,
      onTap: onTap,
      selected: selected ?? false,
      leading: leading,
      title: title == null
          ? null
          : AppText(
              text: title!,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              maxLines: 1,
            ),
      subtitle: body == null
          ? null
          : AppText(
              text: body!,
              fontSize: 13,
              fontWeight: FontWeight.w400,
              maxLines: 5,
            ),
      trailing: trailing,
    );
  }
}

import 'package:app_widgets_example/config/extension/space_extension.dart';
import 'package:app_widgets_example/config/theme/color_extension.dart';
import 'package:app_widgets_example/widgets/app_widgets/app_text.dart';
import 'package:flutter/material.dart';

class AppCheckbox extends StatefulWidget {
  final String text;
  final bool value;
  final ValueChanged<bool?>? onChange;

  const AppCheckbox({
    super.key,
    required this.text,
    required this.value,
    this.onChange,
  });

  @override
  State<AppCheckbox> createState() => _AppCheckboxState();
}

class _AppCheckboxState extends State<AppCheckbox> {
  bool? value;

  @override
  void initState() {
    super.initState();
    value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          activeColor: context.kPrimaryColor,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          value: value,
          onChanged: (bool? value) {
            if (widget.onChange != null) {
              widget.onChange!(value);
            }
            setState(() {
              this.value = value;
            });
          },
        ),
        5.pw,
        AppText(
          text: widget.text,
        )
      ],
    );
  }
}

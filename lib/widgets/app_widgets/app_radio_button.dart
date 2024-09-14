import 'package:flutter/material.dart';
import 'package:general_app/config/theme/color_extension.dart';

import 'app_text.dart';

class AppRadioButton<T> extends StatefulWidget {
  final List<T> options;
  final Function(T? value) onChanged;

  const AppRadioButton({
    super.key,
    required this.options,
    required this.onChanged,
  });

  @override
  State<AppRadioButton<T>> createState() => _AppRadioButtonState<T>();
}

class _AppRadioButtonState<T> extends State<AppRadioButton<T>> {
  T? _groupValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.options
          .map(
            (option) => ListTile(
              horizontalTitleGap: 0,
              title: AppText(
                text: option.toString(),
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
              leading: Radio<T>(
                activeColor: context.kPrimaryColor,
                value: option,
                groupValue: _groupValue,
                onChanged: (T? value) {
                  setState(() {
                    _groupValue = value;
                  });
                  widget.onChanged(value);
                },
              ),
            ),
          )
          .toList(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:general_app/config/theme/color_extension.dart';
import 'package:general_app/widgets/app_widgets/app_text.dart';

class AppChipsMultiChoice<T> extends StatefulWidget {
  const AppChipsMultiChoice({
    super.key,
    required this.choices,
    required this.onSelectedChoicesChanged,
  });

  final List<T> choices;
  final Function(List<T> selectedChoics) onSelectedChoicesChanged;

  @override
  State<AppChipsMultiChoice<T>> createState() => _AppChipsMultiChoiceState();
}

class _AppChipsMultiChoiceState<T> extends State<AppChipsMultiChoice<T>> {
  List<T> selectedChoics = [];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5,
      children: widget.choices.map(
        (choice) {
          return FilterChip(
            label: AppText(
              text: choice.toString(),
              color: selectedChoics.contains(choice)
                  ? context.kColorOnPrimary
                  : context.kTextColor,
            ),
            backgroundColor: context.kBackgroundColor,
            side: BorderSide(color: context.kPrimaryColor),
            selected: selectedChoics.contains(choice),
            onSelected: (bool selected) {
              setState(() => selectedChoics.contains(choice)
                  ? selectedChoics.remove(choice)
                  : selectedChoics.add(choice));
              widget.onSelectedChoicesChanged(selectedChoics);
            },
            selectedColor: context.kPrimaryColor,
            checkmarkColor: selectedChoics.contains(choice)
                ? context.kColorOnPrimary
                : context.kTextColor,
            // onDeleted: () => setState(() => selectedChoics.remove(choice)),
            // deleteIconColor: context.kColorOnPrimary,
          );
        },
      ).toList(),
    );
  }
}

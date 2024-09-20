import 'package:flutter/material.dart';
import 'package:general_app/config/theme/color_extension.dart';
import 'package:general_app/widgets/app_widgets/app_text.dart';

class AppChipsSingleChoice<T> extends StatefulWidget {
  const AppChipsSingleChoice({
    super.key,
    required this.choices,
    required this.onSelectedChoiceChanged,
  });

  final List<T> choices;
  final Function(T? selectedChoics) onSelectedChoiceChanged;

  @override
  State<AppChipsSingleChoice<T>> createState() => _AppChipsSingleChoiceState();
}

class _AppChipsSingleChoiceState<T> extends State<AppChipsSingleChoice<T>> {
  T? selectedChoice;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5,
      children: widget.choices.map(
        (choice) {
          return FilterChip(
            label: AppText(
              text: choice.toString(),
              color: selectedChoice == choice
                  ? context.kColorOnPrimary
                  : context.kTextColor,
            ),
            backgroundColor: context.kBackgroundColor,
            side: BorderSide(color: context.kPrimaryColor),
            selected: selectedChoice == choice,
            onSelected: (bool selected) {
              setState(() => selectedChoice == choice
                  ? selectedChoice = null
                  : selectedChoice = choice);
              widget.onSelectedChoiceChanged(selectedChoice);
            },
            selectedColor: context.kPrimaryColor,
            checkmarkColor: selectedChoice == choice
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

import 'package:app_widgets_example/config/theme/color_extension.dart';
import 'package:flutter/material.dart';

import 'app_text.dart';

class AppDropDownMenu<T> extends StatefulWidget {
  final List<T> items;
  final Function(T?) onChanged;
  final String hint;
  final T? initialValue;
  final bool bordered;
  final double radius;
  final bool expanded;
  final Color? backgroundColor;
  final bool centerHint;
  final String? validationText;

  const AppDropDownMenu({
    super.key,
    this.initialValue,
    required this.hint,
    required this.items,
    required this.onChanged,
    this.bordered = false,
    this.radius = 8,
    this.expanded = false,
    this.backgroundColor,
    this.centerHint = false,
    this.validationText,
  });

  @override
  State<AppDropDownMenu<T>> createState() => AppDropDownMenuState<T>();
}

class AppDropDownMenuState<T> extends State<AppDropDownMenu<T>> {
  T? selectedItem;
  FormFieldState<Object?>? formFieldState;

  @override
  void initState() {
    selectedItem = widget.initialValue;
    super.initState();
  }

  void clearSelection() {
    setState(() {
      selectedItem = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null) {
          return widget.validationText;
        } else {
          return null;
        }
      },
      builder: ((formFieldState) {
        this.formFieldState = formFieldState;
        bool hasError =
            formFieldState.hasError && widget.validationText != null;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: widget.bordered
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(widget.radius),
                      border: Border.all(
                        width: 1,
                        color: hasError
                            ? context.kErrorColor
                            : context.kPrimaryColor,
                      ),
                      color: widget.backgroundColor ?? context.kBackgroundColor,
                    )
                  : BoxDecoration(
                      color: widget.backgroundColor ?? context.kBackgroundColor,
                    ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: DropdownButton<T>(
                value: selectedItem,
                dropdownColor: context.kBackgroundColor,
                hint: Align(
                  alignment: widget.centerHint
                      ? AlignmentDirectional.center
                      : AlignmentDirectional.centerStart,
                  child: AppText(
                    text: selectedItem == null
                        ? widget.hint
                        : selectedItem.toString(),
                    maxLines: 1,
                    color: context.kHintTextColor,
                  ),
                ),
                isExpanded: widget.expanded,
                iconSize: 25,
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: context.kTextColor,
                ),
                underline: const SizedBox(),
                items: widget.items.isEmpty
                    ? []
                    : widget.items
                        .map(
                          (e) => DropdownMenuItem<T>(
                            value: widget.items[widget.items.indexOf(e)],
                            child: AppText(
                              text: e.toString(),
                            ),
                          ),
                        )
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedItem = value;
                  });
                  widget.onChanged(value);
                },
              ),
            ),
            if (hasError)
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 12, top: 10),
                child: Text(
                  '${formFieldState.errorText} *',
                  style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.normal,
                    color: context.kErrorColor,
                  ),
                ),
              )
          ],
        );
      }),
    );
  }
}

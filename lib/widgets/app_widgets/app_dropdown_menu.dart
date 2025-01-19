import 'package:flutter/material.dart';

import 'app_text.dart';

class AppDropMenu<T> extends StatefulWidget {
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

  const AppDropMenu({
    super.key,
    this.initialValue,
    required this.hint,
    required this.items,
    required this.onChanged,
    this.bordered = false,
    this.radius = 8,
    this.expanded = true,
    this.backgroundColor,
    this.centerHint = false,
    this.validationText,
  });

  @override
  State<AppDropMenu<T>> createState() => AppDropMenuState<T>();
}

class AppDropMenuState<T> extends State<AppDropMenu<T>> {
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

  void updateSelection(T? item) {
    setState(() {
      selectedItem = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      value: selectedItem,
      dropdownColor: Colors.white,
      hint: Align(
        alignment: widget.centerHint ? AlignmentDirectional.center : AlignmentDirectional.centerStart,
        child: AppText(
          text: selectedItem == null ? widget.hint : selectedItem.toString(),
          maxLines: 1,
          color: const Color(0xff6E7C91),
          fontSize: 12.62,
        ),
      ),
      decoration: widget.bordered
          ? InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.radius),
                borderSide: const BorderSide(
                  width: 0.5,
                  color: Color(0xffCED7E3),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.radius),
                borderSide: const BorderSide(
                  width: 1,
                  color: Color(0xffCED7E3),
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.radius),
                borderSide: const BorderSide(
                  width: 1,
                  color: Colors.red,
                ),
              ),
              fillColor: widget.backgroundColor,
            )
          : InputDecoration(
              fillColor: widget.backgroundColor,
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
      isExpanded: widget.expanded,
      iconSize: 25,
      icon: const Icon(Icons.keyboard_arrow_down),
      validator: (value) {
        if (value == null) {
          return widget.validationText;
        } else {
          return null;
        }
      },
      items: widget.items.isEmpty
          ? []
          : widget.items
              .map(
                (e) => DropdownMenuItem<T>(
                  value: widget.items[widget.items.indexOf(e)],
                  child: AppText(
                    text: e.toString(),
                    fontSize: 12.62,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff6E7C91),
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
    );
  }
}

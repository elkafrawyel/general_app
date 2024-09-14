import 'package:flutter/material.dart';
import 'package:general_app/config/theme/color_extension.dart';

import '../../../config/constants.dart';
import '../app_modal_bottom_sheet.dart';
import '../app_text.dart';
import 'app_multi_select_model.dart';

class AppMultiSelect extends StatefulWidget {
  final List<AppMultiSelectModel> items;
  final List<AppMultiSelectModel>? initialItems;
  final double? searchBarHeight;
  final Color? primaryColor;
  final Color? backgroundColor;
  final Color? dropdownBackgroundColor;
  final String? label;
  final String? dropdownHintText;
  final TextStyle? labelStyle;
  final TextStyle? dropdownItemStyle;
  final String? multiSelectTag;
  final int? initialIndex;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool hideSearch;
  final bool? enabled;
  final bool? showClearButton;
  final bool multiSelect;
  final bool? multiSelectValuesAsWidget;
  final bool? showLabelInMenu;
  final String? itemOnDialogueBox;
  final Decoration? decoration;
  final TextAlign? labelAlign;
  final ValueChanged<List<AppMultiSelectModel>>? onMultiSelect;
  final ValueChanged<AppMultiSelectModel?>? onSingleSelect;
  final bool displayAsBottomSheet;
  final String? validationText;

  const AppMultiSelect.multi({
    super.key,
    required this.items,
    required this.label,
    this.onMultiSelect,
    this.onSingleSelect,
    this.initialItems,
    this.labelAlign,
    this.searchBarHeight,
    this.primaryColor,
    this.labelStyle,
    this.enabled,
    this.showClearButton,
    this.itemOnDialogueBox,
    this.prefixIcon,
    this.suffixIcon,
    this.initialIndex,
    this.multiSelectTag,
    this.multiSelectValuesAsWidget,
    this.hideSearch = false,
    this.decoration,
    this.showLabelInMenu,
    this.dropdownItemStyle,
    this.backgroundColor,
    this.dropdownBackgroundColor,
    this.dropdownHintText,
    this.displayAsBottomSheet = true,
    this.validationText,
  })  : multiSelect = true,
        assert(onMultiSelect != null);

  const AppMultiSelect.single({
    super.key,
    required this.items,
    required this.label,
    this.onMultiSelect,
    this.onSingleSelect,
    this.initialItems,
    this.labelAlign,
    this.searchBarHeight,
    this.primaryColor,
    this.labelStyle,
    this.enabled,
    this.showClearButton,
    this.itemOnDialogueBox,
    this.prefixIcon,
    this.suffixIcon,
    this.initialIndex,
    this.multiSelectTag,
    this.multiSelectValuesAsWidget,
    this.hideSearch = false,
    this.decoration,
    this.showLabelInMenu,
    this.dropdownItemStyle,
    this.backgroundColor,
    this.dropdownBackgroundColor,
    this.dropdownHintText,
    this.displayAsBottomSheet = true,
    this.validationText,
  })  : multiSelect = false,
        assert(onSingleSelect != null);

  @override
  AppMultiSelectState createState() => AppMultiSelectState();
}

class AppMultiSelectState extends State<AppMultiSelect> {
  final TextEditingController searchController = TextEditingController();
  String singleSelectLabel = '';
  Map<int, AppMultiSelectModel> allItemsMap = {};
  int? initialIndex;
  List<AppMultiSelectModel> initialItems = [];
  List<AppMultiSelectModel> searchList = [];
  List<AppMultiSelectModel> selectedItems = [];
  String? searchQuery;
  FormFieldState<Object?>? formFieldState;

  @override
  void initState() {
    super.initState();

    if (widget.multiSelect) {
      initialItems = widget.initialItems ?? [];
      for (var value in widget.items) {
        allItemsMap[value.hashCode] = value;
      }
    } else {
      initialIndex = widget.initialIndex;
    }
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (initialIndex != null &&
        widget.items.isNotEmpty &&
        singleSelectLabel.isEmpty) {
      singleSelectLabel = widget.items[initialIndex!].name;
    }

    if (widget.multiSelect) {
      if (selectedItems.isEmpty) {
        if (widget.items.isNotEmpty) {
          if (initialItems.isNotEmpty) {
            selectedItems.clear();
          }

          if (initialItems.isNotEmpty) {
            for (int i = 0; i < initialItems.length; i++) {
              if (allItemsMap[initialItems[i].hashCode] != null) {
                selectedItems.add(initialItems[i]);
              }
            }
          }
        }
      }
    } else {
      if (singleSelectLabel == '' && initialIndex != null) {
        singleSelectLabel = widget.items[initialIndex!].name;
      } else {
        if (searchQuery != null) {
          onItemChanged(searchQuery!);
        }
      }
    }

    if (widget.multiSelect && widget.items.isEmpty) {
      singleSelectLabel = '';
      selectedItems.clear();
      widget.onMultiSelect!([]);
    }

    return FormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null) {
          return widget.validationText;
        } else {
          return null;
        }
      },
      builder: (formFieldState) {
        this.formFieldState = formFieldState;
        if (widget.multiSelect) {
          // ignore: invalid_use_of_protected_member
          formFieldState.setValue(initialItems);
        } else {
          // ignore: invalid_use_of_protected_member
          formFieldState.setValue(initialIndex);
        }
        bool hasError =
            formFieldState.hasError && widget.validationText != null;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                if (widget.enabled == null || widget.enabled == true) {
                  if (widget.items.isNotEmpty) {
                    searchList = widget.items;
                    onItemChanged(searchController.text);
                    widget.displayAsBottomSheet
                        ? showBottomSheet(context)
                        : showDialogueBox(context);
                  }
                }
                setState(() {});
              },
              child: Container(
                decoration: widget.decoration ??
                    BoxDecoration(
                      color: context.kBackgroundColor,
                      border: Border.all(
                        color: hasError
                            ? context.kErrorColor
                            : context.kPrimaryColor,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(kRadius),
                    ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      if (widget.prefixIcon != null) const SizedBox(width: 5),
                      widget.prefixIcon ?? const SizedBox(),
                      if (widget.prefixIcon != null) const SizedBox(width: 10),
                      (widget.multiSelect && selectedItems.isNotEmpty)
                          ? Expanded(
                              child: (widget.multiSelectValuesAsWidget ==
                                          true &&
                                      widget.multiSelectValuesAsWidget != null)
                                  ? Wrap(
                                      children: selectedItems
                                          .map(
                                            (e) => Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      5, 3, 5, 3),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: context.kPrimaryColor,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(kRadius),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                    5,
                                                    2,
                                                    5,
                                                    2,
                                                  ),
                                                  child: AppText(
                                                    text: e.name,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    )
                                  : AppText(
                                      text: selectedItems.length == 1
                                          ? widget.multiSelectTag == null
                                              ? '${selectedItems.length} values selected'
                                              : '${selectedItems.length} ${widget.multiSelectTag!} selected'
                                          : widget.multiSelectTag == null
                                              ? '${selectedItems.length} values selected'
                                              : '${selectedItems.length} ${widget.multiSelectTag!} selected',
                                    ),
                            )
                          : Expanded(
                              child: AppText(
                                text: singleSelectLabel == ''
                                    ? widget.label == null
                                        ? 'Choose Value'
                                        : widget.label!
                                    : singleSelectLabel,
                              ),
                            ),
                      widget.suffixIcon ??
                          Icon(
                            Icons.arrow_drop_down,
                            color: context.kTextColor,
                          )
                    ],
                  ),
                ),
              ),
            ),
            if (hasError)
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 12, top: 10),
                child: AppText(
                  text: formFieldState.errorText!,
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                ),
              )
          ],
        );
      },
    );
  }

  clearAll() {
    if (widget.multiSelect) {
      widget.initialItems?.clear();
      selectedItems.clear();
      widget.onMultiSelect!([]);
    } else {
      initialIndex = null;
      singleSelectLabel = '';
      widget.onSingleSelect!(null);
    }

    if (formFieldState != null) {
      // ignore: invalid_use_of_protected_member
      formFieldState!.setValue(null);
    }
    setState(() {});
  }

  selectAll() {
    if (widget.multiSelect) {
      selectedItems.clear();
      selectedItems.addAll(widget.items);
      widget.onMultiSelect!(selectedItems);
    }

    setState(() {});
  }

  Future<void> showBottomSheet(BuildContext context) async {
    await showAppModalBottomSheet(
      context: context,
      maxChildSize: 0.95,
      minChildSize: 0.4,
      initialChildSize: 0.7,
      builder: (context, scrollController) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Material(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  decoration: BoxDecoration(
                    color: context.kBackgroundColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 12.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Container(
                                height: 7,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: context.kPrimaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        _searchBox(setState),
                        _labelView(setState),
                        _selectAllView(setState),
                        Expanded(
                            child: mainList(setState,
                                scrollController: scrollController)),
                        _actionView(setState),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    ).then((value) => setState(() {}));
  }

  Future<void> showDialogueBox(context) async {
    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(15),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Material(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 18.0, horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _searchBox(setState),
                          _labelView(setState),
                          _selectAllView(setState),
                          Expanded(child: mainList(setState)),
                          _actionView(setState),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
    setState(() {});
  }

  Widget _searchBox(StateSetter setState) {
    return Visibility(
      visible: !widget.hideSearch,
      child: Container(
        color: context.kBackgroundColor,
        height: widget.searchBarHeight,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: searchController,
            style: TextStyle(
              color: context.kTextColor,
            ),
            decoration: InputDecoration(
              fillColor: context.kBackgroundColor,
              filled: true,
              hintStyle: TextStyle(
                fontSize: 14,
                color: context.kTextColor,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(kRadius)),
                borderSide: BorderSide(
                  color: context.kPrimaryColor,
                  width: 2,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(kRadius)),
                borderSide: BorderSide(
                  color: context.kPrimaryColor,
                  width: 2,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(kRadius)),
                borderSide: BorderSide(
                  color: widget.primaryColor ?? Colors.grey,
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(kRadius)),
                borderSide: BorderSide(
                  color: context.kErrorColor,
                  width: 2,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(
                    color: widget.primaryColor ?? Colors.grey, width: 2),
              ),
              suffixIcon: Visibility(
                visible: searchController.text.isNotEmpty,
                child: IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: context.kTextColor,
                  ),
                  onPressed: () {
                    searchController.clear();
                    searchList = widget.items;
                    setState;
                  },
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 12.0,
              ),
              hintText: widget.dropdownHintText ?? 'search...',
              isDense: true,
            ),
            onChanged: (v) {
              searchQuery = v;
              onItemChanged(v);
              setState(() {});
            },
          ),
        ),
      ),
    );
  }

  mainList(StateSetter setState, {ScrollController? scrollController}) {
    return RawScrollbar(
      thumbColor: context.kPrimaryColor,
      controller: scrollController,
      trackVisibility: searchList.isNotEmpty,
      thickness: 10,
      radius: const Radius.circular(12),
      thumbVisibility: searchList.isNotEmpty,
      child: Container(
        color: context.kBackgroundColor,
        width: MediaQuery.of(context).size.width,
        child: searchList.isEmpty
            ? Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AppText(
                      text: 'No ${widget.multiSelectTag ?? 'items'} Found !',
                      color: context.kHintTextColor,
                    ),
                  ),
                ],
              )
            : ListView.builder(
                controller: scrollController,
                padding: EdgeInsets.zero,
                itemCount: searchList.length,
                itemBuilder: (BuildContext context, int index) {
                  return TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: context.kBackgroundColor,
                      padding: const EdgeInsets.all(8),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: Row(
                        children: [
                          Visibility(
                            visible: widget.multiSelect,
                            child: SizedBox(
                              width: 24,
                              height: 24,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                                child: Checkbox(
                                    activeColor: searchList[index].color,
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    value: selectedItems
                                            .contains(searchList[index])
                                        ? true
                                        : false,
                                    onChanged: (newValue) {
                                      if (selectedItems
                                          .contains(searchList[index])) {
                                        setState(() => selectedItems
                                            .remove(searchList[index]));
                                      } else {
                                        setState(() => selectedItems
                                            .add(searchList[index]));
                                      }
                                    }),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AppText(
                                text: searchList[index].name,
                                color: searchList[index].color,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {
                      if (widget.multiSelect) {
                        if (selectedItems.contains(searchList[index])) {
                          setState(
                              () => selectedItems.remove(searchList[index]));
                        } else {
                          setState(() => selectedItems.add(searchList[index]));
                        }
                      } else {
                        singleSelectLabel = searchList[index].name;
                        widget.onSingleSelect!(widget.items[index]);
                        // ignore: invalid_use_of_protected_member
                        formFieldState?.setValue(widget.items[index]);
                        formFieldState?.validate();
                        Navigator.pop(context);
                        setState(() {});
                      }
                    },
                  );
                },
              ),
      ),
    );
  }

  onItemChanged(String value) {
    setState(() {
      searchList = widget.items
          .where(
              (item) => item.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  Widget _labelView(StateSetter setState) => Visibility(
        visible: ((widget.showLabelInMenu ?? false) && widget.label != null),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AppText(
            text: widget.label.toString(),
            color: context.kPrimaryColor,
          ),
        ),
      );

  Widget _selectAllView(StateSetter setState) => Visibility(
        visible: widget.multiSelect,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  if (selectedItems.length == searchList.length) {
                    // all data selected
                    selectedItems.clear();
                    initialItems.clear();
                    // ignore: invalid_use_of_protected_member
                    formFieldState?.setValue(null);
                    formFieldState?.validate();
                  } else {
                    // no item selected
                    selectedItems.clear();
                    selectedItems.addAll(searchList);
                    // ignore: invalid_use_of_protected_member
                    formFieldState?.setValue(searchList);
                    formFieldState?.validate();
                  }
                  setState(() {});
                },
                child: Text(
                  selectedItems.length == searchList.length
                      ? 'Clear All'
                      : 'Select All',
                ),
              ),
              const Spacer(),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: selectedItems.isEmpty
                          ? 'No'
                          : selectedItems.length.toString(),
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          color: selectedItems.isEmpty
                              ? Colors.red
                              : Theme.of(context).primaryColor),
                    ),
                    TextSpan(
                      text: ' ${widget.multiSelectTag ?? 'values'} selected',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget _actionView(StateSetter setState) => Visibility(
        visible: (widget.multiSelect),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 28.0),
                child: Text('Done', style: TextStyle(color: Colors.white)),
              ),
              onPressed: () {
                widget.onMultiSelect!(selectedItems);
                // ignore: invalid_use_of_protected_member
                formFieldState?.setValue(selectedItems);
                formFieldState?.validate();
                setState(() {});
                Navigator.pop(context);
              },
            ),
          ),
        ),
      );
}

import 'package:flutter/material.dart';

class AppMultiSelectModel {
  int id;
  String name;
  Color? color;
  dynamic item;

  AppMultiSelectModel({
    required this.id,
    required this.name,
    this.color = Colors.black,
    this.item,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppMultiSelectModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return name;
  }
}

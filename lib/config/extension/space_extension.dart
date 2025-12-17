import 'package:flutter/material.dart';

extension EmptySpace on num {
  /// SizedBox with height
  SizedBox get ph => SizedBox(height: toDouble());

  /// SizedBox with width
  SizedBox get pw => SizedBox(width: toDouble());

  /// Padding with all sides
  EdgeInsets get padAll => EdgeInsets.all(toDouble());

  /// Padding only vertical
  EdgeInsets get padV => EdgeInsets.symmetric(vertical: toDouble());

  /// Padding only horizontal
  EdgeInsets get padH => EdgeInsets.symmetric(horizontal: toDouble());

  /// Circular border radius
  BorderRadius get borderRadiusAll => BorderRadius.circular(toDouble());

  /// Only top border radius
  BorderRadius get borderRadiusTop =>
      BorderRadius.vertical(top: Radius.circular(toDouble()));

  /// Only bottom border radius
  BorderRadius get borderRadiusBottom =>
      BorderRadius.vertical(bottom: Radius.circular(toDouble()));

  /// SizedBox with both width and height (square)
  SizedBox get square => SizedBox(width: toDouble(), height: toDouble());

  /// Radius for BoxShadow or other places
  Radius get radius => Radius.circular(toDouble());
}

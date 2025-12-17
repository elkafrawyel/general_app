import 'package:flutter/material.dart';

extension ResponsiveContext on BuildContext {
  // ---------------- SCREEN SIZE ----------------
  Size get screenSize => MediaQuery.of(this).size;
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;

  // ---------------- ORIENTATION ----------------
  bool get isPortrait =>
      MediaQuery.of(this).orientation == Orientation.portrait;
  bool get isLandscape => !isPortrait;

  // ---------------- DEVICE TYPE ----------------
  bool get isMobile => screenWidth < 600;
  bool get isTablet => screenWidth >= 600 && screenWidth < 1024;
  bool get isDesktop => screenWidth >= 1024;

  // ---------------- RESPONSIVE DIMENSIONS ----------------
  /// Returns width as percentage of screen width
  double widthPercent(double percent) => screenWidth * percent / 100;

  /// Returns height as percentage of screen height
  double heightPercent(double percent) => screenHeight * percent / 100;

  /// Returns font size scaled by screen width (base width: 375)
  double responsiveFont(double fontSize) => fontSize * screenWidth / 375;

  // ---------------- PADDING / MARGIN ----------------
  EdgeInsets get devicePadding => MediaQuery.of(this).padding;
  double get paddingTop => devicePadding.top;
  double get paddingBottom => devicePadding.bottom;
  double get paddingLeft => devicePadding.left;
  double get paddingRight => devicePadding.right;

  // ---------------- THEME ----------------
  ThemeData get theme => Theme.of(this);
  ColorScheme get colors => theme.colorScheme;
  TextTheme get textStyles => theme.textTheme;

  // ---------------- NAVIGATION ----------------
  NavigatorState get navigator => Navigator.of(this);
  void navigateTo(Widget page) =>
      navigator.push(MaterialPageRoute(builder: (_) => page));
  void navigateReplacementTo(Widget page) =>
      navigator.pushReplacement(MaterialPageRoute(builder: (_) => page));
  void goBack([result]) => navigator.pop(result);

  // ---------------- FOCUS ----------------
  void hideKeyboard() => FocusScope.of(this).unfocus();

  // ---------------- SNACKBAR ----------------
  void showSnackBar(
    String message, {
    Color? backgroundColor,
    Duration duration = const Duration(seconds: 2),
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor ?? colors.primary,
        duration: duration,
      ),
    );
  }

  // ---------------- RESPONSIVE SPACING ----------------
  /// SizedBox with height as percentage of screen height
  SizedBox verticalSpace(double percent) =>
      SizedBox(height: heightPercent(percent));

  /// SizedBox with width as percentage of screen width
  SizedBox horizontalSpace(double percent) =>
      SizedBox(width: widthPercent(percent));
}

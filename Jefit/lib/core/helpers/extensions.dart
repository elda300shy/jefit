import 'package:flutter/material.dart';

extension NavigationExtension on BuildContext {
  void navigateTo(String routeName, {Object? arguments}) {
    Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  void navigateToAndRemoveUntil(String routeName, {Object? arguments}) {
    Navigator.of(this).pushNamedAndRemoveUntil(routeName, (route) => false,
        arguments: arguments);
  }

  void navigateToAndReplace(String routeName, {Object? arguments}) {
    Navigator.of(this).pushReplacementNamed(routeName, arguments: arguments);
  }

  void navigateBack() {
    Navigator.of(this).pop();
  }

  void navigateBackUntil(String routeName) {
    Navigator.of(this).popUntil(ModalRoute.withName(routeName));
  }
}

// Theme Extension for BuildContext to get the theme of the app
extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
}

// media query extension for BuildContext to get the size of the screen
extension MediaQueryExtension on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
}

// String Extension to check if the string is null or empty
extension StringExtension on String? {
  bool isNullOrEmpty() => this == null || this == "";
}

extension ListExtension on List? {
  bool isNullOrEmpty() {
    if (this == null || this!.isEmpty) {
      return true;
    } else {
      return false;
    }
  }
}




/// 
extension DateTimeFormate on String? {
  String get formattedDate {
    if (isNullOrEmpty()) {
      return "";
    }
    try {
      DateTime dateTime = DateTime.parse(this!);
      return "${dateTime.month}-${dateTime.day}-${dateTime.year}";
    } catch (e) {
      return this!;
    }
  }
}
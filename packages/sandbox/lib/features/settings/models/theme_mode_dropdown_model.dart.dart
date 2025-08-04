import 'package:flutter/material.dart';
import 'package:wisewidgetslibrary/wisewidgetslibrary.dart';

class ThemeModeDropDownModel extends DropdownModel {
  ThemeModeDropDownModel({required this.mode});
  final ThemeMode mode;

  @override
  String getString(BuildContext context) {
    switch (mode) {
      case ThemeMode.system:
      case ThemeMode.light:
      case ThemeMode.dark:
        return mode.name;
    }
  }

  @override
  Widget? get icon {
    switch (mode) {
      case ThemeMode.system:
        return const Icon(Icons.phone_android_rounded);
      case ThemeMode.light:
        return const Icon(Icons.light_mode);
      case ThemeMode.dark:
        return const Icon(Icons.dark_mode);
    }
  }
}

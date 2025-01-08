import 'package:flutter/material.dart';

/// Dropdown model for `[DropdownPicker]`
abstract interface class DropdownModel {
  /// Item name with localization
  String getString(BuildContext context);

  /// Icon shown in the dropdown cell
  Widget? get icon;
}

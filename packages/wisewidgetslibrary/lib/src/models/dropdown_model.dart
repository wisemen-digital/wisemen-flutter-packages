import 'package:flutter/material.dart';

/// Dropdown model for `[DropdownPicker]`
abstract interface class DropdownModel {
  String getString(BuildContext context);
  String get apiString;
  Widget? get icon;
}

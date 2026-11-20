import 'package:material_ui/material_ui.dart';

/// Dropdown model for `[DropdownPicker]`
abstract class DropdownModel {
  /// Item name with localization
  String getString(BuildContext context);

  /// Icon shown in the dropdown cell
  Widget? get icon;
}

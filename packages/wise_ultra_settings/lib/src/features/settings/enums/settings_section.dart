import 'package:flutter/widgets.dart';
import '../settings.dart';

/// Interface for defining a settings section.
///
/// A settings section represents a group of related settings items in the
/// settings screen. Sections have a title and contain one or more items.
///
/// You can implement this interface with enums to create custom sections:
///
/// ```dart
/// enum MySettingsSection implements SettingsSection {
///   account,
///   preferences;
///
///   @override
///   String getTitle(BuildContext context) {
///     switch (this) {
///       case MySettingsSection.account:
///         return 'Account';
///       case MySettingsSection.preferences:
///         return 'Preferences';
///     }
///   }
///
///   @override
///   List<SettingsItem> getItems() {
///     switch (this) {
///       case MySettingsSection.account:
///         return [MySettingsItem.email, MySettingsItem.password];
///       case MySettingsSection.preferences:
///         return [MySettingsItem.notifications];
///     }
///   }
/// }
/// ```
abstract interface class SettingsSection {
  /// Returns the localized title for this section.
  ///
  /// This title is displayed as a header above the section's items.
  String getTitle(BuildContext context);

  /// Returns the list of settings items in this section.
  ///
  /// The items will be displayed in the order they appear in the list.
  List<SettingsItem> getItems();
}

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Interface for defining a settings item.
///
/// A settings item represents a single actionable row in a settings section.
/// Each item can have a title, optional trailing text/widget, and an optional
/// tap callback.
///
/// You can implement this interface with enums to create custom items:
///
/// ```dart
/// enum MySettingsItem implements SettingsItem {
///   email,
///   password,
///   notifications;
///
///   @override
///   String getTitle(BuildContext context) {
///     switch (this) {
///       case MySettingsItem.email:
///         return 'Email';
///       case MySettingsItem.password:
///         return 'Password';
///       case MySettingsItem.notifications:
///         return 'Push Notifications';
///     }
///   }
///
///   @override
///   String? getTrailingText(WidgetRef ref) {
///     if (this == MySettingsItem.email) {
///       return ref.watch(currentUserProvider).email;
///     }
///     return null;
///   }
///
///   @override
///   Widget? getTrailingWidget(BuildContext context) {
///     if (this == MySettingsItem.notifications) {
///       return Switch(value: true, onChanged: (v) {});
///     }
///     return null;
///   }
///
///   @override
///   GestureTapCallback? onTap(WidgetRef ref) {
///     switch (this) {
///       case MySettingsItem.email:
///         return () => ref.read(routerProvider).push(EditEmailRoute());
///       default:
///         return null;
///     }
///   }
/// }
/// ```
abstract interface class SettingsItem {
  /// Returns the localized title for this item.
  ///
  /// This is displayed as the main text on the left side of the settings row.
  String getTitle(BuildContext context);

  /// Returns optional trailing text to display on the right side.
  ///
  /// This is useful for displaying current values (e.g., app version, email).
  /// If both [getTrailingText] and [getTrailingWidget] return non-null values,
  /// the widget takes precedence.
  String? getTrailingText(WidgetRef ref);

  /// Returns an optional trailing widget to display on the right side.
  ///
  /// This is useful for custom UI elements like switches, badges, or icons.
  /// If both [getTrailingText] and [getTrailingWidget] return non-null values,
  /// the widget takes precedence.
  Widget? getTrailingWidget(BuildContext context);

  /// Returns an optional callback to execute when the item is tapped.
  ///
  /// Return null for non-interactive items (e.g., read-only app version).
  /// The callback typically navigates to another screen or performs an action.
  GestureTapCallback? onTap(WidgetRef ref);
}

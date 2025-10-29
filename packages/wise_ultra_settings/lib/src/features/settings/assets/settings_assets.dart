/// Interface for providing asset paths used in the settings feature.
///
/// Implement this interface to provide paths to assets (like SVG icons)
/// used in the settings UI. Pass your implementation to SettingsFeature.init
///
/// Example:
/// ```dart
/// class MySettingsAssets implements SettingsAssets {
///   @override
///   String get chevronRight => 'assets/icons/chevron_right.svg';
/// }
/// ```
abstract interface class SettingsAssets {
  /// Path to the chevron right icon used for navigable settings items.
  ///
  /// This icon is displayed on the right side of settings items that
  /// can be tapped to navigate to another screen.
  String get chevronRight;
}

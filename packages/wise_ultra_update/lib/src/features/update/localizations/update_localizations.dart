/// Interface for providing localized strings for the update UI.
abstract interface class UpdateLocalizations {
  /// Title text for the update dialog (e.g., "Update Available").
  String get newUpdateAvailableTitle;
  
  /// Subtitle/description text for the update dialog (e.g., "A new version is available").
  String get newUpdateAvailableSubtitle;
  
  /// Text for the primary action button to install the update (e.g., "Update Now").
  String get installUpdate;
  
  /// Text for the secondary action button to dismiss optional updates (e.g., "Later").
  String get illDoThisLater;
}

/// Interface for handling navigation actions from the update dialog.
abstract interface class UpdateNavigationManager {
  /// Called when the user taps the "Install Update" button.
  /// Typically navigates to the app store or triggers the update process.
  void installUpdate();
  
  /// Called when the user taps the "Later" button on optional updates.
  /// Typically dismisses the dialog.
  void installLater();
}

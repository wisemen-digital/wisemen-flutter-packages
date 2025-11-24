/// Interface for providing assets used in the update UI.
abstract interface class UpdateAssets {
  /// Optional path to an avatar/icon image to display in the update dialog.
  /// If null, no avatar will be shown.
  String? get avatar;
}

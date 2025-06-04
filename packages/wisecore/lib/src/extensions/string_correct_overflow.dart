/// Extensions on [String] type
extension StringExtensions on String {
  /// Returns a capitalized version of the string.
  String get capitalized {
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  /// Returns a string with newlines enabled.
  String get enableSlashN {
    return replaceAll(r'\n', '\n');
  }
}

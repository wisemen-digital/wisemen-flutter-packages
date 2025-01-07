/// Extensions on nullable [String] type
extension NullableStringExtension on String? {
  /// Returns the string if it is not null or empty, otherwise returns null
  String? get orNull {
    if (this == null || this!.trim().isEmpty) {
      return null;
    }
    return this;
  }

  /// Returns true if the string is null or empty
  bool get isNullOrEmpty {
    return this == null || this!.isEmpty;
  }
}

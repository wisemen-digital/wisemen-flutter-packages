/// Abstract class for paged errors
abstract class PagedError implements Exception {
  /// Constructor for [PagedError]
  PagedError({
    required this.message,
    this.title,
    this.lastTimeFetched,
  });

  /// Error title
  final String? title;

  /// Error message
  final String message;

  /// Last time data was fetched
  final DateTime? lastTimeFetched;

  /// Sheet body getter to be overridden
  String get sheetBody => throw UnimplementedError(
    'Implement sheetBody getter',
  );
}

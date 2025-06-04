/// [PaginationMeta] abstract class to be implemented within apps
abstract class PaginationMeta<PageKeyType> {
  /// Constructor for [PaginationMeta]
  const PaginationMeta({required this.next, required this.pageSize});

  /// Factory fromJson
  factory PaginationMeta.fromJson(Map<String, dynamic> json) =>
      throw UnimplementedError('Implement fromJson($json) method');

  /// Next page key, used by controller to fetch next page
  final PageKeyType? next;

  /// Page size, used by controller to determine how many items to fetch
  final int pageSize;

  /// Page key getter, used by controller
  PageKeyType? get pageKey => next;

  /// Checks if current page is last page, used by controller
  bool get isLastPage => next == null;
}

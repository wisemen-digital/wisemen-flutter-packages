import 'package:flutter/widgets.dart';

import '../models/models.dart';

/// Infinite scroll controller for paginated data fetching.
abstract class InfiniteScrollController<PageKeyType>
    extends ValueNotifier<PaginationMeta<PageKeyType>> {
  /// [InfiniteScrollController] constructor
  InfiniteScrollController({required PaginationMeta<PageKeyType> initialData})
    : initial = initialData,
      super(initialData);

  /// Pagination metadata for first page
  final PaginationMeta<PageKeyType> initial;

  /// Value notifier to indicate if data is currently being loaded.
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  /// Value notifier to hold any error that occurs during data fetching.
  ValueNotifier<PagedError?> error = ValueNotifier(null);

  /// Fetches a new page of data if lastPage is false.
  /// Has to throw [PagedError] on exceptions.
  Future<PaginationMeta<PageKeyType>> fetchNewPage();

  /// Logs the error for debugging purposes. (usually to Sentry)
  Future<void> logError(Object error, StackTrace stackTrace);

  /// Fetches data and sets loading
  Future<void> onFetchData() async {
    try {
      error.value = null;
      if (!value.isLastPage) {
        isLoading.value = true;
        value = await fetchNewPage();
      }
    } on PagedError catch (e, stackTrace) {
      error.value = e;
      await logError(e, stackTrace);
    } catch (e, stackTrace) {
      // Catch all for any other exceptions
      await logError(e, stackTrace);
    } finally {
      isLoading.value = false;
    }
  }

  /// Refresh controller to first page and fetch new data
  Future<void> refresh() async {
    isLoading.value = true;
    value = initial;
    await fetchNewPage();
    isLoading.value = false;
  }
}

import 'package:riverpod/riverpod.dart';

import '../extensions/list_extension.dart';

/// Mixin for stream providers that watch a local source (such as a database)
/// and fill it with a fetch.
///
/// Until the first [refresh] has finished, an emission without data (`null`,
/// or an empty [Iterable]) does not notify listeners. The UI keeps showing
/// the loading state instead of an empty state while the first fetch is
/// still running. When that fetch finishes, listeners are notified with
/// whatever the stream emitted last, so a fetch that fails or returns
/// nothing still ends the loading state.
///
/// Read the state with Riverpod's `when` on [AsyncValue]
mixin LoadingStreamProvider<T> on AnyNotifier<AsyncValue<T>, T> {
  bool _hasRunBefore = false;

  /// [refreshFunction] refreshes stream data and writes to wherever the stream is read from
  Future<void> refreshFunction();

  /// [onError] handles error catch when refreshing stream data
  Future<void> onError(Object error, StackTrace stackTrace);

  /// [refresh] is used to refresh the stream data
  Future<void> refresh() async {
    try {
      await refreshFunction();
    } catch (error, stackTrace) {
      await onError(error, stackTrace);
    } finally {
      if (!_hasRunBefore) {
        _hasRunBefore = true;
        // Notify in case the fetch did not make the stream emit again.
        if (ref.mounted) ref.notifyListeners();
      }
    }
  }

  @override
  bool updateShouldNotify(AsyncValue<T> previous, AsyncValue<T> next) {
    if (!_hasRunBefore) {
      final value = next.value;
      if (value == null) return false;
      if (value is Iterable && value.isNullOrEmpty) return false;
    }
    return super.updateShouldNotify(previous, next);
  }
}

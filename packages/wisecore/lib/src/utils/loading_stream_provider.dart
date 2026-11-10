import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages, implementation_imports
import 'package:riverpod/src/providers/stream_notifier.dart';

/// Mixin for loading stream data in a provider with correct loading
// ignore: invalid_use_of_internal_member
mixin LoadingStreamProvider<T> on $StreamNotifier<T> {
  /// [refreshFunction] refreshes stream data and writes to wherever the stream is read from
  Future<void> refreshFunction();

  /// [onError] handles error catch when refreshing stream data
  Future<void> onError(Object error, StackTrace stackTrace);

  /// [refresh] is used to refresh the stream data. Call it from `build` to
  /// start the initial fetch.
  Future<void> refresh() async {
    try {
      await refreshFunction();
    } catch (error, stackTrace) {
      await onError(error, stackTrace);
    } finally {
      initialLoading.value = false;
    }
  }

  /// [initialLoading] is true until the first [refresh] completes, whether it
  /// succeeds or fails. Later refreshes leave it false, so data that is
  /// already on screen stays there while it is refreshed.
  ///
  /// Pass this notifier to `whenStream` to show its loading state while this
  /// is true and the stream has not produced any data yet.
  ValueNotifier<bool> initialLoading = ValueNotifier(true);
}

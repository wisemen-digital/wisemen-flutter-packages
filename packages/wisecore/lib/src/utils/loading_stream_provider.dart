import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages, implementation_imports
import 'package:riverpod/src/providers/stream_notifier.dart';

import '../extensions/list_extension.dart';

/// Mixin for loading stream data in a provider with correct loading
// ignore: invalid_use_of_internal_member
mixin LoadingStreamProvider<T> on $StreamNotifier<T> {
  /// [refreshFunction] refreshes stream data and writes to wherever the stream is read from
  Future<void> refreshFunction();

  /// [onError] handles error catch when refreshing stream data
  Future<void> onError(Object error, StackTrace stackTrace);

  /// [refresh] is used to refresh the stream data
  Future<void> refresh() async {
    try {
      if (state.value == null) {
        initialLoading.value = true;
      } else if (state.value is List? && (state.value as List?).isNullOrEmpty) {
        initialLoading.value = true;
      } else {
        initialLoading.value = false;
      }
      await refreshFunction();
    } catch (error, stackTrace) {
      await onError(error, stackTrace);
    } finally {
      initialLoading.value = false;
    }
  }

  /// [initialLoading] is used to indicate if the initial data is being loaded
  ValueNotifier<bool> initialLoading = ValueNotifier(true);
}

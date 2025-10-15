// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
import 'package:flutter/widgets.dart';
import 'package:riverpod/riverpod.dart';

import '../utils/loading_stream_provider.dart';

/// Extensions for [AsyncValue] to simplify handling its states.
extension AsyncStreamValueExtensions<T> on AsyncValue<T> {
  /// Performs an action based on the state of the [AsyncValue]. mixed with
  /// [LoadingStreamProvider] to handle loading states correctly.
  ///
  /// All cases are required, which allows returning a non-nullable value.
  ///
  /// {@template asyncValue.skip_flags}
  /// By default, [whenStream] skips "loading" states if triggered by a [Ref.refresh]
  /// or [Ref.invalidate] (but does not skip loading states if triggered by [Ref.watch]).
  ///
  /// In the event that an [AsyncValue] is in multiple states at once (such as
  /// when reloading a provider or emitting an error after a valid data),
  /// [whenStream] offers various flags to customize whether it should call
  /// [loading]/[error]/[data] :
  ///
  /// - [skipLoadingOnReload] (false by default) customizes whether [loading]
  ///   should be invoked if a provider rebuilds because of [Ref.watch].
  ///   In that situation, [whenStream] will try to invoke either [error]/[data]
  ///   with the previous state.
  ///
  /// - [skipLoadingOnRefresh] (true by default) controls whether [loading]
  ///   should be invoked if a provider rebuilds because of [Ref.refresh]
  ///   or [Ref.invalidate].
  ///   In that situation, [whenStream] will try to invoke either [error]/[data]
  ///   with the previous state.
  ///
  /// - [skipError] (false by default) decides whether to invoke [data] instead
  ///   of [error] if a previous state is available.
  /// {@endtemplate}
  Widget whenStream({
    required Widget Function(T data) data,
    required Widget Function(Object error, StackTrace stackTrace) error,
    required Widget Function() loading,
    bool skipLoadingOnReload = false,
    bool skipLoadingOnRefresh = true,
    bool skipError = false,
  }) {
    if (this is! LoadingStreamProvider) {
      return when(
        data: data,
        error: error,
        loading: loading,
        skipLoadingOnReload: skipLoadingOnReload,
        skipLoadingOnRefresh: skipLoadingOnRefresh,
        skipError: skipError,
      );
    }
    return ValueListenableBuilder(
      valueListenable: (this as LoadingStreamProvider).initialLoading,
      builder: (_, initLoading, __) {
        if (isLoading || initLoading) {
          bool skip;
          if (isRefreshing) {
            skip = skipLoadingOnRefresh;
          } else if (isReloading) {
            skip = skipLoadingOnReload;
          } else {
            skip = false;
          }
          if (!skip) return loading();
        }

        if (hasError && (!hasValue || !skipError)) {
          return error(error, stackTrace!);
        }

        if (requireValue == null) {
          return loading();
        }

        return data(requireValue);
      },
    );
  }
}

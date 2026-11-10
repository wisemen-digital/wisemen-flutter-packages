import 'package:flutter/widgets.dart';
import 'package:riverpod/riverpod.dart';

import '../utils/loading_stream_provider.dart';

/// Extensions for [AsyncValue] to simplify handling its states.
extension AsyncStreamValueExtensions<T> on AsyncValue<T> {
  /// Performs an action based on the state of the [AsyncValue], taking the
  /// initial fetch of a [LoadingStreamProvider] into account.
  ///
  /// A stream read from a local database often emits `null` or an empty list
  /// before the initial fetch has written anything to it. Pass the provider's
  /// [notifier] to keep showing [loading] until that fetch completes, instead
  /// of briefly rendering an empty state:
  ///
  /// ```dart
  /// ref.watch(MyProviders.items).whenStream(
  ///   notifier: ref.watch(MyProviders.items.notifier),
  ///   data: (items) => ItemList(items: items),
  ///   error: (error, stackTrace) => ErrorView(error),
  ///   loading: () => const CircularProgressIndicator(),
  /// );
  /// ```
  ///
  /// [loading] is shown while [LoadingStreamProvider.initialLoading] is true
  /// and the stream has produced no value, `null`, or an empty [Iterable].
  /// Cached data is shown right away, and later refreshes keep showing it.
  /// An error emitted by the stream is passed to [error] immediately.
  ///
  /// Without a [notifier], this behaves exactly like `when`.
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
    LoadingStreamProvider<T>? notifier,
    bool skipLoadingOnReload = false,
    bool skipLoadingOnRefresh = true,
    bool skipError = false,
  }) {
    Widget resolve() => when(
      data: data,
      error: error,
      loading: loading,
      skipLoadingOnReload: skipLoadingOnReload,
      skipLoadingOnRefresh: skipLoadingOnRefresh,
      skipError: skipError,
    );

    if (notifier == null) return resolve();

    return ValueListenableBuilder<bool>(
      valueListenable: notifier.initialLoading,
      builder: (_, initialLoading, _) {
        final current = value;
        final noData =
            current == null || (current is Iterable && current.isEmpty);
        if (initialLoading && !hasError && noData) return loading();
        return resolve();
      },
    );
  }
}

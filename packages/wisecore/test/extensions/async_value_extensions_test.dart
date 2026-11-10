import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wisecore/wisecore.dart';

/// Stands in for a local database table plus the API call that fills it.
class FakeItemsRepository {
  final _table = StreamController<List<String>>.broadcast();
  Completer<void> fetch = Completer<void>();
  int fetchCount = 0;

  Stream<List<String>> watchItems() => _table.stream;

  void write(List<String> items) => _table.add(items);

  void fail(Object error, StackTrace stackTrace) =>
      _table.addError(error, stackTrace);

  Future<void> fetchItems() {
    fetchCount++;
    return fetch.future;
  }
}

class ItemsNotifier extends StreamNotifier<List<String>>
    with LoadingStreamProvider<List<String>> {
  ItemsNotifier(this.repository, {required this.surfaceFetchErrors});

  final FakeItemsRepository repository;
  final bool surfaceFetchErrors;
  final List<Object> fetchErrors = [];

  @override
  Stream<List<String>> build() {
    refresh();
    return repository.watchItems();
  }

  @override
  Future<void> refreshFunction() => repository.fetchItems();

  @override
  Future<void> onError(Object error, StackTrace stackTrace) async {
    fetchErrors.add(error);
    if (surfaceFetchErrors) state = AsyncError(error, stackTrace);
  }
}

/// Riverpod rebuilds dependent widgets one frame after the provider changes.
Future<void> settle(WidgetTester tester) async {
  await tester.pump();
  await tester.pump();
}

void main() {
  late FakeItemsRepository repository;
  late StreamNotifierProvider<ItemsNotifier, List<String>> provider;
  late ProviderContainer container;
  late List<(Object, StackTrace)> receivedErrors;

  Future<void> pumpView(
    WidgetTester tester, {
    bool passNotifier = true,
    bool surfaceFetchErrors = false,
  }) async {
    repository = FakeItemsRepository();
    provider = StreamNotifierProvider(
      () => ItemsNotifier(repository, surfaceFetchErrors: surfaceFetchErrors),
    );
    receivedErrors = [];

    await tester.pumpWidget(
      ProviderScope(
        retry: (_, _) => null,
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Consumer(
            builder: (context, ref, _) => ref
                .watch(provider)
                .whenStream(
                  notifier: passNotifier ? ref.watch(provider.notifier) : null,
                  data: (items) =>
                      Text(items.isEmpty ? 'empty' : 'data:${items.join(',')}'),
                  error: (error, stackTrace) {
                    receivedErrors.add((error, stackTrace));
                    return Text('error:$error');
                  },
                  loading: () => const Text('loading'),
                ),
          ),
        ),
      ),
    );
    container = ProviderScope.containerOf(tester.element(find.byType(Text)));
  }

  ItemsNotifier notifier() => container.read(provider.notifier);

  group('whenStream with a LoadingStreamProvider notifier', () {
    testWidgets('shows loading while the stream has not emitted yet', (
      tester,
    ) async {
      await pumpView(tester);

      expect(find.text('loading'), findsOneWidget);
      expect(notifier().initialLoading.value, isTrue);
    });

    testWidgets(
      'keeps loading when the database emits an empty list before the initial fetch finishes',
      (tester) async {
        await pumpView(tester);

        repository.write([]);
        await settle(tester);

        expect(find.text('loading'), findsOneWidget);

        repository.write(['a', 'b']);
        repository.fetch.complete();
        await settle(tester);

        expect(find.text('data:a,b'), findsOneWidget);
        expect(notifier().initialLoading.value, isFalse);
      },
    );

    testWidgets(
      'shows the empty state once the initial fetch returns nothing',
      (tester) async {
        await pumpView(tester);

        repository.write([]);
        await settle(tester);
        expect(find.text('loading'), findsOneWidget);

        repository.fetch.complete();
        await settle(tester);

        expect(find.text('empty'), findsOneWidget);
      },
    );

    testWidgets('shows cached data immediately while the initial fetch runs', (
      tester,
    ) async {
      await pumpView(tester);

      repository.write(['cached']);
      await settle(tester);

      expect(notifier().initialLoading.value, isTrue);
      expect(find.text('data:cached'), findsOneWidget);

      repository.write(['cached', 'fresh']);
      repository.fetch.complete();
      await settle(tester);

      expect(find.text('data:cached,fresh'), findsOneWidget);
    });

    testWidgets(
      'stops loading and shows the cached state when the initial fetch fails',
      (tester) async {
        await pumpView(tester);

        repository.write([]);
        await settle(tester);
        expect(find.text('loading'), findsOneWidget);

        final exception = Exception('offline');
        repository.fetch.completeError(exception);
        await settle(tester);

        expect(notifier().fetchErrors, [exception]);
        expect(notifier().initialLoading.value, isFalse);
        expect(find.text('empty'), findsOneWidget);
        expect(receivedErrors, isEmpty);
      },
    );

    testWidgets(
      'passes the actual fetch exception to error when onError surfaces it',
      (tester) async {
        await pumpView(tester, surfaceFetchErrors: true);

        final exception = Exception('offline');
        final stackTrace = StackTrace.current;
        repository.fetch.completeError(exception, stackTrace);
        await settle(tester);

        expect(find.text('error:Exception: offline'), findsOneWidget);
        expect(receivedErrors.last.$1, same(exception));
        expect(receivedErrors.last.$2, same(stackTrace));
      },
    );

    testWidgets(
      'passes the actual stream exception to error, even during the initial fetch',
      (tester) async {
        await pumpView(tester);

        final exception = Exception('corrupt table');
        final stackTrace = StackTrace.current;
        repository.fail(exception, stackTrace);
        await settle(tester);

        expect(repository.fetch.isCompleted, isFalse);
        expect(find.text('error:Exception: corrupt table'), findsOneWidget);
        expect(receivedErrors.last.$1, same(exception));
        expect(receivedErrors.last.$2, same(stackTrace));
      },
    );

    testWidgets('keeps showing data during subsequent refreshes', (
      tester,
    ) async {
      await pumpView(tester);

      repository.write(['a']);
      repository.fetch.complete();
      await settle(tester);
      expect(find.text('data:a'), findsOneWidget);

      repository.fetch = Completer<void>();
      final refreshing = notifier().refresh();
      await settle(tester);

      expect(repository.fetchCount, 2);
      expect(find.text('data:a'), findsOneWidget);

      repository.write(['a', 'b']);
      repository.fetch.complete();
      await refreshing;
      await settle(tester);

      expect(find.text('data:a,b'), findsOneWidget);
    });

    testWidgets(
      'keeps showing the empty state during subsequent refreshes of an empty list',
      (tester) async {
        await pumpView(tester);

        repository.write([]);
        repository.fetch.complete();
        await settle(tester);
        expect(find.text('empty'), findsOneWidget);

        repository.fetch = Completer<void>();
        unawaited(notifier().refresh());
        await settle(tester);

        expect(find.text('empty'), findsOneWidget);
        repository.fetch.complete();
      },
    );
  });

  group('whenStream without a notifier', () {
    testWidgets('behaves like when and shows an early empty list as data', (
      tester,
    ) async {
      await pumpView(tester, passNotifier: false);
      expect(find.text('loading'), findsOneWidget);

      repository.write([]);
      await settle(tester);

      expect(find.text('empty'), findsOneWidget);
      repository.fetch.complete();
    });

    testWidgets('passes the actual stream exception to error', (tester) async {
      await pumpView(tester, passNotifier: false);

      final exception = Exception('corrupt table');
      final stackTrace = StackTrace.current;
      repository.fail(exception, stackTrace);
      await settle(tester);

      expect(receivedErrors.last.$1, same(exception));
      expect(receivedErrors.last.$2, same(stackTrace));
      repository.fetch.complete();
    });
  });
}

import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:wisewidgetslibrary/wisewidgetslibrary.dart';

import '../models/pagination_meta_test.dart';

class PendingController extends InfiniteScrollController<int> {
  PendingController({required super.initialData});

  final Completer<TestPaginationMeta> completer = Completer();
  int fetchCount = 0;

  @override
  Future<TestPaginationMeta> fetchNewPage() {
    fetchCount++;
    return completer.future;
  }

  @override
  Future<void> logError(Object error, StackTrace stackTrace) => Future.value();
}

class FailingOnceController extends InfiniteScrollController<int> {
  FailingOnceController({required super.initialData});

  int fetchCount = 0;

  @override
  Future<TestPaginationMeta> fetchNewPage() async {
    fetchCount++;
    if (fetchCount == 1) throw Exception('refresh failed');
    return const TestPaginationMeta(
      next: 2,
      pageSize: TestPaginationMeta.appPageSize,
    );
  }

  @override
  Future<void> logError(Object error, StackTrace stackTrace) => Future.value();
}

void main() {
  test('a failed refresh does not block the next onFetchData', () async {
    final controller = FailingOnceController(
      initialData: TestPaginationMeta.firstPage,
    );

    await expectLater(controller.refresh(), throwsException);
    expect(controller.isLoading.value, false);

    await controller.onFetchData();
    expect(controller.fetchCount, 2);
  });

  test(
    'onFetchData does not fetch again while a fetch is in progress',
    () async {
      final controller = PendingController(
        initialData: TestPaginationMeta.firstPage,
      );

      final first = controller.onFetchData();
      unawaited(controller.onFetchData());
      expect(controller.fetchCount, 1);

      controller.completer.complete(
        const TestPaginationMeta(
          next: 2,
          pageSize: TestPaginationMeta.appPageSize,
        ),
      );
      await first;
    },
  );
}

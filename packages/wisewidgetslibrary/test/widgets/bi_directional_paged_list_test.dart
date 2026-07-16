import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wisewidgetslibrary/wisewidgetslibrary.dart';

import '../models/paged_error_test.dart';
import '../models/pagination_meta_test.dart';

class FakeController extends InfiniteScrollController<int> {
  FakeController({required super.initialData});

  @override
  Future<TestPaginationMeta> fetchNewPage() => Future.value(
    const TestPaginationMeta(
      next: null,
      pageSize: TestPaginationMeta.appPageSize,
    ),
  );

  @override
  Future<void> logError(Object error, StackTrace stackTrace) => Future.value();
}

class FakeErrorController extends InfiniteScrollController<int> {
  FakeErrorController({required super.initialData});

  @override
  Future<TestPaginationMeta> fetchNewPage() async {
    throw TestPagedError(
      message: 'An error occurred',
      title: 'Error',
      lastTimeFetched: DateTime.now(),
    );
  }

  @override
  Future<void> logError(Object error, StackTrace stackTrace) => Future.value();
}

class LoadingController extends InfiniteScrollController<int> {
  LoadingController({required super.initialData});

  @override
  Future<TestPaginationMeta> fetchNewPage() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return const TestPaginationMeta(
      next: null,
      pageSize: TestPaginationMeta.appPageSize,
    );
  }

  @override
  Future<void> logError(Object error, StackTrace stackTrace) => Future.value();
}

void main() {
  // The backward direction renders above the anchor at negative scroll
  // offsets, which start outside the initial viewport (which shows the
  // forward direction starting right at the anchor). Dragging down scrolls
  // toward those negative offsets, revealing the backward items.
  Future<void> scrollToRevealBackwardItems(WidgetTester tester) async {
    await tester.drag(find.byType(CustomScrollView), const Offset(0, 2000));
    await tester.pumpAndSettle();
  }

  Widget buildBiDirectionalPagedList({
    List<int> backwardItems = const [2, 1],
    List<int> forwardItems = const [3, 4, 5],
    InfiniteScrollController<int>? backwardController,
    InfiniteScrollController<int>? forwardController,
    Widget? emptyState,
    Widget Function(BuildContext, int, int)? itemBuilder,
    Widget Function(BuildContext, int)? separatorBuilder,
    Widget Function(BuildContext, void Function())? errorBuilder,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: BiDirectionalPagedList<int>(
          backwardItems: backwardItems,
          forwardItems: forwardItems,
          backwardController:
              backwardController ??
              FakeController(initialData: TestPaginationMeta.firstPage),
          forwardController:
              forwardController ??
              FakeController(initialData: TestPaginationMeta.firstPage),
          itemBuilder:
              itemBuilder ??
              (context, item, index) => ListTile(title: Text('Item $item')),
          emptyState: emptyState ?? const Text('No items'),
          errorBuilder:
              errorBuilder ??
              (context, onRetry) => ElevatedButton(
                onPressed: onRetry,
                child: const Text('Retry'),
              ),
          separatorBuilder: separatorBuilder,
        ),
      ),
    );
  }

  testWidgets('displays backward and forward items using itemBuilder', (
    tester,
  ) async {
    await tester.pumpWidget(buildBiDirectionalPagedList());
    expect(find.text('Item 3'), findsOneWidget);
    expect(find.text('Item 4'), findsOneWidget);
    expect(find.text('Item 5'), findsOneWidget);

    await scrollToRevealBackwardItems(tester);
    expect(find.text('Item 1'), findsOneWidget);
    expect(find.text('Item 2'), findsOneWidget);
  });

  testWidgets('shows emptyState when both lists are empty', (tester) async {
    await tester.pumpWidget(
      buildBiDirectionalPagedList(backwardItems: [], forwardItems: []),
    );
    expect(find.text('No items'), findsWidgets);
  });

  testWidgets(
    'shows errorBuilder for forward direction without affecting backward items',
    (tester) async {
      final forwardController = FakeErrorController(
        initialData: TestPaginationMeta.firstPage,
      );
      await tester.pumpWidget(
        buildBiDirectionalPagedList(forwardController: forwardController),
      );
      await tester.pumpAndSettle();
      expect(find.text('Retry'), findsOneWidget);

      await scrollToRevealBackwardItems(tester);
      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 2'), findsOneWidget);
    },
  );

  testWidgets(
    'shows errorBuilder for backward direction without affecting forward items',
    (tester) async {
      final backwardController = FakeErrorController(
        initialData: TestPaginationMeta.firstPage,
      );
      await tester.pumpWidget(
        buildBiDirectionalPagedList(backwardController: backwardController),
      );
      await tester.pumpAndSettle();
      expect(find.text('Item 3'), findsOneWidget);
      expect(find.text('Item 4'), findsOneWidget);
      expect(find.text('Item 5'), findsOneWidget);

      await scrollToRevealBackwardItems(tester);
      expect(find.text('Retry'), findsOneWidget);
    },
  );

  testWidgets('shows separatorBuilder between items', (tester) async {
    await tester.pumpWidget(
      buildBiDirectionalPagedList(
        separatorBuilder: (context, index) => const Divider(),
        backwardItems: const [1],
        forwardItems: const [2],
      ),
    );
    expect(find.byType(Divider), findsWidgets);
  });

  testWidgets(
    'loading indicator shows independently while forward is loading',
    (
      tester,
    ) async {
      final forwardController = LoadingController(
        initialData: TestPaginationMeta.firstPage,
      );

      unawaited(forwardController.refresh());
      await tester.pumpWidget(
        buildBiDirectionalPagedList(forwardController: forwardController),
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.byType(CircularProgressIndicator), findsNothing);
    },
  );
}

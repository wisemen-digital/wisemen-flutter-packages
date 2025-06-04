import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shimmer/shimmer.dart';
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
  Widget buildPagedList({
    List<int> items = const [1, 2, 3],
    InfiniteScrollController<int>? controller,
    Widget? emptyState,
    Widget Function(BuildContext, int, int)? itemBuilder,
    Widget Function(BuildContext, int)? separatorBuilder,
    Widget Function(BuildContext, void Function())? errorBuilder,
    int? pageSize,
    int? animationInterval,
    int? shimmerItem,
    Color? shimmerColor,
    Color? shimmerHighlightColor,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: PagedList<int>(
          items: items,
          controller:
              controller ??
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
          pageSize: pageSize ?? 3,
          animationInterval: animationInterval ?? 10,
          shimmerItem: shimmerItem,
          shimmerColor: shimmerColor,
          shimmerHighlightColor: shimmerHighlightColor,
        ),
      ),
    );
  }

  testWidgets('displays items using itemBuilder', (tester) async {
    await tester.pumpWidget(buildPagedList(items: [1, 2, 3]));
    expect(find.text('Item 1'), findsOneWidget);
    expect(find.text('Item 2'), findsOneWidget);
    expect(find.text('Item 3'), findsOneWidget);
  });

  testWidgets('shows emptyState when items is empty', (tester) async {
    await tester.pumpWidget(buildPagedList(items: []));
    expect(find.text('No items'), findsOneWidget);
  });

  testWidgets('shows errorBuilder when error occurs', (tester) async {
    final controller = FakeErrorController(
      initialData: TestPaginationMeta.firstPage,
    );
    await tester.pumpWidget(buildPagedList(controller: controller));
    await tester.pumpAndSettle();
    expect(find.text('Retry'), findsOneWidget);
  });

  testWidgets('shows separatorBuilder between items', (tester) async {
    await tester.pumpWidget(
      buildPagedList(
        separatorBuilder: (context, index) => const Divider(),
        items: [1, 2],
      ),
    );
    expect(find.byType(Divider), findsNWidgets(2));
  });

  testWidgets('shows nothing when no more items', (tester) async {
    final controller = FakeController(
      initialData: TestPaginationMeta.firstPage,
    );
    await tester.pumpWidget(buildPagedList(controller: controller));
    expect(find.byType(SizedBox), findsWidgets);
  });

  testWidgets('loading indicator shows when loading', (tester) async {
    final controller = LoadingController(
      initialData: TestPaginationMeta.firstPage,
    );

    unawaited(controller.refresh());
    await tester.pumpWidget(buildPagedList(controller: controller));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('shows shimmer items when shimmerItem is provided', (
    tester,
  ) async {
    final controller = LoadingController(
      initialData: TestPaginationMeta.firstPage,
    );
    unawaited(controller.refresh());
    await tester.pumpWidget(
      buildPagedList(
        controller: controller,
        shimmerItem: 1,
        shimmerColor: Colors.grey,
        shimmerHighlightColor: Colors.white,
        items: [],
      ),
    );
    expect(find.byType(Shimmer), findsAny);

    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(find.byType(Shimmer), findsNothing);
  });
}

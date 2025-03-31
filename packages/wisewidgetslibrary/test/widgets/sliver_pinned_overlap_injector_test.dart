import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wisewidgetslibrary/src/widgets/sliver_pinned_overlap_injector.dart';

class MockSliverOverlapAbsorberHandle extends Mock
    implements SliverOverlapAbsorberHandle {}

void main() {
  group('SliverPinnedOverlapInjector', () {
    late SliverOverlapAbsorberHandle mockHandle;

    setUp(() {
      mockHandle = MockSliverOverlapAbsorberHandle();
      when(() => mockHandle.layoutExtent).thenReturn(50);
    });

    testWidgets('creates RenderSliverPinnedOverlapInjector', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: CustomScrollView(
            slivers: [
              SliverPinnedOverlapInjector(handle: mockHandle),
            ],
          ),
        ),
      );

      expect(find.byType(SliverPinnedOverlapInjector), findsOneWidget);
    });

    test('updates handle correctly', () {
      final renderObject =
          RenderSliverPinnedOverlapInjector(handle: mockHandle);
      final newHandle = MockSliverOverlapAbsorberHandle();

      expect(renderObject.handle, equals(mockHandle));

      renderObject.handle = newHandle;
      expect(renderObject.handle, equals(newHandle));
    });

    test('attach and detach handle listeners', () {
      final renderObject =
          RenderSliverPinnedOverlapInjector(handle: mockHandle);
      final pipelineOwner = PipelineOwner();

      renderObject.attach(pipelineOwner);
      verify(() => mockHandle.addListener(renderObject.markNeedsLayout))
          .called(1);

      renderObject.detach();
      verify(() => mockHandle.removeListener(renderObject.markNeedsLayout))
          .called(1);
    });

    test('performLayout sets correct SliverGeometry', () {
      final renderObject =
          RenderSliverPinnedOverlapInjector(handle: mockHandle);
      const double layoutExtent = 50;

      when(() => mockHandle.layoutExtent).thenReturn(layoutExtent);

      const constraints = SliverConstraints(
        axisDirection: AxisDirection.down,
        growthDirection: GrowthDirection.forward,
        userScrollDirection: ScrollDirection.forward,
        crossAxisExtent: 300,
        viewportMainAxisExtent: 500,
        precedingScrollExtent: 0,
        overlap: 0,
        scrollOffset: 0,
        remainingPaintExtent: 100,
        remainingCacheExtent: 100,
        cacheOrigin: 0,
        crossAxisDirection: AxisDirection.left,
      );

      renderObject.layout(constraints);

      expect(renderObject.geometry!.paintExtent, equals(layoutExtent));
      expect(renderObject.geometry!.maxPaintExtent, equals(layoutExtent));
      expect(
        renderObject.geometry!.maxScrollObstructionExtent,
        equals(layoutExtent),
      );
      expect(renderObject.geometry!.layoutExtent, equals(layoutExtent));
    });
  });
}

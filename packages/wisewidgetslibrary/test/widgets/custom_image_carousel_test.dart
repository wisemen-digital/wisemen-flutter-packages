import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:wisewidgetslibrary/src/widgets/custom_image_carousel.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class FakeRoute extends Fake implements Route<dynamic> {}

void main() {
  late PageController controller;
  late MockNavigatorObserver mockObserver;

  setUp(() {
    controller = PageController();
    mockObserver = MockNavigatorObserver();
  });

  setUpAll(() {
    registerFallbackValue(FakeRoute());
  });

  Widget buildTestableWidget({
    required Widget child,
  }) {
    return MaterialApp(
      home: child,
      navigatorObservers: [mockObserver],
    );
  }

  testWidgets('renders CustomImageCarousel correctly', (tester) async {
    await tester.pumpFrames(
      buildTestableWidget(
        child: CustomImageCarousel(
          controller: controller,
          imageUrls: const ['https://example.com/image1.jpg'],
        ),
      ),
      const Duration(milliseconds: 200),
    );

    expect(find.byType(PhotoViewGallery), findsOneWidget);
  });

  testWidgets('displays close button when showCloseButton is true',
      (tester) async {
    await tester.pumpFrames(
      buildTestableWidget(
        child: CustomImageCarousel(
          controller: controller,
          imageUrls: const ['https://example.com/image1.jpg'],
        ),
      ),
      const Duration(milliseconds: 200),
    );

    expect(find.byIcon(Icons.close), findsOneWidget);
  });

  testWidgets('closes on close button tap', (tester) async {
    await tester.pumpFrames(
      buildTestableWidget(
        child: CustomImageCarousel(
          controller: controller,
          imageUrls: const ['https://example.com/image1.jpg'],
        ),
      ),
      const Duration(milliseconds: 200),
    );

    await tester.tap(find.byIcon(Icons.close));
    await tester.pumpAndSettle();

    verify(() => mockObserver.didPop(any(), any())).called(1);
  });

  testWidgets('displays page indicator when showPageIndicator is true',
      (tester) async {
    await tester.pumpFrames(
      buildTestableWidget(
        child: CustomImageCarousel(
          controller: controller,
          showPageIndicator: true,
          imageUrls: const [
            'https://example.com/image1.jpg',
            'https://example.com/image2.jpg',
          ],
        ),
      ),
      const Duration(milliseconds: 200),
    );

    await tester.pump(const Duration(milliseconds: 1000));

    expect(find.text('1 / 2'), findsOneWidget);
  });

  testWidgets('swiping changes current page indicator', (tester) async {
    await tester.pumpFrames(
      buildTestableWidget(
        child: CustomImageCarousel(
          controller: controller,
          showPageIndicator: true,
          imageUrls: const [
            'https://example.com/image1.jpg',
            'https://example.com/image2.jpg',
          ],
        ),
      ),
      const Duration(milliseconds: 200),
    );

    controller.jumpToPage(1);

    await tester.pump();

    expect(find.text('2 / 2'), findsOneWidget);
  });

  testWidgets('displays extra children', (tester) async {
    await tester.pumpFrames(
      buildTestableWidget(
        child: CustomImageCarousel(
          controller: controller,
          imageUrls: const ['https://example.com/image1.jpg'],
          extraChildren: const [Text('Extra Child')],
        ),
      ),
      const Duration(milliseconds: 200),
    );

    expect(find.text('Extra Child'), findsOneWidget);
  });
}

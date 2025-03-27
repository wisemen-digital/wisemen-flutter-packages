import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wisewidgetslibrary/src/widgets/fullscreen_image_carousel.dart';
import 'package:wisewidgetslibrary/wisewidgetslibrary.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  late MockNavigatorObserver mockObserver;
  const logoPath = '../../../../assets/flutter_logo.png';

  setUp(() {
    mockObserver = MockNavigatorObserver();
  });

  Widget buildTestableWidget({
    required Widget child,
  }) {
    return MaterialApp(
      home: child,
      navigatorObservers: [mockObserver],
    );
  }

  testWidgets('displays image carousel with asset images', (tester) async {
    await tester.pumpWidget(
      buildTestableWidget(
        child: FullscreenImageCarousel.basic(
          imageProviders: const [
            AssetImage(logoPath),
            AssetImage(logoPath),
          ],
          child: Image.asset(logoPath),
        ),
      ),
    );

    expect(find.byType(Image), findsOneWidget);
  });
}

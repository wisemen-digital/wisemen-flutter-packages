import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wisewidgetslibrary/src/widgets/fullscreen_image.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class FakeRoute extends Fake implements Route<dynamic> {}

void main() {
  late MockNavigatorObserver mockObserver;
  const logoPath = '../../../../assets/flutter_logo.png';

  setUp(() {
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

  testWidgets('displays asset image', (tester) async {
    await tester.pumpWidget(
      buildTestableWidget(
        child: FullscreenImage.asset(
          imageAsset: logoPath,
          child: Image.asset(logoPath),
        ),
      ),
    );

    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('displays file image', (tester) async {
    final file = File(logoPath);
    await tester.pumpWidget(
      buildTestableWidget(
        child: FullscreenImage.file(
          imagePath: file.path,
          child: Image.file(file),
        ),
      ),
    );

    expect(find.byType(Image), findsOneWidget);
  });
}

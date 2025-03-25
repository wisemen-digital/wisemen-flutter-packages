import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wisewidgetslibrary/wisewidgetslibrary.dart';

class MockIsWebService implements IsWebService {
  const MockIsWebService();
  @override
  bool getIsWeb() => true;
}

void main() {
  const mockWebService = MockIsWebService();
  testWidgets('returns Material Widget for Web', (WidgetTester tester) async {
    // Mock the platform service to simulate a web environment
    const widget = PlatformWidgetMock(
      isWebService: mockWebService,
    );

    // Build the widget
    await tester.pumpWidget(const MaterialApp(home: widget));

    // Verify that the createMaterialWidget method is called
    expect(find.byType(Material), findsOneWidget);
  });

  testWidgets('returns Material Widget for Android',
      (WidgetTester tester) async {
    // Mock the platform service to simulate Android
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    const widget = PlatformWidgetMock();

    // Build the widget
    await tester.pumpWidget(const MaterialApp(home: widget));

    // Verify that the createMaterialWidget method is called
    expect(find.byType(Material), findsOneWidget);
    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets('returns Cupertino Widget for iOS', (WidgetTester tester) async {
    // Mock the platform service to simulate iOS
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    const widget = PlatformWidgetMock();

    // Build the widget
    await tester.pumpWidget(const MaterialApp(home: widget));

    // Verify that the createCupertinoWidget method is called
    expect(find.byType(CupertinoPageScaffold), findsOneWidget);
    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets('returns Cupertino Widget for macOS', (WidgetTester tester) async {
    // Mock the platform service to simulate macOS
    debugDefaultTargetPlatformOverride = TargetPlatform.macOS;
    const widget = PlatformWidgetMock();

    // Build the widget
    await tester.pumpWidget(const MaterialApp(home: widget));

    // Verify that the createCupertinoWidget method is called
    expect(find.byType(CupertinoPageScaffold), findsOneWidget);
    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets('returns Cupertino Widget for Linux', (WidgetTester tester) async {
    // Mock the platform service to simulate Linux
    debugDefaultTargetPlatformOverride = TargetPlatform.linux;
    const widget = PlatformWidgetMock();

    // Build the widget
    await tester.pumpWidget(const MaterialApp(home: widget));

    // Verify that the createCupertinoWidget method is called
    expect(find.byType(CupertinoPageScaffold), findsOneWidget);
    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets('returns Material Widget for Windows', (WidgetTester tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.windows;
    const widget = PlatformWidgetMock();

    // Build the widget
    await tester.pumpWidget(const MaterialApp(home: widget));

    // Verify that the createCupertinoWidget method is called
    expect(find.byType(Material), findsOneWidget);
    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets('returns Material Widget for Fuchsia', (WidgetTester tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
    const widget = PlatformWidgetMock();

    // Build the widget
    await tester.pumpWidget(const MaterialApp(home: widget));

    // Verify that the createCupertinoWidget method is called
    expect(find.byType(Material), findsOneWidget);
    debugDefaultTargetPlatformOverride = null;
  });
}

// Mock platform widget implementation for testing
class PlatformWidgetMock
    extends PlatformWidget<CupertinoPageScaffold, Material> {
  const PlatformWidgetMock({super.key, super.isWebService});

  @override
  CupertinoPageScaffold createCupertinoWidget(BuildContext context) {
    return CupertinoPageScaffold(child: Container());
  }

  @override
  Material createMaterialWidget(BuildContext context) {
    return Material(child: Container());
  }
}

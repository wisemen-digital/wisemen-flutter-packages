import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wise_nav_bar/src/native/platform_appbar.dart';
import 'package:wise_nav_bar/src/utils/utils.dart';

// Mock PlatformService class
class MockPlatformService extends Mock implements PlatformService {}

void main() {
  late MockPlatformService mockPlatformService;

  setUp(() {
    mockPlatformService = MockPlatformService();

    // Set default values for the platform checks
    when(() => mockPlatformService.isWeb).thenReturn(false);
    when(() => mockPlatformService.isAndroid).thenReturn(false);
    when(() => mockPlatformService.isIOS).thenReturn(false);
    when(() => mockPlatformService.isMacOS).thenReturn(false);
    when(() => mockPlatformService.isFuchsia).thenReturn(false);
    when(() => mockPlatformService.isWindows).thenReturn(false);
    when(() => mockPlatformService.isLinux).thenReturn(false);
  });

  testWidgets('returns Material Widget for Web', (WidgetTester tester) async {
    // Mock the platform service to simulate a web environment
    when(() => mockPlatformService.isWeb).thenReturn(true);
    final widget = PlatformWidgetMock(platformService: mockPlatformService);

    // Build the widget
    await tester.pumpWidget(MaterialApp(home: widget));

    // Verify that the createMaterialWidget method is called
    expect(find.byType(Material), findsOneWidget);
  });

  testWidgets('returns Material Widget for Android',
      (WidgetTester tester) async {
    // Mock the platform service to simulate Android
    when(() => mockPlatformService.isAndroid).thenReturn(true);
    final widget = PlatformWidgetMock(platformService: mockPlatformService);

    // Build the widget
    await tester.pumpWidget(MaterialApp(home: widget));

    // Verify that the createMaterialWidget method is called
    expect(find.byType(Material), findsOneWidget);
  });

  testWidgets('returns Material Widget for Fuchsia',
      (WidgetTester tester) async {
    // Mock the platform service to simulate Android
    when(() => mockPlatformService.isFuchsia).thenReturn(true);
    final widget = PlatformWidgetMock(platformService: mockPlatformService);

    // Build the widget
    await tester.pumpWidget(MaterialApp(home: widget));

    // Verify that the createMaterialWidget method is called
    expect(find.byType(Material), findsOneWidget);
  });

  testWidgets('returns Material Widget for Windows',
      (WidgetTester tester) async {
    // Mock the platform service to simulate Android
    when(() => mockPlatformService.isWindows).thenReturn(true);
    final widget = PlatformWidgetMock(platformService: mockPlatformService);

    // Build the widget
    await tester.pumpWidget(MaterialApp(home: widget));

    // Verify that the createMaterialWidget method is called
    expect(find.byType(Material), findsOneWidget);
  });

  testWidgets('returns Cupertino Widget for iOS, macOS, or Linux',
      (WidgetTester tester) async {
    // Mock the platform service to simulate iOS
    when(() => mockPlatformService.isIOS).thenReturn(true);
    final widget = PlatformWidgetMock(platformService: mockPlatformService);

    // Build the widget
    await tester.pumpWidget(MaterialApp(home: widget));

    // Verify that the createCupertinoWidget method is called
    expect(find.byType(CupertinoPageScaffold), findsOneWidget);
  });

  testWidgets('returns Cupertino Widget for macOS',
      (WidgetTester tester) async {
    // Mock the platform service to simulate iOS
    when(() => mockPlatformService.isMacOS).thenReturn(true);
    final widget = PlatformWidgetMock(platformService: mockPlatformService);

    // Build the widget
    await tester.pumpWidget(MaterialApp(home: widget));

    // Verify that the createCupertinoWidget method is called
    expect(find.byType(CupertinoPageScaffold), findsOneWidget);
  });

  testWidgets('returns Cupertino Widget for Linux',
      (WidgetTester tester) async {
    // Mock the platform service to simulate iOS
    when(() => mockPlatformService.isLinux).thenReturn(true);
    final widget = PlatformWidgetMock(platformService: mockPlatformService);

    // Build the widget
    await tester.pumpWidget(MaterialApp(home: widget));

    // Verify that the createCupertinoWidget method is called
    expect(find.byType(CupertinoPageScaffold), findsOneWidget);
  });

  testWidgets('returns Material Widget with AppBar',
      (WidgetTester tester) async {
    when(() => mockPlatformService.isAndroid).thenReturn(true);
    final widget = PlatformScaffold(
      platformService: mockPlatformService,
      body: const Text('Body'),
      appBar: PlatformAppBar(
        platformService: mockPlatformService,
        title: const Text('Title'),
      ),
    );

    await tester.pumpWidget(MaterialApp(home: widget));
    expect(find.byType(AppBar), findsOneWidget);
  });

  testWidgets('returns Cupertino Widget with AppBar',
      (WidgetTester tester) async {
    when(() => mockPlatformService.isIOS).thenReturn(true);
    final widget = PlatformScaffold(
      platformService: mockPlatformService,
      body: const Text('Body'),
      appBar: PlatformAppBar(
        platformService: mockPlatformService,
        title: const Text('Title'),
      ),
    );

    await tester.pumpWidget(CupertinoApp(home: widget));
    expect(find.byType(CupertinoNavigationBar), findsOneWidget);
  });

  testWidgets('returns Material Widget with backgroundColor',
      (WidgetTester tester) async {
    when(() => mockPlatformService.isAndroid).thenReturn(true);
    final widget = PlatformScaffold(
      platformService: mockPlatformService,
      body: const Text('Body'),
      backgroundColor: Colors.red,
    );

    await tester.pumpWidget(MaterialApp(home: widget));
    final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
    expect(scaffold.backgroundColor, Colors.red);
  });

  testWidgets('returns Cupertino Widget with backgroundColor',
      (WidgetTester tester) async {
    when(() => mockPlatformService.isIOS).thenReturn(true);
    final widget = PlatformScaffold(
      platformService: mockPlatformService,
      body: const Text('Body'),
      backgroundColor: Colors.red,
    );

    await tester.pumpWidget(CupertinoApp(home: widget));
    final scaffold = tester
        .widget<CupertinoPageScaffold>(find.byType(CupertinoPageScaffold));
    expect(scaffold.backgroundColor, Colors.red);
  });

  testWidgets('returns empty widget for unsupported platform',
      (WidgetTester tester) async {
    // Mock the platform service to simulate an unsupported platform
    when(() => mockPlatformService.isAndroid).thenReturn(false);
    when(() => mockPlatformService.isIOS).thenReturn(false);
    when(() => mockPlatformService.isWeb).thenReturn(false);
    when(() => mockPlatformService.isMacOS).thenReturn(false);
    when(() => mockPlatformService.isLinux).thenReturn(false);
    when(() => mockPlatformService.isFuchsia).thenReturn(false);
    when(() => mockPlatformService.isWindows).thenReturn(false);

    final widget = PlatformWidgetMock(platformService: mockPlatformService);

    // Build the widget
    await tester.pumpWidget(MaterialApp(home: widget));

    // Verify that the widget is empty (SizedBox.shrink())
    expect(find.byType(SizedBox), findsOneWidget);
  });

  group('default platform service test', () {
    late DefaultPlatformService platformService;

    setUp(() {
      platformService = DefaultPlatformService();
    });

    test('should return true for isWeb when running on web', () {
      // Use kIsWeb for the web platform
      expect(platformService.isWeb, kIsWeb);
    });

    test('should return true for isAndroid when running on Android', () {
      // Use Platform.isAndroid to mock the behavior for Android platform
      expect(platformService.isAndroid, Platform.isAndroid);
    });

    test('should return true for isIOS when running on iOS', () {
      // Use Platform.isIOS to mock the behavior for iOS platform
      expect(platformService.isIOS, Platform.isIOS);
    });

    test('should return true for isMacOS when running on macOS', () {
      // Use Platform.isMacOS to mock the behavior for macOS platform
      expect(platformService.isMacOS, Platform.isMacOS);
    });

    test('should return true for isFuchsia when running on Fuchsia', () {
      // Use Platform.isFuchsia to mock the behavior for Fuchsia platform
      expect(platformService.isFuchsia, Platform.isFuchsia);
    });

    test('should return true for isWindows when running on Windows', () {
      // Use Platform.isWindows to mock the behavior for Windows platform
      expect(platformService.isWindows, Platform.isWindows);
    });

    test('should return true for isLinux when running on Linux', () {
      // Use Platform.isLinux to mock the behavior for Linux platform
      expect(platformService.isLinux, Platform.isLinux);
    });
  });
}

// Mock platform widget implementation for testing
class PlatformWidgetMock
    extends PlatformWidget<CupertinoPageScaffold, Material> {
  const PlatformWidgetMock({required super.platformService, super.key});

  @override
  CupertinoPageScaffold createCupertinoWidget(BuildContext context) {
    return CupertinoPageScaffold(child: Container());
  }

  @override
  Material createMaterialWidget(BuildContext context) {
    return Material(child: Container());
  }
}

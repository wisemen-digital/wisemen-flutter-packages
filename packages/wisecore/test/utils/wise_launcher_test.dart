import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';
import 'package:wisecore/src/utils/wise_launcher.dart';

class MockUrlLauncherPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements UrlLauncherPlatform {}

class FakeLaunchOptions extends Fake implements LaunchOptions {}

void main() {
  late MockUrlLauncherPlatform mockUrlLauncher;

  setUpAll(() {
    registerFallbackValue(FakeLaunchOptions());
  });

  setUp(() {
    mockUrlLauncher = MockUrlLauncherPlatform();
    UrlLauncherPlatform.instance = mockUrlLauncher;
  });

  Future<bool> returnTrue(_) async => true;
  Future<bool> returnFalse(_) async => false;

  group('WiseLauncher', () {
    test('launchUrl calls launchUrl when canLaunchUrl is true', () async {
      final testUri = Uri.parse('https://example.com');
      when(() => mockUrlLauncher.canLaunch(any())).thenAnswer(returnTrue);
      when(() => mockUrlLauncher.launchUrl(
            testUri.toString(),
            any(),
          )).thenAnswer(returnTrue);

      var callbackCalled = false;

      await WiseLauncher.launchUrl(
        url: testUri.toString(),
        onCannotLaunchUrl: () {
          callbackCalled = true;
        },
      );

      expect(callbackCalled, false);
      verify(() => mockUrlLauncher.canLaunch(testUri.toString())).called(1);
      verify(() => mockUrlLauncher.launchUrl(
            testUri.toString(),
            any(),
          )).called(1);
    });

    test('launchUrl calls onCannotLaunchUrl when canLaunchUrl is false',
        () async {
      final testUri = Uri.parse('https://example.com');
      when(() => mockUrlLauncher.canLaunch(any())).thenAnswer(returnFalse);

      var callbackCalled = false;

      await WiseLauncher.launchUrl(
        url: testUri.toString(),
        onCannotLaunchUrl: () {
          callbackCalled = true;
        },
      );

      expect(callbackCalled, true);
      verify(() => mockUrlLauncher.canLaunch(testUri.toString())).called(1);
      verifyNever(() => mockUrlLauncher.launchUrl(any(), any()));
    });

    test('launchEmail calls launchUrl', () async {
      when(() => mockUrlLauncher.launchUrl(any(), any()))
          .thenAnswer(returnTrue);

      await WiseLauncher.launchEmail(
        email: 'test@example.com',
        subject: 'Test Subject',
        body: 'Test Body',
      );

      final captured =
          verify(() => mockUrlLauncher.launchUrl(captureAny(), any())).captured;

      final uri = captured.first as String;

      expect(uri.startsWith('mailto:test@example.com'), isTrue);
    });

    test('launchPhone calls launchUrl', () async {
      when(() => mockUrlLauncher.launchUrl(any(), any()))
          .thenAnswer(returnTrue);

      await WiseLauncher.launchPhone(phoneNr: '123456');

      verify(() => mockUrlLauncher.launchUrl(
            'tel:123456',
            any(),
          )).called(1);
    });

    test('launchMap calls launchUrl', () async {
      when(() => mockUrlLauncher.launchUrl(any(), any()))
          .thenAnswer(returnTrue);

      await WiseLauncher.launchMap(name: 'Test Place');

      verify(() => mockUrlLauncher.launchUrl(
            any(that: contains('query=Test+Place')),
            any(),
          )).called(1);
    });
  });
}

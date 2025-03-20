import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisecore/src/services/core_service.dart';
import 'package:wisecore/src/services/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('initCore', () {
    test('should initialize core services with shared preferences', () async {
      SharedPreferences.setMockInitialValues({});

      final container = await initCore(
        flavorName: 'testFlavor',
        appName: 'testApp',
      );

      final sharedPreferences = container.read(sharedPreferencesProvider);
      expect(sharedPreferences, isA<SharedPreferences>());
    });
  });

  group('sharedPreferencesProvider', () {
    test('should throw UnimplementedError when not overridden', () {
      final container = ProviderContainer();

      expect(
            () => container.read(sharedPreferencesProvider),
        throwsA(isA<UnimplementedError>()),
      );
    });

    test('should return SharedPreferences instance when overridden', () async {
      SharedPreferences.setMockInitialValues({}); // Mock initial values
      final sharedPreferences = await SharedPreferences.getInstance();

      final container = ProviderContainer(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(sharedPreferences),
        ],
      );

      expect(container.read(sharedPreferencesProvider), sharedPreferences);
    });
  });
}
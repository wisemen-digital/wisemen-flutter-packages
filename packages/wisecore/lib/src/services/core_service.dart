import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'shared_preferences.dart';

/// Initialize core services.
Future<ProviderContainer> initCore({
  required String flavorName,
  required String appName,
}) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  return ProviderContainer(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(sharedPreferences),
    ],
  );
}

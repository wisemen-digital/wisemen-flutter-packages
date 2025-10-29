import 'package:wise_ultra_settings/src/features/settings/settings_feature.dart';

String? emptyValidator(String? value, {bool ignore = false}) {
  if (ignore) {
    return null;
  }

  if (value?.isEmpty ?? true) {
    return SettingsFeature.localizations.required;
  }
  return null;
}

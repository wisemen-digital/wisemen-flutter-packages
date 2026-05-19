import 'package:repository/repository.dart';
import 'package:sandbox/features/damage_form/damage_form.dart';
import 'package:sandbox/features/settings/settings.dart';
import 'package:sandbox/features/shared/shared.dart';

void initFeatures() {
  SharedFeature.init(settingsRepository: appSettingsRepository);
  SettingsFeature.init(repository: userRepository);
  DamageFormFeature.init(repository: damageFormRepository);
}

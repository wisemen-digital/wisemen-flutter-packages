import 'package:repository/repository.dart';
import 'package:sandbox/features/settings/settings.dart';
import 'package:sandbox/features/shared/shared.dart';

void initFeatures() {
  SharedFeature.init(settingsRepository: appSettingsRepository);
  SettingsFeature.init(repository: userRepository);
}

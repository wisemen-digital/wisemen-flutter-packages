import 'package:repository/repository.dart';
import 'package:sandbox/features/shared/shared.dart';

void initFeatures() {
  SharedFeature.init(settingsRepository: appSettingsRepository);
}

import 'package:sandbox/features/job_interview/job_interview.dart';
import 'package:sandbox/features/settings/settings.dart';
import 'package:sandbox/repositories/settings_repository.dart';

void initFeatures() {
  SettingsFeature.init(
    repository: settingsRepositoryImplProvider,
  );
  JobInterviewFeature.init();
}

import 'package:riverpod/riverpod.dart';
import 'package:wisecore/wisecore.dart';

class UpdateService {
  UpdateService({
    required this.ref,
  });
  final Ref ref;

  Future<(String, bool)> getNeedsUpdate(String currentVersion) async {
    final result = await ref.read(Wisecore.protectedClientProvider).wGet(
      '/api/v2/app/versions',
      queryParameters: {
        'currentVersion': currentVersion,
      },
    );

    final latestVersion = result['version'] as String?;
    final isRequired = result['isUpdateRequired'] as bool;

    return (latestVersion ?? currentVersion, isRequired);
  }
}

final updateServiceProvider = Provider<UpdateService>((ref) => UpdateService(ref: ref));

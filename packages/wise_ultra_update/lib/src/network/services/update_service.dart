import 'package:riverpod/riverpod.dart';
import 'package:wisecore/wisecore.dart';

/// Service for fetching update information from the backend API.
class UpdateService {
  /// Creates an update service.
  UpdateService({
    required this.ref,
  });
  
  /// Riverpod ref for accessing providers.
  final Ref ref;

  /// Fetches update information for the given [currentVersion].
  ///
  /// Returns a record containing:
  /// - Latest version string
  /// - Whether the update is required
  Future<(String, bool)> getNeedsUpdate(String currentVersion) async {
    final result = await ref.read(Wisecore.protectedClientProvider).wGet(
      '/api/v2/app/versions',
      queryParameters: {
        'currentVersion': currentVersion,
      },
    ) as Map<String, dynamic>;

    final latestVersion = result['version'] as String?;
    final isRequired = result['isUpdateRequired'] as bool;

    return (latestVersion ?? currentVersion, isRequired);
  }
}

/// Provider for the update service.
final updateServiceProvider = Provider<UpdateService>((ref) => UpdateService(ref: ref));

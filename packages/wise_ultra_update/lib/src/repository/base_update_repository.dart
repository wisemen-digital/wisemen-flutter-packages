import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod/riverpod.dart';

import '../src.dart';

/// Compares two semantic version strings.
/// Returns true if [current] is lower than [latest].
bool isVersionLower(String current, String latest) {
  final currentParts = current.split('.').map((e) => int.tryParse(e) ?? 0).toList();
  final latestParts = latest.split('.').map((e) => int.tryParse(e) ?? 0).toList();

  while (currentParts.length < latestParts.length) {
    currentParts.add(0);
  }
  while (latestParts.length < currentParts.length) {
    latestParts.add(0);
  }

  for (var i = 0; i < currentParts.length; i++) {
    if (currentParts[i] < latestParts[i]) return true;
    if (currentParts[i] > latestParts[i]) return false;
  }
  return false;
}

class BaseUpdateRepository implements UpdateRepository {
  BaseUpdateRepository({required this.ref});

  final Ref ref;

  @override
  Future<(bool, bool)> checkNeedsUpdate() async {
    final info = await PackageInfo.fromPlatform();
    final currentVersion = info.version;

    final result = await ref.read(updateServiceProvider).getNeedsUpdate(currentVersion);

    return (isVersionLower(currentVersion, result.$1), result.$2);
  }
}

final baseUpdateRepositoryProvider = Provider<BaseUpdateRepository>((ref) => BaseUpdateRepository(ref: ref));

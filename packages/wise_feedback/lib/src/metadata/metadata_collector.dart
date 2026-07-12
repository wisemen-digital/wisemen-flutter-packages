import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Collects a map of technical context attached to every report.
// ignore: one_member_abstracts
abstract interface class MetadataCollector {
  /// Gathers metadata. Implementations must never throw — partial data is
  /// preferable to a failed submission.
  Future<Map<String, String>> collect();
}

/// The default [MetadataCollector]: device model, OS, app version and locale.
///
/// Every source is read independently and guarded, so a single failure (an
/// unsupported platform, a missing plugin in tests) drops only that key.
class DeviceMetadataCollector implements MetadataCollector {
  /// Creates the collector. Inject [deviceInfo] / [packageInfoLoader] in tests.
  DeviceMetadataCollector({
    DeviceInfoPlugin? deviceInfo,
    Future<PackageInfo> Function()? packageInfoLoader,
  })  : _deviceInfo = deviceInfo ?? DeviceInfoPlugin(),
        _packageInfoLoader = packageInfoLoader ?? PackageInfo.fromPlatform;

  final DeviceInfoPlugin _deviceInfo;
  final Future<PackageInfo> Function() _packageInfoLoader;

  @override
  Future<Map<String, String>> collect() async {
    final metadata = <String, String>{};

    metadata['platform'] = defaultTargetPlatform.name;

    try {
      metadata['locale'] = PlatformDispatcher.instance.locale.toLanguageTag();
    } on Object {
      // Locale unavailable; skip.
    }

    try {
      final info = await _packageInfoLoader();
      metadata['appVersion'] = info.version;
      metadata['buildNumber'] = info.buildNumber;
    } on Object {
      // Package info unavailable (e.g. no platform channel); skip.
    }

    await _collectDeviceInfo(metadata);

    return metadata;
  }

  Future<void> _collectDeviceInfo(Map<String, String> metadata) async {
    try {
      switch (defaultTargetPlatform) {
        case TargetPlatform.android:
          final info = await _deviceInfo.androidInfo;
          metadata['device'] = '${info.manufacturer} ${info.model}';
          metadata['osVersion'] = 'Android ${info.version.release}';
        case TargetPlatform.iOS:
          final info = await _deviceInfo.iosInfo;
          metadata['device'] = info.utsname.machine;
          metadata['osVersion'] = '${info.systemName} ${info.systemVersion}';
        case TargetPlatform.macOS:
          final info = await _deviceInfo.macOsInfo;
          metadata['device'] = info.model;
          metadata['osVersion'] = 'macOS ${info.osRelease}';
        // ignore: no_default_cases
        default:
          // Other platforms: platform name already captured above.
          break;
      }
    } on Object {
      // Device info unavailable; skip.
    }
  }
}

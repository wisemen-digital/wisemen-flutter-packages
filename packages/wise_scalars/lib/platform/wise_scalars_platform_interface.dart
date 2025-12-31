import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'wise_scalars_method_channel.dart';

/// The interface that implementations of wise_scalars must implement.
abstract class WiseScalarsPlatform extends PlatformInterface {
  /// Constructs a WiseScalarsPlatform.
  WiseScalarsPlatform() : super(token: _token);

  static final Object _token = Object();

  static WiseScalarsPlatform _instance = MethodChannelWiseScalars();

  /// The default instance of [WiseScalarsPlatform] to use.
  ///
  /// Defaults to [MethodChannelWiseScalars].
  static WiseScalarsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [WiseScalarsPlatform] when
  /// they register themselves.
  static set instance(WiseScalarsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Get the temperature unit.
  Future<String?> getTemperatureUnit() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  /// Check if the device uses the metric system for distance.
  Future<bool?> getUsesMetricSystemForDistance() {
    throw UnimplementedError(
      'getUsesMetricSystemForDistance() has not been implemented.',
    );
  }

  /// Get date format styles.
  Future<Map<String, String>?> getDateFormatStyles() {
    throw UnimplementedError('getDateFormatStyles() has not been implemented.');
  }

  /// Get the first day of the week.
  Future<int?> getFirstDayOfWeek() {
    throw UnimplementedError('getFirstDayOfWeek() has not been implemented.');
  }
}

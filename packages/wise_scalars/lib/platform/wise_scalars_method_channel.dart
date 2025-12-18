import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'wise_scalars_platform_interface.dart';

/// An implementation of [WiseScalarsPlatform] that uses method channels.
class MethodChannelWiseScalars extends WiseScalarsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('wise_scalars');

  @override
  Future<String?> getTemperatureUnit() {
    return methodChannel.invokeMethod<String>('getTemperatureUnit');
  }

  @override
  Future<bool?> getUsesMetricSystemForDistance() {
    return methodChannel.invokeMethod<bool>('getUsesMetricSystemForDistance');
  }

  @override
  Future<Map<String, String>?> getDateFormatStyles() {
    return methodChannel.invokeMapMethod<String, String>('getDateFormatStyles');
  }

  @override
  Future<int?> getFirstDayOfWeek() {
    return methodChannel.invokeMethod<int>('getFirstDayOfWeek');
  }
}

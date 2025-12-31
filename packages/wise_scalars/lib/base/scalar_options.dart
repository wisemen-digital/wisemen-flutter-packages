import 'package:flutter/widgets.dart';

import '../date/date_format_patterns.dart';
import '../platform/wise_scalars_platform_interface.dart';
import '../scalar_types/scalar_types.dart';
import 'wise_scalar_scope.dart';

/// Configuration options for scalars
@immutable
class ScalarOptions {
  ScalarOptions._(
    this.firstDayOfWeek,
    this.temperatureUnit,
    this.usesMetricDistance, {
    DateFormatPatterns? dateFormatPatterns,
  }) : dateFormatPatterns = dateFormatPatterns ?? DateFormatPatterns.init();

  /// Retrieves the [ScalarOptions] from method channel
  static Future<ScalarOptions> fromMethodChannel() async {
    final results = await Future.wait([
      WiseScalarsPlatform.instance.getFirstDayOfWeek(),
      WiseScalarsPlatform.instance.getTemperatureUnit(),
      WiseScalarsPlatform.instance.getUsesMetricSystemForDistance(),
      WiseScalarsPlatform.instance.getDateFormatStyles(),
    ]);

    return ScalarOptions._(
      results[0] as int?,
      TemperatureUnit.fromString(results[1] as String?),
      results[2] as bool?,
      dateFormatPatterns: DateFormatPatterns.fromMap(
        results[3] as Map<String, String>?,
      ),
    );
  }

  /// System's date format patterns, defaults to intl package patterns
  final DateFormatPatterns dateFormatPatterns;

  /// First day of the week where monday is 1
  final int? firstDayOfWeek;

  /// System's preferred temperature unit
  final TemperatureUnit? temperatureUnit;

  /// Whether to use metric system for distance units
  final bool? usesMetricDistance;

  /// Retrieves the [ScalarOptions] from [BuildContext]
  static ScalarOptions of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<WiseScalarScope>();
    assert(
      scope != null,
      'No WiseScalarScope found in context. Please wrap your widget tree with WiseScalarScope to provide ScalarOptions.',
    );

    return scope!.options;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScalarOptions &&
          firstDayOfWeek == other.firstDayOfWeek &&
          temperatureUnit == other.temperatureUnit &&
          usesMetricDistance == other.usesMetricDistance &&
          dateFormatPatterns == other.dateFormatPatterns;

  @override
  int get hashCode => Object.hash(
    firstDayOfWeek,
    temperatureUnit,
    usesMetricDistance,
    dateFormatPatterns,
  );
}

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../base/base.dart';

/// A scalar representing temperature
@immutable
class Temperature implements Scalar {
  /// Creates a [Temperature] instance
  const Temperature({required this.value, required this.unit});

  @override
  final TemperatureUnit unit;

  @override
  final double value;

  double get _asCelsius => TemperatureUnit.celsius.calculateFrom(this);

  @override
  int compareTo(Scalar other) {
    if (other is! Temperature) {
      throw ArgumentError('Cannot compare Temperature with ${other.runtimeType}');
    }
    return _asCelsius.compareTo(other._asCelsius);
  }

  @override
  String labelValue(BuildContext context) {
    final unitValue = ScalarOptions.of(context).temperatureUnit?.calculateFrom(this) ?? value;
    return NumberFormat('#').format(unitValue);
  }

  @override
  String label(BuildContext context) {
    final options = ScalarOptions.of(context);
    switch (options.temperatureUnit) {
      case TemperatureUnit.celsius:
      case TemperatureUnit.fahrenheit:
      case TemperatureUnit.kelvin:
        return '${labelValue(context)}${options.temperatureUnit!.symbol}';
      case null:
        return '${NumberFormat('#').format(value)}${unit.symbol}';
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is Temperature && _asCelsius == (other._asCelsius);
  }

  @override
  int get hashCode => Object.hash(_asCelsius, runtimeType);
}

/// Temperature unit options
enum TemperatureUnit {
  /// Celsius unit
  celsius,

  /// Fahrenheit unit
  fahrenheit,

  /// Kelvin unit
  kelvin
  ;

  /// Symbol representation of the temperature unit
  String get symbol {
    switch (this) {
      case TemperatureUnit.celsius:
        return '°C';
      case TemperatureUnit.fahrenheit:
        return '°F';
      case TemperatureUnit.kelvin:
        return ' K';
    }
  }

  /// Converts a [Temperature] from another unit to this unit
  double calculateFrom(Temperature other) {
    if (other.unit == this) {
      return other.value;
    }
    switch (other.unit) {
      case TemperatureUnit.celsius:
        switch (this) {
          case TemperatureUnit.celsius:
            return other.value;
          case TemperatureUnit.fahrenheit:
            return other.value * 9 / 5 + 32;
          case TemperatureUnit.kelvin:
            return other.value + 273.15;
        }
      case TemperatureUnit.fahrenheit:
        switch (this) {
          case TemperatureUnit.celsius:
            return (other.value - 32) * 5 / 9;
          case TemperatureUnit.fahrenheit:
            return other.value;
          case TemperatureUnit.kelvin:
            return (other.value - 32) * 5 / 9 + 273.15;
        }
      case TemperatureUnit.kelvin:
        switch (this) {
          case TemperatureUnit.celsius:
            return other.value - 273.15;
          case TemperatureUnit.fahrenheit:
            return (other.value - 273.15) * 9 / 5 + 32;
          case TemperatureUnit.kelvin:
            return other.value;
        }
    }
  }

  /// Creates a [TemperatureUnit] from a string representation (for method channel)
  static TemperatureUnit? fromString(String? value) {
    switch (value?.toLowerCase()) {
      case 'celsius':
        return TemperatureUnit.celsius;
      case 'fahrenheit':
      // Android LocalePreferences.getTemperatureUnit() returns 'fahrenhe'
      case 'fahrenhe':
        return TemperatureUnit.fahrenheit;
      case 'kelvin':
        return TemperatureUnit.kelvin;
      default:
        return null;
    }
  }
}

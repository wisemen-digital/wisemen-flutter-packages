import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../base/base.dart';

/// A scalar representing distance
@immutable
class Distance implements Scalar {
  /// Creates a [Distance] instance
  const Distance({required this.value, required this.unit});
  @override
  final double value;
  @override
  final DistanceUnit unit;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is Distance &&
        unit._inMillimeters(value) == other.unit._inMillimeters(other.value);
  }

  @override
  int compareTo(Scalar other) {
    if (other is! Distance) {
      throw ArgumentError('Cannot compare Distance with ${other.runtimeType}');
    }
    return unit
        ._inMillimeters(value)
        .compareTo(other.unit._inMillimeters(other.value));
  }

  @override
  int get hashCode => Object.hash(value, unit);

  @override
  String label(BuildContext context) {
    final metric = ScalarOptions.of(context).usesMetricDistance ?? true;
    return '${labelValue(context)} ${unit.calculateFrom(this, useMetric: metric).unit.symbol}';
  }

  @override
  String labelValue(BuildContext context) {
    final metric = ScalarOptions.of(context).usesMetricDistance ?? true;
    final unitValue = unit.calculateFrom(this, useMetric: metric);
    return NumberFormat('#.#').format(unitValue.value);
  }
}

/// Distance unit options
enum DistanceUnit {
  /// Millimeters unit
  millimeters(isMetric: true, size: _UnitSize.xxs),

  /// Centimeters unit
  centimeters(isMetric: true, size: _UnitSize.xs),

  /// Meters unit
  meters(isMetric: true, size: _UnitSize.m),

  /// Kilometers unit
  kilometers(isMetric: true, size: _UnitSize.l),

  /// Inches unit
  inches(isMetric: false, size: _UnitSize.xs),

  /// Feet unit
  feet(isMetric: false, size: _UnitSize.s),

  /// Yards unit
  yards(isMetric: false, size: _UnitSize.m),

  /// Miles unit
  miles(isMetric: false, size: _UnitSize.l)
  ;

  const DistanceUnit({required this.isMetric, required _UnitSize size})
    : _size = size;

  /// Whether this unit is part of the metric system
  final bool isMetric;

  final _UnitSize _size;

  /// Symbol representation of the unit
  String get symbol {
    switch (this) {
      case DistanceUnit.millimeters:
        return 'mm';
      case DistanceUnit.centimeters:
        return 'cm';
      case DistanceUnit.meters:
        return 'm';
      case DistanceUnit.kilometers:
        return 'km';
      case DistanceUnit.inches:
        return 'in';
      case DistanceUnit.feet:
        return 'ft';
      case DistanceUnit.yards:
        return 'yd';
      case DistanceUnit.miles:
        return 'mi';
    }
  }

  double _inMillimeters(double value) {
    switch (this) {
      case DistanceUnit.millimeters:
        return value;
      case DistanceUnit.centimeters:
        return value * 10;
      case DistanceUnit.meters:
        return value * 1000;
      case DistanceUnit.kilometers:
        return value * 1e6;
      case DistanceUnit.inches:
        return value * 25.4;
      case DistanceUnit.feet:
        return value * 304.8;
      case DistanceUnit.yards:
        return value * 914.4;
      case DistanceUnit.miles:
        return value * 1.609e6;
    }
  }

  /// Converts the given [Distance] to a unit of this type.
  ({DistanceUnit unit, double value}) calculateFrom(
    Distance distance, {
    required bool useMetric,
  }) {
    final valueInMillimeters = distance.unit._inMillimeters(distance.value);
    if (isMetric != useMetric) {
      return _oppositeSystemUnit.calculateFrom(distance, useMetric: useMetric);
    }

    switch (this) {
      case DistanceUnit.millimeters:
        return (unit: this, value: valueInMillimeters);
      case DistanceUnit.centimeters:
        return (unit: this, value: valueInMillimeters / 10);
      case DistanceUnit.meters:
        return (unit: this, value: valueInMillimeters / 1000);
      case DistanceUnit.kilometers:
        return (unit: this, value: valueInMillimeters / 1e6);
      case DistanceUnit.inches:
        return (unit: this, value: valueInMillimeters / 25.4);
      case DistanceUnit.feet:
        return (unit: this, value: valueInMillimeters / 304.8);
      case DistanceUnit.yards:
        return (unit: this, value: valueInMillimeters / 914.4);
      case DistanceUnit.miles:
        return (unit: this, value: valueInMillimeters / 1.609e6);
    }
  }

  DistanceUnit get _oppositeSystemUnit {
    final convertedUnit = isMetric
        ? values.firstWhereOrNull((u) => !u.isMetric && u._size == _size)
        : values.firstWhereOrNull((u) => u.isMetric && u._size == _size);
    return convertedUnit ?? this;
  }
}

enum _UnitSize { xxs, xs, s, m, l }

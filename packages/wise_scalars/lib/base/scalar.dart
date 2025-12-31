// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes

import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

/// Abstract base class representing a scalar measurement.
///
/// This class provides a common interface for different scalar implementations,
/// storing a numeric [value] and its corresponding [unit] of measurement.
///
/// Classes implementing this interface must also implement [Comparable] to allow
/// comparison between scalar values.
abstract class Scalar implements Comparable<Scalar> {
  /// Creates a [Scalar] with the given [value] and [unit].
  ///
  /// Both parameters are required to ensure a scalar measurement is always
  /// associated with its numeric value and unit of measurement.
  const Scalar({required this.value, required this.unit});

  /// The numeric value of the scalar measurement.
  final num value;

  /// The unit of measurement for this scalar.
  final Enum unit;

  /// Returns the numeric value formatted for labeling.
  String labelValue(BuildContext context) {
    return value.toString();
  }

  /// Returns a localized label value and unit for the scalar.
  String label(BuildContext context) {
    throw UnimplementedError();
  }

  @mustBeOverridden
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is Scalar && other.value == value && other.unit == unit;
  }

  @mustBeOverridden
  @override
  int get hashCode => Object.hash(value, unit);
}

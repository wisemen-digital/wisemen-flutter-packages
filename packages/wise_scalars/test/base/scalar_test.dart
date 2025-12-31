// ignore_for_file: missing_override_of_must_be_overridden, overridden_fields

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wise_scalars/base/base.dart';

void main() {
  group('Scalar base implementation', () {
    test('creates scalar with integer value', () {
      const scalar = TestScalar(value: 42, unit: TestUnit.small);

      expect(scalar.value, 42);
      expect(scalar.unit, TestUnit.small);
    });

    test('creates scalar with double value', () {
      const scalar = TestScalar(value: 42.5, unit: TestUnit.medium);

      expect(scalar.value, 42.5);
      expect(scalar.unit, TestUnit.medium);
    });

    test('creates scalar with negative value', () {
      const scalar = TestScalar(value: -10, unit: TestUnit.small);

      expect(scalar.value, -10);
    });

    test('creates scalar with zero value', () {
      const scalar = TestScalar(value: 0, unit: TestUnit.small);

      expect(scalar.value, 0);
    });

    test('creates scalar with very large value', () {
      const scalar = TestScalar(value: 1e10, unit: TestUnit.large);

      expect(scalar.value, 1e10);
    });

    test('creates scalar with very small decimal value', () {
      const scalar = TestScalar(value: 0.00001, unit: TestUnit.small);

      expect(scalar.value, 0.00001);
    });
  });

  group('Scalar.labelValue', () {
    testWidgets('returns value as string by default', (tester) async {
      const scalar = TestScalar(value: 42, unit: TestUnit.small);

      await tester.pumpWidget(
        Builder(
          builder: (context) {
            final label = scalar.labelValue(context);
            expect(label, '42');
            return const SizedBox.shrink();
          },
        ),
      );
    });

    testWidgets('formats double value as string', (tester) async {
      const scalar = TestScalar(value: 42.5, unit: TestUnit.medium);

      await tester.pumpWidget(
        Builder(
          builder: (context) {
            final label = scalar.labelValue(context);
            expect(label, '42.5');
            return const SizedBox.shrink();
          },
        ),
      );
    });

    testWidgets('formats negative value as string', (tester) async {
      const scalar = TestScalar(value: -10.5, unit: TestUnit.small);

      await tester.pumpWidget(
        Builder(
          builder: (context) {
            final label = scalar.labelValue(context);
            expect(label, '-10.5');
            return const SizedBox.shrink();
          },
        ),
      );
    });

    testWidgets('formats zero as string', (tester) async {
      const scalar = TestScalar(value: 0, unit: TestUnit.small);

      await tester.pumpWidget(
        Builder(
          builder: (context) {
            final label = scalar.labelValue(context);
            expect(label, '0');
            return const SizedBox.shrink();
          },
        ),
      );
    });
  });

  group('Scalar.label', () {
    testWidgets('throws UnimplementedError by default', (tester) async {
      const scalar = TestScalar(value: 42, unit: TestUnit.small);

      await tester.pumpWidget(
        Builder(
          builder: (context) {
            expect(
              () => scalar.label(context),
              throwsA(isA<UnimplementedError>()),
            );
            return const SizedBox.shrink();
          },
        ),
      );
    });

    testWidgets('can be overridden in subclasses', (tester) async {
      const scalar = CustomLabelScalar(value: 42, unit: TestUnit.small);

      await tester.pumpWidget(
        Builder(
          builder: (context) {
            final label = scalar.label(context);
            expect(label, '42 small');
            return const SizedBox.shrink();
          },
        ),
      );
    });
  });

  group('Scalar equality', () {
    test('identical scalars are equal', () {
      const scalar1 = TestScalar(value: 42, unit: TestUnit.small);
      const scalar2 = TestScalar(value: 42, unit: TestUnit.small);

      expect(scalar1, equals(scalar2));
      expect(scalar1.hashCode, equals(scalar2.hashCode));
    });

    test('scalars with different values are not equal', () {
      const scalar1 = TestScalar(value: 42, unit: TestUnit.small);
      const scalar2 = TestScalar(value: 24, unit: TestUnit.small);

      expect(scalar1, isNot(equals(scalar2)));
    });

    test('scalars with different units are not equal', () {
      const scalar1 = TestScalar(value: 42, unit: TestUnit.small);
      const scalar2 = TestScalar(value: 42, unit: TestUnit.medium);

      expect(scalar1, isNot(equals(scalar2)));
    });

    test('scalars with both different values and units are not equal', () {
      const scalar1 = TestScalar(value: 42, unit: TestUnit.small);
      const scalar2 = TestScalar(value: 24, unit: TestUnit.large);

      expect(scalar1, isNot(equals(scalar2)));
    });

    test('identity equality works', () {
      const scalar = TestScalar(value: 42, unit: TestUnit.small);

      expect(identical(scalar, scalar), true);
      expect(scalar, equals(scalar));
    });

    test('equality with different types returns false', () {
      const scalar = TestScalar(value: 42, unit: TestUnit.small);
      const otherScalar = OtherTypeScalar(value: 42, unit: OtherUnit.typeA);

      expect(scalar, isNot(equals(otherScalar)));
    });

    test('equality with non-Scalar object returns false', () {
      const scalar = TestScalar(value: 42, unit: TestUnit.small);

      expect(scalar, isNot(equals(42)));
      expect(scalar, isNot(equals('42')));
      expect(scalar, isNot(equals(null)));
    });

    test('double precision equality', () {
      const scalar1 = TestScalar(value: 42.123456789, unit: TestUnit.small);
      const scalar2 = TestScalar(value: 42.123456789, unit: TestUnit.small);
      const scalar3 = TestScalar(value: 42.123456788, unit: TestUnit.small);

      expect(scalar1, equals(scalar2));
      expect(scalar1, isNot(equals(scalar3)));
    });
  });

  group('Scalar hashCode', () {
    test('identical scalars have same hashCode', () {
      const scalar1 = TestScalar(value: 42, unit: TestUnit.small);
      const scalar2 = TestScalar(value: 42, unit: TestUnit.small);

      expect(scalar1.hashCode, equals(scalar2.hashCode));
    });

    test('different values produce different hashCodes', () {
      const scalar1 = TestScalar(value: 42, unit: TestUnit.small);
      const scalar2 = TestScalar(value: 24, unit: TestUnit.small);

      // While not guaranteed, different values should typically produce different hashes
      expect(scalar1.hashCode, isNot(equals(scalar2.hashCode)));
    });

    test('different units produce different hashCodes', () {
      const scalar1 = TestScalar(value: 42, unit: TestUnit.small);
      const scalar2 = TestScalar(value: 42, unit: TestUnit.medium);

      expect(scalar1.hashCode, isNot(equals(scalar2.hashCode)));
    });

    test('hashCode is consistent across multiple calls', () {
      const scalar = TestScalar(value: 42, unit: TestUnit.small);

      final hash1 = scalar.hashCode;
      final hash2 = scalar.hashCode;
      final hash3 = scalar.hashCode;

      expect(hash1, equals(hash2));
      expect(hash2, equals(hash3));
    });
  });

  group('Scalar.compareTo', () {
    test('implements Comparable interface', () {
      const scalar = TestScalar(value: 42, unit: TestUnit.small);

      expect(scalar, isA<Comparable<Scalar>>());
    });

    test('basic compareTo implementation in subclass', () {
      const smaller = ComparableScalar(value: 10, unit: TestUnit.small);
      const larger = ComparableScalar(value: 20, unit: TestUnit.small);

      expect(smaller.compareTo(larger), lessThan(0));
      expect(larger.compareTo(smaller), greaterThan(0));
    });

    test('compareTo returns 0 for equal values', () {
      const scalar1 = ComparableScalar(value: 42, unit: TestUnit.small);
      const scalar2 = ComparableScalar(value: 42, unit: TestUnit.small);

      expect(scalar1.compareTo(scalar2), 0);
    });

    test('compareTo with negative values', () {
      const negative = ComparableScalar(value: -10, unit: TestUnit.small);
      const positive = ComparableScalar(value: 10, unit: TestUnit.small);

      expect(negative.compareTo(positive), lessThan(0));
      expect(positive.compareTo(negative), greaterThan(0));
    });

    test('compareTo with zero', () {
      const zero = ComparableScalar(value: 0, unit: TestUnit.small);
      const positive = ComparableScalar(value: 10, unit: TestUnit.small);
      const negative = ComparableScalar(value: -10, unit: TestUnit.small);

      expect(zero.compareTo(positive), lessThan(0));
      expect(zero.compareTo(negative), greaterThan(0));
      expect(positive.compareTo(zero), greaterThan(0));
      expect(negative.compareTo(zero), lessThan(0));
    });

    test('compareTo with decimal values', () {
      const scalar1 = ComparableScalar(value: 10.5, unit: TestUnit.small);
      const scalar2 = ComparableScalar(value: 10.6, unit: TestUnit.small);

      expect(scalar1.compareTo(scalar2), lessThan(0));
      expect(scalar2.compareTo(scalar1), greaterThan(0));
    });

    test('compareTo throws error for incompatible types', () {
      const scalar = ComparableScalar(value: 42, unit: TestUnit.small);
      const otherScalar = OtherTypeScalar(value: 42, unit: OtherUnit.typeA);

      expect(
        () => scalar.compareTo(otherScalar),
        throwsA(isA<ArgumentError>()),
      );
    });
  });

  group('Scalar const constructor', () {
    test('can be created as const', () {
      const scalar = TestScalar(value: 42, unit: TestUnit.small);

      expect(scalar, isA<Scalar>());
      expect(scalar.value, 42);
      expect(scalar.unit, TestUnit.small);
    });

    test('const scalars with same values are identical', () {
      const scalar1 = TestScalar(value: 42, unit: TestUnit.small);
      const scalar2 = TestScalar(value: 42, unit: TestUnit.small);

      expect(identical(scalar1, scalar2), true);
    });

    test('const scalars with different values are not identical', () {
      const scalar1 = TestScalar(value: 42, unit: TestUnit.small);
      const scalar2 = TestScalar(value: 24, unit: TestUnit.small);

      expect(identical(scalar1, scalar2), false);
    });
  });

  group('Scalar with different unit types', () {
    test('works with custom enum units', () {
      const scalar = TestScalar(value: 100, unit: TestUnit.large);

      expect(scalar.unit, TestUnit.large);
      expect(scalar.unit, isA<Enum>());
    });

    test('different enum types create different scalars', () {
      const scalar1 = TestScalar(value: 42, unit: TestUnit.small);
      const scalar2 = OtherTypeScalar(value: 42, unit: OtherUnit.typeA);

      expect(scalar1.runtimeType, isNot(equals(scalar2.runtimeType)));
    });
  });

  group('Scalar edge cases', () {
    test('handles very large numbers', () {
      const scalar = TestScalar(value: double.maxFinite, unit: TestUnit.large);

      expect(scalar.value, double.maxFinite);
    });

    test('handles very small positive numbers', () {
      const scalar = TestScalar(value: double.minPositive, unit: TestUnit.small);

      expect(scalar.value, double.minPositive);
    });

    test('handles infinity', () {
      const scalar = TestScalar(value: double.infinity, unit: TestUnit.large);

      expect(scalar.value, double.infinity);
    });

    test('handles negative infinity', () {
      const scalar = TestScalar(value: double.negativeInfinity, unit: TestUnit.small);

      expect(scalar.value, double.negativeInfinity);
    });

    test('equality with infinity values', () {
      const scalar1 = TestScalar(value: double.infinity, unit: TestUnit.large);
      const scalar2 = TestScalar(value: double.infinity, unit: TestUnit.large);

      expect(scalar1, equals(scalar2));
    });
  });
}

// Test implementations

enum TestUnit {
  small,
  medium,
  large,
}

/// Basic test implementation of Scalar using default label behavior
class TestScalar extends Scalar {
  const TestScalar({required super.value, required this.unit}) : super(unit: unit);

  @override
  final TestUnit unit;

  @override
  int compareTo(Scalar other) {
    if (other is! TestScalar) {
      throw ArgumentError('Cannot compare TestScalar with ${other.runtimeType}');
    }
    return value.compareTo(other.value);
  }
}

/// Test implementation with custom label override
class CustomLabelScalar extends Scalar {
  const CustomLabelScalar({required super.value, required this.unit}) : super(unit: unit);

  @override
  final TestUnit unit;

  @override
  String label(BuildContext context) {
    return '${labelValue(context)} ${unit.name}';
  }

  @override
  int compareTo(Scalar other) {
    if (other is! CustomLabelScalar) {
      throw ArgumentError('Cannot compare CustomLabelScalar with ${other.runtimeType}');
    }
    return value.compareTo(other.value);
  }
}

/// Test implementation for compareTo testing
class ComparableScalar extends Scalar {
  const ComparableScalar({required super.value, required this.unit}) : super(unit: unit);

  @override
  final TestUnit unit;

  @override
  int compareTo(Scalar other) {
    if (other is! ComparableScalar) {
      throw ArgumentError('Cannot compare ComparableScalar with ${other.runtimeType}');
    }
    return value.compareTo(other.value);
  }
}

// Different type for testing type mismatches
enum OtherUnit {
  typeA,
  typeB,
}

class OtherTypeScalar extends Scalar {
  const OtherTypeScalar({required super.value, required this.unit}) : super(unit: unit);

  @override
  final OtherUnit unit;

  @override
  int compareTo(Scalar other) {
    if (other is! OtherTypeScalar) {
      throw ArgumentError('Cannot compare OtherTypeScalar with ${other.runtimeType}');
    }
    return value.compareTo(other.value);
  }
}

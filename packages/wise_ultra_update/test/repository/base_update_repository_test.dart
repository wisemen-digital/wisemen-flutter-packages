import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test/test.dart';
import 'package:wise_ultra_update/src/repository/base_update_repository.dart';

void main() {
  group('BaseUpdateRepository', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('baseUpdateRepositoryProvider can be read', () {
      final repo = container.read(baseUpdateRepositoryProvider);
      expect(repo, isA<BaseUpdateRepository>());
    });

    test('BaseUpdateRepository has checkNeedsUpdate method', () {
      final repo = container.read(baseUpdateRepositoryProvider);
      expect(repo.checkNeedsUpdate, isA<Function>());
    });
  });

  group('isVersionLower', () {
    test('returns true when major version is lower', () {
      expect(isVersionLower('1.0.0', '2.0.0'), true);
    });

    test('returns false when major version is higher', () {
      expect(isVersionLower('2.0.0', '1.0.0'), false);
    });

    test('returns true when minor version is lower', () {
      expect(isVersionLower('1.0.0', '1.1.0'), true);
    });

    test('returns false when minor version is higher', () {
      expect(isVersionLower('1.1.0', '1.0.0'), false);
    });

    test('returns true when patch version is lower', () {
      expect(isVersionLower('1.0.0', '1.0.1'), true);
    });

    test('returns false when patch version is higher', () {
      expect(isVersionLower('1.0.1', '1.0.0'), false);
    });

    test('returns false when versions are equal', () {
      expect(isVersionLower('1.0.0', '1.0.0'), false);
    });

    test('handles different version lengths - current shorter', () {
      expect(isVersionLower('1.0', '1.0.1'), true);
    });

    test('handles different version lengths - latest shorter', () {
      expect(isVersionLower('1.0.1', '1.0'), false);
    });

    test('handles version with non-numeric parts', () {
      expect(isVersionLower('1.0.x', '1.0.1'), true);
    });

    test('handles complex version comparison', () {
      expect(isVersionLower('1.2.3', '1.2.4'), true);
      expect(isVersionLower('1.2.4', '1.2.3'), false);
      expect(isVersionLower('1.2.3', '1.3.0'), true);
      expect(isVersionLower('1.3.0', '1.2.3'), false);
    });

    test('handles multi-digit version numbers', () {
      expect(isVersionLower('1.9.0', '1.10.0'), true);
      expect(isVersionLower('1.10.0', '1.9.0'), false);
    });

    test('handles four-part versions', () {
      expect(isVersionLower('1.0.0.0', '1.0.0.1'), true);
      expect(isVersionLower('1.0.0.1', '1.0.0.0'), false);
    });

    test('handles version 2.0.0 vs 1.9.9', () {
      expect(isVersionLower('1.9.9', '2.0.0'), true);
      expect(isVersionLower('2.0.0', '1.9.9'), false);
    });

    test('handles version 1.0.9 vs 1.0.10', () {
      expect(isVersionLower('1.0.9', '1.0.10'), true);
      expect(isVersionLower('1.0.10', '1.0.9'), false);
    });
  });
}

import 'package:test/test.dart';

// Test the version comparison logic directly
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

void main() {
  group('Version Comparison Logic', () {
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
  });
}

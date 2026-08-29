import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:wise_feedback/wise_feedback.dart';

/// A consumer-supplied translation for a locale the package does not ship.
class _GermanStrings extends WiseFeedbackStringsEn {
  const _GermanStrings();

  @override
  String get sheetTitle => 'Fehler melden';
}

void main() {
  group('built-in translations', () {
    test('ship English, Dutch and French', () {
      expect(WiseFeedbackStrings.builtIn.keys, containsAll(['en', 'nl', 'fr']));
    });

    test('Dutch strings', () {
      const nl = WiseFeedbackStringsNl();
      expect(nl.sheetTitle, 'Een bug melden');
      expect(nl.priorityHigh, 'Hoog');
      expect(nl.fieldCurrentSituation, 'Huidige situatie');
    });

    test('French strings', () {
      const fr = WiseFeedbackStringsFr();
      expect(fr.sheetTitle, 'Signaler un bug');
      expect(fr.priorityHigh, 'Élevée');
    });
  });

  group('WiseFeedbackStrings.resolve', () {
    test('picks the built-in translation for a shipped locale', () {
      expect(
        WiseFeedbackStrings.resolve(const Locale('nl')),
        isA<WiseFeedbackStringsNl>(),
      );
    });

    test('matches on language code, ignoring the country', () {
      expect(
        WiseFeedbackStrings.resolve(const Locale('nl', 'BE')).sheetTitle,
        'Een bug melden',
      );
    });

    test('falls back to English for an unshipped locale', () {
      expect(
        WiseFeedbackStrings.resolve(const Locale('de')),
        isA<WiseFeedbackStringsEn>(),
      );
    });

    test('falls back to English for a null locale', () {
      expect(
        WiseFeedbackStrings.resolve(null),
        isA<WiseFeedbackStringsEn>(),
      );
    });

    test('an override adds a locale the package does not ship', () {
      final strings = WiseFeedbackStrings.resolve(
        const Locale('de'),
        overrides: {const Locale('de'): const _GermanStrings()},
      );
      expect(strings.sheetTitle, 'Fehler melden');
      // Inherited from the English implementation it extends.
      expect(strings.priorityHigh, 'High');
    });

    test('an override replaces a shipped locale', () {
      final strings = WiseFeedbackStrings.resolve(
        const Locale('nl'),
        overrides: {const Locale('nl'): const _GermanStrings()},
      );
      expect(strings.sheetTitle, 'Fehler melden');
    });

    test('a language-only override covers a regional locale', () {
      final strings = WiseFeedbackStrings.resolve(
        const Locale('de', 'AT'),
        overrides: {const Locale('de'): const _GermanStrings()},
      );
      expect(strings.sheetTitle, 'Fehler melden');
    });
  });
}

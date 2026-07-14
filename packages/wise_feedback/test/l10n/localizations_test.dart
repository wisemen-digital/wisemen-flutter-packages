import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wise_feedback/generated/l10n.dart';

void main() {
  test('loads Dutch strings', () async {
    final nl = await WiseFeedbackLocalizations.load(const Locale('nl'));
    expect(nl.sheetTitle, 'Een bug melden');
    expect(nl.priorityHigh, 'Hoog');
    expect(nl.fieldCurrentSituation, 'Huidige situatie');
  });

  test('loads French strings', () async {
    final fr = await WiseFeedbackLocalizations.load(const Locale('fr'));
    expect(fr.sheetTitle, 'Signaler un bug');
    expect(fr.priorityHigh, 'Élevée');
  });

  test('falls back to English', () async {
    final en = await WiseFeedbackLocalizations.load(const Locale('en'));
    expect(en.sheetTitle, 'Report a bug');
  });
}

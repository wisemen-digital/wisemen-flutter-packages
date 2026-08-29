import 'dart:ui';

/// The user-facing text of the built-in feedback UI.
///
/// Plays the same role for wording that `WiseFeedbackTheme` plays for colors:
/// hand-written, `const`, and replaceable. Subclass it to translate the UI into
/// a language the package does not ship, or to reword the shipped ones, and pass
/// the result to `WiseFeedback(strings: {...})`.
///
/// Only the form and its toasts are translated. The issue body sent to the
/// tracker stays English so triagers see consistent headings.
abstract class WiseFeedbackStrings {
  /// Creates the strings.
  const WiseFeedbackStrings();

  /// The translations shipped with the package, keyed by language code.
  static const Map<String, WiseFeedbackStrings> builtIn = {
    'en': WiseFeedbackStringsEn(),
    'nl': WiseFeedbackStringsNl(),
    'fr': WiseFeedbackStringsFr(),
  };

  /// Picks the strings for [locale].
  ///
  /// [overrides] wins over [builtIn], matched on the full locale first and then
  /// on its language code alone, so `{Locale('nl'): ...}` covers `nl_BE` too.
  /// Falls back to English when nothing matches.
  static WiseFeedbackStrings resolve(
    Locale? locale, {
    Map<Locale, WiseFeedbackStrings> overrides = const {},
  }) {
    if (locale != null) {
      final match =
          overrides[locale] ??
          overrides[Locale(locale.languageCode)] ??
          builtIn[locale.languageCode];
      if (match != null) {
        return match;
      }
    }
    return overrides[const Locale('en')] ?? const WiseFeedbackStringsEn();
  }

  /// Title of the feedback sheet.
  String get sheetTitle;

  /// Label of the issue-title field.
  String get titleFieldLabel;

  /// Label of the priority selector.
  String get priorityLabel;

  /// Label of the category selector.
  String get categoryLabel;

  /// Toast shown after a report is filed.
  String get successMessage;

  /// Toast and inline message for a failure that carries no message of its own.
  String get genericError;

  /// Priority option: no priority set.
  String get priorityNone;

  /// Priority option: urgent.
  String get priorityUrgent;

  /// Priority option: high.
  String get priorityHigh;

  /// Priority option: medium.
  String get priorityMedium;

  /// Priority option: low.
  String get priorityLow;

  /// Default label of the built-in `description` field.
  String get fieldDescription;

  /// Default label of the built-in `currentSituation` field.
  String get fieldCurrentSituation;

  /// Default label of the built-in `desiredSituation` field.
  String get fieldDesiredSituation;
}

/// English strings (also the fallback when a locale has no translation).
class WiseFeedbackStringsEn extends WiseFeedbackStrings {
  /// Creates the English strings.
  const WiseFeedbackStringsEn();

  @override
  String get sheetTitle => 'Report a bug';

  @override
  String get titleFieldLabel => 'Title';

  @override
  String get priorityLabel => 'Priority';

  @override
  String get categoryLabel => 'Category';

  @override
  String get successMessage => 'Bug reported. Thanks!';

  @override
  String get genericError => 'Something went wrong. Please try again.';

  @override
  String get priorityNone => 'None';

  @override
  String get priorityUrgent => 'Urgent';

  @override
  String get priorityHigh => 'High';

  @override
  String get priorityMedium => 'Medium';

  @override
  String get priorityLow => 'Low';

  @override
  String get fieldDescription => 'Description';

  @override
  String get fieldCurrentSituation => 'Current Situation';

  @override
  String get fieldDesiredSituation => 'Desired Situation';
}

/// Dutch strings.
class WiseFeedbackStringsNl extends WiseFeedbackStrings {
  /// Creates the Dutch strings.
  const WiseFeedbackStringsNl();

  @override
  String get sheetTitle => 'Een bug melden';

  @override
  String get titleFieldLabel => 'Titel';

  @override
  String get priorityLabel => 'Prioriteit';

  @override
  String get categoryLabel => 'Categorie';

  @override
  String get successMessage => 'Bug gemeld. Bedankt!';

  @override
  String get genericError => 'Er is iets misgegaan. Probeer het opnieuw.';

  @override
  String get priorityNone => 'Geen';

  @override
  String get priorityUrgent => 'Urgent';

  @override
  String get priorityHigh => 'Hoog';

  @override
  String get priorityMedium => 'Gemiddeld';

  @override
  String get priorityLow => 'Laag';

  @override
  String get fieldDescription => 'Omschrijving';

  @override
  String get fieldCurrentSituation => 'Huidige situatie';

  @override
  String get fieldDesiredSituation => 'Gewenste situatie';
}

/// French strings.
class WiseFeedbackStringsFr extends WiseFeedbackStrings {
  /// Creates the French strings.
  const WiseFeedbackStringsFr();

  @override
  String get sheetTitle => 'Signaler un bug';

  @override
  String get titleFieldLabel => 'Titre';

  @override
  String get priorityLabel => 'Priorité';

  @override
  String get categoryLabel => 'Catégorie';

  @override
  String get successMessage => 'Bug signalé. Merci !';

  @override
  String get genericError => "Une erreur s'est produite. Veuillez réessayer.";

  @override
  String get priorityNone => 'Aucune';

  @override
  String get priorityUrgent => 'Urgent';

  @override
  String get priorityHigh => 'Élevée';

  @override
  String get priorityMedium => 'Moyenne';

  @override
  String get priorityLow => 'Faible';

  @override
  String get fieldDescription => 'Description';

  @override
  String get fieldCurrentSituation => 'Situation actuelle';

  @override
  String get fieldDesiredSituation => 'Situation souhaitée';
}

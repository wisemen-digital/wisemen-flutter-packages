// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class WiseFeedbackLocalizations {
  WiseFeedbackLocalizations();

  static WiseFeedbackLocalizations? _current;

  static WiseFeedbackLocalizations get current {
    assert(
      _current != null,
      'No instance of WiseFeedbackLocalizations was loaded. Try to initialize the WiseFeedbackLocalizations delegate before accessing WiseFeedbackLocalizations.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<WiseFeedbackLocalizations> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = WiseFeedbackLocalizations();
      WiseFeedbackLocalizations._current = instance;

      return instance;
    });
  }

  static WiseFeedbackLocalizations of(BuildContext context) {
    final instance = WiseFeedbackLocalizations.maybeOf(context);
    assert(
      instance != null,
      'No instance of WiseFeedbackLocalizations present in the widget tree. Did you add WiseFeedbackLocalizations.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static WiseFeedbackLocalizations? maybeOf(BuildContext context) {
    return Localizations.of<WiseFeedbackLocalizations>(
      context,
      WiseFeedbackLocalizations,
    );
  }

  /// `Report a bug`
  String get sheetTitle {
    return Intl.message('Report a bug', name: 'sheetTitle', desc: '', args: []);
  }

  /// `Title`
  String get titleFieldLabel {
    return Intl.message('Title', name: 'titleFieldLabel', desc: '', args: []);
  }

  /// `Priority`
  String get priorityLabel {
    return Intl.message('Priority', name: 'priorityLabel', desc: '', args: []);
  }

  /// `Category`
  String get categoryLabel {
    return Intl.message('Category', name: 'categoryLabel', desc: '', args: []);
  }

  /// `Bug reported. Thanks!`
  String get successMessage {
    return Intl.message(
      'Bug reported. Thanks!',
      name: 'successMessage',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong. Please try again.`
  String get genericError {
    return Intl.message(
      'Something went wrong. Please try again.',
      name: 'genericError',
      desc: '',
      args: [],
    );
  }

  /// `None`
  String get priorityNone {
    return Intl.message('None', name: 'priorityNone', desc: '', args: []);
  }

  /// `Urgent`
  String get priorityUrgent {
    return Intl.message('Urgent', name: 'priorityUrgent', desc: '', args: []);
  }

  /// `High`
  String get priorityHigh {
    return Intl.message('High', name: 'priorityHigh', desc: '', args: []);
  }

  /// `Medium`
  String get priorityMedium {
    return Intl.message('Medium', name: 'priorityMedium', desc: '', args: []);
  }

  /// `Low`
  String get priorityLow {
    return Intl.message('Low', name: 'priorityLow', desc: '', args: []);
  }

  /// `Description`
  String get fieldDescription {
    return Intl.message(
      'Description',
      name: 'fieldDescription',
      desc: '',
      args: [],
    );
  }

  /// `Current Situation`
  String get fieldCurrentSituation {
    return Intl.message(
      'Current Situation',
      name: 'fieldCurrentSituation',
      desc: '',
      args: [],
    );
  }

  /// `Desired Situation`
  String get fieldDesiredSituation {
    return Intl.message(
      'Desired Situation',
      name: 'fieldDesiredSituation',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate
    extends LocalizationsDelegate<WiseFeedbackLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'nl'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<WiseFeedbackLocalizations> load(Locale locale) =>
      WiseFeedbackLocalizations.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../base/base.dart';

/// Date format patterns configuration
@immutable
class DateFormatPatterns {
  /// Creates a [DateFormatPatterns] instance
  const DateFormatPatterns({
    required this.short,
    required this.medium,
    required this.long,
    required this.full,
    required this.time,
  });

  /// Initializes [DateFormatPatterns] with default intl patterns
  factory DateFormatPatterns.init() {
    return DateFormatPatterns(
      short: DateFormat.yMd(),
      medium: DateFormat.yMMMd(),
      long: DateFormat.yMMMMd(),
      full: DateFormat.yMMMMEEEEd(),
      time: DateFormat.jm(),
    );
  }

  /// Creates [DateFormatPatterns] from method channel's map
  factory DateFormatPatterns.fromMap(Map<String, String>? map) {
    if (map == null) {
      return DateFormatPatterns.init();
    }
    return DateFormatPatterns(
      short: DateFormat(map['short']),
      medium: DateFormat(map['medium']),
      long: DateFormat(map['long']),
      full: DateFormat(map['full']),
      time: DateFormat(map['time']),
    );
  }

  /// DateFormatter.Style .short for iOS <br/>
  /// DateFormat.getDateFormat for Android <br/>
  /// yMd for intl
  final DateFormat short;

  /// DateFormatter.Style .medium for iOS <br/>
  /// DateFormat.getMediumDateFormat for Android <br/>
  /// yMMMd for intl
  final DateFormat medium;

  /// DateFormatter.Style .long for iOS <br/>
  /// DateFormat.getLongDateFormat for Android <br/>
  /// yMMMMd for intl
  final DateFormat long;

  /// DateFormatter.Style .full for iOS <br/>
  /// DateFormat.getDateInstance(.FULL, locale) for Android <br/>
  /// yMMMMEEEEd for intl
  final DateFormat full;

  /// DateFormatter.Style (.timeStyle) .short for iOS <br/>
  /// DateFormat.getTimeFormat for Android <br/>
  /// jm for intl
  final DateFormat time;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DateFormatPatterns &&
          runtimeType == other.runtimeType &&
          short.pattern == other.short.pattern &&
          medium.pattern == other.medium.pattern &&
          long.pattern == other.long.pattern &&
          full.pattern == other.full.pattern &&
          time.pattern == other.time.pattern;
  @override
  int get hashCode => Object.hash(short, medium, long, full, time);
}

/// Extension methods for [DateTime] to format using [DateFormatPatterns]
extension DateFormatPatternsExtension on DateTime {
  DateFormatPatterns _getPatterns(BuildContext context) => ScalarOptions.of(context).dateFormatPatterns;

  /// Formats date using short pattern using [DateFormatPatterns.short]
  String short(BuildContext context) {
    return _getPatterns(context).short.format(this);
  }

  /// Formats date using medium pattern using [DateFormatPatterns.medium]
  String medium(BuildContext context) {
    return _getPatterns(context).medium.format(this);
  }

  /// Formats date using long pattern using [DateFormatPatterns.long]
  String long(BuildContext context) {
    return _getPatterns(context).long.format(this);
  }

  /// Formats date using full pattern using [DateFormatPatterns.full]
  String full(BuildContext context) {
    return _getPatterns(context).full.format(this);
  }

  /// Formats time using time pattern using [DateFormatPatterns.time]
  String time(BuildContext context) {
    return _getPatterns(context).time.format(this);
  }
}

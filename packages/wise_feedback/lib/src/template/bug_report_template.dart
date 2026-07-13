import '../models/feedback_report.dart';
import 'feedback_field.dart';
import 'feedback_template.dart';

/// A structured bug template: **Current Situation** / **Desired Situation**
/// inputs, with **Steps to Reproduce** filled from the navigation breadcrumb
/// and **Context** filled automatically (environment, reporter, timestamp).
class BugReportTemplate extends FeedbackTemplate {
  /// Creates the template.
  ///
  /// [environmentKeys] are the `metadata` keys checked, in order, to fill the
  /// "Environment or url" line (defaults to `environment`, then `flavor`).
  const BugReportTemplate({
    this.currentSituationLabel = 'Current Situation',
    this.desiredSituationLabel = 'Desired Situation',
    this.environmentKeys = const ['environment', 'flavor'],
  });

  /// Label for the current-situation field.
  final String currentSituationLabel;

  /// Label for the desired-situation field.
  final String desiredSituationLabel;

  /// Metadata keys checked in order to fill "Environment or url".
  final List<String> environmentKeys;

  @override
  List<FeedbackField> get fields => [
        FeedbackField(key: 'currentSituation', label: currentSituationLabel),
        FeedbackField(key: 'desiredSituation', label: desiredSituationLabel),
      ];

  @override
  String buildBody(FeedbackReport report) {
    final buffer = StringBuffer()
      ..writeln('## Current Situation')
      ..writeln(report.fields['currentSituation'] ?? '')
      ..writeln()
      ..writeln('## Desired Situation')
      ..writeln(report.fields['desiredSituation'] ?? '')
      ..writeln()
      ..writeln('## Steps to Reproduce')
      ..writeln(_steps(report))
      ..writeln()
      ..writeln('## Context')
      ..writeln('Environment or url: ${_environment(report)}')
      ..writeln('Account or user: ${report.reporter?.email ?? ''}')
      ..writeln('Date & Time: ${_formatDate(report.createdAt)}');
    return buffer.toString().trimRight();
  }

  String _steps(FeedbackReport report) {
    final navigation = report.metadata['navigation'];
    if (navigation is! String || navigation.isEmpty) {
      return '_No navigation recorded._';
    }
    final steps = navigation.split(' → ');
    return [
      for (var i = 0; i < steps.length; i++) '${i + 1}. ${steps[i]}',
    ].join('\n');
  }

  String _environment(FeedbackReport report) {
    for (final key in environmentKeys) {
      final value = report.metadata[key];
      if (value != null) {
        return value.toString();
      }
    }
    return '';
  }

  String _formatDate(DateTime? date) {
    if (date == null) {
      return '';
    }
    String two(int value) => value.toString().padLeft(2, '0');
    return '${date.year}-${two(date.month)}-${two(date.day)} '
        '${two(date.hour)}:${two(date.minute)}';
  }
}

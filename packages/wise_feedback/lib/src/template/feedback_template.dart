import '../models/feedback_priority.dart';
import '../models/feedback_report.dart';
import 'feedback_field.dart';

/// Defines the form inputs and how a [FeedbackReport] renders to an issue body.
///
/// Implement this to match your issue tracker's template. The screenshot is
/// appended by the transport, so [buildBody] should not include it.
abstract class FeedbackTemplate {
  /// Const base constructor so templates can be declared `const`.
  const FeedbackTemplate();

  /// The editable text fields shown in the form (below the title).
  List<FeedbackField> get fields;

  /// Renders the issue body (markdown) from a completed [report].
  String buildBody(FeedbackReport report);
}

/// The default template: a single description field plus a `## Context`
/// section listing reporter, category, priority, environment and recent
/// screens. Preserves the package's original issue format.
class DefaultFeedbackTemplate extends FeedbackTemplate {
  /// Creates the default template.
  const DefaultFeedbackTemplate({this.descriptionLabel = 'Description'});

  /// Label for the single description field.
  final String descriptionLabel;

  @override
  List<FeedbackField> get fields => [
        FeedbackField(key: 'description', label: descriptionLabel),
      ];

  @override
  String buildBody(FeedbackReport report) {
    final buffer = StringBuffer(report.fields['description'] ?? '');
    final context = <String>[];

    final who = formatReporter(report);
    if (who != null) {
      context.add('**Reported by:** $who');
    }
    if (report.category case final String category) {
      context.add('**Category:** $category');
    }
    if (report.priority != FeedbackPriority.none) {
      context.add('**Priority:** ${report.priority.label}');
    }

    final environment = renderEnvironmentBullets(report);
    final navigation = report.metadata['navigation'];

    if (context.isNotEmpty || environment.isNotEmpty || navigation != null) {
      buffer.write('\n\n## Context\n');
      if (context.isNotEmpty) {
        buffer.write('${context.join('\n')}\n');
      }
      if (environment.isNotEmpty) {
        buffer.write('\n**Environment**\n${environment.join('\n')}\n');
      }
      if (navigation != null) {
        buffer.write('\n**Recent screens:** $navigation\n');
      }
    }
    return buffer.toString().trimRight();
  }
}

/// Formats the reporter as `name · email` (or the id), or null when unknown.
String? formatReporter(FeedbackReport report) {
  final reporter = report.reporter;
  if (reporter == null || reporter.isEmpty) {
    return null;
  }
  final named = <String?>[reporter.name, reporter.email]
      .whereType<String>()
      .where((value) => value.isNotEmpty)
      .toList();
  if (named.isNotEmpty) {
    return named.join(' · ');
  }
  return reporter.id;
}

/// Renders `report.metadata` (excluding the `navigation` key) as markdown
/// bullet lines.
List<String> renderEnvironmentBullets(FeedbackReport report) =>
    report.metadata.entries
        .where((entry) => entry.key != 'navigation')
        .map((entry) => '- **${entry.key}:** ${entry.value ?? ''}')
        .toList();

import '../models/feedback_priority.dart';
import '../models/feedback_report.dart';
import '../models/feedback_reporter.dart';
import 'feedback_field.dart';

/// Defines the form inputs and how a completed report renders to an issue body.
///
/// Implement this to match your issue tracker's template. The screenshot is
/// appended by the transport, so [buildBody] should not include it.
abstract class FeedbackTemplate {
  /// Const base constructor so templates can be declared `const`.
  const FeedbackTemplate();

  /// The editable text fields shown in the form (below the title).
  List<FeedbackField> get fields;

  /// Renders the issue body (markdown) from the captured values.
  ///
  /// Takes the report's parts rather than a [FeedbackReport], because the body
  /// this returns *becomes* that report's description — there is no complete
  /// report to hand over yet.
  String buildBody({
    required Map<String, String> fields,
    required Map<String, Object?> metadata,
    FeedbackReporter? reporter,
    FeedbackPriority priority = FeedbackPriority.none,
    String? category,
    DateTime? createdAt,
  });

  /// Formats [reporter] as `name · email` (or the id), or null when unknown.
  ///
  /// Available to subclasses building a context section.
  String? formatReporter(FeedbackReporter? reporter) {
    if (reporter == null || reporter.isEmpty) {
      return null;
    }
    final named = <String?>[
      reporter.name,
      reporter.email,
    ].whereType<String>().where((value) => value.isNotEmpty).toList();
    if (named.isNotEmpty) {
      return named.join(' · ');
    }
    return reporter.id;
  }

  /// Renders [metadata] as markdown bullet lines, excluding the navigation
  /// breadcrumb, which templates present separately.
  ///
  /// Available to subclasses building a context section.
  List<String> renderEnvironmentBullets(Map<String, Object?> metadata) =>
      metadata.entries
          .where((entry) => entry.key != FeedbackReport.navigationKey)
          .map((entry) => '- **${entry.key}:** ${entry.value ?? ''}')
          .toList();

  /// Reads the navigation breadcrumb from [metadata], oldest screen first.
  ///
  /// Empty when no trail was recorded.
  List<String> breadcrumbsOf(Map<String, Object?> metadata) =>
      switch (metadata[FeedbackReport.navigationKey]) {
        final List<String> trail => trail,
        _ => const <String>[],
      };
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
  String buildBody({
    required Map<String, String> fields,
    required Map<String, Object?> metadata,
    FeedbackReporter? reporter,
    FeedbackPriority priority = FeedbackPriority.none,
    String? category,
    DateTime? createdAt,
  }) {
    final buffer = StringBuffer(fields['description'] ?? '');
    final context = <String>[];

    final who = formatReporter(reporter);
    if (who != null) {
      context.add('**Reported by:** $who');
    }
    if (category case final String value) {
      context.add('**Category:** $value');
    }
    if (priority != FeedbackPriority.none) {
      context.add('**Priority:** ${priority.label}');
    }

    final environment = renderEnvironmentBullets(metadata);
    final breadcrumbs = breadcrumbsOf(metadata);

    if (context.isNotEmpty ||
        environment.isNotEmpty ||
        breadcrumbs.isNotEmpty) {
      buffer.write('\n\n## Context\n');
      if (context.isNotEmpty) {
        buffer.write('${context.join('\n')}\n');
      }
      if (environment.isNotEmpty) {
        buffer.write('\n**Environment**\n${environment.join('\n')}\n');
      }
      if (breadcrumbs.isNotEmpty) {
        buffer.write('\n**Recent screens:** ${breadcrumbs.join(' → ')}\n');
      }
    }
    return buffer.toString().trimRight();
  }
}

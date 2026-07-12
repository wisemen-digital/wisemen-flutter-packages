import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/feedback_exception.dart';
import '../models/feedback_priority.dart';
import '../models/feedback_report.dart';
import '../models/feedback_result.dart';
import 'feedback_transport.dart';
import 'http_utils.dart';

/// A [FeedbackTransport] that talks to the Linear GraphQL API directly.
///
/// No backend is required: supply a token and team id and reports are
/// filed as Linear issues from the device.
///
/// Security: the token ships inside the app binary, which is decompilable,
/// so it can be extracted. Use a dedicated Linear bot/service account with a
/// least-privilege token scoped to a single team — never a personal API key —
/// so the worst case of extraction is issue creation in that one team. Supply
/// the token via `--dart-define` or fetch it at runtime; rotate it regularly.
class LinearDirectTransport implements FeedbackTransport {
  /// Creates a direct transport.
  ///
  /// [endpoint] defaults to `https://api.linear.app/graphql`. Pass
  /// [httpClient] to inject a client in tests.
  LinearDirectTransport({
    required String token,
    required String teamId,
    String? projectId,
    Uri? endpoint,
    http.Client? httpClient,
  })  : _token = token,
        _teamId = teamId,
        _projectId = projectId,
        _endpoint = endpoint ?? Uri.parse('https://api.linear.app/graphql'),
        _http = httpClient ?? http.Client();

  static const String _fileUploadMutation = r'''
mutation FileUpload($contentType: String!, $filename: String!, $size: Int!) {
  fileUpload(contentType: $contentType, filename: $filename, size: $size) {
    success
    uploadFile {
      uploadUrl
      assetUrl
      headers { key value }
    }
  }
}
''';

  static const String _issueCreateMutation = r'''
mutation IssueCreate($title: String!, $description: String!, $teamId: String!, $projectId: String, $priority: Int) {
  issueCreate(input: {title: $title, description: $description, teamId: $teamId, projectId: $projectId, priority: $priority}) {
    success
    issue { id url }
  }
}
''';

  final String _token;
  final String _teamId;
  final String? _projectId;
  final Uri _endpoint;
  final http.Client _http;

  @override
  Future<FeedbackResult> send(FeedbackReport report) async {
    final upload = await _requestUploadUrl(report.screenshotPng.length);
    await _uploadScreenshot(upload, report.screenshotPng);
    return _createIssue(report, upload.assetUrl);
  }

  Future<_UploadTarget> _requestUploadUrl(int size) async {
    final data = await _graphql(_fileUploadMutation, <String, dynamic>{
      'contentType': 'image/png',
      'filename': 'feedback.png',
      'size': size,
    });
    final uploadFile = (data['fileUpload'] as Json?)?['uploadFile'] as Json?;
    final uploadUrl = uploadFile?['uploadUrl'] as String?;
    final assetUrl = uploadFile?['assetUrl'] as String?;
    if (uploadUrl == null || assetUrl == null) {
      throw const FeedbackException('Linear did not return an upload URL.');
    }
    final headers = <String, String>{};
    for (final h in (uploadFile?['headers'] as List<dynamic>? ?? <dynamic>[])) {
      final map = h as Json;
      headers[map['key'] as String] = map['value'] as String;
    }
    return _UploadTarget(
      uploadUrl: uploadUrl,
      assetUrl: assetUrl,
      headers: headers,
    );
  }

  Future<void> _uploadScreenshot(_UploadTarget target, List<int> bytes) async {
    final response = await _http.put(
      Uri.parse(target.uploadUrl),
      headers: <String, String>{
        ...target.headers,
        'Content-Type': 'image/png',
      },
      body: bytes,
    );
    if (!response.isSuccessful) {
      throw FeedbackException(
        'Screenshot upload failed with status ${response.statusCode}.',
      );
    }
  }

  Future<FeedbackResult> _createIssue(
    FeedbackReport report,
    String assetUrl,
  ) async {
    final data = await _graphql(_issueCreateMutation, <String, dynamic>{
      'title': report.title,
      'description': _renderBody(report, assetUrl),
      'teamId': _teamId,
      'projectId': _projectId,
      'priority': report.priority.linearValue,
    });
    final issueCreate = data['issueCreate'] as Json?;
    final success = issueCreate?['success'] as bool?;
    final issue = issueCreate?['issue'] as Json?;
    if (success != true || issue == null) {
      throw const FeedbackException('Linear did not create the issue.');
    }
    return FeedbackResult(
      issueId: issue['id'] as String?,
      issueUrl: issue['url'] as String?,
    );
  }

  /// Builds the issue body: the user's text, a `## Context` section rendering
  /// reporter/category/priority/environment/navigation, then the screenshot.
  String _renderBody(FeedbackReport report, String assetUrl) {
    final buffer = StringBuffer(report.description);
    final context = <String>[];

    final reporter = report.reporter;
    if (reporter != null && !reporter.isEmpty) {
      final named = <String?>[reporter.name, reporter.email]
          .whereType<String>()
          .where((value) => value.isNotEmpty)
          .toList();
      final who = named.isNotEmpty ? named.join(' · ') : (reporter.id ?? '');
      if (who.isNotEmpty) {
        context.add('**Reported by:** $who');
      }
    }
    if (report.category case final String category) {
      context.add('**Category:** $category');
    }
    if (report.priority != FeedbackPriority.none) {
      context.add('**Priority:** ${report.priority.label}');
    }

    final environment = report.metadata.entries
        .where((entry) => entry.key != 'navigation')
        .map((entry) => '- **${entry.key}:** ${entry.value ?? ''}')
        .toList();
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

    buffer.write('\n\n![screenshot]($assetUrl)');
    return buffer.toString();
  }

  Future<Json> _graphql(
    String query,
    Json variables,
  ) async {
    final http.Response response;
    try {
      response = await _http.post(
        _endpoint,
        headers: <String, String>{
          'Authorization': _token,
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          <String, dynamic>{'query': query, 'variables': variables},
        ),
      );
    } catch (e) {
      throw FeedbackException(
        'Could not reach Linear. Check your connection and try again.',
        cause: e,
      );
    }
    if (response.statusCode == 401 || response.statusCode == 403) {
      throw const FeedbackException(
        'Could not authenticate with Linear. Check the API token.',
      );
    }
    if (!response.isSuccessful) {
      throw FeedbackException(
        'Linear returned an unexpected response (status '
        '${response.statusCode}).',
      );
    }
    final Json decoded;
    try {
      decoded = jsonDecode(response.body) as Json;
    } catch (e) {
      throw FeedbackException('Invalid response from Linear.', cause: e);
    }
    if (decoded['errors'] != null) {
      throw const FeedbackException(
        'Linear rejected the report. Please try again.',
      );
    }
    final data = decoded['data'] as Json?;
    if (data == null) {
      throw const FeedbackException('Linear response contained no data.');
    }
    return data;
  }
}

class _UploadTarget {
  const _UploadTarget({
    required this.uploadUrl,
    required this.assetUrl,
    required this.headers,
  });

  final String uploadUrl;
  final String assetUrl;
  final Map<String, String> headers;
}

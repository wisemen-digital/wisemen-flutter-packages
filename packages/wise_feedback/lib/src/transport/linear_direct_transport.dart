import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/feedback_exception.dart';
import '../models/feedback_report.dart';
import '../models/feedback_result.dart';
import 'feedback_transport.dart';

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
mutation IssueCreate($title: String!, $description: String!, $teamId: String!, $projectId: String) {
  issueCreate(input: {title: $title, description: $description, teamId: $teamId, projectId: $projectId}) {
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
    final uploadFile = (data['fileUpload'] as Map<String, dynamic>?)?['uploadFile']
        as Map<String, dynamic>?;
    final uploadUrl = uploadFile?['uploadUrl'] as String?;
    final assetUrl = uploadFile?['assetUrl'] as String?;
    if (uploadUrl == null || assetUrl == null) {
      throw const FeedbackException('Linear did not return an upload URL.');
    }
    final headers = <String, String>{};
    for (final h in (uploadFile?['headers'] as List<dynamic>? ?? <dynamic>[])) {
      final map = h as Map<String, dynamic>;
      headers[map['key'] as String] = map['value'] as String;
    }
    return _UploadTarget(uploadUrl: uploadUrl, assetUrl: assetUrl, headers: headers);
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
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw FeedbackException(
        'Screenshot upload failed with status ${response.statusCode}.',
      );
    }
  }

  Future<FeedbackResult> _createIssue(FeedbackReport report, String assetUrl) async {
    final description = '${report.description}\n\n![screenshot]($assetUrl)';
    final data = await _graphql(_issueCreateMutation, <String, dynamic>{
      'title': report.title,
      'description': description,
      'teamId': _teamId,
      'projectId': _projectId,
    });
    final issue =
        (data['issueCreate'] as Map<String, dynamic>?)?['issue'] as Map<String, dynamic>?;
    return FeedbackResult(
      issueId: issue?['id'] as String?,
      issueUrl: issue?['url'] as String?,
    );
  }

  Future<Map<String, dynamic>> _graphql(
    String query,
    Map<String, dynamic> variables,
  ) async {
    final http.Response response;
    try {
      response = await _http.post(
        _endpoint,
        headers: <String, String>{
          'Authorization': _token,
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{'query': query, 'variables': variables}),
      );
    } on Object catch (e) {
      throw FeedbackException('Network error contacting Linear.', cause: e);
    }
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw FeedbackException('Linear returned status ${response.statusCode}.');
    }
    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    if (decoded['errors'] != null) {
      throw FeedbackException('Linear GraphQL error: ${decoded['errors']}');
    }
    final data = decoded['data'] as Map<String, dynamic>?;
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

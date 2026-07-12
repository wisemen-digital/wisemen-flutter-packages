import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/feedback_exception.dart';
import '../models/feedback_report.dart';
import '../models/feedback_result.dart';
import 'feedback_transport.dart';

/// A [FeedbackTransport] that POSTs the report to an HTTPS endpoint you own.
///
/// The backend holds the Linear token and creates the issue, so no Linear
/// credential ever reaches the device. Authenticate the request with your
/// app's own auth via `authHeadersProvider`.
///
/// Request: `multipart/form-data` with `title`, `description`, `metadata`
/// (JSON string) fields and a `screenshot` (image/png) file part.
/// Response: 2xx JSON `{ "issueId": "...", "issueUrl": "..." }`.
class LinearProxyTransport implements FeedbackTransport {
  /// Creates a proxy transport targeting [endpoint].
  LinearProxyTransport({
    required Uri endpoint,
    Future<Map<String, String>> Function()? authHeadersProvider,
    http.Client? httpClient,
  })  : _endpoint = endpoint,
        _authHeadersProvider = authHeadersProvider,
        _http = httpClient ?? http.Client();

  final Uri _endpoint;
  final Future<Map<String, String>> Function()? _authHeadersProvider;
  final http.Client _http;

  @override
  Future<FeedbackResult> send(FeedbackReport report) async {
    final request = http.MultipartRequest('POST', _endpoint)
      ..fields['title'] = report.title
      ..fields['description'] = report.description
      ..fields['metadata'] = jsonEncode(report.metadata)
      ..files.add(
        http.MultipartFile.fromBytes(
          'screenshot',
          report.screenshotPng,
          filename: 'feedback.png',
        ),
      );

    if (_authHeadersProvider != null) {
      request.headers.addAll(await _authHeadersProvider());
    }

    final http.StreamedResponse streamed;
    try {
      streamed = await _http.send(request);
    } on Object catch (e) {
      throw FeedbackException(
        'Network error contacting feedback endpoint.',
        cause: e,
      );
    }
    final response = await http.Response.fromStream(streamed);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw FeedbackException(
        'Feedback endpoint returned status ${response.statusCode}.',
      );
    }

    if (response.body.isEmpty) {
      return const FeedbackResult();
    }
    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    return FeedbackResult(
      issueId: decoded['issueId'] as String?,
      issueUrl: decoded['issueUrl'] as String?,
    );
  }
}

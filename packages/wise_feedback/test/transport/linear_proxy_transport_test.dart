import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:wise_feedback/wise_feedback.dart';

FeedbackReport _report() => FeedbackReport(
      title: 'Proxy title',
      description: 'Proxy desc',
      screenshotPng: Uint8List.fromList([137, 80, 78, 71]),
      metadata: const {'route': '/settings'},
    );

void main() {
  group('LinearProxyTransport', () {
    test('POSTs multipart with auth headers and parses issue info', () async {
      late http.Request captured;
      final client = MockClient((request) async {
        captured = request;
        return http.Response(
          jsonEncode(
            {'issueId': 'PRX-9', 'issueUrl': 'https://linear.app/x/PRX-9'},
          ),
          201,
        );
      });

      final transport = LinearProxyTransport(
        endpoint: Uri.parse('https://api.myapp.com/feedback'),
        authHeadersProvider: () async =>
            {'Authorization': 'Bearer session-abc'},
        httpClient: client,
      );

      final result = await transport.send(_report());

      expect(captured.method, 'POST');
      expect(captured.url.toString(), 'https://api.myapp.com/feedback');
      expect(captured.headers['authorization'], 'Bearer session-abc');
      expect(
        captured.headers['content-type'],
        startsWith('multipart/form-data'),
      );
      // Field values appear in the multipart body. The body also contains raw
      // PNG bytes, so it is decoded leniently rather than via `captured.body`
      // (which is strict UTF-8 and would throw a FormatException).
      final bodyText = utf8.decode(captured.bodyBytes, allowMalformed: true);
      expect(bodyText, contains('Proxy title'));
      expect(bodyText, contains('Proxy desc'));
      expect(bodyText, contains('/settings'));
      expect(result.issueId, 'PRX-9');
      expect(result.issueUrl, 'https://linear.app/x/PRX-9');
    });

    test('throws FeedbackException on non-2xx', () async {
      final client = MockClient((request) async => http.Response('nope', 500));
      final transport = LinearProxyTransport(
        endpoint: Uri.parse('https://api.myapp.com/feedback'),
        httpClient: client,
      );
      expect(
        () => transport.send(_report()),
        throwsA(isA<FeedbackException>()),
      );
    });
  });
}

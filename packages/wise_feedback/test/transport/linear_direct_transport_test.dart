import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:wise_feedback/wise_feedback.dart';

FeedbackReport _report() => FeedbackReport(
      title: 'Save crashes',
      description: 'It crashes',
      screenshotPng: Uint8List.fromList(List<int>.filled(4, 7)),
    );

void main() {
  group('LinearDirectTransport', () {
    test('runs fileUpload -> PUT -> issueCreate and returns issue info',
        () async {
      final calls = <String>[];
      final client = MockClient((request) async {
        if (request.method == 'POST') {
          final body = jsonDecode(request.body) as Map<String, dynamic>;
          final query = body['query'] as String;
          if (query.contains('fileUpload')) {
            calls.add('fileUpload');
            expect(request.headers['authorization'], 'lin_test_token');
            return http.Response(
              jsonEncode({
                'data': {
                  'fileUpload': {
                    'uploadFile': {
                      'uploadUrl': 'https://uploads.example/put',
                      'assetUrl': 'https://assets.example/a.png',
                      'headers': [
                        {'key': 'x-amz-acl', 'value': 'public-read'},
                      ],
                    },
                  },
                },
              }),
              200,
            );
          }
          if (query.contains('issueCreate')) {
            calls.add('issueCreate');
            final vars = body['variables'] as Map<String, dynamic>;
            expect(vars['title'], 'Save crashes');
            expect(
              vars['description'] as String,
              contains('https://assets.example/a.png'),
            );
            return http.Response(
              jsonEncode({
                'data': {
                  'issueCreate': {
                    'success': true,
                    'issue': {
                      'id': 'iss_1',
                      'url': 'https://linear.app/x/issue/ABC-1',
                    },
                  },
                },
              }),
              200,
            );
          }
        }
        if (request.method == 'PUT') {
          calls.add('put');
          expect(request.url.toString(), 'https://uploads.example/put');
          expect(request.headers['x-amz-acl'], 'public-read');
          expect(request.headers['content-type'], 'image/png');
          return http.Response('', 200);
        }
        return http.Response('unexpected', 500);
      });

      final transport = LinearDirectTransport(
        token: 'lin_test_token',
        teamId: 'team_123',
        httpClient: client,
      );

      final result = await transport.send(_report());

      expect(calls, ['fileUpload', 'put', 'issueCreate']);
      expect(result.issueId, 'iss_1');
      expect(result.issueUrl, 'https://linear.app/x/issue/ABC-1');
    });

    test('throws FeedbackException when fileUpload returns no upload url',
        () async {
      final client = MockClient(
        (request) async => http.Response(
          jsonEncode({
            'data': {
              'fileUpload': {'uploadFile': null},
            },
          }),
          200,
        ),
      );
      final transport = LinearDirectTransport(
        token: 't',
        teamId: 'team',
        httpClient: client,
      );
      expect(
        () => transport.send(_report()),
        throwsA(isA<FeedbackException>()),
      );
    });

    test('throws FeedbackException when issueCreate reports success: false',
        () async {
      final client = MockClient((request) async {
        if (request.method == 'POST') {
          final body = jsonDecode(request.body) as Map<String, dynamic>;
          final query = body['query'] as String;
          if (query.contains('fileUpload')) {
            return http.Response(
              jsonEncode({
                'data': {
                  'fileUpload': {
                    'uploadFile': {
                      'uploadUrl': 'https://uploads.example/put',
                      'assetUrl': 'https://assets.example/a.png',
                      'headers': <dynamic>[],
                    },
                  },
                },
              }),
              200,
            );
          }
          if (query.contains('issueCreate')) {
            return http.Response(
              jsonEncode({
                'data': {
                  'issueCreate': {
                    'success': false,
                    'issue': null,
                  },
                },
              }),
              200,
            );
          }
        }
        if (request.method == 'PUT') {
          return http.Response('', 200);
        }
        return http.Response('unexpected', 500);
      });
      final transport = LinearDirectTransport(
        token: 't',
        teamId: 'team',
        httpClient: client,
      );
      expect(
        () => transport.send(_report()),
        throwsA(isA<FeedbackException>()),
      );
    });

    test('throws FeedbackException when the PUT upload fails', () async {
      final client = MockClient((request) async {
        if (request.method == 'POST') {
          return http.Response(
            jsonEncode({
              'data': {
                'fileUpload': {
                  'uploadFile': {
                    'uploadUrl': 'https://uploads.example/put',
                    'assetUrl': 'https://assets.example/a.png',
                    'headers': <dynamic>[],
                  },
                },
              },
            }),
            200,
          );
        }
        return http.Response('denied', 403);
      });
      final transport = LinearDirectTransport(
        token: 't',
        teamId: 'team',
        httpClient: client,
      );
      expect(
        () => transport.send(_report()),
        throwsA(isA<FeedbackException>()),
      );
    });
  });
}

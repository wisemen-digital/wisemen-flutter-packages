import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:test/test.dart';
import 'package:wiseclient/wiseclient.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterSecureStorage.setMockInitialValues({});
  group('A group of basic tests to test functionality', () {
    final wiseOptions = WiseOptions.baseWithLocale(
      url: 'https://jsonplaceholder.typicode.com/',
      locale: 'en',
    );
    final awesome = WiseClient(
      wiseInterceptors: [WiseInterceptor.logging, WiseInterceptor.error],
      options: wiseOptions,
    );

    test('Client is native', () {
      expect(awesome.isWebClient, isFalse);
    });

    test('Expect url not to be empty', () async {
      expect(awesome.options.baseUrl, isNotEmpty);
    });

    test('Normal dio get works', () async {
      const path = 'todos/1';
      final something = await awesome.get<dynamic>(path);
      expect(something, isNotNull);
    });

    test('Normal dio post works', () async {
      const path = 'posts';
      const body = {
        'title': 'foo',
        'body': 'bar',
        'userId': 1,
      };
      final something = await awesome.post<dynamic>(
        path,
        data: body,
      );
      expect(something.data, isMap);
      expect((something.data as Map)['userId'], equals(1));
    });

    test('Wise get works', () async {
      const path = 'todos/1';
      final something = await awesome.wGet(path);
      expect(something, isMap);
    });

    test('Can add headers to requests', () async {
      const path = 'todos/1';
      const additionalHeaders = {'testHeader': 'testValue'};
      final something = await awesome.wGet(
        path,
        extraHeaders: additionalHeaders,
      );
      expect(something, isMap);
    });

    test('Does not remember headers', () async {
      const path = 'todos/1';
      const additionalHeaders1 = {'testHeader1': 'testValue1'};
      final firstResult = await awesome.wGet(
        path,
        extraHeaders: additionalHeaders1,
      );

      const additionalHeaders2 = {'testHeader2': 'testValue2'};
      final secondResult = await awesome.wGet(
        path,
        extraHeaders: additionalHeaders2,
      );
      expect(firstResult, isMap);
      expect(secondResult, isMap);
    });

    test('Wise post works', () async {
      const path = 'posts';
      const body = {
        'title': 'foo',
        'body': 'bar',
        'userId': 1,
      };
      final something = await awesome.wPost(
        path,
        body: body,
      );
      expect(something, isMap);
      expect((something as Map)['userId'], equals(1));
    });

    test('Wise get throws dio exception on non existing path', () async {
      const path = 'todos/1/notfound';
      expect(() => awesome.wGet(path), throwsA(isA<DioException>()));
    });

    test('Dio get throws dio exception on non existing path', () async {
      const path = 'todos/1/notfound';
      expect(() => awesome.get<dynamic>(path), throwsA(isA<DioException>()));
    });

    test('Cancelled token does not finish request', () async {
      const path = 'todos/1';
      dynamic response;
      try {
        Future.delayed(
          const Duration(milliseconds: 5),
          awesome.cancelAndReset,
        );
        response = await awesome.wGet(path);
      } catch (e) {
        response = e.toString();
      }
      expect(response, isA<String>());
    });

    test('Can cancel and reset successfully', () async {
      const path = 'todos/1';
      dynamic response;
      try {
        Future.delayed(
          const Duration(milliseconds: 5),
          awesome.cancelAndReset,
        );
        response = await awesome.wGet(path);
      } catch (e) {
        response = e.toString();
      }
      expect(response, isA<String>());
      await Future.delayed(
        const Duration(seconds: 2),
        () async {
          final secondRequest = await awesome.wGet(path);
          expect(secondRequest, isMap);
        },
      );
    });
  });
}

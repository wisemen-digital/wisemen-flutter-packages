import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for APIStatusApi
void main() {
  final instance = Openapi().getAPIStatusApi();

  group(APIStatusApi, () {
    //Future<GetApiInfoResponse> getApiInfo() async
    test('test getApiInfo', () async {
      // TODO
    });
  });
}

import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for GlobalSearchApi
void main() {
  final instance = Openapi().getGlobalSearchApi();

  group(GlobalSearchApi, () {
    //Future<SearchCollectionsResponse> searchCollectionsV1(SearchCollectionsFilterQuery filter, String search) async
    test('test searchCollectionsV1', () async {
      // TODO
    });
  });
}

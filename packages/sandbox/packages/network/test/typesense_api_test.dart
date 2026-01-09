import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for TypesenseApi
void main() {
  final instance = Openapi().getTypesenseApi();

  group(TypesenseApi, () {
    //Future importCollectionsV1({ BuiltList<TypesenseCollectionName> collections }) async
    test('test importCollectionsV1', () async {
      // TODO
    });

    //Future migrateCollectionsV1(bool fresh, { BuiltList<TypesenseCollectionName> collections }) async
    test('test migrateCollectionsV1', () async {
      // TODO
    });

    //Future<ViewCollectionIndexResponse> viewCollectionIndexV1() async
    test('test viewCollectionIndexV1', () async {
      // TODO
    });

    //Future viewCollectionsV1() async
    test('test viewCollectionsV1', () async {
      // TODO
    });
  });
}

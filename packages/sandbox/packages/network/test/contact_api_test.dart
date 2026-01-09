import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for ContactApi
void main() {
  final instance = Openapi().getContactApi();

  group(ContactApi, () {
    //Future<CreateContactResponse> createContactV1(CreateContactCommand createContactCommand) async
    test('test createContactV1', () async {
      // TODO
    });

    //Future deleteContactV1(String uuid) async
    test('test deleteContactV1', () async {
      // TODO
    });

    //Future updateContactV1(String uuid, UpdateContactCommand updateContactCommand) async
    test('test updateContactV1', () async {
      // TODO
    });

    //Future<ViewContactDetailResponse> viewContactDetailV1(String uuid) async
    test('test viewContactDetailV1', () async {
      // TODO
    });

    //Future<ViewContactIndexResponse> viewContactIndexV1({ PaginatedOffsetQuery pagination, BuiltList<ViewContactIndexSortQuery> sort, ViewContactIndexFilterQuery filter, String search }) async
    test('test viewContactIndexV1', () async {
      // TODO
    });
  });
}

import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for UserApi
void main() {
  final instance = Openapi().getUserApi();

  group(UserApi, () {
    //Future setUserRolesV1(String user, SetUserRolesCommand setUserRolesCommand) async
    test('test setUserRolesV1', () async {
      // TODO
    });

    //Future<ViewMeResponse> viewMeV1() async
    test('test viewMeV1', () async {
      // TODO
    });

    //Future<ViewUserDetailResponse> viewUserDetailV1(String uuid) async
    test('test viewUserDetailV1', () async {
      // TODO
    });

    //Future<ViewUserIndexResponse> viewUserIndexV1({ PaginatedOffsetQuery pagination, String search }) async
    test('test viewUserIndexV1', () async {
      // TODO
    });
  });
}

import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for RoleApi
void main() {
  final instance = Openapi().getRoleApi();

  group(RoleApi, () {
    //Future clearRolePermissionsCacheV1(ClearRolePermissionsCacheCommand clearRolePermissionsCacheCommand) async
    test('test clearRolePermissionsCacheV1', () async {
      // TODO
    });

    //Future<CreateRoleResponse> createRoleV1(CreateRoleCommand createRoleCommand) async
    test('test createRoleV1', () async {
      // TODO
    });

    //Future deleteRoleV1(String role) async
    test('test deleteRoleV1', () async {
      // TODO
    });

    //Future updateRoleV1(String role, UpdateRoleCommand updateRoleCommand) async
    test('test updateRoleV1', () async {
      // TODO
    });

    //Future updateRolesPermissionsV1(UpdateRolesPermissionsCommand updateRolesPermissionsCommand) async
    test('test updateRolesPermissionsV1', () async {
      // TODO
    });

    //Future<ViewRoleDetailResponse> viewRoleDetailV1(String role) async
    test('test viewRoleDetailV1', () async {
      // TODO
    });

    //Future<ViewRoleIndexResponse> viewRoleIndexV1() async
    test('test viewRoleIndexV1', () async {
      // TODO
    });
  });
}

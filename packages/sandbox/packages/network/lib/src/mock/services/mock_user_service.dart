import 'package:built_collection/built_collection.dart';
import 'package:openapi/openapi.dart';
import 'package:openapi/src/services/user_service.dart';

class MockUserService implements UserService {
  @override
  Future<ViewMeResponse> getMe() {
    return Future.value(
      ViewMeResponse(
        (b) => b
          ..uuid = '1234'
          ..email = 'john.doe@example.com'
          ..firstName = 'John'
          ..lastName = 'Doe'
          ..roles = ListBuilder([
            ViewRoleDetailResponse(
              (b) => b
                ..name = 'tester'
                ..isDefault = true
                ..isSystemAdmin = false
                ..uuid = '1'
                ..updatedAt = DateTime.now()
                ..createdAt = DateTime.now(),
            ),
          ]),
      ),
    );
  }
}

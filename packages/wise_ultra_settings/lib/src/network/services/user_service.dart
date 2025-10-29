import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wisecore/wisecore.dart';

import '../network.dart';

class UserService {
  const UserService({required this.ref});
  final Ref ref;

  Future<UserDTO> getMe() async {
    try {
      final result = await ref.read(Wisecore.protectedClientProvider).wGet(
            '/api/v1/customer-zone/individuals',
          );
      return UserDTO.fromJson(result as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateMe({
    required String firstName,
    required String lastName,
    DateTime? birthDate,
  }) async {
    try {
      await ref.read(Wisecore.protectedClientProvider).wPost(
        '/api/v1/customer-zone/individuals',
        body: {
          'firstName': firstName,
          'lastName': lastName,
          'birthDate': birthDate?.toIso8601String(),
        },
      );
    } catch (e) {
      rethrow;
    }
  }
}

final userServiceProvider = Provider.autoDispose(
  (ref) => UserService(ref: ref),
);

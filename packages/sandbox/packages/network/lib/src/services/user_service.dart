import '../api.dart';
import '../model/view_me_response.dart';

abstract interface class UserService {
  Future<ViewMeResponse> getMe();
}

// TODO(Y): Custom exceptions for this kind of stuff, maybe standard functions to parse responses
class UserServiceImpl implements UserService {
  UserServiceImpl(this.api);
  final Openapi api;

  @override
  Future<ViewMeResponse> getMe() async {
    final response = await api.getUserApi().viewMeV1();
    return response.data!;
  }
}

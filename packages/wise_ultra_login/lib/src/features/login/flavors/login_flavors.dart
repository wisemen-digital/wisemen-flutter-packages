import '../login.dart';

abstract interface class LoginFlavors {
  String get authenticationUrl;
  String get bundleId;
  String get clientID;
  String get organizationID;
  List<LoginMethod> get loginMethods;
  String get splashImage;
}

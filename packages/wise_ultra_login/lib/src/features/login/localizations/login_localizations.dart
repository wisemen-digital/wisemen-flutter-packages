import 'package:flutter/widgets.dart';

abstract interface class LoginLocalizations {
  String get logout;
  String get logoutWarning;
  String get cancel;

  String loginTitle(BuildContext context);
  String loginSubtitle(BuildContext context);
  String loginMethod(BuildContext context, String value);
  String email(BuildContext context);
}

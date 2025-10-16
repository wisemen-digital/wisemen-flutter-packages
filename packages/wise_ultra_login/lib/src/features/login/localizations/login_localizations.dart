import 'package:flutter/widgets.dart';

abstract interface class LoginLocalizations {
  String loginTitle(BuildContext context);
  String loginSubtitle(BuildContext context);
  String loginMethod(BuildContext context, String value);
  String email(BuildContext context);
}

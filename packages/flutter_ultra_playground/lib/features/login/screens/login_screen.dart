import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:wise_ultra_login/wise_ultra_login.dart' as login;

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const login.LoginScreen();
  }
}

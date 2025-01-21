import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sandbox/assets/assets.dart';

@RoutePage()
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        AppAssets.splashImage,
        fit: BoxFit.cover,
      ),
    );
  }
}

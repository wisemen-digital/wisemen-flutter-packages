import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wise_ultra_settings/wise_ultra_settings.dart' as settings;

@RoutePage()
class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const settings.PersonalInfoScreen();
  }
}

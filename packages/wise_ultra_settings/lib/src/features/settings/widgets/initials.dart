import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:wise_theming/wise_theming.dart';

class Initials extends StatelessWidget {
  final String firstName;
  final String lastName;

  const Initials({super.key, required this.firstName, required this.lastName});

  Initials.fromFullName({super.key, required String fullName}) : firstName = fullName.split(' ').first, lastName = fullName.split(' ').last;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.foregroundColors.secondary,
      child: Center(
        child: FractionallySizedBox(
          widthFactor: 0.5,
          heightFactor: 0.5,
          child: Center(
            child: AutoSizeText(
              '${firstName[0].toUpperCase()}${lastName.split(' ').last[0].toUpperCase()}',
              minFontSize: 1,
              maxFontSize: 500,
              style: context.title.copyWith(color: context.textColors.primaryOnBrand, fontSize: 500),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:wise_theming/wise_theming.dart';

/// Widget that displays user initials in a colored circle.
///
/// Shows the first letter of the first name and the first letter of the last name
/// in uppercase. Used as a fallback when a user's profile picture is not available.
///
/// The initials are displayed with auto-sizing text to fit the available space.
class Initials extends StatelessWidget {
  /// Creates an initials widget from first and last names.
  const Initials({required this.firstName, required this.lastName, super.key});

  /// Creates an initials widget from a full name string.
  ///
  /// Splits the full name by spaces and uses the first word as first name
  /// and the last word as last name.
  Initials.fromFullName({required String fullName, super.key})
      : firstName = fullName.split(' ').first,
        lastName = fullName.split(' ').last;

  /// User's first name.
  final String firstName;

  /// User's last name.
  final String lastName;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
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

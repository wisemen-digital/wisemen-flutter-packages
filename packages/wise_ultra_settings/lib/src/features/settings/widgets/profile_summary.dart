// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wise_theming/wise_theming.dart';
import 'package:wisewidgetslibrary/wisewidgetslibrary.dart';
import '../settings.dart';

/// Widget displaying a user profile summary card in the settings screen.
///
/// Shows the user's profile picture (or initials if no picture is available)
/// and their full name in a branded card with a partially overlapping avatar.
///
/// This widget is automatically used by [SettingsScreen] to display user
/// information at the top of the settings page.
class ProfileSummary extends ConsumerWidget {
  /// Creates a profile summary widget.
  ///
  /// The [user] parameter is required and contains the user information to display.
  const ProfileSummary({required this.user, super.key});

  /// The user whose information should be displayed.
  final User user;

  /// Profile image size
  static const double IMAGE_SIZE = 80;

  /// Profile image overlap
  static const double IMAGE_OVERLAP = 0.33;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: IMAGE_SIZE * IMAGE_OVERLAP),
          decoration: BoxDecoration(color: context.foregroundColors.brandPrimary, borderRadius: BorderRadius.circular(16)),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                padding: padHL.copyWith(top: IMAGE_SIZE * (1 - IMAGE_OVERLAP) + Sizes.xs, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      user.fullName,
                      textAlign: TextAlign.center,
                      style: context.title.copyWith(color: context.textColors.primaryOnBrand, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Center(
            child: ClipOval(
              child: SizedBox(
                width: IMAGE_SIZE,
                height: IMAGE_SIZE,
                child: NullableCachedNetworkImage(
                  imageUrl: user.profilePictureUrl,
                  errorWidget: (context, url, error) => _buildInitials(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInitials() {
    return Initials(firstName: user.firstName, lastName: user.lastName);
  }
}

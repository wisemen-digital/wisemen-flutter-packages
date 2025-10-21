import 'package:flutter/material.dart';

import '../login.dart';

/// Represents a single authentication method available for login.
///
/// Each login method has a unique identifier, display name, and type that
/// determines its behavior and visual representation in the login UI.
///
/// Example:
/// ```dart
/// final googleLogin = LoginMethod(
///   id: 'google-idp-123',
///   name: 'Google',
///   type: LoginType.google,
/// );
///
/// final customLogin = LoginMethod(
///   id: 'custom-idp-456',
///   name: 'Company SSO',
///   type: LoginType.other,
/// );
/// ```
class LoginMethod {
  /// Creates a new login method.
  ///
  /// All parameters are required.
  LoginMethod({required this.id, required this.name, required this.type});

  /// Unique identifier for this authentication method.
  ///
  /// This typically corresponds to the identity provider ID in Zitadel.
  final String id;

  /// Display name for this authentication method.
  ///
  /// This name is used for custom (LoginType.other) providers.
  /// For standard providers (Apple, Google, Email), localized names are used instead.
  final String name;

  /// The type of authentication method.
  ///
  /// Determines which icon to display and how the method is labeled in the UI.
  final LoginType type;

  /// Gets the localized display title for this login method.
  ///
  /// For standard login types (Apple, Google, Email), returns localized strings.
  /// For custom login types (LoginType.other), returns the [name] field.
  ///
  /// Parameters:
  /// - [context]: Build context used for localization lookups
  ///
  /// Returns a user-friendly display name for the login method.
  String getTitle(BuildContext context) {
    switch (type) {
      case LoginType.apple:
        return 'Apple';
      case LoginType.google:
        return 'Google';
      case LoginType.email:
        return LoginFeature.localizations.email(context);
      case LoginType.other:
        return name;
    }
  }

  /// Gets the asset path for the icon associated with this login method.
  ///
  /// Returns the appropriate SVG icon path based on the login type:
  /// - Apple: Apple logo
  /// - Google: Google logo
  /// - Email: Email icon
  /// - Other: null (no icon)
  ///
  /// Returns null for custom login methods (LoginType.other).
  String? getIconAsset() {
    switch (type) {
      case LoginType.apple:
        return LoginFeature.assets.apple;
      case LoginType.google:
        return LoginFeature.assets.google;
      case LoginType.email:
        return LoginFeature.assets.email;
      case LoginType.other:
        return null;
    }
  }
}

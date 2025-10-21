import 'package:flutter/widgets.dart';

/// Interface for providing localized strings used in the login feature.
///
/// Implementations of this interface supply all user-facing text for the
/// login UI, allowing for internationalization and customization.
///
/// Example implementation:
/// ```dart
/// class AppLoginLocalizations implements LoginLocalizations {
///   @override
///   String get logout => 'Log Out';
///
///   @override
///   String get logoutWarning => 'Are you sure you want to log out?';
///
///   @override
///   String get cancel => 'Cancel';
///
///   @override
///   String loginTitle(BuildContext context) => 'Welcome';
///
///   @override
///   String loginSubtitle(BuildContext context) => 'Sign in to continue';
///
///   @override
///   String loginMethod(BuildContext context, String value) => 'Sign in with $value';
///
///   @override
///   String email(BuildContext context) => 'Email';
/// }
/// ```
abstract interface class LoginLocalizations {
  /// Text for the logout button or action.
  ///
  /// Example: 'Log Out', 'Sign Out', 'Logout'
  String get logout;

  /// Warning message shown in the logout confirmation dialog.
  ///
  /// Example: 'Are you sure you want to log out?'
  String get logoutWarning;

  /// Text for the cancel button in dialogs.
  ///
  /// Example: 'Cancel', 'No', 'Go Back'
  String get cancel;

  /// Main title text displayed at the top of the login screen.
  ///
  /// Parameters:
  /// - [context]: Build context for accessing localization resources
  ///
  /// Example: 'Welcome', 'Sign In', 'Login'
  String loginTitle(BuildContext context);

  /// Subtitle text displayed below the title on the login screen.
  ///
  /// Parameters:
  /// - [context]: Build context for accessing localization resources
  ///
  /// Example: 'Choose your sign-in method', 'Sign in to continue'
  String loginSubtitle(BuildContext context);

  /// Template for login button text, incorporating the method name.
  ///
  /// Parameters:
  /// - [context]: Build context for accessing localization resources
  /// - [value]: The name of the login method (e.g., 'Google', 'Apple')
  ///
  /// Example: 'Sign in with $value', 'Continue with $value'
  String loginMethod(BuildContext context, String value);

  /// Localized text for 'Email' as a login method.
  ///
  /// Parameters:
  /// - [context]: Build context for accessing localization resources
  ///
  /// Example: 'Email', 'Email Address', 'E-mail'
  String email(BuildContext context);
}

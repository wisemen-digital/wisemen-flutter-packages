import 'package:wiseclient/wiseclient.dart';

import '../login.dart';

/// Abstract interface defining the contract for authentication operations.
///
/// Implementations of this interface handle OAuth2/OIDC authentication flows,
/// token management, and session lifecycle. The default implementation
/// ([BaseLoginRepository]) integrates with Zitadel for authentication.
///
/// Custom implementations can be provided during [LoginFeature.init] to
/// support different authentication backends or to add custom behavior.
///
/// Example custom implementation:
/// ```dart
/// class CustomLoginRepository implements LoginRepository {
///   @override
///   List<LoginMethod> getSupportedLoginMethods() {
///     return [
///       LoginMethod(id: '1', name: 'Custom', type: LoginType.other),
///     ];
///   }
///
///   @override
///   Future<void> login(LoginMethod method) async {
///     // Custom login logic
///   }
///
///   // ... implement other methods
/// }
/// ```
abstract interface class LoginRepository {
  /// Returns the list of authentication methods available for login.
  ///
  /// This list is typically configured in [LoginFlavors.loginMethods] and
  /// determines which login buttons are displayed in the UI.
  ///
  /// Returns a list of [LoginMethod] objects representing available authentication options.
  List<LoginMethod> getSupportedLoginMethods();

  /// Initiates the OAuth2 authorization flow for the specified login method.
  ///
  /// This method:
  /// 1. Constructs the OAuth2 authorization request with appropriate scopes
  /// 2. Launches the browser or in-app browser for authentication
  /// 3. Handles the redirect callback with the authorization code
  /// 4. Exchanges the code for access and refresh tokens
  /// 5. Stores the tokens securely
  /// 6. Registers the tokens with the HTTP client for API requests
  ///
  /// Parameters:
  /// - [method]: The authentication method to use
  ///
  /// Throws [Exception] if the authentication flow fails or is cancelled by the user.
  Future<void> login(LoginMethod method);

  /// Ends the current user session and revokes all tokens.
  ///
  /// This method:
  /// 1. Retrieves the current ID token from secure storage
  /// 2. Calls the Zitadel end session endpoint
  /// 3. Revokes the refresh token if available
  /// 4. Clears all stored tokens
  /// 5. Removes tokens from the HTTP client
  ///
  /// Throws [Exception] if logout fails, though tokens are cleared regardless.
  Future<void> logout();

  /// Refreshes an expired access token using the refresh token.
  ///
  /// This method is typically called automatically by the HTTP client when
  /// it receives a 401 or 400 response indicating token expiration.
  ///
  /// Parameters:
  /// - [token]: The current OAuth2Token containing the refresh token
  ///
  /// Returns a new [OAuth2Token] with fresh access and ID tokens.
  ///
  /// Throws [Exception] if the refresh fails (e.g., refresh token is invalid or expired).
  Future<OAuth2Token> refresh(OAuth2Token? token);
}

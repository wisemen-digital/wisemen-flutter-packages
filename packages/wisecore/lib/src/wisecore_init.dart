import 'package:riverpod/riverpod.dart';
import 'package:wiseclient/wiseclient.dart';

/// Wisecore base class
class Wisecore {
  /// Core protected client
  static late Provider<WiseClient> protectedClientProvider;

  /// Initializer for the core
  // ignore: use_setters_to_change_properties
  static void init({
    required Provider<WiseClient> protectedClientProvider,
  }) {
    Wisecore.protectedClientProvider = protectedClientProvider;
  }
}

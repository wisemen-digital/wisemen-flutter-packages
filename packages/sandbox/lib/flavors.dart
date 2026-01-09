import 'package:flutter_dotenv/flutter_dotenv.dart';

enum Flavor { DEVELOPMENT, STAGING, QA, PRODUCTION }

class F {
  static Flavor? appFlavor;

  static String get appName {
    switch (appFlavor) {
      case Flavor.DEVELOPMENT:
        return 'Sandbox Development';
      case Flavor.STAGING:
        return 'Sandbox Staging';
      case Flavor.QA:
        return 'Sandbox QA';
      case Flavor.PRODUCTION:
        return 'Sandbox';
      default:
        return 'Sandbox';
    }
  }

  static String get baseUrl => dotenv.get('BASE_URL');

  static String get clientId => dotenv.get('CLIENT_ID');

  static String get clientSecret => dotenv.get('CLIENT_SECRET');

  static String? get bannerName {
    switch (appFlavor) {
      case Flavor.DEVELOPMENT:
        return 'DEV';
      case Flavor.STAGING:
        return 'STAGING';
      case Flavor.QA:
        return 'QA';
      case Flavor.PRODUCTION:
        return null;
      default:
        return null;
    }
  }

  static String get name => appFlavor?.name ?? '';
}

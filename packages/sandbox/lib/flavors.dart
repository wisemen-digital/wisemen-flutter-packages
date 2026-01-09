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

  static String get zitadelBaseUrl => dotenv.get('AUTH_BASE_URL');

  static String get clientId => dotenv.get('CLIENT_ID');

  static String get zitadelAppId => dotenv.get('AUTH_APPLICATION_ID');

  static String get zitadelOrganizationId => dotenv.get('AUTH_ORGANIZATION_ID');

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

  static String get bundleId {
    switch (appFlavor) {
      case Flavor.DEVELOPMENT:
        return 'com.wisemen.app.development';
      case Flavor.STAGING:
        return 'com.wisemen.app.staging';
      case Flavor.QA:
        return 'com.wisemen.app.qa';
      case Flavor.PRODUCTION:
        return 'com.wisemen.app';
      default:
        return 'com.wisemen.app.development';
    }
  }

  static String get name => appFlavor?.name ?? '';
}

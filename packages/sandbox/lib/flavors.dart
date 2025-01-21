enum Flavor {
  DEVELOPMENT,
  STAGING,
  QA,
  PRODUCTION,
}

class F {
  static Flavor? appFlavor;

  static String get appName {
    switch (appFlavor) {
      case Flavor.DEVELOPMENT:
        return 'Sanbox Development';
      case Flavor.STAGING:
        return 'Sanbox Staging';
      case Flavor.QA:
        return 'Sanbox QA';
      case Flavor.PRODUCTION:
        return 'Sanbox';
      default:
        return 'Sanbox';
    }
  }

  static String get baseUrl {
    switch (appFlavor) {
      case Flavor.DEVELOPMENT:
      case Flavor.STAGING:
      case Flavor.QA:
      case Flavor.PRODUCTION:
      case null:
        return 'https://jsonplaceholder.typicode.com/';
    }
  }

  static String get clientId {
    switch (appFlavor) {
      case Flavor.DEVELOPMENT:
      case Flavor.STAGING:
      case Flavor.QA:
      case Flavor.PRODUCTION:
      case null:
        return 'null';
    }
  }

  static String get clientSecret {
    switch (appFlavor) {
      case Flavor.DEVELOPMENT:
      case Flavor.STAGING:
      case Flavor.QA:
      case Flavor.PRODUCTION:
      case null:
        return 'null';
    }
  }

  static String? get onesignalKey {
    switch (appFlavor) {
      case Flavor.DEVELOPMENT:
      case Flavor.STAGING:
      case Flavor.QA:
      case Flavor.PRODUCTION:
      case null:
        return null;
    }
  }

  static String? get sentryDsn {
    switch (appFlavor) {
      case Flavor.DEVELOPMENT:
      case Flavor.STAGING:
      case Flavor.QA:
      case Flavor.PRODUCTION:
      case null:
        return null;
    }
  }

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

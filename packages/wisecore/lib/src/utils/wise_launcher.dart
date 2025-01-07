import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart' as ul;

/// [WiseLauncher] class to handle url launcher errors etc.
class WiseLauncher {
  /// Launches a url on the device's default browser.
  static Future<void> launchUrl({
    required String url,
    required VoidCallback onCannotLaunchUrl,
    bool isPlatformDefault = true,
  }) async {
    final uri = Uri.tryParse(url);
    if (uri != null) {
      await ul.canLaunchUrl(uri).then((canLaunch) async {
        if (canLaunch) {
          await ul.launchUrl(
            uri,
            mode: isPlatformDefault
                ? ul.LaunchMode.platformDefault
                : ul.LaunchMode.externalApplication,
          );
        } else {
          onCannotLaunchUrl();
        }
      });
    } else {
      onCannotLaunchUrl();
    }
  }

  /// Opens email app with email as receiver
  static Future<void> launchEmail({
    required String email,
    String? subject,
    String? body,
  }) async {
    final emailLaunchUri = Uri(
      queryParameters: {
        'subject': subject,
        'body': body,
      },
      scheme: 'mailto',
      path: email,
    );
    await ul.launchUrl(emailLaunchUri);
  }

  /// Opens phone app with phone number
  static Future<void> launchPhone({required String phoneNr}) async {
    final phoneLaunchUri = Uri(
      scheme: 'tel',
      path: phoneNr,
    );
    await ul.launchUrl(phoneLaunchUri);
  }

  /// Opens map app with search query
  static Future<void> launchMap({required String name}) async {
    await ul.launchUrl(_createQueryUri(name));
  }

  /// Returns a [Uri] that can be launched on the current platform
  /// to open a maps application showing the result of a search query.
  static Uri _createQueryUri(String query) {
    Uri uri;

    if (kIsWeb) {
      uri = Uri.https(
        'www.google.com',
        '/maps/search/',
        {'api': '1', 'query': query},
      );
    } else if (Platform.isAndroid) {
      uri = Uri(scheme: 'geo', host: '0,0', queryParameters: {'q': query});
    } else if (Platform.isIOS) {
      uri = Uri.https('maps.apple.com', '/', {'q': query});
    } else {
      uri = Uri.https(
        'www.google.com',
        '/maps/search/',
        {'api': '1', 'query': query},
      );
    }

    return uri;
  }
}

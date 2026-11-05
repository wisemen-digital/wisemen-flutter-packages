import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'signing_controller.dart';

/// Formats the metadata shown below the signature.
extension SigningMetadata on SigningController {
  /// The trimmed name and first-ink time, joined by " · ".
  ///
  /// [pattern] is an `intl` date pattern; null uses the locale's short date
  /// and 24-hour time.
  String metadataLabel(Locale locale, String? pattern) {
    final time = signedAt;
    final name = signerName.trim();
    final format = pattern == null
        ? DateFormat.yMd(locale.toString()).add_Hm()
        : DateFormat(pattern, locale.toString());
    return [
      if (name.isNotEmpty) name,
      if (time != null) format.format(time),
    ].join(' · ');
  }
}

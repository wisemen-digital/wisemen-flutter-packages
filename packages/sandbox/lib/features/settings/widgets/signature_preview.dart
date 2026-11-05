import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sandbox/generated/l10n.dart';
import 'package:wise_theming/wise_theming.dart';
import 'package:wisewidgetslibrary/wisewidgetslibrary.dart';

/// App-side preview of a submitted signature and its metadata.
class SignaturePreview extends StatelessWidget {
  /// Creates a preview of [result].
  const SignaturePreview({super.key, required this.result});

  /// The submitted signature.
  final SigningResult result;

  static const _imageHeight = 120.0;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final time = DateFormat.yMd(
      Localizations.localeOf(context).toString(),
    ).add_Hm().format(result.signedAt);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: Sizes.s,
      children: [
        Text(s.signatureDemoPreview, style: context.body),
        Text(
          s.signatureDemoMetadata(result.signerName, time),
          style: context.body,
        ),
        SizedBox(
          height: _imageHeight,
          child: ColoredBox(
            color: context.backgroundColors.secondary,
            child: Image.memory(result.pngBytes),
          ),
        ),
      ],
    );
  }
}

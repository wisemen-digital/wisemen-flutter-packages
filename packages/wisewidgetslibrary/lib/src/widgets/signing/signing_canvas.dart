import 'package:flutter/material.dart';

import '../../constants/app_sizes.dart';
import 'signature_pad.dart';
import 'signing_controller.dart';
import 'signing_metadata.dart';
import 'signing_strings.dart';
import 'signing_style.dart';

/// Signature card with the signer's name and first-ink time below the drawing,
/// and the signature validation error below the card.
///
/// Strokes, name and time live in [controller], so the same controller can move
/// between a `SigningField` and a standalone canvas, for example when rotating.
/// The drawing keeps its first canvas size and is scaled uniformly and centered
/// in a canvas of a different shape; it is never stretched or cropped.
class SigningCanvas extends StatelessWidget {
  /// Creates the signature card of [controller].
  const SigningCanvas({
    required this.controller,
    required this.strings,
    this.decoration,
    this.metadataStyle,
    this.timestampFormat,
    this.fillHeight = false,
    super.key,
  });

  /// Signing state that owns the drawing and metadata.
  final SigningController controller;

  /// Canvas label and error text.
  final SigningStrings strings;

  /// Card fill, border and corners. Defaults to white paper with the Material
  /// outline. Keep the surface light enough for black signature ink.
  final BoxDecoration? decoration;

  /// Metadata typography and color. Defaults to the theme's label style in a
  /// muted ink color that stays readable on the paper in dark mode.
  final TextStyle? metadataStyle;

  /// Optional `intl` pattern, for example `dd/MM/yyyy HH:mm`.
  /// Only changes presentation; the controller's timestamp is unchanged.
  final String? timestampFormat;

  /// Whether the card fills the height its parent gives it, instead of using
  /// the default 380:144 drawing area. Requires a bounded height, for example
  /// inside `Expanded`.
  final bool fillHeight;

  static const _aspectRatio = 380 / 144;
  static const _radius = BorderRadius.all(Radius.circular(12));
  static const _metadataPadding = EdgeInsetsDirectional.fromSTEB(20, 0, 20, 10);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = fillHeight ? MainAxisSize.max : MainAxisSize.min;
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        final pad = Semantics(
          label: strings.signHere,
          child: SignaturePad(controller: controller.signatureController),
        );
        final card = DecoratedBox(
          decoration:
              decoration ??
              BoxDecoration(
                color: signingPaperColor,
                border: Border.all(color: theme.colorScheme.outlineVariant),
                borderRadius: _radius,
              ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: size,
            children: [
              if (fillHeight)
                Expanded(child: pad)
              else
                AspectRatio(aspectRatio: _aspectRatio, child: pad),
              Padding(
                padding: _metadataPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Divider(height: 1, color: signingRuleColor),
                    gapHS,
                    Text(
                      controller.metadataLabel(
                        Localizations.localeOf(context),
                        timestampFormat,
                      ),
                      style:
                          metadataStyle ??
                          theme.textTheme.labelMedium?.copyWith(
                            color: signingMutedInkColor,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
        final error = Semantics(
          liveRegion: true,
          child: Text(
            strings.signatureRequired,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.error,
            ),
          ),
        );
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: size,
          spacing: signingSectionGap,
          children: [
            if (fillHeight) Expanded(child: card) else card,
            // A filled pad must not resize when the error clears on the first
            // stroke movement: SignaturePad ends a stroke whose canvas resizes.
            if (fillHeight)
              Visibility(
                visible: controller.showsSignatureError,
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: error,
              )
            else if (controller.showsSignatureError)
              error,
          ],
        );
      },
    );
  }
}

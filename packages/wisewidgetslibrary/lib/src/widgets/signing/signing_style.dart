import 'package:flutter/material.dart';

import 'signature_stroke.dart';

/// Gap between the field's sections and between the card and its error.
const signingSectionGap = 12.0;

/// Default paper behind the ink. It stays light in dark mode because the ink
/// is always black, so the card's own colors derive from the ink, not the theme.
const signingPaperColor = Colors.white;

/// Rule above the metadata on the paper.
final signingRuleColor = signatureInkColor.withValues(alpha: .12);

/// Muted metadata text on the paper.
final signingMutedInkColor = signatureInkColor.withValues(alpha: .54);

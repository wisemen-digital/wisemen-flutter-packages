// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

/// Constant sizes to be used in the app (paddings, gaps, rounded corners etc.)
class Sizes {
  static const xs = 4.0;
  static const s = 8.0;
  static const m = 16.0;
  static const l = 32.0;
  static const xl = 64.0;
}

/// Constant gap widths
const gapXS = SizedBox(width: Sizes.xs);
const gapS = SizedBox(width: Sizes.s);
const gapM = SizedBox(width: Sizes.m);
const gapL = SizedBox(width: Sizes.l);
const gapXL = SizedBox(width: Sizes.xl);

/// Constant gap heights
const gapHXs = SizedBox(height: Sizes.xs);
const gapHS = SizedBox(height: Sizes.s);
const gapHM = SizedBox(height: Sizes.m);
const gapHL = SizedBox(height: Sizes.l);
const gapHXL = SizedBox(height: Sizes.xl);

/// Constant gaps
const gapBottom = SizedBox(height: Sizes.l);

/// Constant padding all
const pad0 = EdgeInsets.zero;
const padXS = EdgeInsets.all(Sizes.xs);
const padS = EdgeInsets.all(Sizes.s);
const padM = EdgeInsets.all(Sizes.m);
const padL = EdgeInsets.all(Sizes.l);
const padXL = EdgeInsets.all(Sizes.xl);

/// Constant padding vertical
const padVXS = EdgeInsets.symmetric(vertical: Sizes.xs);
const padVS = EdgeInsets.symmetric(vertical: Sizes.s);
const padVM = EdgeInsets.symmetric(vertical: Sizes.m);
const padVL = EdgeInsets.symmetric(vertical: Sizes.l);
const padVXL = EdgeInsets.symmetric(vertical: Sizes.xl);

/// Constant padding horizontal
const padHXS = EdgeInsets.symmetric(horizontal: Sizes.xs);
const padHS = EdgeInsets.symmetric(horizontal: Sizes.s);
const padHM = EdgeInsets.symmetric(horizontal: Sizes.m);
const padHL = EdgeInsets.symmetric(horizontal: Sizes.l);
const padHXL = EdgeInsets.symmetric(horizontal: Sizes.xl);

/// Constant border radius
const radXS = BorderRadius.all(Radius.circular(Sizes.xs));
const radS = BorderRadius.all(Radius.circular(Sizes.s));
const radM = BorderRadius.all(Radius.circular(Sizes.m));
const radL = BorderRadius.all(Radius.circular(Sizes.l));
const radXL = BorderRadius.all(Radius.circular(Sizes.xl));

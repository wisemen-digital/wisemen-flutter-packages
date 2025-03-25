import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wisewidgetslibrary/src/constants/app_sizes.dart';

void main() {
  test('Sizes constants', () {
    expect(Sizes.xs, 4.0);
    expect(Sizes.s, 8.0);
    expect(Sizes.m, 16.0);
    expect(Sizes.l, 32.0);
    expect(Sizes.xl, 64.0);
  });

  test('Gap constants', () {
    expect(gapWXS.width, Sizes.xs);
    expect(gapWS.width, Sizes.s);
    expect(gapWM.width, Sizes.m);
    expect(gapWL.width, Sizes.l);
    expect(gapWXL.width, Sizes.xl);

    expect(gapHXs.height, Sizes.xs);
    expect(gapHS.height, Sizes.s);
    expect(gapHM.height, Sizes.m);
    expect(gapHL.height, Sizes.l);
    expect(gapHXL.height, Sizes.xl);
  });

  test('Padding constants', () {
    expect(pad0, EdgeInsets.zero);
    expect(padXS, const EdgeInsets.all(Sizes.xs));
    expect(padS, const EdgeInsets.all(Sizes.s));
    expect(padM, const EdgeInsets.all(Sizes.m));
    expect(padL, const EdgeInsets.all(Sizes.l));
    expect(padXL, const EdgeInsets.all(Sizes.xl));

    expect(padVXS, const EdgeInsets.symmetric(vertical: Sizes.xs));
    expect(padVS, const EdgeInsets.symmetric(vertical: Sizes.s));
    expect(padVM, const EdgeInsets.symmetric(vertical: Sizes.m));
    expect(padVL, const EdgeInsets.symmetric(vertical: Sizes.l));
    expect(padVXL, const EdgeInsets.symmetric(vertical: Sizes.xl));

    expect(padHXS, const EdgeInsets.symmetric(horizontal: Sizes.xs));
    expect(padHS, const EdgeInsets.symmetric(horizontal: Sizes.s));
    expect(padHM, const EdgeInsets.symmetric(horizontal: Sizes.m));
    expect(padHL, const EdgeInsets.symmetric(horizontal: Sizes.l));
    expect(padHXL, const EdgeInsets.symmetric(horizontal: Sizes.xl));
  });

  test('Border radius constants', () {
    expect(radXS, const BorderRadius.all(Radius.circular(Sizes.xs)));
    expect(radS, const BorderRadius.all(Radius.circular(Sizes.s)));
    expect(radM, const BorderRadius.all(Radius.circular(Sizes.m)));
    expect(radL, const BorderRadius.all(Radius.circular(Sizes.l)));
    expect(radXL, const BorderRadius.all(Radius.circular(Sizes.xl)));
  });
}

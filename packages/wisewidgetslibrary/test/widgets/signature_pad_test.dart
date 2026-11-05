import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wisewidgetslibrary/wisewidgetslibrary.dart';

import '../fixtures/signature_android_line.dart';

const _boundaryKey = ValueKey('signature pixels');

void main() {
  late SignatureController controller;

  setUp(() => controller = SignatureController());
  tearDown(() => controller.dispose());

  testWidgets('draws, notifies, counts distinct points and clears', (
    tester,
  ) async {
    var changes = 0;
    controller.addListener(() => changes++);
    expect(controller.isEmpty, isTrue);
    expect(await controller.toPngBytes(), isNull);
    await _mount(tester, controller);

    final finger = await tester.startGesture(const Offset(20, 30));
    await finger.moveTo(const Offset(80, 50));
    await finger.moveTo(const Offset(80, 50));
    expect(controller.strokeCount, 1);
    expect(controller.pointCount, 2);
    await finger.up();
    await tester.tapAt(const Offset(100, 70));
    expect(controller.strokeCount, 2);
    expect(controller.pointCount, 3);
    expect(controller.isEmpty, isFalse);
    expect(changes, 3);
    await tester.pump();
    expect((await _display(tester)).inkBounds, isNotNull);

    controller.clear();
    await tester.pump();
    expect(controller.isEmpty, isTrue);
    expect(controller.strokeCount, 0);
    expect(controller.pointCount, 0);
    expect(changes, 4);
    expect((await _display(tester)).inkBounds, isNull);
    expect(await controller.toPngBytes(), isNull);
  });

  testWidgets('separate pads keep their drawing and clearing independent', (
    tester,
  ) async {
    final other = SignatureController();
    addTearDown(other.dispose);
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Align(
          alignment: Alignment.topLeft,
          child: Row(
            children: [
              SizedBox(
                width: 200,
                height: 100,
                child: SignaturePad(controller: controller),
              ),
              SizedBox(
                width: 200,
                height: 100,
                child: SignaturePad(controller: other),
              ),
            ],
          ),
        ),
      ),
    );
    await tester.tapAt(const Offset(20, 30));
    expect(other.isEmpty, isTrue);
    await tester.tapAt(const Offset(220, 40));
    controller.clear();
    expect(controller.isEmpty, isTrue);
    expect(other.pointCount, 1);
    expect(await _export(tester, other), isNotNull);
  });

  testWidgets(
    'PNG is transparent, contains the drawing and matches displayed pixels',
    (tester) async {
      await _mount(tester, controller);
      await _draw(tester, const [
        Offset(20, 30),
        Offset(100, 30),
        Offset(100, 70),
      ]);
      await tester.pump();
      final display = await _display(tester);
      final png = (await _export(tester, controller))!;
      expect(png.width, 200);
      expect(png.height, 100);
      expect(png.alphaAt(0, 0), 0);
      expect(png.alphaAt(50, 30), 255);
      expect(png.inkBounds, isNotNull);
      expect(png.bytes, display.bytes);
    },
  );

  testWidgets('a sharp retrace retains the actual tip and continuous ink', (
    tester,
  ) async {
    await _mount(tester, controller);
    await _draw(tester, const [
      Offset(20, 40),
      Offset(100, 40),
      Offset(20, 40),
    ]);
    await tester.pump();
    final png = (await _export(tester, controller))!;
    expect(png.inkBounds!.right, greaterThan(100));
    for (var x = 20; x <= 100; x++) {
      expect(png.alphaAt(x, 40), greaterThan(0));
    }
    expect(png.bytes, (await _display(tester)).bytes);
  });

  testWidgets(
    'subpixel backwards jitter is smoothed instead of preserved as tips',
    (tester) async {
      await _mount(tester, controller);
      final samples = List.generate(
        451,
        (i) => Offset(20 + i * .35, 50 + (i.isEven ? -.7 : .7)),
      );
      await _draw(tester, samples);
      await tester.pump();
      final png = (await _export(tester, controller))!;
      var error = 0.0;
      for (var x = 40; x < 160; x++) {
        error += (png.columnCenter(x) - 49.5).abs();
      }
      expect(error / 120, lessThan(.08));
      expect(png.columnInk(100), lessThan(2.3));
      expect(controller.pointCount, samples.length);
      expect(png.bytes, (await _display(tester)).bytes);
    },
  );

  testWidgets(
    'dense deliberate tips, short strokes and the live endpoint stay visible',
    (tester) async {
      await _mount(tester, controller);
      await _draw(tester, [
        for (var x = 20; x <= 100; x++) Offset(x.toDouble(), 30),
        for (var x = 99; x >= 20; x--) Offset(x.toDouble(), 30),
      ]);
      await _draw(tester, const [
        Offset(40, 70),
        Offset(42, 70),
        Offset(40, 70),
      ]);
      await _draw(tester, const [
        Offset(60, 70),
        Offset(61, 70),
        Offset(62, 70),
        Offset(63, 70),
      ]);
      final finger = await tester.startGesture(const Offset(130, 60));
      await finger.moveTo(const Offset(170, 60));
      final png = (await _export(tester, controller))!;
      expect(png.alphaAt(100, 30), greaterThan(0));
      expect(png.alphaAt(42, 70), greaterThan(0));
      expect(png.alphaAt(60, 70), greaterThan(0));
      expect(png.alphaAt(63, 70), greaterThan(0));
      expect(png.alphaAt(170, 60), greaterThan(0));
      await finger.cancel();
      expect((await _export(tester, controller))!.bytes, png.bytes);
    },
  );

  testWidgets('a straight path stays centered with uneven input density', (
    tester,
  ) async {
    await _mount(tester, controller);
    await _draw(tester, [
      const Offset(20, 30),
      for (var i = 0; i <= 100; i++) Offset(70 + i / 100, 30),
      const Offset(100, 30),
      const Offset(180, 30),
    ]);
    final png = (await _export(tester, controller))!;
    for (var x = 22; x < 179; x++) {
      expect(png.columnCenter(x), closeTo(29.5, .08));
      expect(png.columnInk(x), greaterThan(0));
    }
  });

  testWidgets(
    'replays a recorded native Android trace with matching screen and PNG',
    (tester) async {
      await _mount(
        tester,
        controller,
        size: const Size(379.42857142857144, 189.71428571428572),
      );
      final (x, y, _) = androidLineSamples.first;
      final finger = await tester.startGesture(Offset(x, y));
      for (final (x, y, micros) in androidLineSamples.skip(1)) {
        await finger.moveTo(
          Offset(x, y),
          timeStamp: Duration(microseconds: micros),
        );
      }
      await finger.up();
      await tester.pump();
      final png = (await _export(tester, controller))!;
      expect(controller.pointCount, 93);
      expect(png.width, 380);
      expect(png.height, 190);
      expect(png.alphaAt(0, 0), 0);
      expect(png.alphaAt(x.floor(), y.floor()), greaterThan(0));
      final (lastX, lastY, _) = androidLineSamples.last;
      expect(png.alphaAt(lastX.floor(), lastY.floor()), greaterThan(0));
      expect(png.bytes, (await _display(tester)).bytes);
    },
  );

  testWidgets('a dense event cluster does not pull a curved path sideways', (
    tester,
  ) async {
    await _mount(tester, controller);
    final uniform = List.generate(41, (i) {
      final x = 50 + i * .5;
      return Offset(x, 35 + (x - 60) * (x - 60) / 8);
    });
    final clustered = [
      ...uniform.take(17),
      for (var i = 1; i < 100; i++)
        Offset.lerp(uniform[16], uniform[17], i / 100)!,
      ...uniform.skip(17),
    ];
    final images = <_Raster>[];
    for (final samples in [uniform, clustered]) {
      controller.clear();
      final finger = await tester.startGesture(samples.first);
      for (var i = 1; i < samples.length; i++) {
        await finger.moveTo(
          samples[i],
          timeStamp: Duration(milliseconds: i * 60),
        );
      }
      await finger.up();
      images.add((await _export(tester, controller))!);
    }
    for (var x = 54; x <= 66; x++) {
      expect(
        images.first.columnCenter(x),
        closeTo(images.last.columnCenter(x), .15),
      );
    }
  });

  testWidgets('a tap exports a visible dot', (tester) async {
    await _mount(tester, controller);
    await tester.tapAt(const Offset(40, 40));
    final png = (await _export(tester, controller))!;
    expect(png.alphaAt(40, 40), greaterThan(0));
    expect(controller.strokeCount, 1);
    expect(controller.pointCount, 1);
  });

  testWidgets('faster writing is thinner and width transitions are gradual', (
    tester,
  ) async {
    await _mount(tester, controller);
    await _timedLine(tester, const Duration(milliseconds: 40));
    final slow = (await _export(tester, controller))!;
    controller.clear();
    await _timedLine(tester, const Duration(milliseconds: 2));
    final fast = (await _export(tester, controller))!;
    expect(slow.columnInk(140), greaterThan(fast.columnInk(140) * 1.5));
    for (var x = 30; x < 170; x++) {
      expect((fast.columnInk(x + 1) - fast.columnInk(x)).abs(), lessThan(1));
      expect(fast.columnInk(x), greaterThan(0));
    }
  });

  testWidgets('short curves keep endpoints and export exactly as displayed', (
    tester,
  ) async {
    await _mount(tester, controller);
    final finger = await tester.startGesture(const Offset(30, 70));
    await finger.moveTo(
      const Offset(70, 20),
      timeStamp: const Duration(milliseconds: 20),
    );
    await finger.moveTo(
      const Offset(110, 70),
      timeStamp: const Duration(milliseconds: 50),
    );
    await finger.moveTo(
      const Offset(150, 20),
      timeStamp: const Duration(milliseconds: 60),
    );
    await finger.up();
    await tester.pump();
    final png = (await _export(tester, controller))!;
    expect(png.alphaAt(30, 70), greaterThan(0));
    expect(png.alphaAt(150, 20), greaterThan(0));
    expect(png.bytes, (await _display(tester)).bytes);
    expect(png.inkBounds!.left, greaterThan(27));
    expect(png.inkBounds!.right, lessThan(153));
  });

  testWidgets(
    'duplicate points and unusual clocks keep short strokes visible and bounded',
    (tester) async {
      await _mount(tester, controller);
      final finger = await tester.startGesture(const Offset(30, 50));
      await finger.moveTo(
        const Offset(30, 50),
        timeStamp: const Duration(seconds: 1),
      );
      expect(controller.pointCount, 1);
      await finger.moveTo(const Offset(31, 50));
      await finger.moveTo(
        const Offset(32, 50),
        timeStamp: const Duration(microseconds: -1),
      );
      await finger.moveTo(
        const Offset(33, 50),
        timeStamp: const Duration(microseconds: 1),
      );
      await finger.moveTo(
        const Offset(34, 50),
        timeStamp: const Duration(seconds: 5),
      );
      await finger.cancel();
      final png = (await _export(tester, controller))!;
      expect(controller.pointCount, 5);
      expect(png.inkBounds!.height, lessThanOrEqualTo(6));
      for (var x = 30; x <= 34; x++) {
        expect(png.alphaAt(x, 50), greaterThan(0));
      }
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'portrait/landscape resizing preserves every stroke and its proportions',
    (tester) async {
      await _mount(tester, controller, size: const Size(120, 240));
      await _draw(tester, const [
        Offset(1, 1),
        Offset(118, 1),
        Offset(118, 238),
        Offset(1, 238),
        Offset(1, 1),
      ]);
      await tester.tapAt(const Offset(60, 120));
      await tester.pump();
      final original = await _display(tester);
      final exportBefore = (await _export(tester, controller))!;

      await _mount(tester, controller, size: const Size(300, 120));
      final resized = await _display(tester);
      // The 120x240 canvas fits into 60x120, centered at x=120.
      expect(resized.inkBounds!.left, closeTo(120.5, 1));
      expect(resized.inkBounds!.right, closeTo(179.5, 1));
      expect(resized.inkBounds!.top, closeTo(0.5, 1));
      expect(resized.inkBounds!.bottom, closeTo(119.5, 1));
      expect(resized.alphaAt(150, 60), greaterThan(0));
      expect(resized.alphaAt(121, 60), greaterThan(0));
      expect(resized.alphaAt(178, 60), greaterThan(0));
      expect(resized.alphaAt(150, 1), greaterThan(0));
      expect(resized.alphaAt(150, 118), greaterThan(0));
      expect((await _export(tester, controller))!.bytes, exportBefore.bytes);

      await _mount(tester, controller, size: const Size(120, 240));
      expect((await _display(tester)).bytes, original.bytes);
      expect(controller.strokeCount, 2);
      expect(controller.pointCount, 6);
    },
  );

  testWidgets('new points after resizing map into the original canvas', (
    tester,
  ) async {
    await _mount(tester, controller, size: const Size(100, 200));
    await tester.tapAt(const Offset(50, 50));
    await _mount(tester, controller);
    await tester.tapAt(const Offset(20, 50)); // Outside the fitted canvas.
    expect(controller.strokeCount, 1);
    await _draw(tester, const [Offset(90, 60), Offset(110, 60)]);
    final png = (await _export(tester, controller))!;
    expect(png.alphaAt(50, 50), greaterThan(0));
    expect(png.alphaAt(50, 120), greaterThan(0));
    expect(controller.strokeCount, 2);
  });

  testWidgets('ignores additional fingers and keeps cancelled strokes', (
    tester,
  ) async {
    await _mount(tester, controller);
    final first = await tester.startGesture(const Offset(20, 30), pointer: 1);
    final second = await tester.startGesture(const Offset(150, 70), pointer: 2);
    await second.moveTo(const Offset(160, 80));
    await second.cancel();
    await first.moveTo(const Offset(70, 30));
    await first.cancel();
    expect(controller.strokeCount, 1);
    expect(controller.pointCount, 2);
    final png = (await _export(tester, controller))!;
    expect(png.alphaAt(50, 30), 255);
    expect(png.alphaAt(150, 70), 0);
    await tester.tapAt(const Offset(50, 80));
    expect(controller.strokeCount, 2);
  });

  testWidgets('does not promote a finger that was ignored while another drew', (
    tester,
  ) async {
    await _mount(tester, controller);
    final first = await tester.startGesture(const Offset(20, 30), pointer: 1);
    final second = await tester.startGesture(const Offset(150, 70), pointer: 2);
    await first.up();
    await second.moveTo(const Offset(160, 80));
    await second.up();
    expect(controller.pointCount, 1);
    await tester.tapAt(const Offset(50, 80));
    expect(controller.strokeCount, 2);
  });

  testWidgets(
    'clear during drawing prevents the old finger from adding points',
    (tester) async {
      await _mount(tester, controller);
      final finger = await tester.startGesture(const Offset(20, 30));
      controller.clear();
      await finger.moveTo(const Offset(80, 50));
      await finger.up();
      expect(controller.isEmpty, isTrue);
      await _mount(tester, controller, size: const Size(300, 200));
      await tester.tapAt(const Offset(250, 150));
      final png = (await _export(tester, controller))!;
      expect(png.width, 300);
      expect(png.height, 200);
    },
  );

  testWidgets('leaving the canvas ends the stroke without a reentry bridge', (
    tester,
  ) async {
    await _mount(tester, controller);
    final finger = await tester.startGesture(const Offset(20, 30));
    await finger.moveTo(const Offset(80, 30));
    await finger.moveTo(const Offset(220, 30));
    await finger.moveTo(const Offset(150, 70));
    await finger.up();
    expect(controller.pointCount, 2);
    final png = (await _export(tester, controller))!;
    expect(png.alphaAt(150, 70), 0);
  });

  testWidgets(
    'resizing during drawing ends the stroke without a coordinate jump',
    (tester) async {
      await _mount(tester, controller);
      final finger = await tester.startGesture(const Offset(20, 30));
      await finger.moveTo(const Offset(80, 30));
      await _mount(tester, controller, size: const Size(100, 200));
      await finger.moveTo(const Offset(50, 100));
      await finger.up();
      expect(controller.pointCount, 2);
      await tester.tapAt(const Offset(50, 100));
      expect(controller.strokeCount, 2);
    },
  );

  testWidgets(
    'controller replacement and remount preserve data without stale input',
    (tester) async {
      final other = SignatureController();
      addTearDown(other.dispose);
      await _mount(tester, controller);
      final finger = await tester.startGesture(const Offset(20, 30));
      await _mount(tester, other);
      await finger.moveTo(const Offset(80, 30));
      await finger.up();
      expect(other.isEmpty, isTrue);
      await tester.tapAt(const Offset(80, 70));
      controller.clear(); // The replaced controller no longer affects this pad.
      expect(other.pointCount, 1);
      await tester.pumpWidget(const SizedBox());
      expect(await _export(tester, other), isNotNull);
      await _mount(tester, other);
      await tester.tapAt(const Offset(100, 70));
      expect(other.strokeCount, 2);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'export snapshots remain valid through clear and unmount/dispose',
    (tester) async {
      final temporary = SignatureController();
      await _mount(tester, temporary);
      await _draw(tester, const [Offset(20, 30), Offset(80, 30)]);
      await tester.runAsync(() async {
        final pending = temporary.toPngBytes();
        temporary.clear();
        await tester.pumpWidget(const SizedBox());
        temporary.dispose();
        final png = await _decode((await pending)!);
        expect(png.alphaAt(50, 30), 255);
      });
    },
  );

  testWidgets('does not draw with the secondary mouse button', (tester) async {
    await _mount(tester, controller);
    final mouse = await tester.startGesture(
      const Offset(20, 30),
      kind: PointerDeviceKind.mouse,
      buttons: kSecondaryMouseButton,
    );
    await mouse.moveTo(const Offset(80, 30));
    await mouse.up();
    expect(controller.isEmpty, isTrue);
  });

  testWidgets('drawing inside a scroll view does not scroll its ancestor', (
    tester,
  ) async {
    final scroll = ScrollController();
    addTearDown(scroll.dispose);
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ListView(
            controller: scroll,
            children: [
              SizedBox(
                height: 300,
                child: SignaturePad(controller: controller),
              ),
              const SizedBox(height: 1200),
            ],
          ),
        ),
      ),
    );
    await _draw(tester, const [
      Offset(50, 200),
      Offset(50, 150),
      Offset(50, 80),
    ]);
    await tester.pumpAndSettle();
    expect(scroll.offset, 0);
    expect(controller.pointCount, 3);
  });

  testWidgets('zero and tiny layouts accept no invisible drawing', (
    tester,
  ) async {
    await _mount(tester, controller, size: Size.zero);
    await tester.tapAt(const Offset(1, 1));
    await _mount(tester, controller, size: const Size(2, 2));
    await tester.tapAt(const Offset(1, 1));
    expect(controller.isEmpty, isTrue);
    expect(tester.takeException(), isNull);
  });
}

Future<void> _mount(
  WidgetTester tester,
  SignatureController controller, {
  Size size = const Size(200, 100),
}) {
  return tester.pumpWidget(
    Directionality(
      textDirection: TextDirection.ltr,
      child: Align(
        alignment: Alignment.topLeft,
        child: RepaintBoundary(
          key: _boundaryKey,
          child: SizedBox.fromSize(
            size: size,
            child: SignaturePad(controller: controller),
          ),
        ),
      ),
    ),
  );
}

Future<void> _draw(WidgetTester tester, List<Offset> points) async {
  final finger = await tester.startGesture(points.first);
  for (final point in points.skip(1)) {
    await finger.moveTo(point);
  }
  await finger.up();
}

Future<void> _timedLine(WidgetTester tester, Duration interval) async {
  final finger = await tester.startGesture(const Offset(20, 50));
  for (var i = 1; i <= 16; i++) {
    await finger.moveTo(Offset(20 + i * 10, 50), timeStamp: interval * i);
  }
  await finger.up();
}

Future<_Raster?> _export(WidgetTester tester, SignatureController controller) {
  return tester.runAsync<_Raster?>(() async {
    final png = await controller.toPngBytes();
    return png == null ? null : _decode(png);
  });
}

Future<_Raster> _decode(Uint8List png) async {
  expect(png.take(8), [137, 80, 78, 71, 13, 10, 26, 10]);
  final codec = await ui.instantiateImageCodec(png);
  try {
    final frame = await codec.getNextFrame();
    try {
      return await _pixels(frame.image);
    } finally {
      frame.image.dispose();
    }
  } finally {
    codec.dispose();
  }
}

Future<_Raster> _display(WidgetTester tester) async {
  final boundary = tester.renderObject<RenderRepaintBoundary>(
    find.byKey(_boundaryKey),
  );
  return (await tester.runAsync(() async {
    final image = await boundary.toImage();
    try {
      return await _pixels(image);
    } finally {
      image.dispose();
    }
  }))!;
}

Future<_Raster> _pixels(ui.Image image) async {
  final data = (await image.toByteData())!;
  return _Raster(
    image.width,
    image.height,
    data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
  );
}

class _Raster {
  _Raster(this.width, this.height, this.bytes);

  final int width;
  final int height;
  final Uint8List bytes;

  int alphaAt(int x, int y) => bytes[(y * width + x) * 4 + 3];

  double columnInk(int x) {
    var total = 0;
    for (var y = 0; y < height; y++) {
      total += alphaAt(x, y);
    }
    return total / 255;
  }

  double columnCenter(int x) {
    var total = 0;
    var moment = 0;
    for (var y = 0; y < height; y++) {
      final alpha = alphaAt(x, y);
      total += alpha;
      moment += y * alpha;
    }
    return moment / total;
  }

  Rect? get inkBounds {
    Rect? bounds;
    for (var y = 0; y < height; y++) {
      for (var x = 0; x < width; x++) {
        if (alphaAt(x, y) == 0) continue;
        final pixel = Rect.fromLTWH(x.toDouble(), y.toDouble(), 1, 1);
        bounds = bounds?.expandToInclude(pixel) ?? pixel;
      }
    }
    return bounds;
  }
}

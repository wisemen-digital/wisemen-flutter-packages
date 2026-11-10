import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wisewidgetslibrary/src/widgets/signing/signing_style.dart';
import 'package:wisewidgetslibrary/wisewidgetslibrary.dart';

void main() {
  late SigningController controller;

  setUp(() => controller = SigningController());
  tearDown(() => controller.dispose());

  testWidgets('applies the name border and Clear button style', (tester) async {
    const border = OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF00FF00)),
    );
    await _mount(
      tester,
      controller,
      nameBorder: border,
      clearButtonStyle: TextButton.styleFrom(
        backgroundColor: const Color(0xFFFF0000),
      ),
    );
    final decoration = tester
        .widget<TextField>(find.byType(TextField))
        .decoration!;
    expect(decoration.border, border);
    expect(decoration.enabledBorder, border);
    final clear = tester.widget<TextButton>(
      find.widgetWithText(TextButton, 'Clear'),
    );
    expect(
      clear.style!.backgroundColor!.resolve({}),
      const Color(0xFFFF0000),
    );
  });

  testWidgets(
    'separate accessible name label, decorative Clear icon and compact card',
    (tester) async {
      final semantics = tester.ensureSemantics();
      controller.signerName = 'Ada';
      const metadataStyle = TextStyle(color: Color(0xFF667085), fontSize: 12);
      await _mount(
        tester,
        controller,
        width: 412,
        clearIcon: const Icon(Icons.undo, semanticLabel: 'decorative undo'),
        metadataStyle: metadataStyle,
        timestampFormat: 'dd/MM/yyyy HH:mm',
      );
      final label = find.text('Name of the signer');
      final input = find.byType(TextField);
      expect(label, findsOneWidget);
      expect(tester.widget<TextField>(input).decoration!.labelText, isNull);
      expect(tester.getTopLeft(input).dy - tester.getBottomLeft(label).dy, 4);
      expect(tester.getSize(input).height, closeTo(52, 1));
      expect(find.bySemanticsLabel('Name of the signer'), findsOneWidget);
      expect(
        tester.getSemantics(input),
        isSemantics(label: 'Name of the signer', isTextField: true),
      );
      expect(find.bySemanticsLabel('decorative undo'), findsNothing);
      semantics.dispose();
      final clear = find.widgetWithText(TextButton, 'Clear');
      expect(tester.widget<TextButton>(clear).onPressed, isNull);
      final card = find
          .ancestor(
            of: find.byType(SignaturePad),
            matching: find.byType(DecoratedBox),
          )
          .first;
      expect(tester.getSize(card).width, 380);
      expect(tester.getSize(card).height, closeTo(180, 3));
      await _sign(tester);
      await tester.pump();
      expect(tester.widget<TextButton>(clear).onPressed, isNotNull);
      final metadata = find.textContaining(
        RegExp(r'Ada · \d{2}/\d{2}/\d{4} \d{2}:\d{2}'),
      );
      expect(metadata, findsOneWidget);
      expect(tester.widget<Text>(metadata).style, metadataStyle);
      await tester.tap(clear);
      await tester.pump();
      expect(tester.widget<TextButton>(clear).onPressed, isNull);
    },
  );

  testWidgets(
    '"Sign here" matches the name label; card text and divider suit dark mode',
    (tester) async {
      controller.signerName = 'Ada';
      await _mount(tester, controller, theme: ThemeData.dark());
      expect(
        tester
            .widget<Text>(
              find.byWidgetPredicate((w) => w is Text && w.data == 'Ada'),
            )
            .style
            ?.color,
        signingMutedInkColor,
      );
      final labelStyle = tester.widget<Text>(find.text('Name of the signer'));
      expect(
        tester.widget<Text>(find.text('Sign here')).style,
        labelStyle.style,
      );
      expect(
        tester.widget<Divider>(find.byType(Divider)).color,
        signingRuleColor,
      );
    },
  );

  testWidgets(
    'submit shows separate translated errors for missing name and ink',
    (tester) async {
      await _mount(tester, controller, strings: const _TestStrings());
      expect(find.text('Missing name'), findsNothing);
      expect(await controller.submit(), isNull);
      await tester.pump();
      expect(find.text('Missing name'), findsOneWidget);
      expect(find.text('Missing ink'), findsOneWidget);
      await tester.enterText(find.byType(TextField), '  ');
      expect(await controller.submit(), isNull);
      await tester.enterText(find.byType(TextField), ' Ada ');
      await tester.pump();
      expect(find.text('Missing name'), findsNothing);
      expect(find.text('Missing ink'), findsOneWidget);
      expect(controller.signedAt, isNull);
    },
  );

  testWidgets(
    'first ink immediately shows date and time; Clear and redraw start a new time',
    (tester) async {
      controller.signerName = 'Ada';
      await _mount(tester, controller);
      expect(controller.signedAt, isNull);
      expect(find.textContaining('Ada ·'), findsNothing);

      final before = DateTime.now();
      final start =
          tester.getTopLeft(find.byType(SignaturePad)) + const Offset(20, 20);
      final finger = await tester.startGesture(start);
      final firstInk = controller.signedAt!;
      expect(firstInk.isBefore(before), isFalse);
      expect(firstInk.isAfter(DateTime.now()), isFalse);
      await tester.pump();
      expect(
        find.textContaining(
          RegExp(r'Ada · \d{1,2}/\d{1,2}/\d{4} \d{1,2}:\d{2}'),
        ),
        findsOneWidget,
      );
      await finger.moveBy(const Offset(30, 0));
      await finger.cancel();
      await _sign(tester);
      expect(controller.signedAt, firstInk);
      await _mount(tester, controller, width: 600);
      expect(controller.signedAt, firstInk);
      expect(find.textContaining('Ada ·'), findsOneWidget);

      controller.clear();
      await tester.pump();
      expect(controller.signedAt, isNull);
      expect(find.textContaining('Ada ·'), findsNothing);
      expect(controller.signerName, 'Ada');
      final beforeRedraw = DateTime.now();
      await _sign(tester);
      final redrawnAt = controller.signedAt!;
      expect(redrawnAt.isBefore(beforeRedraw), isFalse);
      expect(redrawnAt.isAfter(firstInk), isTrue);
      expect((await _submit(tester, controller))!.signedAt, redrawnAt);
    },
  );

  testWidgets(
    'rejects tap-only drawings but accepts a legitimately short moving stroke',
    (tester) async {
      controller.signerName = 'Ada';
      await _mount(tester, controller);
      await tester.tapAt(tester.getCenter(find.byType(SignaturePad)));
      final tappedAt = controller.signedAt;
      expect(tappedAt, isNotNull);
      expect(await controller.submit(), isNull);
      expect(controller.signedAt, tappedAt);
      await tester.pump();
      expect(find.text('Draw a signature.'), findsOneWidget);
      controller.clear();
      await _sign(tester, distance: 1);
      expect(await _submit(tester, controller), isNotNull);
      await tester.pump();
      expect(find.text('Draw a signature.'), findsNothing);
    },
  );

  testWidgets(
    'confirmation returns trimmed name, transparent ink and one stable timestamp',
    (tester) async {
      controller.signerName = '  Ada Lovelace  ';
      await _mount(tester, controller);
      await _sign(tester);
      final before = DateTime.now();
      final drawnAt = controller.signedAt!;
      final result = (await _submit(tester, controller))!;
      expect(result.signerName, 'Ada Lovelace');
      expect(result.signedAt, drawnAt);
      expect(result.signedAt.isAfter(before), isFalse);
      expect(result.signedAt.isAfter(DateTime.now()), isFalse);
      expect(controller.signedAt, result.signedAt);
      expect(controller.isSubmitting, isFalse);
      expect(await _submit(tester, controller), same(result));
      result.pngBytes[0] = 0;
      expect(result.pngBytes[0], 137);
      final size = tester.getSize(find.byType(SignaturePad));
      await tester.runAsync(() async {
        final codec = await ui.instantiateImageCodec(result.pngBytes);
        final frame = await codec.getNextFrame();
        final image = frame.image;
        try {
          expect(image.width, size.width.ceil());
          expect(image.height, size.height.ceil());
          final rgba = (await image.toByteData())!.buffer.asUint8List();
          expect(rgba[3], 0);
          expect(rgba[((20 * image.width + 40) * 4) + 3], greaterThan(0));
        } finally {
          image.dispose();
          codec.dispose();
        }
      });
      await tester.pump();
      expect(find.textContaining('Ada Lovelace ·'), findsOneWidget);
    },
  );

  testWidgets(
    'clear retains name and removes drawing and confirmed timestamp',
    (tester) async {
      controller.signerName = 'Ada';
      await _mount(tester, controller);
      await _sign(tester);
      expect(await _submit(tester, controller), isNotNull);
      await tester.pump();
      await tester.tap(find.text('Clear'));
      await tester.pump();
      expect(controller.signerName, 'Ada');
      expect(
        tester.widget<TextField>(find.byType(TextField)).controller!.text,
        'Ada',
      );
      expect(controller.signedAt, isNull);
      expect(await controller.submit(), isNull);
      await tester.pump();
      expect(find.text('Draw a signature.'), findsOneWidget);
    },
  );

  testWidgets(
    'name and ink edits invalidate confirmation while retaining first-ink time',
    (tester) async {
      controller.signerName = 'Ada';
      await _mount(tester, controller);
      await _sign(tester);
      final first = (await _submit(tester, controller))!;
      tester.widget<TextField>(find.byType(TextField)).controller!.selection =
          const TextSelection.collapsed(offset: 1);
      expect(controller.signedAt, first.signedAt);
      await tester.enterText(find.byType(TextField), 'Grace');
      expect(controller.signedAt, first.signedAt);
      final second = (await _submit(tester, controller))!;
      expect(second.signerName, 'Grace');
      expect(second.signedAt, first.signedAt);
      await _sign(tester);
      expect(controller.signedAt, first.signedAt);
      expect(await _submit(tester, controller), isNot(same(second)));
    },
  );

  testWidgets(
    'concurrent submissions share one snapshot; clear invalidates pending capture',
    (tester) async {
      controller.signerName = 'Ada';
      await _mount(tester, controller);
      await _sign(tester);
      await tester.runAsync(() async {
        final first = controller.submit();
        expect(controller.submit(), same(first));
        expect(controller.isSubmitting, isTrue);
        controller.clear();
        expect(await first, isNull);
        expect(controller.signedAt, isNull);
        expect(controller.isSubmitting, isFalse);
      });
    },
  );

  testWidgets(
    'name and drawing edits during capture never publish stale metadata',
    (tester) async {
      controller.signerName = 'Ada';
      await _mount(tester, controller);
      await _sign(tester);
      final drawnAt = controller.signedAt;
      final capture = controller.submit();
      controller.signerName = 'Grace';
      expect(await tester.runAsync<SigningResult?>(() => capture), isNull);
      expect(controller.signedAt, drawnAt);
      final next = controller.submit();
      await _sign(tester);
      expect(await tester.runAsync<SigningResult?>(() => next), isNull);
      expect(controller.signedAt, drawnAt);
      expect((await _submit(tester, controller))!.signerName, 'Grace');
    },
  );

  testWidgets(
    'independent fields keep names, drawing and timestamps separate',
    (tester) async {
      final other = SigningController();
      addTearDown(other.dispose);
      controller.signerName = 'Ada';
      await _mount(tester, controller);
      await _sign(tester);
      final result = await _submit(tester, controller);
      await _mount(tester, other);
      expect(other.signerName, isEmpty);
      expect(await other.submit(), isNull);
      other.clear();
      expect(controller.signedAt, result!.signedAt);
      expect(await _submit(tester, controller), same(result));
    },
  );

  testWidgets(
    'rebuild, rotation and remount retain name, complete ink and confirmation',
    (tester) async {
      controller.signerName = 'Ada';
      await _mount(tester, controller);
      await _sign(tester);
      final result = (await _submit(tester, controller))!;
      await _mount(tester, controller, width: 600);
      expect(controller.signerName, 'Ada');
      expect(await _submit(tester, controller), same(result));
      expect(find.textContaining('Ada ·'), findsOneWidget);
      await tester.pumpWidget(const SizedBox());
      await _mount(tester, controller);
      expect(await _submit(tester, controller), same(result));
    },
  );

  testWidgets(
    'disposing during capture returns no result and never notifies afterward',
    (tester) async {
      final temporary = SigningController()..signerName = 'Ada';
      await _mount(tester, temporary);
      await _sign(tester);
      final capture = temporary.submit();
      await tester.pumpWidget(const SizedBox());
      temporary.dispose();
      expect(await tester.runAsync<SigningResult?>(() => capture), isNull);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'long names, large text and keyboard insets remain scrollable on a small screen',
    (tester) async {
      tester.view
        ..physicalSize = const Size(320, 600)
        ..devicePixelRatio = 1
        ..viewInsets = const FakeViewPadding(bottom: 250);
      addTearDown(tester.view.reset);
      controller.signerName = List.filled(20, 'A very long name').join(' ');
      await _mount(tester, controller, width: 320, scale: 2);
      expect(await controller.submit(), isNull);
      await tester.pump();
      await tester.ensureVisible(find.byType(SignaturePad));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      await tester.ensureVisible(find.byType(TextField));
      await tester.tap(find.byType(TextField));
      await tester.pump();
      expect(tester.testTextInput.isVisible, isTrue);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'fillHeight canvas fills its parent; the default keeps the 380:144 area',
    (tester) async {
      await _mount(tester, controller, width: 412);
      expect(
        tester.getSize(find.byType(SignaturePad)).aspectRatio,
        closeTo(380 / 144, .01),
      );

      tester.view
        ..physicalSize = const Size(800, 360)
        ..devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await _mountSigningMode(tester, controller);
      expect(
        find.descendant(
          of: find.byType(SigningCanvas),
          matching: find.byType(AspectRatio),
        ),
        findsNothing,
      );
      final card = find
          .ancestor(
            of: find.byType(SignaturePad),
            matching: find.byType(DecoratedBox),
          )
          .first;
      expect(tester.getBottomLeft(find.byType(SigningCanvas)).dy, 360 - 16);
      expect(
        tester.getBottomLeft(card).dy,
        lessThan(360 - 16 - signingSectionGap),
      );
      final pad = tester.getSize(find.byType(SignaturePad));
      expect(pad.width, 800 - 32);
      expect(pad.aspectRatio, isNot(closeTo(380 / 144, .1)));
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'in fill mode, clearing the signature error does not cut off the stroke',
    (tester) async {
      tester.view
        ..physicalSize = const Size(800, 360)
        ..devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      controller.signerName = 'Ada';
      await _mountSigningMode(tester, controller);
      expect(await controller.submit(), isNull);
      await tester.pump();
      expect(find.text('Draw a signature.'), findsOneWidget);
      final padSize = tester.getSize(find.byType(SignaturePad));

      final finger = await tester.startGesture(
        tester.getCenter(find.byType(SignaturePad)),
      );
      for (var i = 1; i <= 5; i++) {
        await finger.moveBy(
          const Offset(10, 0),
          timeStamp: Duration(milliseconds: 10 * i),
        );
        await tester.pump();
      }
      await finger.up();
      await tester.pump();
      expect(controller.showsSignatureError, isFalse);
      expect(
        tester
            .widget<Visibility>(
              find.ancestor(
                of: find.text('Draw a signature.'),
                matching: find.byType(Visibility),
              ),
            )
            .visible,
        isFalse,
      );
      expect(tester.getSize(find.byType(SignaturePad)), padSize);
      expect(controller.signatureController.strokeCount, 1);
      expect(controller.signatureController.pointCount, 6);
    },
  );

  testWidgets(
    'one controller keeps strokes, name and time across field and fill modes',
    (tester) async {
      controller.signerName = 'Ada';
      await _mount(tester, controller, width: 412);
      await _sign(tester);
      await tester.pump();
      final portrait = tester.getSize(find.byType(SignaturePad));
      final signedAt = controller.signedAt;
      final metadata = tester.widget<Text>(find.textContaining('Ada ·')).data!;

      tester.view
        ..physicalSize = const Size(800, 360)
        ..devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await _mountSigningMode(tester, controller);
      expect(find.text(metadata), findsOneWidget);
      expect(
        tester
            .widget<TextButton>(find.widgetWithText(TextButton, 'Clear'))
            .onPressed,
        isNotNull,
      );
      expect(controller.signatureController.canvasSize, portrait);
      // The original canvas is centered, so start from the pad's center.
      final center = tester.getCenter(find.byType(SignaturePad));
      final finger = await tester.startGesture(center);
      await finger.moveBy(
        const Offset(60, 0),
        timeStamp: const Duration(milliseconds: 30),
      );
      await finger.up();
      expect(controller.signatureController.strokeCount, 2);
      expect(controller.signedAt, signedAt);

      tester.view.reset();
      await _mount(tester, controller, width: 412);
      expect(tester.getSize(find.byType(SignaturePad)), portrait);
      expect(controller.signatureController.strokeCount, 2);
      expect(controller.signedAt, signedAt);
      expect(find.text(metadata), findsOneWidget);
      expect(
        tester.widget<TextField>(find.byType(TextField)).controller!.text,
        'Ada',
      );

      final result = (await _submit(tester, controller))!;
      expect(result.signedAt, signedAt);
      await tester.runAsync(() async {
        final codec = await ui.instantiateImageCodec(result.pngBytes);
        final frame = await codec.getNextFrame();
        final image = frame.image;
        try {
          expect(image.width, portrait.width.ceil());
          expect(image.height, portrait.height.ceil());
          // The landscape stroke from the center lands at the canvas center.
          final rgba = (await image.toByteData())!.buffer.asUint8List();
          final x = image.width ~/ 2 + 5;
          final y = image.height ~/ 2;
          expect(rgba[((y * image.width + x) * 4) + 3], greaterThan(0));
        } finally {
          image.dispose();
          codec.dispose();
        }
      });
    },
  );
}

Future<void> _mountSigningMode(
  WidgetTester tester,
  SigningController controller,
) {
  return tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (context) => Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 12,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Sign here',
                      style: Theme.of(context).signingLabelStyle,
                    ),
                    SigningClearButton(controller: controller, label: 'Clear'),
                  ],
                ),
                Expanded(
                  child: SigningCanvas(
                    controller: controller,
                    strings: const SigningStringsEn(),
                    fillHeight: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Future<void> _mount(
  WidgetTester tester,
  SigningController controller, {
  double width = 360,
  double scale = 1,
  SigningStrings strings = const SigningStringsEn(),
  Widget? clearIcon,
  TextStyle? metadataStyle,
  String? timestampFormat,
  ThemeData? theme,
  InputBorder? nameBorder,
  ButtonStyle? clearButtonStyle,
}) {
  return tester.pumpWidget(
    MaterialApp(
      theme: theme,
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(
          context,
        ).copyWith(textScaler: TextScaler.linear(scale)),
        child: child!,
      ),
      home: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            width: width,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SigningField(
                controller: controller,
                strings: strings,
                clearIcon: clearIcon,
                metadataStyle: metadataStyle,
                timestampFormat: timestampFormat,
                nameBorder: nameBorder,
                clearButtonStyle: clearButtonStyle,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

Future<void> _sign(WidgetTester tester, {double distance = 60}) async {
  final start =
      tester.getTopLeft(find.byType(SignaturePad)) + const Offset(20, 20);
  final finger = await tester.startGesture(start);
  await finger.moveBy(
    Offset(distance, 0),
    timeStamp: const Duration(milliseconds: 30),
  );
  await finger.up();
}

Future<SigningResult?> _submit(
  WidgetTester tester,
  SigningController controller,
) => tester.runAsync<SigningResult?>(controller.submit);

class _TestStrings extends SigningStringsEn {
  const _TestStrings();

  @override
  String get nameRequired => 'Missing name';

  @override
  String get signatureRequired => 'Missing ink';
}

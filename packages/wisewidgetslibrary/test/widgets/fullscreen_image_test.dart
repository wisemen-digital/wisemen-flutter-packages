import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:photo_view/photo_view.dart';
import 'package:wisewidgetslibrary/src/widgets/fullscreen_image.dart';

void main() {
  const thumbnailKey = Key('thumbnail');
  const missingAsset = 'assets/does_not_exist.png';

  Widget buildTestableWidget(Widget child) {
    return MaterialApp(
      home: Scaffold(body: Center(child: child)),
    );
  }

  Widget thumbnail() => const SizedBox(
    key: thumbnailKey,
    width: 100,
    height: 100,
    child: ColoredBox(color: Colors.red),
  );

  Future<void> openFullscreen(WidgetTester tester) async {
    await tester.tap(find.byKey(thumbnailKey));
    await tester.pumpAndSettle();
  }

  // File and network loads never complete under fake async, so the viewer's
  // loading indicator would keep pumpAndSettle from returning.
  Future<void> openFullscreenWhileLoading(WidgetTester tester) async {
    await tester.tap(find.byKey(thumbnailKey));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
  }

  ImageProvider imageProviderOf(WidgetTester tester) =>
      tester.widget<PhotoView>(find.byType(PhotoView)).imageProvider!;

  testWidgets('renders child wrapped in a Hero', (tester) async {
    await tester.pumpWidget(
      buildTestableWidget(
        FullscreenImage.asset(imageAsset: missingAsset, child: thumbnail()),
      ),
    );

    expect(find.byKey(thumbnailKey), findsOneWidget);
    expect(
      find.ancestor(of: find.byKey(thumbnailKey), matching: find.byType(Hero)),
      findsOneWidget,
    );
    expect(find.byType(PhotoView), findsNothing);
  });

  testWidgets('tapping the child opens the fullscreen viewer', (tester) async {
    await tester.pumpWidget(
      buildTestableWidget(
        FullscreenImage.asset(imageAsset: missingAsset, child: thumbnail()),
      ),
    );

    await openFullscreen(tester);

    expect(find.byType(PhotoView), findsOneWidget);
    expect(find.byIcon(Icons.close), findsOneWidget);
    final scaffold = tester.widget<Scaffold>(
      find.ancestor(
        of: find.byType(PhotoView),
        matching: find.byType(Scaffold),
      ),
    );
    expect(scaffold.backgroundColor, Colors.black);
  });

  testWidgets('close button dismisses the fullscreen viewer', (tester) async {
    await tester.pumpWidget(
      buildTestableWidget(
        FullscreenImage.asset(imageAsset: missingAsset, child: thumbnail()),
      ),
    );
    await openFullscreen(tester);

    await tester.tap(find.byIcon(Icons.close));
    await tester.pumpAndSettle();

    expect(find.byType(PhotoView), findsNothing);
    expect(find.byIcon(Icons.close), findsNothing);
    expect(find.byKey(thumbnailKey), findsOneWidget);
  });

  testWidgets('close button is visible while not dragging or zoomed', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildTestableWidget(
        FullscreenImage.asset(imageAsset: missingAsset, child: thumbnail()),
      ),
    );
    await openFullscreen(tester);

    final closeButton = find.byIcon(Icons.close);
    final opacity = tester.widget<AnimatedOpacity>(
      find.ancestor(of: closeButton, matching: find.byType(AnimatedOpacity)),
    );
    final slide = tester.widget<AnimatedSlide>(
      find.ancestor(of: closeButton, matching: find.byType(AnimatedSlide)),
    );
    expect(opacity.opacity, 1);
    expect(slide.offset, Offset.zero);
  });

  testWidgets('shows default error icon when the image fails to load', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildTestableWidget(
        FullscreenImage.asset(imageAsset: missingAsset, child: thumbnail()),
      ),
    );
    await openFullscreen(tester);

    expect(find.byIcon(Icons.error_rounded), findsOneWidget);
  });

  testWidgets('shows custom error widget when the image fails to load', (
    tester,
  ) async {
    const errorKey = Key('error');
    await tester.pumpWidget(
      buildTestableWidget(
        FullscreenImage.asset(
          imageAsset: missingAsset,
          errorWidget: const SizedBox.expand(key: errorKey),
          child: thumbnail(),
        ),
      ),
    );
    await openFullscreen(tester);

    expect(find.byKey(errorKey), findsOneWidget);
    expect(find.byIcon(Icons.error_rounded), findsNothing);
  });

  testWidgets('tapping the error widget dismisses the fullscreen viewer', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildTestableWidget(
        FullscreenImage.asset(imageAsset: missingAsset, child: thumbnail()),
      ),
    );
    await openFullscreen(tester);

    await tester.tap(find.byIcon(Icons.error_rounded));
    await tester.pumpAndSettle();

    expect(find.byType(PhotoView), findsNothing);
  });

  group('image provider', () {
    testWidgets('asset constructor uses an AssetImage', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          FullscreenImage.asset(imageAsset: missingAsset, child: thumbnail()),
        ),
      );
      await openFullscreen(tester);

      final provider = imageProviderOf(tester);
      expect(provider, isA<AssetImage>());
      expect((provider as AssetImage).assetName, missingAsset);
    });

    testWidgets('file constructor uses a FileImage', (tester) async {
      const path = '/does/not/exist.png';
      await tester.pumpWidget(
        buildTestableWidget(
          FullscreenImage.file(imagePath: path, child: thumbnail()),
        ),
      );
      await openFullscreenWhileLoading(tester);

      final provider = imageProviderOf(tester);
      expect(provider, isA<FileImage>());
      expect((provider as FileImage).file.path, path);
    });

    testWidgets('network constructor uses a CachedNetworkImageProvider', (
      tester,
    ) async {
      const url = 'https://example.com/image.png';
      await tester.pumpWidget(
        buildTestableWidget(
          FullscreenImage.network(imageUrl: url, child: thumbnail()),
        ),
      );
      await openFullscreenWhileLoading(tester);

      final provider = imageProviderOf(tester);
      expect(provider, isA<CachedNetworkImageProvider>());
      expect((provider as CachedNetworkImageProvider).url, url);
    });
  });
}

import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'custom_image_carousel.dart';

/// Fullscreen image carousel widget
class FullscreenImageCarousel extends StatefulWidget {
  /// Basic constructor
  const FullscreenImageCarousel.basic({
    required this.imageProviders,
    required this.child,
    super.key,
    this.errorWidget,
    this.initialPage,
    this.heroTag,
    this.maxScale,
    this.photoViewBackgroundColor,
    this.showPageIndicator = true,
    this.showCloseButton = true,
    this.enableRotation = false,
    this.extraChildren = const [],
    this.currentPageTextstyle = const TextStyle(
      fontFamily: 'CupertinoSystemDisplay',
      fontWeight: FontWeight.w600,
      color: Colors.grey,
      fontSize: 16,
    ),
    this.pageIndicatorSeperatorTextstyle = const TextStyle(
      fontFamily: 'CupertinoSystemDisplay',
      fontWeight: FontWeight.w600,
      color: Colors.grey,
      fontSize: 16,
    ),
    this.totalAmountOfPagesTextstyle = const TextStyle(
      fontFamily: 'CupertinoSystemDisplay',
      fontWeight: FontWeight.w600,
      color: Colors.grey,
      fontSize: 16,
    ),
    this.dismissTresholds,
    this.dismissDirection,
    this.onPageChange,
  }) : complexChild = null,
       imageUrls = null;

  /// Complex constructor
  const FullscreenImageCarousel.complex({
    required this.imageProviders,
    required this.complexChild,
    super.key,
    this.errorWidget,
    this.initialPage,
    this.heroTag,
    this.maxScale,
    this.photoViewBackgroundColor,
    this.showPageIndicator = true,
    this.showCloseButton = true,
    this.enableRotation = false,
    this.extraChildren = const [],
    this.currentPageTextstyle = const TextStyle(
      fontFamily: 'CupertinoSystemDisplay',
      fontWeight: FontWeight.w600,
      color: Colors.grey,
      fontSize: 16,
    ),
    this.pageIndicatorSeperatorTextstyle = const TextStyle(
      fontFamily: 'CupertinoSystemDisplay',
      fontWeight: FontWeight.w600,
      color: Colors.grey,
      fontSize: 16,
    ),
    this.totalAmountOfPagesTextstyle = const TextStyle(
      fontFamily: 'CupertinoSystemDisplay',
      fontWeight: FontWeight.w600,
      color: Colors.grey,
      fontSize: 16,
    ),
    this.dismissTresholds,
    this.dismissDirection,
    this.onPageChange,
  }) : child = null,
       imageUrls = null;

  /// Basic constructor with urls
  const FullscreenImageCarousel.basicWithUrls({
    required this.imageUrls,
    required this.child,
    super.key,
    this.errorWidget,
    this.initialPage,
    this.heroTag,
    this.maxScale,
    this.photoViewBackgroundColor,
    this.showPageIndicator = true,
    this.showCloseButton = true,
    this.enableRotation = false,
    this.extraChildren = const [],
    this.currentPageTextstyle = const TextStyle(
      fontFamily: 'CupertinoSystemDisplay',
      fontWeight: FontWeight.w600,
      color: Colors.grey,
      fontSize: 16,
    ),
    this.pageIndicatorSeperatorTextstyle = const TextStyle(
      fontFamily: 'CupertinoSystemDisplay',
      fontWeight: FontWeight.w600,
      color: Colors.grey,
      fontSize: 16,
    ),
    this.totalAmountOfPagesTextstyle = const TextStyle(
      fontFamily: 'CupertinoSystemDisplay',
      fontWeight: FontWeight.w600,
      color: Colors.grey,
      fontSize: 16,
    ),
    this.dismissTresholds,
    this.dismissDirection,
    this.onPageChange,
  }) : complexChild = null,
       imageProviders = null;

  /// Complex constructor with urls
  const FullscreenImageCarousel.complexWithUrls({
    required this.imageUrls,
    required this.complexChild,
    super.key,
    this.errorWidget,
    this.initialPage,
    this.heroTag,
    this.maxScale,
    this.photoViewBackgroundColor,
    this.showPageIndicator = true,
    this.showCloseButton = true,
    this.enableRotation = false,
    this.extraChildren = const [],
    this.currentPageTextstyle = const TextStyle(
      fontFamily: 'CupertinoSystemDisplay',
      fontWeight: FontWeight.w600,
      color: Colors.grey,
      fontSize: 16,
    ),
    this.pageIndicatorSeperatorTextstyle = const TextStyle(
      fontFamily: 'CupertinoSystemDisplay',
      fontWeight: FontWeight.w600,
      color: Colors.grey,
      fontSize: 16,
    ),
    this.totalAmountOfPagesTextstyle = const TextStyle(
      fontFamily: 'CupertinoSystemDisplay',
      fontWeight: FontWeight.w600,
      color: Colors.grey,
      fontSize: 16,
    ),
    this.dismissTresholds,
    this.dismissDirection,
    this.onPageChange,
  }) : child = null,
       imageProviders = null;

  /// Image providers
  final List<ImageProvider<Object>>? imageProviders;

  /// Image urls for cached network images
  final List<String>? imageUrls;

  /// Child widget
  final Widget? child;

  /// Complex child widget
  final Widget Function(void Function(int initialPage) openCarousel)?
  complexChild;

  /// Error widget
  final Widget? errorWidget;

  /// Optional initial page
  final int? initialPage;

  /// Hero tag
  final String? heroTag;

  /// Maximum scale
  final double? maxScale;

  /// Photo view background color
  final Color? photoViewBackgroundColor;

  /// Dissmiss tresholds
  final Map<DismissiblePageDismissDirection, double>? dismissTresholds;

  /// Dismiss direction
  final DismissiblePageDismissDirection? dismissDirection;

  /// Show page indicator
  final bool showPageIndicator;

  /// Show close button
  final bool showCloseButton;

  /// Extra children
  final List<Widget> extraChildren;

  /// Current page text style
  final TextStyle currentPageTextstyle;

  /// Enable rotation
  final bool enableRotation;

  /// Page indicator seperator text style
  final TextStyle pageIndicatorSeperatorTextstyle;

  /// Total amount of pages text style
  final TextStyle totalAmountOfPagesTextstyle;

  /// Delegate for page change
  final void Function(int?)? onPageChange;

  @override
  State<StatefulWidget> createState() => _FullscreenImageCarouselState();
}

class _FullscreenImageCarouselState extends State<FullscreenImageCarousel> {
  PageController controller = PageController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      widget.onPageChange?.call(controller.page?.round() ?? 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<void> openCarousel({int initialPage = 0}) async {
      controller = PageController(initialPage: initialPage);

      controller.addListener(() {
        widget.onPageChange?.call(controller.page?.round() ?? 0);
      });

      await context.pushTransparentRoute<void>(
        CustomImageCarousel(
          photoViewBackgroundColor: widget.photoViewBackgroundColor,
          dismissThresholds: widget.dismissTresholds,
          dismissDirection: widget.dismissDirection,
          imageProviders: widget.imageProviders,
          extraChildren: widget.extraChildren,
          showPageIndicator: widget.showPageIndicator,
          showCloseButton: widget.showCloseButton,
          enableRotation: widget.enableRotation,
          currentPageTextstyle: widget.currentPageTextstyle,
          pageIndicatorSeperatorTextstyle:
              widget.pageIndicatorSeperatorTextstyle,
          totalAmountOfPagesTextstyle: widget.totalAmountOfPagesTextstyle,
          errorWidget: widget.errorWidget,
          imageUrls: widget.imageUrls,
          maxScale: widget.maxScale,
          initialPage: initialPage,
          heroTag: widget.heroTag,
          controller: controller,
        ),
      );

      widget.onPageChange?.call(null);

      controller.dispose();
    }

    if (widget.complexChild != null) {
      return widget.complexChild!((int initialPage) {
        openCarousel(initialPage: initialPage);
      });
    }

    return GestureDetector(
      onTap: () => openCarousel(initialPage: widget.initialPage ?? 0),
      child: widget.child ?? const SizedBox(),
    );
  }
}

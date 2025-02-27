import 'package:cached_network_image/cached_network_image.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

/// Custom image carousel with close button and page indicator
class CustomImageCarousel extends StatefulWidget {
  /// Constructor [CustomImageCarousel]
  const CustomImageCarousel({
    required this.controller,
    this.showPageIndicator = false,
    this.extraChildren = const [],
    this.photoViewBackgroundColor,
    this.showCloseButton = true,
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
    this.enableRotation = false,
    this.dismissThresholds,
    this.dismissDirection,
    this.imageProviders,
    this.initialPage,
    this.errorWidget,
    this.imageUrls,
    this.maxScale,
    this.heroTag,
    super.key,
  });

  /// Decides when page gets dismissed
  final Map<DismissiblePageDismissDirection, double>? dismissThresholds;

  /// List of images
  final List<ImageProvider<Object>>? imageProviders;

  /// Text style for page indicator seperator
  final TextStyle pageIndicatorSeperatorTextstyle;

  /// Text style for total amount of pages
  final TextStyle totalAmountOfPagesTextstyle;

  /// Text style for current page
  final TextStyle currentPageTextstyle;

  /// Extra children
  final List<Widget> extraChildren;

  /// Page controller
  final PageController controller;

  /// List of image urls
  final List<String>? imageUrls;

  /// Show page indicator
  final bool showPageIndicator;

  /// Show close button
  final bool showCloseButton;

  /// Error widget
  final Widget? errorWidget;

  /// Enable rotation
  final bool enableRotation;

  /// Initial page
  final int? initialPage;

  /// Defaults to `DismissiblePageDismissDirection.multi`
  final DismissiblePageDismissDirection? dismissDirection;

  /// Defaults to `Colors.transparent`
  final Color? photoViewBackgroundColor;

  /// Defaults to `2.0`
  final double? maxScale;

  /// Defaults to `imageProviders[index].hashCode`
  final String? heroTag;

  static const double _closeIconSize = 24;
  static const Color _closeIconColor = Colors.white;
  static const Color _closeIconBackgroundColor = Colors.black;
  static const Duration _closeIconAnimationDuration =
      Duration(milliseconds: 100);
  static const Offset _closeIconSlideOffset = Offset(0, -.5);
  static const double _closeIconSidePadding = 24;
  static const Duration _pageIndiatorAnimationDuration =
      Duration(milliseconds: 100);
  static const Offset _pageIndicatorSlideOffset = Offset(0, .5);
  static final BorderRadius _pageIndicatorBorderRadius =
      BorderRadius.circular(12);
  static const EdgeInsets _pageIndicatorPadding =
      EdgeInsets.symmetric(horizontal: 6);
  static const Color _pageIndicatorBackgroundColor = Colors.black;

  @override
  State<CustomImageCarousel> createState() => _CustomImageCarouselState();
}

class _CustomImageCarouselState extends State<CustomImageCarousel> {
  late int currentPage = widget.initialPage ?? 0;
  bool isDragging = false;
  bool isZoomed = false;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        widget.controller.addListener(() {
          setState(() {
            currentPage = widget.controller.page!.round();
          });
        });
      },
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          DismissiblePage(
            onDismissed: () => Navigator.of(context).pop(),
            disabled: isZoomed,
            onDragUpdate: (value) {
              setState(() {
                if (value.overallDragValue > 0.0) {
                  isDragging = true;
                } else {
                  isDragging = false;
                }
              });
            },
            direction: widget.dismissDirection ??
                DismissiblePageDismissDirection.multi,
            dismissThresholds: widget.dismissThresholds ??
                {
                  DismissiblePageDismissDirection.multi: .2,
                },
            minScale: 1,
            child: PhotoViewGallery.builder(
              pageController: widget.controller,
              enableRotation: widget.enableRotation,
              scaleStateChangedCallback: (value) {
                setState(() {
                  if (value == PhotoViewScaleState.initial ||
                      value == PhotoViewScaleState.zoomedOut) {
                    isZoomed = false;
                  }
                  if (value == PhotoViewScaleState.covering ||
                      value == PhotoViewScaleState.zoomedIn) {
                    isZoomed = true;
                  }
                });
              },
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
              itemCount: (widget.imageProviders ?? widget.imageUrls)!.length,
              backgroundDecoration: BoxDecoration(
                color: widget.photoViewBackgroundColor ?? Colors.transparent,
              ),
              builder: (context, index) => PhotoViewGalleryPageOptions(
                imageProvider: widget.imageProviders?[index] ??
                    CachedNetworkImageProvider(
                      widget.imageUrls![index],
                    ),
                minScale: PhotoViewComputedScale.contained,
                maxScale:
                    PhotoViewComputedScale.covered * (widget.maxScale ?? 2.0),
                heroAttributes: PhotoViewHeroAttributes(
                  tag: widget.heroTag ??
                      (widget.imageProviders ?? widget.imageUrls)![index]
                          .hashCode,
                ),
                scaleStateCycle: (value) {
                  setState(() {
                    if (value == PhotoViewScaleState.initial ||
                        value == PhotoViewScaleState.zoomedOut) {
                      isZoomed = false;
                    }
                    if (value == PhotoViewScaleState.covering ||
                        value == PhotoViewScaleState.zoomedIn) {
                      isZoomed = true;
                    }
                  });

                  return value;
                },
                errorBuilder: (context, error, stackTrace) => GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: widget.errorWidget ??
                      const Center(
                        child: Material(
                          type: MaterialType.transparency,
                          child: Text(
                            'Failed to load image',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                ),
              ),
            ),
          ),
          if (widget.showCloseButton)
            PositionedDirectional(
              top: kToolbarHeight,
              end: CustomImageCarousel._closeIconSidePadding,
              child: AnimatedSlide(
                duration: CustomImageCarousel._closeIconAnimationDuration,
                offset: isDragging || isZoomed
                    ? CustomImageCarousel._closeIconSlideOffset
                    : Offset.zero,
                child: AnimatedOpacity(
                  duration: CustomImageCarousel._closeIconAnimationDuration * 2,
                  opacity: isDragging || isZoomed ? 0.0 : 1.0,
                  child: Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      borderRadius: BorderRadius.circular(
                        CustomImageCarousel._closeIconSize / 2,
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            CustomImageCarousel._closeIconSize / 2,
                          ),
                          color: CustomImageCarousel._closeIconBackgroundColor,
                        ),
                        child: const Icon(
                          Icons.close,
                          size: CustomImageCarousel._closeIconSize,
                          color: CustomImageCarousel._closeIconColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          if (widget.showPageIndicator)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                    const EdgeInsets.only(bottom: kBottomNavigationBarHeight),
                child: AnimatedSlide(
                  duration: CustomImageCarousel._pageIndiatorAnimationDuration,
                  offset: isDragging || isZoomed
                      ? CustomImageCarousel._pageIndicatorSlideOffset
                      : Offset.zero,
                  child: AnimatedOpacity(
                    duration:
                        CustomImageCarousel._pageIndiatorAnimationDuration * 2,
                    opacity: isDragging || isZoomed ? 0.0 : 1.0,
                    child: Container(
                      padding: CustomImageCarousel._pageIndicatorPadding,
                      decoration: BoxDecoration(
                        borderRadius:
                            CustomImageCarousel._pageIndicatorBorderRadius,
                        color:
                            CustomImageCarousel._pageIndicatorBackgroundColor,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${currentPage + 1}',
                            style: widget.currentPageTextstyle,
                          ),
                          Text(
                            ' / ',
                            style: widget.pageIndicatorSeperatorTextstyle,
                          ),
                          Text(
                            '${(widget.imageProviders ?? widget.imageUrls)!.length}',
                            style: widget.totalAmountOfPagesTextstyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ...widget.extraChildren,
        ],
      ),
    );
  }
}

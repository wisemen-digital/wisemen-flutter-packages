import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

/// Fullscreen image widget
class FullscreenImage extends StatefulWidget {
  /// Constructor [FullscreenImage.asset] for asset image
  const FullscreenImage.asset({
    required this.imageAsset,
    required this.child,
    super.key,
    this.errorWidget,
  }) : imageUrl = null,
       imagePath = null;

  /// Constructor [FullscreenImage.network] for cached network image
  const FullscreenImage.network({
    required this.imageUrl,
    required this.child,
    super.key,
    this.errorWidget,
  }) : imagePath = null,
       imageAsset = null;

  /// Constructor [FullscreenImage.file] for file image
  const FullscreenImage.file({
    required this.imagePath,
    required this.child,
    super.key,
    this.errorWidget,
  }) : imageUrl = null,
       imageAsset = null;

  /// Image URL
  final String? imageUrl;

  /// Image path
  final String? imagePath;

  /// Image asset
  final String? imageAsset;

  /// Child widget
  final Widget child;

  /// Error widget
  final Widget? errorWidget;

  @override
  State<FullscreenImage> createState() => _FullscreenImageState();
}

class _FullscreenImageState extends State<FullscreenImage> {
  /// Image hero key
  final Key heroKey = UniqueKey();
  bool isDragging = false;
  bool isZoomed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Hero(
        tag: heroKey,
        child: widget.child,
      ),
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder<dynamic>(
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
            pageBuilder: (BuildContext context, _, __) {
              return Scaffold(
                backgroundColor: Colors.black,
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
                      direction: DismissiblePageDismissDirection.multi,
                      dismissThresholds: const {
                        DismissiblePageDismissDirection.multi: .2,
                      },
                      minScale: 1,
                      child: Hero(
                        tag: heroKey,
                        child: PhotoView(
                          errorBuilder: (context, error, stackTrace) =>
                              GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child:
                                    widget.errorWidget ??
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
                          imageProvider: widget.imageUrl != null
                              ? CachedNetworkImageProvider(widget.imageUrl!)
                              : widget.imagePath != null
                              ? Image.file(File(widget.imagePath!)).image
                              : Image.asset(widget.imageAsset!).image,
                          onTapUp: (context, details, controllerValue) {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    PositionedDirectional(
                      top: kToolbarHeight,
                      end: 24,
                      child: AnimatedSlide(
                        duration: Durations.short2,
                        offset: isDragging || isZoomed
                            ? const Offset(0, -.5)
                            : Offset.zero,
                        child: AnimatedOpacity(
                          duration: Durations.short2 * 2,
                          opacity: isDragging || isZoomed ? 0.0 : 1.0,
                          child: Material(
                            type: MaterialType.transparency,
                            child: InkWell(
                              onTap: () => Navigator.of(context).pop(),
                              borderRadius: BorderRadius.circular(
                                24 / 2,
                              ),
                              child: Ink(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    24 / 2,
                                  ),
                                  color: Colors.black,
                                ),
                                child: const Icon(
                                  Icons.close,
                                  size: 24,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

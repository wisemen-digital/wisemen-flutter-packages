import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// Widget that displays a cached network image with support for nullable URLs.
///
/// Wraps [CachedNetworkImage] but handles null image URLs gracefully by
/// showing the error widget when the URL is null or when the image fails to load.
///
/// Used internally for displaying user profile pictures with a fallback to initials.
class NullableCachedNetworkImage extends StatelessWidget {
  /// Creates a nullable cached network image widget.
  const NullableCachedNetworkImage({
    required this.imageUrl,
    required this.errorWidget,
    super.key,
    this.fit,
    this.placeholder,
    this.alignment = Alignment.center,
  });

  /// The URL of the image to display. Can be null.
  final String? imageUrl;

  /// How the image should be inscribed into the box.
  final BoxFit? fit;

  /// Widget to display when the image fails to load or URL is null.
  final LoadingErrorWidgetBuilder errorWidget;

  /// Widget to display while the image is loading.
  final PlaceholderWidgetBuilder? placeholder;

  /// How to align the image within its bounds.
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null) {
      return errorWidget(context, imageUrl ?? '', Exception());
    }

    return CachedNetworkImage(imageUrl: imageUrl!, fit: fit, errorWidget: errorWidget, placeholder: placeholder, alignment: alignment);
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NullableCachedNetworkImage extends StatelessWidget {
  const NullableCachedNetworkImage({
    super.key,
    required this.imageUrl,
    this.fit,
    required this.errorWidget,
    this.placeholder,
    this.alignment = Alignment.center,
  });

  final String? imageUrl;
  final BoxFit? fit;
  final LoadingErrorWidgetBuilder errorWidget;
  final PlaceholderWidgetBuilder? placeholder;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null) {
      return errorWidget(context, imageUrl ?? '', Exception());
    }

    return CachedNetworkImage(imageUrl: imageUrl!, fit: fit, errorWidget: errorWidget, placeholder: placeholder, alignment: alignment);
  }
}

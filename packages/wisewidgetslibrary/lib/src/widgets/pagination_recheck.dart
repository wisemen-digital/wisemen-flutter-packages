import 'package:flutter/material.dart';

import '../../wisewidgetslibrary.dart';

/// [PaginationRecheck] fetches the next page when [controller]'s loading ends
/// while the watched end of the enclosing scroll view is within one viewport
/// of being visible.
class PaginationRecheck extends StatefulWidget {
  /// Constructor [PaginationRecheck]
  const PaginationRecheck({
    required this.controller,
    required this.forward,
    required this.child,
    super.key,
  });

  /// [InfiniteScrollController] that loads the pages of [child]
  final InfiniteScrollController<dynamic> controller;

  /// Whether [child] grows toward the end of the scroll view (true) or
  /// toward its start (false)
  final bool forward;

  /// The sliver to re-check
  final Widget child;

  @override
  State<PaginationRecheck> createState() => _PaginationRecheckState();
}

class _PaginationRecheckState extends State<PaginationRecheck> {
  @override
  void initState() {
    super.initState();
    widget.controller.isLoading.addListener(_onLoadingChanged);
  }

  @override
  void didUpdateWidget(covariant PaginationRecheck oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.isLoading.removeListener(_onLoadingChanged);
      widget.controller.isLoading.addListener(_onLoadingChanged);
    }
  }

  @override
  void dispose() {
    widget.controller.isLoading.removeListener(_onLoadingChanged);
    super.dispose();
  }

  // Items can arrive while isLoading is still true, and easy_infinite_pagination
  // only fetches when a new last item is built, so it never re-checks once
  // loading ends and the list would stall.
  void _onLoadingChanged() {
    final controller = widget.controller;
    if (controller.isLoading.value || controller.error.value != null) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final position = context
          .findAncestorStateOfType<ScrollableState>()
          ?.position;
      if (position == null || !position.hasContentDimensions) return;
      final remaining = widget.forward
          ? position.extentAfter
          : position.extentBefore;
      if (remaining < position.viewportDimension) {
        controller.onFetchData();
      }
    });
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

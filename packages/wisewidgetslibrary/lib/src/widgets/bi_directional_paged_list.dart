import 'package:easy_infinite_pagination/easy_infinite_pagination.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shimmer/shimmer.dart';

import '../../wisewidgetslibrary.dart';

/// [BiDirectionalPagedList] that displays items growing both backward and
/// forward from an anchor point, each direction driven by its own
/// [InfiniteScrollController].
///
/// Useful for lists that open on a starting point and can page further in
/// either direction, e.g. a calendar list that opens on today and lets the
/// user scroll up into the past or down into the future.
class BiDirectionalPagedList<T> extends StatefulWidget {
  /// [BiDirectionalPagedList] constructor
  const BiDirectionalPagedList({
    required this.backwardItems,
    required this.forwardItems,
    required this.itemBuilder,
    required this.backwardController,
    required this.forwardController,
    required this.errorBuilder,
    this.emptyState,
    this.forwardEmptyState,
    this.backwardEmptyState,
    super.key,
    this.separatorBuilder,
    this.shrinkWrap = false,
    this.physics,
    this.padding = EdgeInsets.zero,
    this.shimmerItem,
    this.pageSize = 25,
    this.animationInterval = 200,
    this.shimmerColor,
    this.shimmerHighlightColor,
    this.invisibleItemsThreshold = 5,
    this.scrollDirection = Axis.vertical,
    this.scrollController,
  });

  /// Items before the anchor, ordered nearest-to-anchor first
  /// (e.g. yesterday, the day before, ...)
  final List<T> backwardItems;

  /// Items from the anchor onward, ordered nearest-to-anchor first
  /// (e.g. today, tomorrow, ...)
  final List<T> forwardItems;

  /// A builder function that builds an item widget at the given index
  final Widget Function(BuildContext context, T item, int index) itemBuilder;

  /// A builder function that builds a separator widget between items
  final Widget Function(BuildContext, int)? separatorBuilder;

  /// [InfiniteScrollController] that manages pagination and loading state
  /// for the backward (before the anchor) direction
  final InfiniteScrollController<dynamic> backwardController;

  /// [InfiniteScrollController] that manages pagination and loading state
  /// for the forward (from the anchor onward) direction
  final InfiniteScrollController<dynamic> forwardController;

  /// Empty state widget to display when a direction has no items.
  /// Reused for both the backward and forward direction.
  final Widget? emptyState;

  /// Empty state widget to display when there are no forward items remaining
  /// This overrides the normal empty state
  final Widget? forwardEmptyState;

  /// Empty state widget to display when there are no backward items remaining
  /// This overrides the normal empty state
  final Widget? backwardEmptyState;

  /// Whether the list should shrink wrap to its content
  final bool shrinkWrap;

  /// Scroll physics for the list
  final ScrollPhysics? physics;

  /// Padding applied to both directions.
  ///
  /// Note: since backward and forward are separate slivers meeting at the
  /// anchor, non-zero padding is applied on both sides of the seam between
  /// them (it doubles up visually at the anchor). Leave at zero if that seam
  /// padding is undesirable.
  final EdgeInsetsGeometry padding;

  /// Error builder function to display when an error occurs during loading.
  /// Reused for both the backward and forward direction.
  final Widget Function(BuildContext context, void Function() onRetry)
  errorBuilder;

  /// Optional shimmer item to display while loading
  final T? shimmerItem;

  /// Number of items to display in the shimmer loading indicator
  /// Defaults to 25, can be changed to match the expected page size
  final int pageSize;

  /// Animation interval for shimmer items
  /// Defaults to 200 milliseconds, can be adjusted for faster APIs
  final int animationInterval;

  /// Optional shimmer colors for the loading indicator
  final Color? shimmerColor;

  /// Optional shimmer highlight color for the loading indicator
  final Color? shimmerHighlightColor;

  /// The threshold for the number of invisible items to trigger fetching more data.
  final int invisibleItemsThreshold;

  /// The [Axis] along which the scroll view's offset increases.
  /// Defaults to [Axis.vertical].
  final Axis scrollDirection;

  /// Optional [ScrollController] for the underlying [CustomScrollView]
  final ScrollController? scrollController;

  @override
  State<BiDirectionalPagedList<T>> createState() =>
      _BiDirectionalPagedListState<T>();
}

class _BiDirectionalPagedListState<T> extends State<BiDirectionalPagedList<T>> {
  // The anchor sliver key must stay stable across rebuilds, since
  // CustomScrollView.center identifies the anchor sliver by key identity.
  final Key _centerKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.backwardController.isLoading,
      builder: (context, isLoadingBackward, __) => ValueListenableBuilder(
        valueListenable: widget.forwardController.isLoading,
        builder: (context, isLoadingForward, __) => CustomScrollView(
          center: _centerKey,
          controller: widget.scrollController,
          scrollDirection: widget.scrollDirection,
          shrinkWrap: widget.shrinkWrap,
          physics: widget.physics,
          slivers: [
            SliverPadding(
              padding: widget.padding,
              sliver: _buildSliver(
                context: context,
                items: widget.backwardItems,
                controller: widget.backwardController,
                isLoading: isLoadingBackward,
                emptyState:
                    widget.backwardEmptyState ??
                    widget.emptyState ??
                    const SizedBox.shrink(),
              ),
            ),
            SliverPadding(
              key: _centerKey,
              padding: widget.padding,
              sliver: _buildSliver(
                context: context,
                items: widget.forwardItems,
                controller: widget.forwardController,
                isLoading: isLoadingForward,
                emptyState:
                    widget.forwardEmptyState ??
                    widget.emptyState ??
                    const SizedBox.shrink(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSliver({
    required BuildContext context,
    required List<T> items,
    required InfiniteScrollController<dynamic> controller,
    required bool isLoading,
    required Widget emptyState,
  }) {
    return SliverInfiniteListView.separated(
      enableShrinkWrapForFirstPageIndicators: true,
      separatorBuilder:
          widget.separatorBuilder ?? (_, __) => const SizedBox.shrink(),
      delegate: PaginationDelegate(
        isLoading: isLoading,
        itemCount: items.length,
        hasError: controller.error.value != null,
        hasReachedMax: controller.value.isLastPage,
        itemBuilder: (context, index) =>
            widget.itemBuilder(context, items[index], index),
        onFetchData: controller.onFetchData,
        firstPageErrorBuilder: (context, onRetry) => emptyState,
        firstPageLoadingBuilder: (context) => widget.shimmerItem == null
            ? _circularLoadingIndicator(context)
            : _shimmerLoadingIndicator(context),
        loadMoreLoadingBuilder: (context) => !isLoading
            ? gapHM
            : widget.shimmerItem == null
            ? _circularLoadingIndicator(context)
            : _shimmerLoadingIndicator(context),
        firstPageNoItemsBuilder: (context) => Center(child: widget.emptyState),
        loadMoreErrorBuilder: (context, onRetry) =>
            Center(child: widget.errorBuilder(context, onRetry)),
        loadMoreNoMoreItemsBuilder: (context) => const SizedBox.shrink(),
        invisibleItemsThreshold: widget.invisibleItemsThreshold,
      ),
    );
  }

  Widget _circularLoadingIndicator(BuildContext context) {
    return Center(
      child: PlatformLoadingIndicator(
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }

  Widget _shimmerLoadingIndicator(BuildContext context) {
    return IgnorePointer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List<Widget>.generate(
          widget.pageSize,
          (index) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Shimmer.fromColors(
                baseColor: widget.shimmerColor ?? Colors.grey.shade300,
                highlightColor:
                    widget.shimmerHighlightColor ?? Colors.grey.shade100,
                child: widget.itemBuilder(
                  context,
                  widget.shimmerItem as T,
                  index,
                ),
              ).animate().fadeIn(
                duration: Duration(
                  milliseconds: index * widget.animationInterval,
                ),
                curve: Curves.easeIn,
              ),
              if (widget.separatorBuilder != null)
                widget.separatorBuilder!(context, index),
            ],
          ),
        ),
      ),
    );
  }
}

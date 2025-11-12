import 'package:easy_infinite_pagination/easy_infinite_pagination.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shimmer/shimmer.dart';

import '../../wisewidgetslibrary.dart';

/// [PagedList] that displays items using an items list and [InfiniteScrollController]
class PagedList<T> extends StatelessWidget {
  /// [PagedList] constructor
  const PagedList({
    required this.items,
    required this.itemBuilder,
    required this.controller,
    required this.emptyState,
    required this.errorBuilder,
    super.key,
    this.separatorBuilder,
    this.shrinkWrap = true,
    this.physics = const NeverScrollableScrollPhysics(),
    this.padding = EdgeInsets.zero,
    this.shimmerItem,
    this.pageSize = 25,
    this.animationInterval = 200,
    this.shimmerColor,
    this.shimmerHighlightColor,
    this.invisibleItemsThreshold = 5,
  });

  /// List of items to display, usually a stream from database
  final List<T> items;

  /// A builder function that builds an item widget at the given index
  final Widget Function(BuildContext context, T item, int index) itemBuilder;

  /// A builder function that builds a separator widget between items
  final Widget Function(BuildContext, int)? separatorBuilder;

  /// [InfiniteScrollController] that manages pagination and loading state
  /// Can have any KeyType
  final InfiniteScrollController<dynamic> controller;

  /// Empty state widget to display when there are no items
  final Widget emptyState;

  /// Whether the list should shrink wrap to its content
  final bool shrinkWrap;

  /// Scroll physics for the list
  final ScrollPhysics physics;

  /// Padding for the list
  final EdgeInsetsGeometry padding;

  /// Error builder function to display when an error occurs during loading
  final Widget Function(BuildContext context, void Function() onRetry) errorBuilder;

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

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller.isLoading,
      builder: (context, isLoading, child) => InfiniteListView.separated(
        shrinkWrap: shrinkWrap,
        physics: physics,
        padding: padding,
        separatorBuilder: separatorBuilder ?? (_, __) => const SizedBox.shrink(),
        delegate: PaginationDelegate(
          isLoading: isLoading,
          itemCount: items.length,
          hasError: controller.error.value != null,
          hasReachedMax: controller.value.isLastPage,
          itemBuilder: (context, index) {
            return itemBuilder(context, items[index], index);
          },
          onFetchData: controller.onFetchData,
          firstPageErrorBuilder: (context, onRetry) => Center(child: emptyState),
          firstPageLoadingBuilder: (context) => shimmerItem == null ? _circularLoadingIndicator(context) : _shimmerLoadingIndicator(context),
          loadMoreLoadingBuilder: (context) => !isLoading
              ? gapHM
              : shimmerItem == null
              ? _circularLoadingIndicator(context)
              : _shimmerLoadingIndicator(context),
          firstPageNoItemsBuilder: (context) => Center(child: emptyState),
          loadMoreErrorBuilder: (context, onRetry) => Center(child: errorBuilder(context, onRetry)),
          loadMoreNoMoreItemsBuilder: (context) => const SizedBox.shrink(),
          invisibleItemsThreshold: invisibleItemsThreshold,
        ),
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
          pageSize,
          (index) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Shimmer.fromColors(
                baseColor: shimmerColor ?? Colors.grey.shade300,
                highlightColor: shimmerHighlightColor ?? Colors.grey.shade100,
                child: itemBuilder(context, shimmerItem as T, index),
              ).animate().fadeIn(
                duration: Duration(milliseconds: index * animationInterval),
                curve: Curves.easeIn,
              ),
              if (separatorBuilder != null) separatorBuilder!(context, index),
            ],
          ),
        ),
      ),
    );
  }
}

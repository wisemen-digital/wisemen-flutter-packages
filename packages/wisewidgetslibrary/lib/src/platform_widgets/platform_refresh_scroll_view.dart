import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/sliver_pinned_overlap_injector.dart';
import 'platform_widget.dart';

/// [PlatformCustomScrollRefreshIndicator] with CustomScrollView and RefreshIndicator
class PlatformCustomScrollRefreshIndicator extends PlatformWidget {
  /// Constructor [PlatformCustomScrollRefreshIndicator]
  const PlatformCustomScrollRefreshIndicator({
    required this.slivers,
    required this.onRefresh,
    super.key,
    this.scrollController,
    this.indicatorColor,
    this.indicatorBackgroundColor,
    this.injectOverlap = true,
  });

  /// Body slivers (under the refresh indicator)
  final List<Widget> slivers;

  /// Refresh indicator
  final Future<void> Function() onRefresh;

  /// Optional scroll controller
  final ScrollController? scrollController;

  /// Indicator color
  final Color? indicatorColor;

  /// Indicator background color
  final Color? indicatorBackgroundColor;

  /// Inject overlap used when in nested scroll view
  final bool injectOverlap;

  @override
  Widget createCupertinoWidget(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        CupertinoSliverRefreshControl(
          onRefresh: onRefresh,
          builder: (
            context,
            refreshState,
            pulledExtent,
            refreshTriggerPullDistance,
            refreshIndicatorExtent,
          ) {
            return Padding(
              padding: injectOverlap
                  ? EdgeInsets.only(
                      top: NestedScrollView.sliverOverlapAbsorberHandleFor(
                            context,
                          ).layoutExtent ??
                          0,
                    )
                  : EdgeInsets.zero,
              child: CupertinoSliverRefreshControl.buildRefreshIndicator(
                context,
                refreshState,
                pulledExtent,
                refreshTriggerPullDistance,
                refreshIndicatorExtent,
              ),
            );
          },
        ),
        if (injectOverlap)
          SliverPinnedOverlapInjector(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          ),
        ...slivers,
      ],
    );
  }

  @override
  Widget createMaterialWidget(BuildContext context) {
    return RefreshIndicator(
      displacement: injectOverlap
          ? (NestedScrollView.sliverOverlapAbsorberHandleFor(
                    context,
                  ).layoutExtent ??
                  0) +
              40
          : 40, //* standard displacement is 40
      color: indicatorColor,
      backgroundColor: indicatorBackgroundColor,
      onRefresh: onRefresh,
      child: CustomScrollView(
        slivers: [
          if (injectOverlap)
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
          ...slivers,
        ],
      ),
    );
  }
}

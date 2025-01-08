import 'package:flutter/cupertino.dart';

/// A Cupertino-style refresh indicator that works with [SafeArea].
class SafeAreaCupertinoRefreshIndicator extends StatelessWidget {
  /// Constructor [SafeAreaCupertinoRefreshIndicator]
  const SafeAreaCupertinoRefreshIndicator({
    required this.onRefresh,
    super.key,
  });

  /// Refresh callback
  final RefreshCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return CupertinoSliverRefreshControl(
      refreshIndicatorExtent: 0,
      onRefresh: onRefresh,
      builder: (
        context,
        refreshState,
        pulledExtent,
        refreshTriggerPullDistance,
        refreshIndicatorExtent,
      ) {
        return Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
          ),
          child: CupertinoSliverRefreshControl.buildRefreshIndicator(
            context,
            refreshState,
            pulledExtent,
            refreshTriggerPullDistance,
            refreshIndicatorExtent,
          ),
        );
      },
    );
  }
}

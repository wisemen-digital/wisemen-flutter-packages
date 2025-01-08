import 'package:flutter/cupertino.dart';

class SafeAreaCupertinoRefreshIndicator extends StatelessWidget {
  const SafeAreaCupertinoRefreshIndicator({
    required this.onRefresh,
    super.key,
  });

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

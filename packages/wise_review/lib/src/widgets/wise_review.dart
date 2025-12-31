import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:wisecore/wisecore.dart';

import '../constants/constants.dart';

/// A widget that automatically shows a store review prompt based on app open count.
///
/// This widget tracks how many times the app has been opened and displays
/// an in-app review prompt when the [minimumOpenCount] threshold is reached
/// and [canShowReview] is true.
///
/// The open count is incremented on:
/// - Widget initialization
/// - App lifecycle resume (when app returns to foreground)
///
/// Example:
/// ```dart
/// WiseReview(
///   minimumOpenCount: 10,
///   canShowReview: userCompletedOnboarding,
///   child: MaterialApp(
///     home: HomeScreen(),
///   ),
/// )
/// ```
class WiseReview extends ConsumerStatefulWidget {
  /// Creates a [WiseReview] widget.
  ///
  /// The [canShowReview] and [child] parameters are required.
  /// The [minimumOpenCount] defaults to 10.
  const WiseReview({
    required this.child,
    super.key,
    this.minimumOpenCount = 10,
    this.canShowReview = true,
  });

  /// The minimum number of times the app must be opened before showing the review prompt.
  ///
  /// Defaults to 10.
  final int minimumOpenCount;

  /// Controls whether the review prompt can be shown.
  ///
  /// Use this to conditionally enable the review prompt based on app state,
  /// such as after user completes onboarding or achieves certain milestones.
  final bool canShowReview;

  /// The child widget to display.
  final Widget child;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WiseReviewState();
}

class _WiseReviewState extends ConsumerState<WiseReview>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _incrementOpenCountAndShowReviewIfNeeded(increment: true);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      _incrementOpenCountAndShowReviewIfNeeded(increment: true);
    }
  }

  @override
  void didUpdateWidget(covariant WiseReview oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!oldWidget.canShowReview && widget.canShowReview) {
      _incrementOpenCountAndShowReviewIfNeeded();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  Future<void> _incrementOpenCountAndShowReviewIfNeeded(
      {bool increment = false}) async {
    final prefs = ref.read(sharedPreferencesProvider);
    final openCount = prefs.getInt(Constants.appOpenCount) ?? 0;

    if (increment) {
      await prefs.setInt(Constants.appOpenCount, openCount + 1);
    }

    final currentCount = prefs.getInt(Constants.appOpenCount) ?? 0;
    if (currentCount >= widget.minimumOpenCount && widget.canShowReview) {
      unawaited(
        Future(() async {
          final inAppReview = InAppReview.instance;
          if (await inAppReview.isAvailable()) {
            unawaited(inAppReview.requestReview());
          }
        }),
      );
    }
  }
}

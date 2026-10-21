import 'package:flutter/material.dart';

/// A widget builder function that builds a [Center] widget containing a
/// [CircularProgressIndicator.adaptive].
///
/// This widget is used as a placeholder when the app is still fetching data
/// for the first page of a paginated list.
Widget firstPageLoadingBuilder(BuildContext context) {
  return const FirstPageLoadingBuilder();
}

/// Default indicator shown while the first page loads.
class FirstPageLoadingBuilder extends StatelessWidget {
  /// A stateless widget that displays a [Center] widget containing a
  /// [CircularProgressIndicator.adaptive].
  const FirstPageLoadingBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }
}

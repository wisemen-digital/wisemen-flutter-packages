// coverage:ignore-file

import 'package:flutter/material.dart';

/// Builds the default [FirstPageNoItemsBuilder].
Widget firstPageNoItemsBuilder(BuildContext context) {
  return const FirstPageNoItemsBuilder();
}

/// Default indicator shown when the first page has no items.
class FirstPageNoItemsBuilder extends StatelessWidget {
  /// A widget that is displayed when the list is empty.
  ///
  /// This widget is displayed in the center of the screen with a message
  /// indicating that no items are found.
  const FirstPageNoItemsBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 32,
          horizontal: 16,
        ),
        child: Column(
          children: [
            // Error message title
            Text(
              'No items found!',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            // Error message description
            const Text(
              'Oops, it seems that there are no items in this list.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

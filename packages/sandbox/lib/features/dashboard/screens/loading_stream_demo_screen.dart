import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wise_nav_bar/wise_nav_bar.dart';
import 'package:wisecore/wisecore.dart';

import '../providers/loading_stream_demo_providers.dart';

/// Shows the initial loading problem of [LoadingStreamProvider] with `whenStream`.
///
/// The database starts empty and the fetch takes 3 seconds. Expected: a
/// spinner for 3 seconds, then the items. What happens: "No items" for 3
/// seconds, because `whenStream` shows the empty list the database emits
/// before the fetch has written anything.
@RoutePage()
class LoadingStreamDemoScreen extends ConsumerWidget {
  const LoadingStreamDemoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: const Text('LoadingStreamProvider demo'),
        actions: [
          IconButton(
            tooltip: 'Empty the database and start again',
            icon: const Icon(Icons.restart_alt),
            onPressed: () {
              ref.read(demoItemsDatabaseProvider).write([]);
              ref.invalidate(demoItemsProvider);
            },
          ),
        ],
      ),
      body: Material(
        type: MaterialType.transparency,
        child: RefreshIndicator(
          onRefresh: () => ref.read(demoItemsProvider.notifier).refresh(),
          child: ref
              .watch(demoItemsProvider)
              .whenStream(
                data: (items) => ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    if (items.isEmpty) const ListTile(title: Text('No items (empty state)')),
                    for (final item in items) ListTile(title: Text(item)),
                  ],
                ),
                error: (error, stackTrace) => Center(child: Text('$error')),
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
        ),
      ),
    );
  }
}

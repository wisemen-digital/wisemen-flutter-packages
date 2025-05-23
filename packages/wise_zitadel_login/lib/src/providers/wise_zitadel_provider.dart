import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../options.dart';

/// A provider for the [WiseZitadelOptions] instance. Needs to be overridden in main
final wiseZitadelOptionsProvider = Provider<WiseZitadelOptions>(
  (ref) => throw UnimplementedError(
    'Make sure to override this container with the actual values from flavours',
  ),
);

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract interface class SettingsItem {
  String getTitle(BuildContext context);
  String? getTrailingText(WidgetRef ref);
  Widget? getTrailingWidget(BuildContext context);
  GestureTapCallback? onTap(WidgetRef ref);
}

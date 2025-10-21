import 'package:flutter/widgets.dart';
import '../settings.dart';

abstract interface class SettingsSection {
  String getTitle(BuildContext context);
  List<SettingsItem> getItems();
}

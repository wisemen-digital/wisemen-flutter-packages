import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'platform_widget.dart';

/// [PlatformSwitch] with CupertinoSwitch and Switch
class PlatformSwitch extends PlatformWidget<CupertinoSwitch, Switch> {
  /// Constructor [PlatformSwitch]
  const PlatformSwitch({
    required this.value,
    required this.onChanged,
    super.key,
    this.activeColor,
    this.inactiveColor,
  });

  /// Switch value
  final bool value;

  /// Void callback onChanged with bool value
  // ignore: avoid_positional_boolean_parameters
  final void Function(bool) onChanged;

  /// Active color
  final Color? activeColor;

  /// Border and track color on Android when the switch is off.
  final Color? inactiveColor;

  @override
  CupertinoSwitch createCupertinoWidget(BuildContext context) =>
      CupertinoSwitch(
        value: value,
        onChanged: onChanged,
        activeTrackColor: activeColor,
      );

  @override
  Switch createMaterialWidget(BuildContext context) => Switch(
    value: value,
    onChanged: onChanged,
    activeColor: activeColor,
    inactiveThumbColor: inactiveColor,
    trackOutlineColor: value
        ? null
        : WidgetStatePropertyAll(
            inactiveColor,
          ),
  );
}

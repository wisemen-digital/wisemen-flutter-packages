import 'package:flutter/material.dart';
import 'package:pull_down_button/pull_down_button.dart';

import '../constants/constants.dart';
import '../models/dropdown_model.dart';
import 'platform_widgets.dart';

/// Platform context menu [PlatformDropdownPicker]
class PlatformDropdownPicker<T extends DropdownModel> extends PlatformWidget {
  /// Constructor [PlatformDropdownPicker]
  const PlatformDropdownPicker({
    required this.child,
    required this.onChanged,
    required this.options,
    required this.borderRadius,
    required this.focusNode,
    this.backgroundColor = Colors.white,
    this.iconSize = 24,
    this.textStyle,
    this.selected,
    super.key,
  });

  /// Child widget (usually a button that opens the dropdown)
  final Widget child;

  /// Void callback onChanged with selected option
  final void Function(T? option) onChanged;

  /// Dropdown options
  final List<T> options;

  /// Selected option
  final T? selected;

  /// Border radius for the dropdown menu
  final BorderRadius borderRadius;

  /// Focus node for the dropdown
  final FocusNode focusNode;

  /// Icon size
  final double iconSize;

  /// Pulldown items text style
  final TextStyle? textStyle;

  /// Background color
  final Color backgroundColor;

  @override
  Widget createCupertinoWidget(BuildContext context) {
    return PullDownButton(
      itemBuilder: (context) => options.map(
        (e) {
          return PullDownMenuItem.selectable(
            onTap: () {
              onChanged(e);
            },
            title: e.getString(context),
            itemTheme: PullDownMenuItemTheme(
              textStyle: textStyle,
            ),
            selected: e == selected,
            iconWidget: e.icon,
          );
        },
      ).toList(),
      buttonBuilder: (context, showMenu) => Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: showMenu,
          borderRadius: borderRadius,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget createMaterialWidget(BuildContext context) {
    return MenuAnchor(
      childFocusNode: focusNode,
      style: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(backgroundColor),
      ),
      menuChildren: options.map(
        (e) {
          return MenuItemButton(
            onPressed: () {
              onChanged(e);
            },
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width * .7,
              child: Row(
                children: [
                  SizedBox(
                    width: 30,
                    child: Visibility(
                      visible: e == selected,
                      child: Icon(
                        Icons.check_rounded,
                        color: textStyle?.color,
                        size: iconSize,
                      ),
                    ),
                  ),
                  gapWS,
                  Expanded(
                    child: Text(
                      e.getString(context),
                      style: textStyle,
                    ),
                  ),
                  gapWS,
                  if (e.icon != null) e.icon!,
                ],
              ),
            ),
          );
        },
      ).toList(),
      builder: (_, MenuController controller, Widget? nestedChild) {
        return Material(
          type: MaterialType.transparency,
          child: InkWell(
            focusNode: focusNode,
            borderRadius: borderRadius,
            onTap: () {
              if (controller.isOpen) {
                controller.close();
              } else {
                controller.open();
              }
            },
            child: child,
          ),
        );
      },
    );
  }
}

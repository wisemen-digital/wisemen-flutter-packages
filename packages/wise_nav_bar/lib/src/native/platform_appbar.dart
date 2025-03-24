import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/utils.dart';

/// Base Native [PlatformAppBar] that combines the shared variables of [AppBar]
/// and [CupertinoNavigationBar].
/// Material specs: https://m3.material.io/components/top-app-bar
/// Cupertino specs: https://developer.apple.com/design/human-interface-guidelines/navigation-bars
class PlatformAppBar extends PlatformWidget
    implements ObstructingPreferredSizeWidget {
  /// Constructor [PlatformAppBar]
  const PlatformAppBar({
    required super.platformService,
    super.key,
    this.leading,
    this.previousPageTitle,
    this.title,
    this.actions,
    this.actionSpacing = 8,
    this.backgroundColor,
    this.brightness,
    this.border,
    this.bottom,
    this.automaticBackgroundVisibility = true,
    this.enableBackgroundFilterBlur = true,
    this.centerTitle = false,
    this.transitionBetweenRoutes = true,
  });

  /// Constructor [PlatformAppBar.text]
  PlatformAppBar.text({
    required String title,
    required super.platformService,
    super.key,
    this.leading,
    this.previousPageTitle,
    this.actions,
    this.actionSpacing = 8,
    this.backgroundColor,
    this.brightness,
    this.border,
    this.bottom,
    this.automaticBackgroundVisibility = true,
    this.enableBackgroundFilterBlur = true,
    this.centerTitle = false,
    this.transitionBetweenRoutes = true,
  }) : title = Text(title);

  /// Title widget of the navigation bar.
  /// Usually a [Text] widget that describes the content on the screen.
  /// Material: [AppBar.title] Headline text should easily fit within the top app bar.
  /// It should not be truncated or shrunken
  /// Cupertino: [CupertinoNavigationBar.middle] Text should be no longer than
  /// 15 characters
  final Widget? title;

  /// Leading widget usually in charge of navigation.
  /// Material: [AppBar.leading] usually a menu icon or back button
  /// Cupertino: [CupertinoNavigationBar.leading] usually a back button
  /// with previous page title
  final Widget? leading;

  /// [CupertinoNavigationBar.previousPageTitle] Title of the previous route, iOS only
  /// Defaults to 'Back' when title is longer than 12 characters
  final String? previousPageTitle;

  /// List of actions widgets that are usually icons or buttons.
  /// Could be in charge of navigation too on iOS
  final List<Widget>? actions;

  /// Spacing between each action widget
  final double actionSpacing;

  /// Background color of the navigation bar
  final Color? backgroundColor;

  /// Brightness of the navigation bar. Controls the color of the status bar
  final Brightness? brightness;

  /// Border around the navigation bar container. Usually only bottom
  final Border? border;

  /// [CupertinoNavigationBar.automaticBackgroundVisibility] Automatically
  /// show or hide the background. Ignores [backgroundColor] when set
  final bool automaticBackgroundVisibility;

  /// [CupertinoNavigationBar.enableBackgroundFilterBlur] Enable background
  /// filter blur. Defaults to true
  final bool enableBackgroundFilterBlur;

  /// [CupertinoNavigationBar.transitionBetweenRoutes] Animate the transition between pages
  /// Defaults to true, disable this for things like the first route in a bottom sheet
  final bool transitionBetweenRoutes;

  /// [AppBar.centerTitle] Center the title widget always true on iOS
  final bool centerTitle;

  /// [AppBar.bottom] on Android, [CupertinoNavigationBar.bottom] widget that appears at the bottom of the app bar
  final PreferredSizeWidget? bottom;

  @override
  PreferredSizeWidget createMaterialWidget(BuildContext context) {
    return AppBar(
      key: key,
      leading: leading,
      title: title,
      actions: actions
          ?.map<Widget>(
            (e) => Padding(
              padding: EdgeInsets.only(right: actionSpacing),
              child: e,
            ),
          )
          .toList(),
      backgroundColor: backgroundColor,
      systemOverlayStyle: brightness != null
          ? SystemUiOverlayStyle(
              statusBarBrightness: brightness,
            )
          : null,
      shape: border,
      centerTitle: centerTitle,
      bottom: bottom,
    );
  }

  @override
  ObstructingPreferredSizeWidget createCupertinoWidget(BuildContext context) {
    return CupertinoNavigationBar(
      key: key,
      leading: leading,
      previousPageTitle: previousPageTitle,
      middle: title,
      trailing: actions != null
          ? Row(
              mainAxisSize: MainAxisSize.min,
              spacing: actionSpacing,
              children: actions!,
            )
          : null,
      backgroundColor: backgroundColor,
      brightness: brightness,
      border: border,
      enableBackgroundFilterBlur: enableBackgroundFilterBlur,
      automaticBackgroundVisibility: automaticBackgroundVisibility,
      transitionBetweenRoutes: transitionBetweenRoutes,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize {
    final heightForDrawer = bottom?.preferredSize.height ?? 0.0;
    if (kIsWeb) {
      return Size.fromHeight(kToolbarHeight + heightForDrawer);
    }
    if (Platform.isAndroid || Platform.isFuchsia || Platform.isWindows) {
      return Size.fromHeight(kToolbarHeight + heightForDrawer);
    } else if (Platform.isIOS || Platform.isMacOS || Platform.isLinux) {
      return Size.fromHeight(
        kMinInteractiveDimensionCupertino + heightForDrawer,
      );
    }
    return Size.zero;
  }

  @override
  bool shouldFullyObstruct(BuildContext context) {
    return true;
  }
}

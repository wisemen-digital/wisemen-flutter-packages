import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/utils.dart';

/// Base Native [PlatformSliverAppBar] that combines the shared variables of [SliverAppBar.medium]
/// and [CupertinoSliverNavigationBar].
/// Material specs: https://m3.material.io/components/top-app-bar
/// Cupertino specs: https://developer.apple.com/design/human-interface-guidelines/navigation-bars
class PlatformSliverAppBar extends PlatformWidget {
  /// Constructor [PlatformSliverAppBar]
  const PlatformSliverAppBar({
    super.key,
    this.leading,
    this.previousPageTitle,
    this.title,
    this.largeTitle,
    this.actions,
    this.actionSpacing = 8,
    this.backgroundColor,
    this.brightness,
    this.border,
    this.bottom,
    this.bottomMode,
    this.automaticBackgroundVisibility = true,
    this.enableBackgroundFilterBlur = true,
    this.centerTitle = false,
    this.transitionBetweenRoutes = true,
  });

  /// Constructor [PlatformSliverAppBar.text]
  PlatformSliverAppBar.text({
    required String title,
    EdgeInsetsDirectional androidLargeTitlePadding =
        const EdgeInsetsDirectional.all(16),
    TextStyle androidLargeTitleStyle = const TextStyle(fontSize: 24),
    super.key,
    this.leading,
    this.previousPageTitle,
    this.actions,
    this.actionSpacing = 8,
    this.backgroundColor,
    this.brightness,
    this.border,
    this.bottom,
    this.bottomMode,
    this.automaticBackgroundVisibility = true,
    this.enableBackgroundFilterBlur = true,
    this.centerTitle = false,
    this.transitionBetweenRoutes = true,
  })  : title = Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        largeTitle = _buildLargeTitleWidget(
          title,
          androidLargeTitlePadding,
          androidLargeTitleStyle,
          bottom,
        );

  /// Title widget of the navigation bar.
  /// Usually a [Text] widget that describes the content on the screen.
  /// Material: [SliverAppBar.title] Headline text should easily fit within the top app bar.
  /// It should not be truncated or shrunken
  /// Cupertino: [CupertinoSliverNavigationBar.middle] Text should be no longer than
  /// 15 characters
  final Widget? title;

  /// Large title widget of the navigation bar.
  /// Usually a [Text] widget aligned bottom left.
  /// Material: [SliverAppBar.title] Headline text should easily fit within the top app bar.
  /// It should not be truncated or shrunken
  /// Cupertino: [CupertinoSliverNavigationBar.middle] Text should be no longer than
  /// 15 characters
  final Widget? largeTitle;

  /// Leading widget usually in charge of navigation.
  /// Material: [SliverAppBar.leading] usually a menu icon or back button
  /// Cupertino: [CupertinoSliverNavigationBar.leading] usually a back button
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

  /// [SliverAppBar.centerTitle] Center the title widget always true on iOS
  final bool centerTitle;

  /// [AppBar.bottom] on Android, [CupertinoNavigationBar.bottom] widget that appears at the bottom of the app bar
  final PreferredSizeWidget? bottom;

  /// [NavigationBarBottomMode] type of the bottom navigation bar, iOS only
  final NavigationBarBottomMode? bottomMode;

  @override
  Widget createMaterialWidget(BuildContext context) {
    return SliverAppBar.medium(
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
      scrolledUnderElevation: 12,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: largeTitle,
      ),
    );
  }

  @override
  Widget createCupertinoWidget(BuildContext context) {
    return CupertinoSliverNavigationBar(
      key: key,
      leading: leading,
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
      middle: title,
      alwaysShowMiddle: false,
      largeTitle: largeTitle,
      bottom: bottom,
      bottomMode: bottomMode,
      previousPageTitle: previousPageTitle,
    );
  }

  static Widget? _buildLargeTitleWidget(
    String title,
    EdgeInsetsDirectional androidLargeTitlePadding,
    TextStyle androidLargeTitleStyle,
    PreferredSizeWidget? bottom,
  ) {
    if (kIsWeb ||
        Platform.isAndroid ||
        Platform.isFuchsia ||
        Platform.isWindows) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: androidLargeTitlePadding,
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: androidLargeTitleStyle,
            ),
          ),
          if (bottom != null) SizedBox.fromSize(size: bottom.preferredSize),
        ],
      );
    } else if (Platform.isIOS || Platform.isMacOS || Platform.isLinux) {
      return Text(title);
    }
    return null;
  }
}

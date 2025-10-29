// ignore_for_file: depend_on_referenced_packages

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wise_theming/wise_theming.dart';
import 'package:wisecore/wisecore.dart';
import 'package:wisewidgetslibrary/wisewidgetslibrary.dart';

import '../login.dart';

/// The main login screen widget that displays authentication options.
///
/// This screen provides a visually animated login interface with support for
/// multiple authentication methods (Apple, Google, Email, and custom providers).
/// It displays a splash image background with an animated bottom sheet containing
/// login options.
///
/// The screen automatically retrieves supported login methods from [LoginFlavors]
/// and displays them with appropriate icons and labels. Each method shows a
/// loading indicator when authentication is in progress.
///
/// Example usage:
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(
///     builder: (_) => LoginScreen(
///       belowTitleHeader: Text('Welcome back!'),
///       footer: TermsAndConditionsWidget(),
///     ),
///   ),
/// );
/// ```
class LoginScreen extends ConsumerStatefulWidget {
  /// Creates a LoginScreen widget.
  ///
  /// All parameters are optional and can be used to customize the UI.
  const LoginScreen({
    super.key,
    this.belowTitleHeader,
    this.footer,
  });

  /// Optional widget to display below the title and subtitle.
  ///
  /// This can be used to add custom content such as welcome messages,
  /// promotional text, or other UI elements.
  final Widget? belowTitleHeader;

  /// Optional widget to display at the bottom of the login options.
  ///
  /// Commonly used for terms and conditions, privacy policy links,
  /// or other footer content.
  final Widget? footer;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(milliseconds: 500),
      () => setState(() {
        _isOpen = true;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final supportedMethods = ref.watch(supportedLoginTypesProvider);
    final selectedMethod = ref.watch(selectedLoginMethodProvider);

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: ColoredBox(
              color: context.backgroundColors.primary,
              child: Image.asset(LoginFeature.assets.splashImage, fit: BoxFit.cover),
            ),
          ),
          if (LoginFeature.flavors.splashImage.isNotEmpty)
            Positioned.fill(
              child: ColoredBox(
                color: context.backgroundColors.primary,
                child: CachedNetworkImage(imageUrl: LoginFeature.flavors.splashImage, fit: BoxFit.cover),
              ),
            ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: AnimatedClipRect(
              open: _isOpen,
              child: Container(
                margin: const EdgeInsets.only(top: 64),
                padding: padM.copyWith(bottom: MediaQuery.paddingOf(context).bottom + Sizes.m),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  color: context.backgroundColors.primary,
                  boxShadow: [BoxShadow(blurRadius: 8, spreadRadius: 8, color: context.textColors.primary.withValues(alpha: 0.1))],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      LoginFeature.localizations.loginTitle(context),
                      style: context.title.copyWith(color: context.foregroundColors.primary),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      LoginFeature.localizations.loginSubtitle(context),
                      style: context.body.copyWith(color: context.foregroundColors.secondary),
                      textAlign: TextAlign.center,
                    ),
                    if (widget.belowTitleHeader != null) ...[
                      gapHM,
                      widget.belowTitleHeader!,
                    ],
                    gapHM,
                    ...supportedMethods.map(
                      (m) => Padding(
                        padding: padVXS,
                        child: Material(
                          color: context.backgroundColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: radS,
                            side: BorderSide(color: context.borderColors.primary),
                          ),
                          child: InkWell(
                            onTap: () => ref.watch(loginControllerProvider.notifier).login(m),
                            borderRadius: radS,
                            child: Padding(
                              padding: padM,
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: AnimatedOpacity(
                                      opacity: ref.watch(loginControllerProvider).isLoading && selectedMethod?.id == m.id ? 1 : 0,
                                      duration: const Duration(milliseconds: 300),
                                      child: const Center(child: PlatformLoadingIndicator()),
                                    ),
                                  ),
                                  AnimatedOpacity(
                                    opacity: ref.watch(loginControllerProvider).isLoading && selectedMethod?.id == m.id ? 0 : 1,
                                    duration: const Duration(milliseconds: 300),
                                    child: Center(
                                      child: Row(
                                        spacing: Sizes.s,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          if (m.getIconAsset() != null)
                                            SizedBox.square(
                                              dimension: 20,
                                              child: SvgPicture.asset(
                                                m.getIconAsset()!,
                                                colorFilter: m.type == LoginType.email ? context.foregroundColors.secondary.colorFiltered() : null,
                                              ),
                                            ),
                                          Text(
                                            LoginFeature.localizations.loginMethod(context, m.getTitle(context)),
                                            style: context.title.copyWith(
                                              fontSize: 16,
                                              color: context.foregroundColors.primary,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (widget.footer != null) ...[
                      gapHM,
                      widget.footer!,
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

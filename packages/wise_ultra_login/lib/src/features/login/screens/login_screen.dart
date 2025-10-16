import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wisecore/wisecore.dart';
import 'package:wisewidgetslibrary/wisewidgetslibrary.dart';
import 'package:wise_theming/wise_theming.dart';

import '../login.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

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

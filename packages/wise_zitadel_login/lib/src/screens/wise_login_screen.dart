import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wise_nav_bar/wise_nav_bar.dart';
import 'package:wisewidgetslibrary/wisewidgetslibrary.dart';

import '../providers/wise_zitadel_provider.dart';
import '../types/zitadel_login_type.dart';

/// [WiseLoginScreen] with bottom aligned buttons and a builder function
class WiseLoginScreen extends HookConsumerWidget {
  /// Constructor for [WiseLoginScreen]
  const WiseLoginScreen({
    super.key,
    this.builder,
  });

  /// The builder function used in a Scaffold
  /// Usually a brand's logo
  /// Placed at the bottom of the Stack
  final WidgetBuilder? builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final options = ref.watch(wiseZitadelOptionsProvider);
    // ignore: prefer_final_locals, omit_local_variable_types
    ValueNotifier<ZitadelLoginType?> loadingLoginType = useState(null);

    Future<void> handleLogin(
      ZitadelLoginType loginTypePressed,
    ) async {
      loadingLoginType.value = loginTypePressed;
      final token = await loginTypePressed.login(options);
      loadingLoginType.value = null;
      // ignore: use_build_context_synchronously
      options.onLoginSuccess(context.router, ref, token);
    }

    return PlatformScaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          if (builder != null) builder!(context),
          Align(
            alignment: Alignment.bottomCenter,
            child: ValueListenableBuilder(
              valueListenable: loadingLoginType,
              builder: (context, value, child) {
                return Padding(
                  padding: const EdgeInsets.all(16).copyWith(
                    bottom: MediaQuery.paddingOf(context).bottom + 16,
                  ),
                  child: Column(
                    spacing: 12,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: options.supportedTypes.map(
                      (type) {
                        final isLoading = value == type;
                        return PlatformButton2(
                          color: options.buttonOptions.color(context),
                          foregroundColor: options.buttonOptions
                                  .buttonTextStyle(context)
                                  .color ??
                              Colors.white,
                          borderRadius: options.buttonOptions.borderRadius,
                          borderSide: options.buttonOptions.borderSide,
                          isLoading: isLoading,
                          onPressed: () async {
                            await handleLogin(type);
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            spacing: 8,
                            children: [
                              SvgPicture.asset(
                                type.iconSvgString,
                                width: 24,
                                height: 24,
                              ),
                              Flexible(
                                child: Text(
                                  type.buttonText,
                                  style: options.buttonOptions
                                      .buttonTextStyle(context),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ).toList(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

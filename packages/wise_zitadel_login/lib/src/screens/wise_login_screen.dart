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
    final authenticator = ref.watch(wiseZitadelAuthenticatorProvider);
    // ignore: prefer_final_locals, omit_local_variable_types
    ValueNotifier<ZitadelLoginType?> loadingLoginType = useState(null);

    // Fetching the discovery document up front keeps the login itself
    // synchronous, which is what lets the flow start on web. A failure here is
    // ignored on purpose: the login the user actually asks for runs into it
    // again, and reports it then.
    //
    // On web this also finishes a login that was started before: the
    // authorization server sends the browser back to a fresh page load, so the
    // token arrives here rather than out of the button's own `login` call.
    useEffect(() {
      authenticator.prepare().then((token) {
        if (token == null || !context.mounted) {
          return;
        }
        options.onLoginSuccess(context.router, ref, token);
      }).ignore();
      return null;
    }, [authenticator]);

    Future<void> handleLogin(
      ZitadelLoginType loginTypePressed,
    ) async {
      loadingLoginType.value = loginTypePressed;
      try {
        final token = await authenticator.login(loginTypePressed);
        // ignore: use_build_context_synchronously
        options.onLoginSuccess(context.router, ref, token);
      } catch (error, stackTrace) {
        // A cancelled or failed login must not leave the button spinning, and
        // is reported to the app's error handler rather than swallowed.
        FlutterError.reportError(
          FlutterErrorDetails(
            exception: error,
            stack: stackTrace,
            library: 'wise_zitadel_login',
            context: ErrorDescription('while logging in'),
          ),
        );
      } finally {
        loadingLoginType.value = null;
      }
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
                          foregroundColor:
                              options.buttonOptions
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
                                  style: options.buttonOptions.buttonTextStyle(
                                    context,
                                  ),
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wiseclient/src/error_screens/messages.dart';

/// [BaseClientError] to show a basic screen with the error's information
class BaseClientError extends StatefulWidget {
  /// Constructor [BaseClientError] with error message
  const BaseClientError({required this.errorInformation, super.key});

  /// The error message
  final String errorInformation;

  @override
  State<BaseClientError> createState() => _BaseClientErrorState();
}

class _BaseClientErrorState extends State<BaseClientError> {
  bool showFullMessage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          getClientErrorTitle(
            Localizations.localeOf(context).languageCode,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.devices,
                  size: 48,
                ),
                Text(
                  getDetailedClientErrorMessage(
                    Localizations.localeOf(context).languageCode,
                  ),
                  textAlign: TextAlign.center,
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Text(
                    getViewFullMessage(
                      Localizations.localeOf(context).languageCode,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    showFullMessage = !showFullMessage;
                    setState(() {});
                  },
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  transitionBuilder: (child, animation) {
                    return SizeTransition(
                      axisAlignment: 1,
                      sizeFactor: animation,
                      child: child,
                    );
                  },
                  switchInCurve: Curves.ease,
                  switchOutCurve: Curves.easeOut,
                  child: showFullMessage
                      ? Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.errorInformation,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

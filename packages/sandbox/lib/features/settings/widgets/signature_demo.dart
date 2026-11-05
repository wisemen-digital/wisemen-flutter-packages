import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sandbox/generated/l10n.dart';
import 'package:wisewidgetslibrary/wisewidgetslibrary.dart';

import '../settings.dart';

/// App-owned submission and preview for the shared [SigningField].
class SignatureDemo extends ConsumerStatefulWidget {
  /// Creates the signature drawing example.
  const SignatureDemo({super.key});

  @override
  ConsumerState<SignatureDemo> createState() => _SignatureDemoState();
}

class _SignatureDemoState extends ConsumerState<SignatureDemo> {
  static const _maxWidth = 640.0;
  static const _actionGap = 12.0;

  final _signing = SigningController();

  @override
  void initState() {
    super.initState();
    _signing.addListener(_discardPreview);
  }

  void _discardPreview() {
    if (ref.read(SettingsProviders.signatureDemo).value != null) {
      ref.read(SettingsProviders.signatureDemo.notifier).discard();
    }
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    await ref.read(SettingsProviders.signatureDemo.notifier).submit(_signing);
  }

  @override
  void dispose() {
    _signing
      ..removeListener(_discardPreview)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final submission = ref.watch(SettingsProviders.signatureDemo);
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: _maxWidth),
        child: Padding(
          padding: padM,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: _actionGap,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: Sizes.m,
                    children: [
                      SigningField(controller: _signing),
                      if (submission.value case final result?) SignaturePreview(result: result),
                    ],
                  ),
                ),
              ),
              FilledButton(
                onPressed: submission.isLoading ? null : _submit,
                child: Text(S.of(context).done),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wise_ultra_update/src/features/update/update.dart';

class UpdateWrapper extends ConsumerStatefulWidget {
  const UpdateWrapper({required this.child, super.key});

  final Widget child;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UpdateWrapperState();
}

class _UpdateWrapperState extends ConsumerState<UpdateWrapper> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    Future(() => UpdateController.showUpdateDialogIfNeeded(context, ref));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      UpdateController.showUpdateDialogIfNeeded(context, ref);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

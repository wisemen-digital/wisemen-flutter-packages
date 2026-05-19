import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sandbox/generated/l10n.dart';
import 'package:wise_theming/wise_theming.dart';
import 'package:wisewidgetslibrary/wisewidgetslibrary.dart';

import '../damage_form.dart';

@RoutePage()
class DamageFormScreen extends StatefulHookConsumerWidget {
  const DamageFormScreen({super.key});

  @override
  ConsumerState<DamageFormScreen> createState() => _DamageFormScreenState();
}

class _DamageFormScreenState extends ConsumerState<DamageFormScreen> {
  @override
  Widget build(BuildContext context) {
    final model = ref.watch(DamageFormProviders.model);
    final descriptionController = useTextEditingController(text: model.description);
    return PopScope(
      canPop: !model.hasEditedFields,
      child: Scaffold(
        appBar: AppBar(
          leading: CloseButton(
            onPressed: () {
              // TODO(Someone): Cancel dialog
              context.pop();
            },
          ),
          title: Text(S.of(context).reportDamage),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: padHM,
          child: PlatformButton2.text(
            text: S.of(context).save,
            textStyle: context.headline.copyWith(color: context.textColors.primaryOnBrand),
            color: context.foregroundColors.brandPrimary,
            foregroundColor: context.textColors.primaryOnBrand,
            size: const Size.fromHeight(48),
            onPressed: ref.read(damageFormControllerProvider.notifier).submitForm,
            isLoading: ref.watch(damageFormControllerProvider).isLoading,
            isDisabled: !model.hasEditedFields,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              spacing: Sizes.s,
              children: [
                DamageFormTextField(
                  descriptionController: descriptionController,
                  onChanged: (value) {
                    ref.read(DamageFormProviders.model.notifier).changeValue(model.copyWith(description: value));
                  },
                  title: S.of(context).description,
                ),
                Row(
                  spacing: Sizes.s,
                  children: [
                    Expanded(
                      child: DateField(
                        title: S.of(context).date,
                        onChanged: (date) {
                          ref.read(DamageFormProviders.model.notifier).changeValue(model.copyWith(date: date));
                        },
                        initialDate: model.date,
                      ),
                    ),
                    Expanded(
                      child: TimeField(
                        title: S.of(context).time,
                        onChanged: (date) {
                          ref.read(DamageFormProviders.model.notifier).changeValue(model.copyWith(date: date));
                        },
                        initialDate: model.date,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

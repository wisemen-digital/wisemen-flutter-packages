import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wise_nav_bar/wise_nav_bar.dart';
import 'package:wise_theming/wise_theming.dart';
import 'package:wise_ultra_settings/src/features/settings/controllers/settings_controllers.dart';
import 'package:wisewidgetslibrary/wisewidgetslibrary.dart';

import '../settings.dart';

class PersonalInfoScreen extends StatefulHookConsumerWidget {
  const PersonalInfoScreen({super.key});

  @override
  ConsumerState<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends ConsumerState<PersonalInfoScreen> {
  final ScrollController _controller = ScrollController();

  bool _hasBorder = false;

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      final hasBorder = _controller.offset > 0;

      if (hasBorder != _hasBorder) {
        setState(() {
          _hasBorder = hasBorder;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasEdited = ref.watch(hasEditedUserProvider);
    final firstName = ref.watch(firstNameProvider);
    final lastName = ref.watch(lastNameProvider);
    final dateOfBirth = ref.watch(dateOfBirthProvider);
    print(dateOfBirth);

    return PopScope(
      canPop: !hasEdited,
      child: Scaffold(
        backgroundColor: context.backgroundColors.primary,
        appBar: PlatformAppBar.text(
          leading: AppBarButton(
            title: SettingsFeature.localizations.cancel,
            onPressed: () => ref.read(settingsControllersProvider.notifier).cancelEditProfile(),
          ),
          title: SettingsFeature.localizations.personalInfo(context),
          actions: [
            AppBarButton(
              title: SettingsFeature.localizations.save(context),
              isBold: true,
              onPressed: _update,
              isLoading: ref.watch(settingsControllersProvider).isLoading,
            ),
          ],
          border: Border(bottom: BorderSide(color: _hasBorder ? context.borderColors.primary : context.backgroundColors.primary)),
        ),
        body: ListView(
          controller: _controller,
          padding: EdgeInsets.only(bottom: MediaQuery.paddingOf(context).bottom),
          children: [
            gapHM,
            Padding(
              padding: padHM,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FormTextfield(
                    title: SettingsFeature.localizations.firstName(context),
                    onChanged: ref.read(firstNameProvider.notifier).changeValue,
                    initialText: firstName,
                    autofillHints: const [AutofillHints.givenName],
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    validator: emptyValidator,
                    autoFocus: false,
                  ),
                  const SizedBox(height: 15),
                  FormTextfield(
                    title: SettingsFeature.localizations.lastName(context),
                    autoFocus: false,
                    onChanged: ref.read(lastNameProvider.notifier).changeValue,
                    initialText: lastName,
                    autofillHints: const [AutofillHints.familyName],
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    validator: emptyValidator,
                  ),
                  const SizedBox(height: 15),
                  DateField(
                    title: SettingsFeature.localizations.birthDate(context),
                    onChanged: (val) {
                      ref.read(dateOfBirthProvider.notifier).changeValue(val);
                    },
                    initialDate: dateOfBirth,
                    maxDate: DateTime.now(),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _update() async {
    final firstName = ref.watch(firstNameProvider);
    final lastName = ref.watch(lastNameProvider);
    final dateOfBirth = ref.watch(dateOfBirthProvider);

    await ref.read(settingsControllersProvider.notifier).updateProfile(
          firstName: firstName ?? '',
          lastName: lastName ?? '',
          birthDate: dateOfBirth,
        );
  }
}

import 'package:flutter/material.dart';
import 'package:wise_theming/wise_theming.dart';

void main() {
  runApp(const SimpleWiseThemingExample());
}

class SimpleWiseThemingExample extends StatelessWidget {
  const SimpleWiseThemingExample({super.key});

  @override
  Widget build(BuildContext context) {
    final theming = WiseTheming(
      supportedThemes: supportedThemes,
      targetPlatform: TargetPlatform.iOS,
    );
    return ValueListenableBuilder(
      valueListenable: theming,
      builder: (context, value, child) {
        return MaterialApp(
          title: 'WiseTheming Simple Example',
          themeMode: value?.themeType.themeMode,
          theme: theming.lightTheme,
          darkTheme: theming.darkTheme,
          highContrastTheme: theming.lightContrastTheme,
          highContrastDarkTheme: theming.darkContrastTheme,
          home: ExampleScreen(theming: theming),
        );
      },
    );
  }
}

class ExampleScreen extends StatelessWidget {
  const ExampleScreen({required this.theming, super.key});

  final WiseTheming theming;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Wise Theming Example',
          style: context.title,
        ),
        backgroundColor: context.backgroundColors.brandPrimary,
        foregroundColor: context.textColors.primaryOnBrand,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 12,
            children: [
              Text(
                'Choose Theme:',
                style: context.headline,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: theming.supportedThemes
                    .map((theme) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: ElevatedButton(
                            onPressed: () => _switchTheme(theme.identifier),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: context.wiseTheme.identifier ==
                                      theme.identifier
                                  ? context.foregroundColors.brandPrimary
                                  : context.backgroundColors.secondary,
                              foregroundColor: context.wiseTheme.identifier ==
                                      theme.identifier
                                  ? context.textColors.primaryOnBrand
                                  : context.textColors.primary,
                              side: BorderSide(
                                  color: context.borderColors.primary),
                            ),
                            child: Text(
                              theme.identifier,
                              style: context.body,
                            ),
                          ),
                        ))
                    .toList(),
              ),
              Text(
                'Theme Colors:',
                style: context.headline,
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: context.backgroundColors.secondary,
                  border: Border.all(color: context.borderColors.primary),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Primary Text',
                      style: context.body.copyWith(
                        color: context.textColors.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Secondary text with lower contrast',
                      style: context.body.copyWith(
                        color: context.textColors.secondary,
                        fontSize: 14,
                      ),
                    ),
                    Row(
                      spacing: 8,
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: context.backgroundColors.errorPrimary,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        Text(
                          'Error',
                          style: context.body
                              .copyWith(color: context.textColors.errorPrimary),
                        ),
                        SizedBox.shrink(),
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: context.backgroundColors.warningPrimary,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        Text(
                          'Warning',
                          style: context.body.copyWith(
                              color: context.textColors.warningPrimary),
                        ),
                        SizedBox.shrink(),
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: context.backgroundColors.successPrimary,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        Text(
                          'Success',
                          style: context.body.copyWith(
                              color: context.textColors.successPrimary),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                'Utility Colors:',
                style: context.body
                    .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _UtilityColorSample('Blue', context.utilityColors.blue),
                  _UtilityColorSample('Green', context.utilityColors.green),
                  _UtilityColorSample('Orange', context.utilityColors.orange),
                  _UtilityColorSample('Purple', context.utilityColors.purple),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _switchTheme(String themeId) {
    final newTheme = theming.setCurrentTheme(themeId);
    debugPrint('Switched to theme: ${newTheme.identifier}');
  }
}

class _UtilityColorSample extends StatelessWidget {
  const _UtilityColorSample(this.name, this.color);

  final String name;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade300),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          name,
          style: context.body.copyWith(fontSize: 12),
        ),
      ],
    );
  }
}

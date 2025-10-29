import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wise_theming/wise_theming.dart';
import 'package:wisewidgetslibrary/wisewidgetslibrary.dart';

import '../update_feature.dart';

class UpdateWidget extends ConsumerWidget {
  const UpdateWidget({
    required this.isRequired,
    super.key,
  });

  final bool isRequired;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: DefaultTextStyle(
        style: const TextStyle(),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: padM,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: radL,
                color: context.backgroundColors.primary,
              ),
              child: Padding(
                padding: EdgeInsets.only(top: UpdateFeature.assets.avatar != null ? Sizes.l : 0),
                child: Column(
                  spacing: Sizes.s,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      UpdateFeature.localizations.newUpdateAvailableTitle,
                      style: context.title.copyWith(color: context.textColors.primary, fontWeight: FontWeight.w700, height: 0),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      UpdateFeature.localizations.newUpdateAvailableSubtitle,
                      style: AppStyles.body.copyWith(fontSize: 14, color: context.textColors.secondary, fontWeight: FontWeight.w400, height: 0),
                      textAlign: TextAlign.center,
                    ),
                    gapHM,
                    Material(
                      color: context.foregroundColors.brandPrimary,
                      borderRadius: radXL,
                      child: InkWell(
                        onTap: () => ref.read(UpdateFeature.navigationManager).installUpdate(),
                        borderRadius: radXL,
                        child: Center(
                          child: Padding(
                            padding: padM,
                            child: Text(
                              UpdateFeature.localizations.installUpdate,
                              style: context.title.copyWith(color: context.textColors.primaryOnBrand, fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (!isRequired)
                      Material(
                        type: MaterialType.transparency,
                        borderRadius: radXL,
                        child: InkWell(
                          onTap: () => ref.read(UpdateFeature.navigationManager).installLater(),
                          borderRadius: radXL,
                          child: Center(
                            child: Padding(
                              padding: padM,
                              child: Text(
                                UpdateFeature.localizations.illDoThisLater,
                                style: context.title.copyWith(color: context.textColors.secondary, fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            if (UpdateFeature.assets.avatar != null)
              Positioned(
                top: -36,
                left: 0,
                right: 0,
                child: Image.asset(
                  UpdateFeature.assets.avatar!,
                  height: 72,
                  width: 72,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

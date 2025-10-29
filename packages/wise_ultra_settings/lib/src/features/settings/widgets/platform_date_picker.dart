import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wise_theming/wise_theming.dart';
import 'package:wise_ultra_settings/src/features/settings/settings_feature.dart';
import 'package:wisecore/wisecore.dart';
import 'package:wisewidgetslibrary/wisewidgetslibrary.dart';

Future<DateTime?> showPlatformDatePicker({
  required BuildContext context,
  DateTime? selectedDate,
  DateTime? minDate,
  DateTime? maxDate,
}) async {
  DateTime? newDate;
  newDate ??= selectedDate;

  if (isIos) {
    const double height = 450;
    const double maxWidth = 400;
    const bottomPadding = 100;

    return showDialog(
      context: context,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Center(
            child: Dialog(
              insetPadding: const EdgeInsets.all(20),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: maxWidth),
                child: Container(
                  height: height,
                  decoration: BoxDecoration(
                    color: context.backgroundColors.primary,
                    borderRadius: radM,
                  ),
                  child: Padding(
                    padding: padM,
                    child: Column(
                      children: [
                        SizedBox(
                          height: height - bottomPadding,
                          child: UIDatePicker(
                            tintColor: context.foregroundColors.brandPrimary,
                            date: selectedDate != null ? DateTime.fromMillisecondsSinceEpoch(selectedDate.millisecondsSinceEpoch) : null,
                            minimumDate: minDate != null ? DateTime.fromMillisecondsSinceEpoch(minDate.millisecondsSinceEpoch) : null,
                            maximumDate: maxDate != null ? DateTime.fromMillisecondsSinceEpoch(maxDate.millisecondsSinceEpoch) : null,
                            onChanged: (selectedDate) {
                              newDate = selectedDate;
                            },
                          ),
                        ),
                        gapHM,
                        // ignore: deprecated_member_use
                        PlatformButton(
                          color: context.foregroundColors.brandPrimary,
                          height: 48,
                          borderRadius: BorderRadius.circular(25),
                          child: Text(
                            SettingsFeature.localizations.ok,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'CupertinoSystemDisplay',
                              fontSize: 15,
                              color: context.foregroundColors.brandPrimary.computeLuminance() > 0.5 ? Colors.black : Colors.white,
                            ),
                          ),
                          onPressed: () => Navigator.of(context).pop(newDate ?? DateTime.now()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  } else {
    return showDatePicker(
      context: context,
      firstDate: minDate ?? DateTime(1900),
      initialDate: selectedDate ?? DateTime.now(),
      lastDate: maxDate ??
          DateTime.now().add(
            const Duration(days: 730),
          ),
      builder: (context, child) {
        return child!;
      },
    );
  }
}

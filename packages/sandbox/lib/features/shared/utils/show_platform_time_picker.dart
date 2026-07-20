import 'package:cupertino_calendar_picker/cupertino_calendar_picker.dart';
import 'package:flutter/material.dart';
import 'package:wisecore/wisecore.dart';

Future<TimeOfDay?> showPlatformTimePicker({
  required BuildContext context,
  required RenderBox? widgetRenderBox,
  TimeOfDay? selectedTime,
  TimeOfDay? minTime,
  TimeOfDay? maxTime,
}) async {
  TimeOfDay? newTime;
  newTime ??= selectedTime;

  if (isIos) {
    return showCupertinoTimePicker(
      context,
      widgetRenderBox: widgetRenderBox,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
  } else {
    return showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
  }
}

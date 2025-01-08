import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'platform_widget.dart';

/// [PlatformDatePicker] with CupertinoDatePicker and DatePickerDialog
class PlatformDatePicker extends PlatformWidget<Widget, Widget> {
  /// Constructor [PlatformDatePicker]
  const PlatformDatePicker({
    required this.date,
    super.key,
    this.save = 'Save',
    this.cancel = 'Cancel',
  });

  /// Starting date value
  final DateTime? date;

  /// Save button title (defaults to 'Save')
  final String save;

  /// Cancel button title (defaults to 'Cancel')
  final String cancel;

  @override
  Widget createCupertinoWidget(BuildContext context) {
    var newDate = date ?? DateTime.now();
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CupertinoButton(
                onPressed: Navigator.of(context).pop,
                child: Text(cancel),
              ),
              CupertinoButton(
                onPressed: () {
                  Navigator.of(context).pop(newDate);
                },
                child: Text(save),
              ),
            ],
          ),
          Flexible(
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (selectedDate) {
                newDate = selectedDate;
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget createMaterialWidget(BuildContext context) => Material(
        color: Colors.transparent,
        child: DatePickerDialog(
          firstDate: DateTime.now()..add(const Duration(days: 10)),
          initialDate: date,
          lastDate: DateTime.now().add(const Duration(milliseconds: 1)),
          currentDate: DateTime.now(),
          cancelText: cancel,
          confirmText: save,
        ),
      );
}

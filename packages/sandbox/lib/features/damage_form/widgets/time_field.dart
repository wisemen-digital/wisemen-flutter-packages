import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sandbox/features/shared/shared.dart';
import 'package:wise_theming/wise_theming.dart';
import 'package:wisewidgetslibrary/wisewidgetslibrary.dart';

class TimeField extends StatefulWidget {
  const TimeField({
    super.key,
    required this.title,
    required this.onChanged,
    required this.initialDate,
    this.autoFocus = false,
    this.focusNode,
    this.maxDate,
  });

  final String title;
  final void Function(DateTime) onChanged;
  final DateTime? initialDate;
  final bool autoFocus;
  final FocusNode? focusNode;
  final DateTime? maxDate;

  static const START_PADDING = EdgeInsetsDirectional.symmetric(
    horizontal: 12,
    vertical: 14,
  );
  static final BORDER_RADIUS = BorderRadius.circular(Sizes.s);

  @override
  State<TimeField> createState() => _TimeFieldState();
}

class _TimeFieldState extends State<TimeField> {
  late final FocusNode focusNode;
  bool isFocused = false;

  @override
  void initState() {
    focusNode = widget.focusNode ?? FocusNode();
    super.initState();
  }

  Future<void> setTime() async {
    isFocused = true;
    final time = await showPlatformTimePicker(
      context: context,
      widgetRenderBox: context.findRenderObject() as RenderBox?,
      selectedTime: widget.initialDate != null ? TimeOfDay.fromDateTime(widget.initialDate!) : TimeOfDay.now(),
    );
    if (time != null) {
      final date = widget.initialDate != null
          ? DateTime(
              widget.initialDate!.year,
              widget.initialDate!.month,
              widget.initialDate!.day,
              time.hour,
              time.minute,
            )
          : DateTime.now();
      widget.onChanged(date);
    }
    isFocused = false;
    focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: Sizes.s,
        children: [
          Text(
            widget.title,
            style: context.headline,
          ),
          InkWell(
            focusNode: focusNode,
            autofocus: widget.autoFocus,
            onFocusChange: (value) async {
              if (value && !isFocused) {
                setTime();
              }
            },
            onTap: () {
              if (!isFocused) {
                setTime();
              }
            },
            borderRadius: TimeField.BORDER_RADIUS,
            child: TextFormField(
              enabled: false,
              controller: TextEditingController()
                ..text = widget.initialDate != null
                    ? DateFormat().add_jm().format(
                        widget.initialDate!,
                      )
                    : '',
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: TimeField.BORDER_RADIUS,
                ),
              ),
              style: context.input,
            ),
          ),
        ],
      ),
    );
  }
}

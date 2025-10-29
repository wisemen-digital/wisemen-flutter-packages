import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wise_theming/wise_theming.dart';

import '../settings.dart';

class DateField extends StatefulWidget {
  const DateField({
    required this.title,
    required this.onChanged,
    required this.initialDate,
    super.key,
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
  static final BORDER_RADIUS = BorderRadius.circular(8);

  @override
  State<DateField> createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  late final FocusNode focusNode;
  bool isFocused = false;

  @override
  void initState() {
    focusNode = widget.focusNode ?? FocusNode();
    super.initState();
  }

  Future<void> setDate() async {
    isFocused = true;
    final date = await showPlatformDatePicker(
      context: context,
      selectedDate: widget.initialDate,
      maxDate: widget.maxDate,
    );
    if (date != null) {
      widget.onChanged(date);
    }
    isFocused = false;
    focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: DateField.BORDER_RADIUS,
      borderSide: BorderSide(
        color: context.borderColors.primary,
      ),
    );
    final focusedBorder = border.copyWith(
      borderSide: BorderSide(
        color: context.foregroundColors.brandPrimary,
      ),
    );
    final errorBorder = border.copyWith(
      borderSide: BorderSide(
        color: context.foregroundColors.errorPrimary,
      ),
    );

    return Material(
      type: MaterialType.transparency,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: context.body.copyWith(
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 6),
          InkWell(
            focusNode: focusNode,
            autofocus: widget.autoFocus,
            onFocusChange: (value) async {
              if (value && !isFocused) {
                setDate();
              }
            },
            onTap: () {
              if (!isFocused) {
                setDate();
              }
            },
            borderRadius: DateField.BORDER_RADIUS,
            child: TextFormField(
              enabled: false,
              controller: TextEditingController()
                ..text = widget.initialDate != null
                    ? DateFormat().add_yMMMMd().format(
                          widget.initialDate!,
                        )
                    : '',
              decoration: InputDecoration(
                contentPadding: DateField.START_PADDING,
                border: border,
                disabledBorder: border,
                enabledBorder: border,
                focusedBorder: focusedBorder,
                errorBorder: errorBorder,
                focusedErrorBorder: errorBorder,
                hintText: widget.title,
                hintStyle: context.body.copyWith(
                  color: context.foregroundColors.secondary,
                  fontSize: 12,
                ),
              ),
              style: context.body,
            ),
          ),
        ],
      ),
    );
  }
}

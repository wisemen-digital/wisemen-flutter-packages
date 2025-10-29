import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wise_theming/wise_theming.dart';

class FormTextfield extends HookWidget {
  const FormTextfield({
    required this.title,
    required this.onChanged,
    super.key,
    this.initialText,
    this.errorText,
    this.onSubmit,
    this.minLines = 1,
    this.maxLines = 1,
    this.keyboardType,
    this.autofillHints,
    this.textCapitalization,
    this.isObscure = false,
    this.autoFocus = true,
    this.focusNode,
    this.validator,
    this.validateMode = AutovalidateMode.onUnfocus,
    this.addScrollPadding,
    this.copyEnabled,
    this.textInputAction,
    this.suffixIcon,
    this.controller,
    this.backgroundColor,
    this.showsTitle = true,
  });

  const FormTextfield.long({
    required this.title,
    required this.onChanged,
    super.key,
    this.initialText,
    this.errorText,
    this.onSubmit,
    this.minLines = 3,
    this.maxLines,
    this.keyboardType,
    this.autofillHints,
    this.textCapitalization,
    this.isObscure = false,
    this.autoFocus = false,
    this.focusNode,
    this.validator,
    this.validateMode = AutovalidateMode.onUnfocus,
    this.addScrollPadding,
    this.copyEnabled,
    this.textInputAction,
    this.suffixIcon,
    this.controller,
    this.backgroundColor,
    this.showsTitle = true,
  });

  final String title;
  final void Function(String) onChanged;
  final void Function(String)? onSubmit;
  final TextInputType? keyboardType;
  final List<String>? autofillHints;
  final TextCapitalization? textCapitalization;
  final String? initialText;
  final String? errorText;
  final int minLines;
  final int? maxLines;
  final bool isObscure;
  final bool autoFocus;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final AutovalidateMode validateMode;
  final double? addScrollPadding;
  final bool? copyEnabled;
  final TextInputAction? textInputAction;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final Color? backgroundColor;
  final bool showsTitle;

  static const START_PADDING = EdgeInsetsDirectional.symmetric(
    horizontal: 12,
    vertical: 14,
  );
  static final BORDER_RADIUS = BorderRadius.circular(8);
  static const LARGE_SCROLL_PADDING = EdgeInsets.all(160);
  static const SMALL_SCROLL_PADDING = EdgeInsets.all(20);

  @override
  Widget build(BuildContext context) {
    final focusNode = this.focusNode ?? useFocusNode();
    final border = OutlineInputBorder(
      borderRadius: BORDER_RADIUS,
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
          if (showsTitle) ...[
            Text(
              title,
              style: context.body.copyWith(
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 6),
          ],
          TextFormField(
            focusNode: focusNode,
            controller: controller,
            autofocus: autoFocus,
            initialValue: initialText,
            enableInteractiveSelection: copyEnabled,
            scrollPadding: (minLines > 1 ? LARGE_SCROLL_PADDING : SMALL_SCROLL_PADDING).copyWith(bottom: addScrollPadding),
            decoration: InputDecoration(
              contentPadding: START_PADDING.copyWith(
                start: 0,
              ),
              prefix: SizedBox(
                width: START_PADDING.start,
              ),
              border: border,
              filled: backgroundColor != null,
              fillColor: backgroundColor,
              disabledBorder: border,
              enabledBorder: border,
              focusedBorder: focusedBorder,
              errorBorder: errorBorder,
              errorText: errorText,
              focusedErrorBorder: errorBorder,
              hintText: title,
              hintStyle: context.body.copyWith(
                color: context.foregroundColors.secondary,
                fontSize: 12,
              ),
              suffixIcon: suffixIcon,
            ),
            onFieldSubmitted: onSubmit,
            validator: validator,
            autovalidateMode: validator != null ? validateMode : null,
            minLines: minLines,
            maxLines: maxLines,
            keyboardType: keyboardType,
            obscureText: isObscure,
            textCapitalization: textCapitalization ?? TextCapitalization.sentences,
            onChanged: onChanged,
            style: context.body,
            autofillHints: autofillHints,
            autocorrect: !(minLines <= 1),
            textInputAction: textInputAction,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:wise_theming/wise_theming.dart';
import 'package:wisewidgetslibrary/wisewidgetslibrary.dart';

class DamageFormTextField extends StatelessWidget {
  const DamageFormTextField({
    super.key,
    required this.descriptionController,
    required this.onChanged,
    required this.title,
  });

  final TextEditingController descriptionController;
  final void Function(String)? onChanged;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: Sizes.s,
      children: [
        Text(
          title,
          style: context.headline,
        ),
        TextFormField(
          controller: descriptionController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Sizes.s),
            ),
          ),
          style: context.input,
          onChanged: onChanged,
          minLines: 3,
          maxLines: 20,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import '../../theme/wise_feedback_theme.dart';

/// A borderless dropdown sized to sit inside a labelled field box.
///
/// [items] maps each selectable value to the label shown for it.
class FeedbackDropdown<T> extends StatelessWidget {
  /// Creates the dropdown.
  const FeedbackDropdown({
    required this.theme,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.fieldKey,
    this.hint,
    super.key,
  });

  /// Visual configuration.
  final WiseFeedbackTheme theme;

  /// Currently selected value, or null when nothing is selected.
  final T? value;

  /// Selectable values mapped to their display labels.
  final Map<T, String> items;

  /// Called with the newly selected value.
  final ValueChanged<T?> onChanged;

  /// Applied to the underlying `DropdownButton` so tests can target it.
  final Key fieldKey;

  /// Placeholder shown while [value] is null.
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<T>(
        key: fieldKey,
        value: value,
        isExpanded: true,
        isDense: true,
        hint: hint == null
            ? null
            : Text(
                hint!,
                style: TextStyle(color: theme.hintColor, fontSize: 17),
              ),
        icon: Icon(Icons.keyboard_arrow_down_rounded, color: theme.hintColor),
        style: TextStyle(fontSize: 17, color: theme.textColor),
        onChanged: onChanged,
        items: [
          for (final entry in items.entries)
            DropdownMenuItem<T>(value: entry.key, child: Text(entry.value)),
        ],
      ),
    );
  }
}

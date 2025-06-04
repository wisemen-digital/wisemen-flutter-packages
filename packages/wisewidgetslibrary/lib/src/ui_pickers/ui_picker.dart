import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../extensions/extensions.dart';

/// The alignment to use for the selected item text.
enum PickerTextAlignment {
  /// Align the text to the center.
  center,

  /// Align the text to the left.
  left,

  /// Align the text to the right.
  right,
}

/// A wrapper around the native iOS Picker that uses UIMenu and UIButton
/// for selecting from a list of string items.
///
/// A dropdown menu lets the user select from a number of items. The widget
/// shows the currently selected item.
///
/// The [onChanged] callback should update a state variable that defines the
/// dropdown's value. It should also call [State.setState] to rebuild the
/// dropdown with the new value.
///
class UIPicker extends StatefulWidget {
  /// Constructor [UIPicker]
  const UIPicker({
    required this.items,
    required this.selectedIndex,
    super.key,
    this.textColor,
    this.tintColor,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.cornerRadius,
    this.fontSize,
    this.textAlignment,
    this.onChanged,
  });

  /// The index of the currently selected item. Null if nothing is selected.
  final int selectedIndex;

  /// The list of string items the user can select.
  final List<String> items;

  /// Called when the user selects an item.
  final void Function(int)? onChanged;

  /// The color to use when painting the text.
  final Color? textColor;

  /// The text color to use when the picker is highlighted.
  final Color? tintColor;

  /// The color to fill in the background of the picker.
  final Color? backgroundColor;

  /// The color to use when painting the bordr of the picker.
  final Color? borderColor;

  /// The border width.
  final double? borderWidth;

  /// The corner radius.
  final double? cornerRadius;

  /// The font size of the selected item text.
  final double? fontSize;

  /// The alignment to use for the selected item text.
  final PickerTextAlignment? textAlignment;

  @override
  State<UIPicker> createState() => _UIPickerState();
}

class _UIPickerState extends State<UIPicker> {
  MethodChannel? _channel;

  @override
  Widget build(BuildContext context) {
    const viewType = 'FLPicker';
    final creationParams = <String, dynamic>{
      'items': widget.items,
      'selectedIndex': widget.selectedIndex,
    };
    if (widget.textColor != null) {
      creationParams['textColor'] = widget.textColor?.hexString;
    }
    if (widget.tintColor != null) {
      creationParams['tintColor'] = widget.tintColor?.hexString;
    }
    if (widget.backgroundColor != null) {
      creationParams['backgroundColor'] = widget.backgroundColor?.hexString;
    }
    if (widget.borderColor != null) {
      creationParams['borderColor'] = widget.borderColor?.hexString;
    }
    if (widget.borderWidth != null) {
      creationParams['borderWidth'] = widget.borderWidth;
    }
    if (widget.cornerRadius != null) {
      creationParams['cornerRadius'] = widget.cornerRadius;
    }
    if (widget.fontSize != null) {
      creationParams['fontSize'] = widget.fontSize;
    }
    if (widget.textAlignment != null) {
      creationParams['textAlignment'] = widget.textAlignment!.index;
    }
    if (_channel != null) {
      _channel?.invokeMethod('setIndex', widget.selectedIndex);
    }
    return UiKitView(
      viewType: viewType,
      layoutDirection: TextDirection.ltr,
      creationParams: creationParams,
      creationParamsCodec: const StandardMessageCodec(),
      onPlatformViewCreated: (int id) {
        _channel = MethodChannel('FLPicker/$id');
        _channel?.setMethodCallHandler(_channelCallHandler);
      },
    );
  }

  Future<void> _channelCallHandler(MethodCall call) async {
    switch (call.method) {
      case 'onChanged':
        final index = call.arguments as int;
        if (widget.onChanged != null) {
          // ignore: prefer_null_aware_method_calls
          widget.onChanged!(index);
        }
    }
  }
}

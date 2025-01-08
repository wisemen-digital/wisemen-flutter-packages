import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../widgets/animated_clip_rect.dart';
import 'platform_widgets.dart';

/// [PlatformSearchBar] widget with cancel option on iOS
class PlatformSearchBar extends PlatformWidget {
  /// Constructor [PlatformSearchBar]
  const PlatformSearchBar({
    required this.backgroundColor,
    required this.textColor,
    required this.placeholderColor,
    required this.buttonColor,
    super.key,
    this.onSearchChanged,
    this.cancelText = 'Cancel',
    this.hintText = 'Search',
  });

  /// Callback when search text changes
  final ValueChanged<String>? onSearchChanged;

  /// Button color (iOS only)
  final Color buttonColor;

  /// Cancel button text (iOS only)
  final String cancelText;

  /// Background color (Android only)
  final Color backgroundColor;

  /// Text color (Android only)
  final Color textColor;

  /// Placeholder color (Android only)
  final Color placeholderColor;

  /// Search text (Android only)
  final String hintText;

  @override
  Widget createCupertinoWidget(BuildContext context) {
    return _CupertinoSearchBar(
      buttonColor: buttonColor,
      onSearchChanged: onSearchChanged,
      cancelText: cancelText,
    );
  }

  @override
  Widget createMaterialWidget(BuildContext context) {
    return _MaterialSearchBar(
      onSearchChanged: onSearchChanged,
      placeholderColor: placeholderColor,
      backgroundColor: backgroundColor,
      textColor: textColor,
      searchText: hintText,
    );
  }
}

/// [PlatformSearchBar] Cupertino implimentation
class _CupertinoSearchBar extends StatefulWidget {
  /// Constructor [_CupertinoSearchBar]
  const _CupertinoSearchBar({
    required this.buttonColor,
    this.onSearchChanged,
    this.cancelText = 'Cancel',
  });

  /// Callback when search text changes
  final ValueChanged<String>? onSearchChanged;

  /// Button color
  final Color buttonColor;

  /// Cancel button text
  final String cancelText;

  @override
  State<_CupertinoSearchBar> createState() => _CupertinoSearchBarState();
}

class _CupertinoSearchBarState extends State<_CupertinoSearchBar> {
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      setState(() {
        _isEditing =
            _focusNode.hasFocus || _textEditingController.text.isNotEmpty;
      });
    });

    _textEditingController.addListener(() {
      setState(() {
        _isEditing =
            _textEditingController.text.isNotEmpty || _focusNode.hasFocus;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CupertinoSearchTextField(
            controller: _textEditingController,
            focusNode: _focusNode,
            onChanged: widget.onSearchChanged,
          ),
        ),
        AnimatedClipRect(
          open: !_isEditing,
          horizontalAnimation: true,
          verticalAnimation: false,
          alignment: Alignment.centerLeft,
          child: const Padding(padding: EdgeInsets.only(right: 16)),
        ),
        AnimatedClipRect(
          open: _isEditing,
          horizontalAnimation: true,
          verticalAnimation: false,
          alignment: Alignment.centerLeft,
          child: CupertinoButton(
            child: Text(
              widget.cancelText,
              style: TextStyle(color: widget.buttonColor),
            ),
            onPressed: () {
              _textEditingController.clear();
              _focusNode.unfocus();
              widget.onSearchChanged?.call('');
            },
          ),
        ),
      ],
    );
  }
}

class _MaterialSearchBar extends StatefulWidget {
  const _MaterialSearchBar({
    required this.onSearchChanged,
    required this.placeholderColor,
    required this.backgroundColor,
    required this.textColor,
    required this.searchText,
  });

  final ValueChanged<String>? onSearchChanged;
  final Color placeholderColor;
  final Color backgroundColor;
  final Color textColor;
  final String searchText;

  @override
  State<_MaterialSearchBar> createState() => _MaterialSearchBarState();
}

class _MaterialSearchBarState extends State<_MaterialSearchBar> {
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      setState(() {
        _isEditing =
            _focusNode.hasFocus || _textEditingController.text.isNotEmpty;
      });
    });

    _textEditingController.addListener(() {
      setState(() {
        _isEditing =
            _textEditingController.text.isNotEmpty || _focusNode.hasFocus;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: Sizes.p8,
        right: Sizes.p16,
      ),
      child: SearchBar(
        elevation: const WidgetStatePropertyAll(0),
        leading: Icon(
          Icons.search,
          color: widget.placeholderColor,
        ),
        backgroundColor: WidgetStatePropertyAll(
          widget.backgroundColor,
        ),
        textStyle: WidgetStatePropertyAll(
          TextStyle(color: widget.textColor),
        ),
        hintStyle: WidgetStatePropertyAll(
          TextStyle(color: widget.placeholderColor),
        ),
        hintText: widget.searchText,
        controller: _textEditingController,
        trailing: _isEditing
            ? [
                IconButton(
                  color: widget.placeholderColor,
                  onPressed: () {
                    _textEditingController.clear();
                    widget.onSearchChanged?.call('');
                  },
                  icon: const Icon(Icons.clear),
                ),
              ]
            : [],
        onChanged: widget.onSearchChanged,
      ),
    );
  }
}

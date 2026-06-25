import 'package:flutter/rendering.dart' show RenderParagraph;
import 'package:flutter/widgets.dart';
import 'package:styled_text/styled_text.dart';

import '../classifier/classifier.dart';

/// Rich text widget with extra features
class WiseTextWidget extends StatefulWidget {
  /// Creates a [WiseTextWidget] with all constructor options
  const WiseTextWidget(
    this.text, {
    super.key,
    this.newLineAsBreaks = true,
    this.style,
    this.tags = const {},
    this.textAlign,
    this.textDirection,
    this.softWrap,
    this.overflow,
    this.textScaler,
    this.maxLines,
    this.locale,
    this.strutStyle,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectable = false,
    this.classified = false,
    this.classifier,
  });

  /// The text to display in this widget. The text must be valid xml.
  ///
  /// Tag attributes must be enclosed in double quotes.
  /// You need to escape specific XML characters in text:
  ///
  /// ```
  /// Original character  Escaped character
  /// ------------------  -----------------
  /// "                   &quot;
  /// '                   &apos;
  /// &                   &amp;
  /// <                   &lt;
  /// >                   &gt;
  /// <space>             &space;
  /// ```
  ///
  final String text;

  /// Treat newlines as line breaks.
  final bool newLineAsBreaks;

  /// Is text selectable.
  ///
  /// Text selection styling is done by setting `textSelectionTheme` in `ThemeData`.
  final bool selectable;

  /// Decides wether to classify text using [WiseTextClassifier]
  final bool classified;

  /// Defaults to a platform-backed [WiseTextClassifier] when omitted. Provide a
  /// custom instance of [WiseTextClassifierInterface] to control classification
  /// yourself
  final WiseTextClassifierInterface? classifier;

  /// Default text style.
  final TextStyle? style;

  /// Map of tag assignments to text style classes and tag handlers.
  ///
  /// Example:
  /// ```dart
  /// StyledText(
  ///   text: '&lt;red&gt;Red&lt;/red&gt; text.',
  ///   tags: [
  ///     'red': StyledTextTag(style: TextStyle(color: Colors.red)),
  ///   ],
  /// )
  /// ```
  final Map<String, StyledTextTagBase> tags;

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  /// The directionality of the text.
  final TextDirection? textDirection;

  /// Whether the text should break at soft line breaks.
  ///
  /// If false, the glyphs in the text will be positioned as if there was unlimited horizontal space.
  final bool? softWrap;

  /// How visual overflow should be handled.
  final TextOverflow? overflow;

  /// {@macro flutter.painting.textPainter.textScaler}
  final TextScaler? textScaler;

  /// An optional maximum number of lines for the text to span, wrapping if necessary.
  /// If the text exceeds the given number of lines, it will be truncated according
  /// to [overflow].
  ///
  /// If this is 1, text will not wrap. Otherwise, text will be wrapped at the
  /// edge of the box.
  final int? maxLines;

  /// Used to select a font when the same Unicode character can
  /// be rendered differently, depending on the locale.
  ///
  /// It's rarely necessary to set this property. By default its value
  /// is inherited from the enclosing app with `Localizations.localeOf(context)`.
  ///
  /// See [RenderParagraph.locale] for more information.
  final Locale? locale;

  /// {@macro flutter.painting.textPainter.strutStyle}
  final StrutStyle? strutStyle;

  /// {@macro flutter.painting.textPainter.textWidthBasis}
  final TextWidthBasis? textWidthBasis;

  /// {@macro dart.ui.textHeightBehavior}
  final TextHeightBehavior? textHeightBehavior;

  @override
  State<WiseTextWidget> createState() => _WiseTextWidgetState();
}

class _WiseTextWidgetState extends State<WiseTextWidget> {
  Future<String> processText() async {
    if (widget.classified) {
      try {
        final classifiedItems = await WiseTextClassifier(
          classifier: widget.classifier,
        ).classify(widget.text);
        return classifiedItems.map((e) => e.tag).join();
      } catch (e) {
        return widget.text;
      }
    } else {
      return widget.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: processText(),
      initialData: widget.text,
      builder: (context, snapshot) {
        if (widget.selectable) {
          return StyledText.selectable(
            text: snapshot.data ?? widget.text,
            tags: widget.tags,
            newLineAsBreaks: widget.newLineAsBreaks,
            style: widget.style,
            textAlign: widget.textAlign,
            textDirection: widget.textDirection,
            textScaler: widget.textScaler,
            maxLines: widget.maxLines,
            strutStyle: widget.strutStyle,
            textWidthBasis: widget.textWidthBasis,
            textHeightBehavior: widget.textHeightBehavior,
          );
        } else {
          return StyledText(
            text: snapshot.data ?? widget.text,
            softWrap: widget.softWrap,
            overflow: widget.overflow,
            locale: widget.locale,
            tags: widget.tags,
            newLineAsBreaks: widget.newLineAsBreaks,
            style: widget.style,
            textAlign: widget.textAlign,
            textDirection: widget.textDirection,
            textScaler: widget.textScaler,
            maxLines: widget.maxLines,
            strutStyle: widget.strutStyle,
            textWidthBasis: widget.textWidthBasis,
            textHeightBehavior: widget.textHeightBehavior,
          );
        }
      },
    );
  }
}

# wise_text

A Flutter plugin that renders rich, styled text and automatically detects meaningful items — dates, addresses, links, emails and phone numbers — using the host platform's native data detectors.

## Features

- **Native classification**: Detects dates, addresses, links, emails and phone numbers using each platform's built-in detectors — no regexes, no extra dependencies, no network calls
- **`NSDataDetector` on iOS/macOS**: Backed by Apple's data detector via a swiftgen-generated bridge
- **`TextClassifier` on Android**: Backed by Android's on-device `TextClassifier` via a jnigen-generated bridge
- **Unsupported platform fallback**: A no-op classifier on unsupported platforms returns the text untouched, so classification can never crash your UI
- **Rich text styling**: Built on top of [`styled_text`](https://pub.dev/packages/styled_text), so detected items become XML tags you can style however you like

## Installation

Add `wise_text` to your `pubspec.yaml`:

```yaml
dependencies:
  wise_text: ^[version]
```

## Classification

Set `classified: true` and the widget detects meaningful items in your text on-device and lets you style each kind. It uses each platform's native, built-in detectors — so detection is fast, offline, and stays consistent with the rest of the OS:

| Platform      | Powered by        |
| ------------- | ----------------- |
| iOS / macOS   | `NSDataDetector`  |
| Android       | `TextClassifier`  |
| Other         | — (text shown as-is) |

The following item types are detected, each exposed as a `WiseTextItemType` you can style:

| Type          | Example                          |
| ------------- | -------------------------------- |
| `date`        | June 29, 2026 at 3:00 PM         |
| `address`     | 1 Infinite Loop, Cupertino, CA   |
| `link`        | https://www.apple.com            |
| `email`       | hello@appwise.be                 |
| `phoneNumber` | +1 (408) 555-0123                |

Style each type by adding it to the widget's `tags` map (see below).

## Usage

```dart
import 'package:flutter/material.dart';
import 'package:wise_text/wise_text.dart';

WiseTextWidget(
  'Join the Flutter meetup on July 15, 2026 at 6:00 PM at 1600 Amphitheatre Parkway, '
  'Mountain View, CA 94043. Call +1 650-253-0000, visit https://flutter.dev or email events@flutter.dev',
  classified: true,
  selectable: true,
  textAlign: TextAlign.center,
  tags: {
    WiseTextItemType.date.tagName: StyledTextTag(style: TextStyle(color: Colors.red)),
    WiseTextItemType.phoneNumber.tagName: StyledTextTag(style: TextStyle(color: Colors.green)),
    WiseTextItemType.email.tagName: StyledTextTag(style: TextStyle(color: Colors.blue)),
    WiseTextItemType.link.tagName: StyledTextTag(style: TextStyle(color: Colors.purple)),
  },
)
```

Use `WiseTextItemType.<type>.tagName` for the tag keys to stay in sync with the tags the classifier emits (or pass the uppercase string directly, e.g. `'DATE'`).

### Styling the widget's API

`WiseTextWidget` is a thin wrapper around `styled_text`. The `tags`, tag handlers, gesture handling and XML escaping rules all come from that package — see the [`styled_text` documentation](https://pub.dev/packages/styled_text) for the full styling and tag-handler API.

> **Note:** Because tags are XML, the `text` you pass must be valid XML when you use literal tags yourself. Escape `"` `'` `&` `<` `>` and `<space>` as `&quot;` `&apos;` `&amp;` `&lt;` `&gt;` `&space;` respectively.

## Plain classification (no widget)

You can use the classifier on its own when you only need the structured spans:

```dart
final spans = await WiseTextClassifier().classify(
  'Call 0470 58 20 75 before June 29, 2026',
);

for (final span in spans) {
  print('${span.type}: ${span.text}');
}
```

Provide a custom `classifier` (any `WiseTextClassifierInterface`) to either `WiseTextClassifier` or `WiseTextWidget` to override platform detection — useful for testing or supplying your own detection logic.

## Parameters

- `text` (String, required): The text to display. Valid XML when using literal tags.
- `classified` (bool, default: `false`): Whether to run native classification on the text.
- `classifier` (`WiseTextClassifierInterface?`): Custom classifier; defaults to the platform implementation.
- `tags` (`Map<String, StyledTextTagBase>`): Tag-to-style/handler assignments passed through to `styled_text`.
- `selectable` (bool, default: `false`): Renders selectable text. Selection styling comes from `textSelectionTheme` in `ThemeData`.
- `style`, `textAlign`, `textDirection`, `softWrap`, `overflow`, `textScaler`, `maxLines`, `locale`, `strutStyle`, `textWidthBasis`, `textHeightBehavior`, `newLineAsBreaks`: Standard text-rendering options, forwarded to the underlying `StyledText`.

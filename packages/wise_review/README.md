# wise_review

A Flutter package that automatically shows a store review prompt based on app open count.

## Features

- Automatically tracks app open count
- Shows in-app review prompt when threshold is reached
- Configurable minimum open count
- Conditional review display based on app state
- Lifecycle-aware (tracks app resumes)

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  wise_review: ^1.0.0
```

## Usage

Wrap your app's main widget with `WiseReview`:

```dart
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wise_review/wise_review.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return WiseReview(
      minimumOpenCount: 10, // Show review after 10 app opens (default)
      canShowReview: true, // Control when review can be shown
      child: MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}
```

## Parameters

- `minimumOpenCount` (int, default: 10): The minimum number of times the app must be opened before showing the review prompt
- `canShowReview` (bool, required): Controls whether the review prompt can be shown (e.g., only after user completes onboarding)
- `child` (Widget, required): The child widget to wrap

## How it works

1. The widget tracks app opens using SharedPreferences
2. Count increments on:
   - Widget initialization
   - App lifecycle resume (when app comes back to foreground)
3. When count reaches `minimumOpenCount` AND `canShowReview` is true, the in-app review prompt is triggered
4. The actual review prompt display depends on platform availability (iOS/Android)

## Example

```dart
WiseReview(
  minimumOpenCount: 5,
  canShowReview: userCompletedOnboarding && !userDeclinedReview,
  child: MaterialApp(
    home: HomeScreen(),
  ),
)
```

## Requirements

- Flutter SDK: >=3.6.0 <4.0.0
- Dart SDK: >=3.6.0 <4.0.0

## Dependencies

- `wisecore`: For SharedPreferences provider
- `in_app_review`: For native review prompts
- `hooks_riverpod`: For state management

## License

See LICENSE file for details.

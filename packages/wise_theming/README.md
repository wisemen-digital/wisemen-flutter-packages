# WiseTheming 🎨

A comprehensive Flutter theming package that provides a robust and flexible theming system with support for multiple themes, dark mode, high contrast accessibility, and seamless Material Design integration.

## Features ✨

- **🌈 Complete Color System**: Comprehensive color palettes with semantic naming
- **🌙 Multi-Theme Support**: Light, dark, and high contrast theme variants
- **🎯 Type-Safe**: Full type safety with strongly-typed color schemes
- **♿ Accessibility**: Built-in high contrast themes for better accessibility
- **📱 Platform Aware**: Adapts to different platforms (iOS, Android, etc.)
- **🔄 Smooth Transitions**: Color interpolation for animated theme switching
- **🎨 Design System Ready**: Pre-built color palettes and typography scales
- **🚀 Easy Integration**: Simple BuildContext extensions for quick access

## Installation 📦

Add `wise_theming` to your `pubspec.yaml`:

```yaml
dependencies:
  wise_theming: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## Quick Start 🚀

### 1. Basic Setup

```dart
import 'package:flutter/material.dart';
import 'package:wise_theming/wise_theming.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theming = WiseTheming(
      supportedThemes: supportedThemes, // Built-in base themes
      targetPlatform: TargetPlatform.iOS,
    );

    return ValueListenableBuilder(
      valueListenable: theming,
      builder: (context, theme, child) {
        return MaterialApp(
          title: 'My App',
          themeMode: theme?.themeType.themeMode,
          theme: theming.lightTheme,
          darkTheme: theming.darkTheme,
          highContrastTheme: theming.lightContrastTheme,
          highContrastDarkTheme: theming.darkContrastTheme,
          home: MyHomePage(theming: theming),
        );
      },
    );
  }
}
```

### 2. Using Themed Colors and Styles

```dart
class MyHomePage extends StatelessWidget {
  final WiseTheming theming;
  
  const MyHomePage({required this.theming, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColors.primary,
      appBar: AppBar(
        title: Text(
          'My App',
          style: context.title, // Pre-styled with theme colors
        ),
        backgroundColor: context.backgroundColors.brandPrimary,
        foregroundColor: context.textColors.primaryOnBrand,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Using semantic text styles
            Text(
              'Welcome!',
              style: context.headline,
            ),
            Text(
              'This text automatically adapts to the current theme.',
              style: context.body,
            ),
            
            // Theme-aware containers
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: context.backgroundColors.secondary,
                border: Border.all(color: context.borderColors.primary),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Themed container with automatic colors',
                style: context.body,
              ),
            ),
            
            // Theme switching button
            ElevatedButton(
              onPressed: () => _switchTheme('Base dark theme'),
              style: ElevatedButton.styleFrom(
                backgroundColor: context.backgroundColors.brandSolid,
                foregroundColor: context.textColors.primaryOnBrand,
              ),
              child: Text('Switch to Dark Theme'),
            ),
          ],
        ),
      ),
    );
  }
  
  void _switchTheme(String themeId) {
    theming.setCurrentTheme(themeId);
  }
}
```

## Color System 🎨

WiseTheming provides a comprehensive color system organized into semantic categories:

### Text Colors
```dart
context.textColors.primary         // Primary text color
context.textColors.secondary       // Secondary text color
context.textColors.brandPrimary    // Brand-colored text
context.textColors.errorPrimary    // Error state text
context.textColors.disabled        // Disabled text color
```

### Background Colors
```dart
context.backgroundColors.primary       // Primary background
context.backgroundColors.secondary     // Secondary background
context.backgroundColors.brandPrimary  // Brand background
context.backgroundColors.errorPrimary  // Error background
context.backgroundColors.overlay       // Modal overlays
```

### Border Colors
```dart
context.borderColors.primary      // Standard borders
context.borderColors.brand        // Brand-colored borders
context.borderColors.error        // Error state borders
context.borderColors.disabled     // Disabled borders
```

### Utility Colors
```dart
context.utilityColors.blue        // Utility blue
context.utilityColors.green       // Utility green
context.utilityColors.orange      // Utility orange
context.utilityColors.purple      // Utility purple
// + more utility colors
```

## Typography System 📝

Pre-defined text styles that automatically adapt to your theme:

```dart
Text('Large Title', style: context.largeTitle)
Text('Title', style: context.title)
Text('Headline', style: context.headline)
Text('Sub Headline', style: context.subHeadline)
Text('Body Text', style: context.body)
Text('Input Text', style: context.input)
```

All text styles automatically apply the appropriate color from `textColors.primary` while preserving the typography scale.

## Theme Management 🔄

### Switching Themes

```dart
// Switch to a specific theme by identifier
final newTheme = theming.setCurrentTheme('Base dark theme');

// Available base theme identifiers:
// - 'Base theme' (light)
// - 'Base dark theme' (dark)
// - 'High contrast theme' (light high contrast)
// - 'High contrast dark theme' (dark high contrast)
```

### Creating Custom Themes

```dart
final customTheme = WiseTheme(
  identifier: 'My Custom Theme',
  themeType: WiseThemeType.light,
  textColors: const TextColors(
    primary: Color(0xFF2D3748),
    secondary: Color(0xFF4A5568),
    brandPrimary: Color(0xFF3182CE),
    // ... define all required colors
  ),
  backgroundColors: const BackgroundColors(
    primary: Color(0xFFFFFFFF),
    secondary: Color(0xFFF7FAFC),
    brandPrimary: Color(0xFFEBF8FF),
    // ... define all required colors
  ),
  // ... define other color schemes
);

// Use your custom theme
final theming = WiseTheming(
  supportedThemes: [customTheme, ...supportedThemes],
  targetPlatform: TargetPlatform.android,
  selectedTheme: customTheme,
);
```

### Platform-Specific Theming

```dart
final theming = WiseTheming(
  supportedThemes: supportedThemes,
  targetPlatform: Theme.of(context).platform, // Automatically adapt
  selectedTheme: myTheme,
);
```

### Accessibility Features

WiseTheming includes built-in high contrast themes for better accessibility:

```dart
// The package automatically provides high contrast variants
MaterialApp(
  theme: theming.lightTheme,
  darkTheme: theming.darkTheme,
  highContrastTheme: theming.lightContrastTheme,     // High contrast light
  highContrastDarkTheme: theming.darkContrastTheme,  // High contrast dark
  // Flutter automatically switches based on system accessibility settings
)
```

## Examples 📖

Check out the [complete example](https://github.com/wisemen-digital/wisemen-flutter-packages/tree/main/packages/wise_theming/example) for more detailed usage patterns, including:

- Theme switching interface
- Color palette display
- Typography showcase
- Semantic color usage
- Custom theme creation

## API Reference 📚

### Core Classes

- **`WiseTheming`**: Main theming controller and ValueNotifier
- **`WiseTheme`**: Individual theme definition implementing ThemeExtension
- **`WiseThemeType`**: Enum for theme variants (light, dark, lightContrast, darkContrast)

### Color Classes

- **`TextColors`**: Text and foreground colors
- **`BackgroundColors`**: Background and surface colors
- **`BorderColors`**: Border and divider colors
- **`ForegroundColors`**: Interactive element colors
- **`UtilityColors`**: Utility and accent colors

### Extensions

- **`WiseThemeExtension`**: BuildContext extension for accessing theme colors
- **`TextStyleExtension`**: BuildContext extension for accessing text styles

## License 📄

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

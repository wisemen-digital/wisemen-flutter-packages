---
description: 'Flutter theming architecture with 3-layer semantic color system. Use when: setting up theme structure, creating colors, implementing dark mode, adding BuildContext extensions, defining text styles, creating color palettes, organizing theme files. Keywords: theme, colors, dark mode, light mode, TextColors, BackgroundColors, ForegroundColors, BorderColors, UtilityColors, PrimitiveColors, BuildContext extensions, ColorScheme, ThemeData.'
applyTo: 'lib/theme/**'
---

# Flutter Theming Guidelines

Use a 3-layer semantic color system with BuildContext extensions for automatic light/dark mode switching. **Never use hardcoded colors in widgets.**

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                     UI LAYER                                │
│  BuildContext Extensions (auto light/dark switching)        │
│  context.textColor, context.bgColor, context.fgColor, etc.  │
└─────────────────────────────────────────────────────────────┘
                            ▲
┌─────────────────────────────────────────────────────────────┐
│                   SEMANTIC LAYER                            │
│  Abstract color role classes with Light/Dark implementations│
│  TextColors, ForegroundColors, BackgroundColors, etc.       │
└─────────────────────────────────────────────────────────────┘
                            ▲
┌─────────────────────────────────────────────────────────────┐
│                  PRIMITIVE LAYER                            │
│  Raw Material Design color palettes (25-950 swatches)       │
│  PrimitiveColors: gray, brand, error, warning, success      │
└─────────────────────────────────────────────────────────────┘
```

## File Structure

```
lib/theme/
├── theme.dart                    # BuildContext extensions (main entry point)
├── app_theme.dart                # ThemeData configuration
├── colors/
│   ├── colors.dart               # Barrel export
│   ├── primitive_colors.dart     # Raw color palettes
│   ├── text_colors.dart          # Text color roles
│   ├── foreground_colors.dart    # Icon/element colors
│   ├── background_colors.dart    # Background colors
│   ├── border_colors.dart        # Border colors
│   └── utility_colors.dart       # Chart/visualization colors
└── text_styles/
    └── app_text_styles.dart      # Base text style definitions
```

## Layer 1: Primitive Colors

Raw Material Design color palettes using MaterialColor swatches (25, 50, 100...900, 950). **Never use directly in widgets.**

Contains:
- Base colors (white, black, transparent)
- Gray palettes for light and dark mode (`gray`, `grayDark`)
- Brand colors (primary color palette)
- Status colors (`error`, `warning`, `success`)

## Layer 2: Semantic Color Classes

Abstract classes defining color **roles** with separate Light/Dark implementations.

### Color Categories

| Class | Purpose | Example Roles |
|-------|---------|---------------|
| `TextColors` | Text content | `primary`, `secondary`, `disabled`, `errorPrimary` |
| `ForegroundColors` | Icons, graphics | `primary`, `brandPrimary`, `errorPrimary` |
| `BackgroundColors` | Surfaces, containers | `primary`, `secondary`, `brandSolid`, `overlay` |
| `BorderColors` | Borders, dividers | `primary`, `brand`, `error` |
| `UtilityColors` | Charts, visualization | `teal`, `blue`, `orange`, `purple` |

### Pattern

```dart
// Abstract class defines the contract
abstract class TextColors {
  Color get primary;
  Color get secondary;
  Color get disabled;
  Color get errorPrimary;
  // ... more roles
}

// Light implementation
class LightTextColors implements TextColors {
  @override
  Color get primary => PrimitiveColors.gray[900]!;
  // ...
}

// Dark implementation
class DarkTextColors implements TextColors {
  @override
  Color get primary => PrimitiveColors.grayDark[50]!;
  // ...
}
```

## Layer 3: BuildContext Extensions

The UI access layer that auto-switches between light/dark mode.

```dart
// lib/theme/theme.dart

extension ThemeExtension on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  Brightness get brightness => colorScheme.brightness;
}

extension ColorClassesExtensions on BuildContext {
  bool get _isDark => brightness == Brightness.dark;

  TextColors get textColor => _isDark ? DarkTextColors() : LightTextColors();
  ForegroundColors get fgColor => _isDark ? DarkForegroundColors() : LightForegroundColors();
  BorderColors get borderColor => _isDark ? DarkBorderColors() : LightBorderColors();
  BackgroundColors get bgColor => _isDark ? DarkBackgroundColors() : LightBackgroundColors();
  UtilityColors get utilityColor => _isDark ? DarkUtilityColors() : LightUtilityColors();
}

// Optional: Pre-colored text styles
extension TextStyleExtension on BuildContext {
  TextStyle get title => AppStyles.title.copyWith(color: textColor.primaryOnBrand);
  TextStyle get normal => AppStyles.normal.copyWith(color: textColor.primary);
  TextStyle get label => AppStyles.label.copyWith(color: textColor.secondary);
}
```

## Usage Patterns

### ✅ Correct: Use Context Extensions

```dart
// Background
Container(color: context.bgColor.primary)

// Icon
Icon(Icons.home, color: context.fgColor.brandPrimary)

// Text with default color
Text('Hello', style: context.normal)

// Text with custom color - use copyWith to override
Text(
  'Custom colored text',
  style: context.title.copyWith(
    color: context.textColor.tertiary,
  ),
)
Text(
  'Error text',
  style: context.normal.copyWith(
    color: context.textColor.errorPrimary,
    fontWeight: FontWeight.w600,
  ),
)

// Border
Container(
  decoration: BoxDecoration(
    border: Border.all(color: context.borderColor.primary),
  ),
)

// Status feedback
Container(
  color: context.bgColor.errorPrimary,
  child: Icon(Icons.error, color: context.fgColor.errorPrimary),
)

// Charts
PieChart(sections: [
  PieChartSectionData(color: context.utilityColor.blue),
  PieChartSectionData(color: context.utilityColor.orange),
])
```

### ❌ Wrong: Hardcoded Colors

```dart
// DON'T do this
Container(color: Colors.white)
Container(color: Color(0xFF333333))
Icon(Icons.home, color: Colors.blue)
Text('Hello', style: TextStyle(color: Colors.black87))
```

## Best Practices

1. **Never use hardcoded colors** — Always use `context.textColor`, `context.bgColor`, etc.
2. **Never use PrimitiveColors in widgets** — Only reference them in semantic color implementations
3. **Use semantic role names** — `context.textColor.primary` not `Colors.black`
4. **Follow hierarchy convention** — primary → secondary → tertiary → quaternary
5. **Use status variants** — `errorPrimary`, `warningPrimary`, `successPrimary` for feedback
6. **Reserve utility colors** — Only for charts and data visualization
7. **Dark mode is automatic** — Extensions handle light/dark switching based on theme brightness

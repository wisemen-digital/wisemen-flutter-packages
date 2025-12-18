# Testing Guide for Wisemen Flutter Packages

This document provides comprehensive testing guidelines, patterns, and best practices for all packages in the Wisemen Flutter monorepo.

## Table of Contents

- [Overview](#overview)
- [Coverage Standards](#coverage-standards)
- [Testing Patterns](#testing-patterns)
- [Common Issues & Solutions](#common-issues--solutions)
- [Test Organization](#test-organization)
- [Running Tests](#running-tests)
- [Best Practices](#best-practices)
- [Package-Specific Guides](#package-specific-guides)

## Overview

All packages in this monorepo should maintain high test coverage to ensure code quality, prevent regressions, and facilitate refactoring.

### Testing Stack

- **Framework**: Flutter Test
- **State Management**: Riverpod (with ProviderScope for testing)
- **Mocking**: Mocktail
- **Coverage Tool**: lcov

## Coverage Standards

### Minimum Requirements

- **Line Coverage**: 80% minimum
- **Target Coverage**: 85-90%
- **Critical Paths**: 100% (authentication, payment, data persistence)

### What to Test

✅ **Must Test**:
- Public APIs and interfaces
- Business logic and state management
- User interactions and UI flows
- Error handling and edge cases
- Data transformations and validations

❌ **Skip Testing**:
- Generated code (*.g.dart, *.freezed.dart)
- Third-party package wrappers (unless adding logic)
- Simple getters/setters without logic
- Private implementation details

## Testing Patterns

### 1. Widget Testing with Animations

**Problem**: Widgets with animations cause `pumpAndSettle()` to timeout.

**Solution**: Add a `disableAnimations` parameter to animated widgets:

```dart
class MyAnimatedWidget extends StatefulWidget {
  const MyAnimatedWidget({
    super.key,
    this.disableAnimations = false,
  });

  final bool disableAnimations;

  @override
  State<MyAnimatedWidget> createState() => _MyAnimatedWidgetState();
}

class _MyAnimatedWidgetState extends State<MyAnimatedWidget> {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    
    if (widget.disableAnimations) {
      _isVisible = true;
    } else {
      Future.delayed(
        const Duration(milliseconds: 500),
        () => setState(() => _isVisible = true),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _isVisible ? 1.0 : 0.0,
      duration: widget.disableAnimations 
        ? Duration.zero 
        : const Duration(milliseconds: 300),
      child: MyContent(),
    );
  }
}
```

**In Tests**:

```dart
testWidgets('widget renders correctly', (tester) async {
  await tester.pumpWidget(
    const MaterialApp(
      home: MyAnimatedWidget(disableAnimations: true),
    ),
  );
  
  // Use pump() instead of pumpAndSettle()
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 100));
  
  expect(find.byType(MyContent), findsOneWidget);
});
```

### 2. Theming Setup

**Problem**: Widgets using custom theming require proper theme context.

**Solution**: Create a theming helper function:

```dart
// In test/utils/test_helpers.dart
Widget wrapWithTheming(Widget child) {
  final theming = WiseTheming(
    supportedThemes: supportedThemes,
    targetPlatform: TargetPlatform.iOS,
  );

  return MaterialApp(
    theme: theming.lightTheme,
    darkTheme: theming.darkTheme,
    home: child,
  );
}

// Usage
testWidgets('themed widget test', (tester) async {
  await tester.pumpWidget(
    wrapWithTheming(const MyWidget()),
  );
});
```

**Important**: Avoid `ValueListenableBuilder` in test helpers as it can cause infinite rebuild loops.

### 3. Riverpod Provider Testing

**Pattern 1: Testing Provider Values**

```dart
test('provider returns expected value', () {
  final container = ProviderContainer();
  addTearDown(container.dispose);
  
  final value = container.read(myProvider);
  expect(value, expectedValue);
});
```

**Pattern 2: Testing Provider State Changes**

```dart
test('provider state updates correctly', () {
  final container = ProviderContainer();
  addTearDown(container.dispose);
  
  final notifier = container.read(myNotifierProvider.notifier);
  
  expect(container.read(myNotifierProvider), initialState);
  
  notifier.updateState(newValue);
  
  expect(container.read(myNotifierProvider), newValue);
});
```

**Pattern 3: Testing Widgets with Providers**

```dart
testWidgets('widget uses provider correctly', (tester) async {
  await tester.pumpWidget(
    ProviderScope(
      child: MaterialApp(
        home: MyWidget(),
      ),
    ),
  );
  
  await tester.pump();
  
  expect(find.text('Provider Value'), findsOneWidget);
});
```

**Pattern 4: Overriding Providers in Tests**

```dart
testWidgets('widget with overridden provider', (tester) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        myProvider.overrideWith((ref) => mockValue),
      ],
      child: MaterialApp(
        home: MyWidget(),
      ),
    ),
  );
});
```

### 4. Test Assets Management

**Problem**: Widgets loading assets (SVG, images) fail without real files.

**Solution**: Create minimal test fixtures:

```bash
# Create fixtures directory
mkdir -p test/fixtures

# Minimal SVG (10x10 rectangle)
cat > test/fixtures/test_icon.svg << 'EOF'
<svg xmlns="http://www.w3.org/2000/svg" width="10" height="10">
  <rect width="10" height="10" fill="#000"/>
</svg>
EOF

# Minimal PNG (1x1 transparent pixel)
echo 'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNk+M9QDwADhgGAWjR9awAAAABJRU5ErkJggg==' | base64 -d > test/fixtures/test_image.png
```

**Update Fake Implementations**:

```dart
class FakeAssets implements Assets {
  @override
  String get icon => 'test/fixtures/test_icon.svg';
  
  @override
  String get image => 'test/fixtures/test_image.png';
}
```

### 5. Mocking Platform Channels

**Problem**: Platform-specific code throws `MissingPluginException` in tests.

**Solution**: Mock platform channels in test setup:

```dart
// In test/utils/mock_platform.dart
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

const myChannel = MethodChannel('com.example.my_channel');

void mockPlatformChannels() {
  TestWidgetsFlutterBinding.ensureInitialized();
  
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
    .setMockMethodCallHandler(myChannel, (MethodCall methodCall) async {
      switch (methodCall.method) {
        case 'myMethod':
          return {'result': 'success'};
        default:
          return null;
      }
    });
}

// In test files
void main() {
  setUp(() {
    mockPlatformChannels();
  });
}
```

### 6. Testing Async Operations

**Pattern 1: Simple Async Test**

```dart
test('async function completes', () async {
  final result = await myAsyncFunction();
  expect(result, expectedValue);
});
```

**Pattern 2: Testing Futures with Matchers**

```dart
test('future completes with value', () {
  expect(myAsyncFunction(), completion(equals(expectedValue)));
});

test('future throws error', () {
  expect(myAsyncFunction(), throwsA(isA<MyException>()));
});
```

**Pattern 3: Testing Streams**

```dart
test('stream emits values', () {
  expect(
    myStream(),
    emitsInOrder([value1, value2, value3, emitsDone]),
  );
});
```

**Pattern 4: Async Widget Updates**

```dart
testWidgets('async widget update', (tester) async {
  await tester.pumpWidget(MyWidget());
  await tester.pump(); // Initial frame
  
  // Trigger async operation
  await tester.tap(find.byType(ElevatedButton));
  await tester.pump(); // Start async
  await tester.pump(const Duration(seconds: 1)); // Complete async
  
  expect(find.text('Updated'), findsOneWidget);
});
```

### 7. Testing User Interactions

**Tap Gestures**:

```dart
testWidgets('button tap', (tester) async {
  await tester.pumpWidget(MyWidget());
  
  await tester.tap(find.byType(ElevatedButton));
  await tester.pump();
  
  expect(find.text('Tapped'), findsOneWidget);
});
```

**Text Input**:

```dart
testWidgets('text field input', (tester) async {
  await tester.pumpWidget(MyWidget());
  
  await tester.enterText(find.byType(TextField), 'Hello');
  await tester.pump();
  
  expect(find.text('Hello'), findsOneWidget);
});
```

**Scrolling**:

```dart
testWidgets('scroll to item', (tester) async {
  await tester.pumpWidget(MyWidget());
  
  await tester.scrollUntilVisible(
    find.text('Item 50'),
    500.0,
    scrollable: find.byType(Scrollable),
  );
  
  expect(find.text('Item 50'), findsOneWidget);
});
```

**Long Press**:

```dart
testWidgets('long press', (tester) async {
  await tester.pumpWidget(MyWidget());
  
  await tester.longPress(find.byType(GestureDetector));
  await tester.pump();
  
  expect(find.text('Long Pressed'), findsOneWidget);
});
```

### 8. Testing Error Handling

```dart
test('handles error gracefully', () async {
  final repository = MyRepository();
  
  expect(
    () => repository.fetchData(invalidId: 'invalid'),
    throwsA(isA<ValidationException>()),
  );
});

testWidgets('displays error message', (tester) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        dataProvider.overrideWith((ref) => throw Exception('Error')),
      ],
      child: MaterialApp(home: MyWidget()),
    ),
  );
  
  await tester.pump();
  
  expect(find.text('Error occurred'), findsOneWidget);
});
```

## Common Issues & Solutions

### Issue 1: `pumpAndSettle` Timeout

**Symptoms**: 
```
pumpAndSettle timed out
```

**Causes**:
- Continuous animations
- `ValueListenableBuilder` causing rebuilds
- Timers or periodic updates
- Infinite animation loops

**Solutions**:
1. Add `disableAnimations` parameter to widgets
2. Use `pump()` with specific durations instead of `pumpAndSettle()`
3. Avoid `ValueListenableBuilder` in test helpers
4. Set animation durations to `Duration.zero` in tests

```dart
// Instead of:
await tester.pumpAndSettle();

// Use:
await tester.pump();
await tester.pump(const Duration(milliseconds: 100));
```

### Issue 2: Theme Not Found

**Symptoms**:
```
No WiseTheme found in context
```

**Solution**: Wrap widgets with proper theming:

```dart
await tester.pumpWidget(
  wrapWithTheming(const MyWidget()),
);
```

### Issue 3: Asset Loading Failures

**Symptoms**:
```
Unable to load asset: assets/icon.svg
```

**Solution**: Create test fixtures and update fake implementations

### Issue 4: Provider Not Found

**Symptoms**:
```
ProviderNotFoundException
```

**Solution**: Wrap widget with `ProviderScope`:

```dart
await tester.pumpWidget(
  ProviderScope(
    child: MaterialApp(home: MyWidget()),
  ),
);
```

### Issue 5: Platform Channel Errors

**Symptoms**:
```
MissingPluginException
```

**Solution**: Mock platform channels in `setUp()`

## Test Organization

### Directory Structure

```
package_name/
├── lib/
│   └── src/
│       ├── features/
│       ├── models/
│       ├── repositories/
│       └── utils/
└── test/
    ├── features/          # Feature tests
    ├── models/            # Model tests
    ├── repositories/      # Repository tests
    ├── utils/             # Utility tests
    ├── widgets/           # Widget tests
    ├── fixtures/          # Test assets
    │   ├── test_icon.svg
    │   └── test_image.png
    └── utils/             # Test utilities
        ├── test_helpers.dart
        ├── fake_implementations.dart
        └── mock_platform.dart
```

### Test File Naming

- Test files should mirror source files: `my_widget.dart` → `my_widget_test.dart`
- Place tests in the same relative path: `lib/src/widgets/my_widget.dart` → `test/widgets/my_widget_test.dart`

### Test Grouping

```dart
void main() {
  group('MyClass', () {
    group('constructor', () {
      test('creates instance with default values', () {});
      test('creates instance with custom values', () {});
    });
    
    group('myMethod', () {
      test('returns expected value', () {});
      test('throws error on invalid input', () {});
    });
  });
}
```

## Running Tests

### Basic Commands

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/widgets/my_widget_test.dart

# Run tests matching pattern
flutter test --name "MyWidget"

# Run with coverage
flutter test --coverage --coverage-path=coverage/lcov.info

# Run in watch mode (requires package)
flutter test --watch
```

### Coverage Analysis

```bash
# Generate coverage report
flutter test --coverage

# View coverage in terminal (requires lcov)
lcov --summary coverage/lcov.info

# Generate HTML report (requires lcov)
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html

# Check coverage percentage (Python)
python3 -c "
data = open('coverage/lcov.info').read()
lines = data.split('\n')
total_lf = sum(int(line.split(':')[1]) for line in lines if line.startswith('LF:'))
total_lh = sum(int(line.split(':')[1]) for line in lines if line.startswith('LH:'))
coverage = (total_lh / total_lf * 100) if total_lf > 0 else 0
print(f'Coverage: {coverage:.2f}%')
"
```

### CI/CD Integration

```yaml
# Example GitHub Actions workflow
name: Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
      - run: flutter pub get
      - run: flutter test --coverage
      - run: |
          if [ $(python3 -c "data = open('coverage/lcov.info').read(); lines = data.split('\n'); total_lf = sum(int(line.split(':')[1]) for line in lines if line.startswith('LF:')); total_lh = sum(int(line.split(':')[1]) for line in lines if line.startswith('LH:')); coverage = (total_lh / total_lf * 100) if total_lf > 0 else 0; print(int(coverage))") -lt 80 ]; then
            echo "Coverage is below 80%"
            exit 1
          fi
```

## Best Practices

### General Guidelines

1. **Write tests first** (TDD) or immediately after implementation
2. **Keep tests simple** - one concept per test
3. **Use descriptive names** - test names should explain what is being tested
4. **Test behavior, not implementation** - focus on what, not how
5. **Make tests independent** - each test should run in isolation
6. **Clean up resources** - use `addTearDown()` or `tearDown()`
7. **Avoid test interdependence** - don't rely on test execution order
8. **Mock external dependencies** - isolate the unit under test
9. **Test edge cases** - null, empty, boundary values
10. **Keep tests fast** - avoid unnecessary delays

### Widget Testing Guidelines

1. **Always disable animations** in widget tests
2. **Use `pump()` over `pumpAndSettle()`** when possible
3. **Test user-visible behavior** - what users see and interact with
4. **Verify accessibility** - test with screen readers in mind
5. **Test different screen sizes** - use `tester.binding.window.physicalSizeTestValue`
6. **Test theme variations** - light/dark mode
7. **Test localization** - different languages if applicable

### Provider Testing Guidelines

1. **Test provider initialization** - verify initial state
2. **Test state transitions** - verify state changes correctly
3. **Test provider dependencies** - verify providers interact correctly
4. **Test error states** - verify error handling
5. **Dispose containers** - always use `addTearDown(container.dispose)`

### Code Coverage Guidelines

1. **Aim for 80%+ coverage** - but don't chase 100%
2. **Focus on critical paths** - authentication, payments, data persistence
3. **Skip generated code** - *.g.dart, *.freezed.dart files
4. **Document uncovered code** - explain why certain code isn't tested
5. **Review coverage reports** - identify gaps regularly

### Test Maintenance

1. **Update tests with code changes** - keep tests in sync
2. **Refactor tests** - apply DRY principle to test code
3. **Remove obsolete tests** - delete tests for removed features
4. **Update test data** - keep test fixtures current
5. **Review test failures** - investigate and fix promptly

## Package-Specific Guides

Each package may have specific testing requirements. Refer to package-level `TESTING_GUIDE.md` files:

- [wise_ultra_login](packages/wise_ultra_login/TESTING_GUIDE.md) - Authentication and login testing patterns

## Contributing

When adding new testing patterns or solutions:

1. Document the pattern in this guide
2. Add examples to relevant package guides
3. Update the table of contents
4. Share learnings with the team

## Resources

- [Flutter Testing Documentation](https://docs.flutter.dev/testing)
- [Riverpod Testing Guide](https://riverpod.dev/docs/essentials/testing)
- [Mocktail Documentation](https://pub.dev/packages/mocktail)
- [Flutter Test Best Practices](https://docs.flutter.dev/testing/best-practices)

---

**Last Updated**: November 2025  
**Maintainer**: Development Team  
**Questions**: Contact the team lead or open an issue

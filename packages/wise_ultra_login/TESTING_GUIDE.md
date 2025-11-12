# Testing Guide for wise_ultra_login

This document outlines the testing approach, patterns, and lessons learned while achieving 80%+ code coverage for the wise_ultra_login package.

## Coverage Achievement

- **Target**: 80% code coverage
- **Achieved**: 89.61% (207/231 lines)
- **Total Tests**: 100 tests (all passing)

## Key Testing Patterns

### 1. Widget Testing with Animations

**Problem**: Flutter widgets with animations can cause `pumpAndSettle()` to timeout in tests, especially when using `ValueListenableBuilder` or continuous animations.

**Solution**: Add a `disableAnimations` parameter to widgets that have animations:

```dart
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({
    super.key,
    this.belowTitleHeader,
    this.footer,
    this.disableAnimations = false, // Add this parameter
  });

  final bool disableAnimations;
  
  // In initState:
  @override
  void initState() {
    super.initState();
    
    if (widget.disableAnimations) {
      _isOpen = true; // Skip animation delay
    } else {
      Future.delayed(
        const Duration(milliseconds: 500),
        () => setState(() => _isOpen = true),
      );
    }
  }
  
  // For AnimatedWidgets, use conditional durations:
  AnimatedClipRect(
    open: _isOpen,
    duration: widget.disableAnimations 
      ? Duration.zero 
      : const Duration(milliseconds: 300),
    child: Container(...),
  )
}
```

**In Tests**: Use `pump()` with short delays instead of `pumpAndSettle()`:

```dart
await tester.pumpWidget(widget);
await tester.pump();
await tester.pump(const Duration(milliseconds: 100));
```

### 2. Theming Setup for Widget Tests

**Problem**: Widgets using `WiseTheming` require proper theme context or they'll throw assertions.

**Solution**: Create a helper function to wrap widgets with theming:

```dart
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

// Usage in tests:
await tester.pumpWidget(
  ProviderScope(
    child: wrapWithTheming(
      const LoginScreen(disableAnimations: true),
    ),
  ),
);
```

**Important**: Don't use `ValueListenableBuilder` in test helpers as it can cause infinite rebuild loops.

### 3. Test Asset Management

**Problem**: Widgets that load assets (SVG, images) need real files to avoid loading errors.

**Solution**: Create minimal test fixtures:

```bash
# Create test fixtures directory
mkdir -p test/fixtures

# Create minimal SVG
echo '<svg xmlns="http://www.w3.org/2000/svg"><rect width="10" height="10"/></svg>' > test/fixtures/test_icon.svg

# Create minimal PNG (1x1 transparent pixel)
echo 'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNk+M9QDwADhgGAWjR9awAAAABJRU5ErkJggg==' | base64 -d > test/fixtures/test_image.png
```

Update fake implementations to use test fixtures:

```dart
class FakeLoginAssets implements LoginAssets {
  @override
  String get apple => 'test/fixtures/test_icon.svg';
  
  @override
  String get email => 'test/fixtures/test_icon.svg';
  
  @override
  String get google => 'test/fixtures/test_icon.svg';
  
  @override
  String get splashImage => 'test/fixtures/test_image.png';
}
```

### 4. Riverpod Provider Testing

**Pattern**: Use `ProviderScope` and `ProviderContainer` for testing providers:

```dart
test('provider test', () {
  final container = ProviderContainer();
  addTearDown(container.dispose);
  
  final value = container.read(myProvider);
  expect(value, expectedValue);
});

// For widget tests:
await tester.pumpWidget(
  ProviderScope(
    child: MyWidget(),
  ),
);
```

### 5. Mock Setup for Platform Channels

**Pattern**: Mock platform channels in `setUpAll` to avoid platform-specific errors:

```dart
void mockPlatformAlerts() {
  TestWidgetsFlutterBinding.ensureInitialized();
  
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
    .setMockMethodCallHandler(channel, handler);
}

void main() {
  setUp(() {
    mockPlatformAlerts();
  });
}
```

## Test Organization

### Test Structure

```
test/
├── controllers/          # Controller/Notifier tests
├── enums/               # Enum tests
├── models/              # Model tests
├── providers/           # Provider tests
├── repository/          # Repository tests
├── screens/             # Widget/Screen tests
├── utils/               # Test utilities
│   ├── fake_ref.dart   # Fake implementations
│   └── mock_auth.dart  # Platform channel mocks
└── fixtures/            # Test assets
    ├── test_icon.svg
    └── test_image.png
```

### Test Categories

1. **Unit Tests**: Test individual functions, methods, and classes
   - Models (constructors, getters, methods)
   - Enums (values, comparisons)
   - Utilities

2. **Provider Tests**: Test Riverpod providers
   - Initial state
   - State changes
   - Provider dependencies

3. **Repository Tests**: Test data layer
   - CRUD operations
   - Error handling
   - Integration with providers

4. **Controller Tests**: Test business logic
   - State management
   - User actions
   - Error handling

5. **Widget Tests**: Test UI components
   - Rendering
   - User interactions
   - Layout structure
   - Edge cases

## Common Test Patterns

### Testing Widget Properties

```dart
test('widget has correct properties', () {
  const widget = MyWidget(
    property1: 'value1',
    property2: 'value2',
  );
  
  expect(widget.property1, equals('value1'));
  expect(widget.property2, equals('value2'));
});
```

### Testing Widget Rendering

```dart
testWidgets('widget renders correctly', (tester) async {
  await tester.pumpWidget(
    ProviderScope(
      child: wrapWithTheming(
        const MyWidget(disableAnimations: true),
      ),
    ),
  );
  
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 100));
  
  expect(find.text('Expected Text'), findsOneWidget);
  expect(find.byType(ExpectedWidget), findsOneWidget);
});
```

### Testing User Interactions

```dart
testWidgets('button tap triggers action', (tester) async {
  int tapCount = 0;
  
  await tester.pumpWidget(
    MaterialApp(
      home: ElevatedButton(
        onPressed: () => tapCount++,
        child: const Text('Tap Me'),
      ),
    ),
  );
  
  await tester.tap(find.text('Tap Me'));
  await tester.pump();
  
  expect(tapCount, equals(1));
});
```

### Testing Async Operations

```dart
test('async operation completes', () async {
  final result = await myAsyncFunction();
  expect(result, expectedValue);
});

testWidgets('async widget update', (tester) async {
  await tester.pumpWidget(MyWidget());
  await tester.pump(); // Initial frame
  
  // Trigger async operation
  await tester.tap(find.byType(ElevatedButton));
  await tester.pump(); // Start async operation
  await tester.pump(const Duration(seconds: 1)); // Complete async operation
  
  expect(find.text('Updated'), findsOneWidget);
});
```

## Troubleshooting

### Issue: `pumpAndSettle` Timeout

**Symptoms**: Tests fail with "pumpAndSettle timed out"

**Causes**:
- Continuous animations
- `ValueListenableBuilder` causing rebuilds
- Timers or periodic updates

**Solutions**:
1. Add `disableAnimations` parameter to widgets
2. Use `pump()` instead of `pumpAndSettle()`
3. Avoid `ValueListenableBuilder` in test helpers
4. Set animation durations to `Duration.zero` in tests

### Issue: Theme Not Found

**Symptoms**: "No WiseTheme found in context"

**Solution**: Wrap widgets with proper theming using `wrapWithTheming()` helper

### Issue: Asset Loading Failures

**Symptoms**: "Unable to load asset" errors

**Solution**: Create test fixtures and update fake implementations to use them

### Issue: Platform Channel Errors

**Symptoms**: "MissingPluginException" or platform-specific errors

**Solution**: Mock platform channels in test setup

## Running Tests

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/screens/login_screen_test.dart

# Run with coverage
flutter test --coverage --coverage-path=coverage/lcov.info

# Check coverage percentage
python3 -c "
data = open('coverage/lcov.info').read()
lines = data.split('\n')
total_lf = sum(int(line.split(':')[1]) for line in lines if line.startswith('LF:'))
total_lh = sum(int(line.split(':')[1]) for line in lines if line.startswith('LH:'))
coverage = (total_lh / total_lf * 100) if total_lf > 0 else 0
print(f'Coverage: {coverage:.2f}%')
"
```

## Best Practices

1. **Always test with animations disabled** in widget tests to avoid timeouts
2. **Use descriptive test names** that explain what is being tested
3. **Group related tests** using `group()` for better organization
4. **Clean up resources** using `addTearDown()` or `tearDown()`
5. **Mock external dependencies** to isolate units under test
6. **Test edge cases** including null values, empty lists, and error conditions
7. **Keep tests independent** - each test should be able to run in isolation
8. **Use setUp/setUpAll** for common initialization
9. **Avoid testing implementation details** - focus on behavior
10. **Maintain test fixtures** in a dedicated directory

## Coverage Goals

- **Minimum**: 80% line coverage
- **Target**: 85-90% line coverage
- **Focus areas**:
  - All public APIs
  - Business logic
  - Error handling
  - User interactions
  - Edge cases

## Applying to Other Packages

When testing other packages in the monorepo:

1. **Copy test utilities**: Reuse `fake_ref.dart`, `mock_auth.dart` patterns
2. **Create test fixtures**: Add minimal assets for any asset-loading widgets
3. **Add animation controls**: Include `disableAnimations` parameter in animated widgets
4. **Use theming helper**: Adapt `wrapWithTheming()` for package-specific themes
5. **Follow test structure**: Maintain consistent directory organization
6. **Document patterns**: Update this guide with package-specific patterns

## Maintenance

- **Update tests** when adding new features
- **Refactor tests** when refactoring code
- **Review coverage** regularly to identify gaps
- **Update this guide** with new patterns and solutions
- **Share learnings** across the team

---

**Last Updated**: November 2025  
**Package Version**: wise_ultra_login  
**Coverage**: 89.61%

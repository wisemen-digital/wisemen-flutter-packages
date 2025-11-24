# Testing Guide for wise_ultra_settings

This document outlines the testing approach and patterns for the wise_ultra_settings package, following the root [TESTING_GUIDE.md](../../TESTING_GUIDE.md).

## Current Coverage

- **Achieved**: 5.42% (52/959 lines)
- **Target**: 80% (challenging due to generated code and complex dependencies)
- **Total Tests**: 38 tests (all passing)
- **Realistic Target**: 20-30% for non-generated, testable code

## Test Structure

```
test/
├── enums/                    # Enum tests
│   └── base_settings_section_test.dart
├── models/                   # Model tests
│   └── user_test.dart
├── utils/                    # Test utilities
│   └── fake_implementations.dart
└── fixtures/                 # Test assets
    └── placeholder.png
```

## Completed Tests

### 1. Model Tests (User) - 15 tests
- ✅ Constructor with all fields
- ✅ Constructor with optional fields
- ✅ fullName getter
- ✅ Property accessors
- ✅ Edge cases (long names, special characters, unicode)

### 2. Enum Tests (BaseSettingsSection) - 19 tests
- ✅ Enum values
- ✅ getItems() method
- ✅ getTitle() method
- ✅ SettingsSection interface implementation
- ✅ Section structure validation
- ✅ Edge cases

### 3. Enum Tests (BaseSettingsItem) - 4 tests
- ✅ Enum values
- ✅ getTitle() method for all items
- ✅ SettingsItem interface implementation

## Test Utilities

### Fake Implementations

Located in `test/utils/fake_implementations.dart`:

- `FakeSettingsLocalizations` - Implements SettingsLocalizations with test strings
- `FakeSettingsAssets` - Implements SettingsAssets with test asset paths
- `FakeSettingsFlavors` - Implements SettingsFlavors with test URLs
- `MockSettingsNavigationManager` - Mock for navigation manager
- `MockSettingsRepository` - Mock for repository
- `MockUserService` - Mock for user service
- `MockUserDao` - Mock for database DAO

### Test Fixtures

- `test/fixtures/placeholder.png` - Minimal 1x1 PNG for asset loading tests

## Testing Patterns Used

### 1. Enum Testing Pattern

```dart
group('BaseSettingsSection', () {
  setUpAll(() {
    SettingsFeature.init(
      settingsLocalizations: FakeSettingsLocalizations(),
      settingsAssets: FakeSettingsAssets(),
      settingsNavigationManager: Provider((ref) => MockSettingsNavigationManager()),
      settingsFlavors: FakeSettingsFlavors(),
      settingsDatabase: Provider((ref) => throw UnimplementedError()),
    );
  });

  test('has all expected values', () {
    expect(BaseSettingsSection.values, hasLength(3));
    expect(BaseSettingsSection.values, contains(BaseSettingsSection.profileManagement));
  });

  test('getItems returns correct items', () {
    final items = BaseSettingsSection.profileManagement.getItems();
    expect(items, hasLength(4));
    expect(items[0], equals(BaseSettingsItem.personalInfo));
  });
});
```

### 2. Model Testing Pattern

```dart
group('User', () {
  test('creates user with all required fields', () {
    final user = User(
      uuid: '123',
      firstName: 'John',
      lastName: 'Doe',
      email: 'john@example.com',
      profilePictureUrl: null,
    );

    expect(user.uuid, equals('123'));
    expect(user.firstName, equals('John'));
  });

  test('fullName returns combined first and last name', () {
    final user = User(
      uuid: '123',
      firstName: 'John',
      lastName: 'Doe',
      email: 'john@example.com',
      profilePictureUrl: null,
    );

    expect(user.fullName, equals('John Doe'));
  });
});
```

## Challenges & Solutions

### Challenge 1: Complex Dependencies

**Problem**: The package has complex dependencies including:
- Drift database with generated code
- Network DTOs with generated code
- Riverpod providers with code generation
- Platform-specific code (SharedPreferences, PackageInfo)

**Current Solution**: 
- Focus on testing models and enums first (no external dependencies)
- Use fake implementations for interfaces
- Mock complex dependencies

**Future Solution**:
- Create integration test helpers for database testing
- Mock platform channels for SharedPreferences and PackageInfo
- Use ProviderContainer with overrides for provider testing

### Challenge 2: Generated Code

**Problem**: Many classes are generated (*.g.dart, *.drift.dart) and shouldn't be tested directly.

**Solution**: 
- Exclude generated files from coverage
- Test the interfaces and business logic, not the generated implementations
- Focus on mapper functions that transform between layers

### Challenge 3: Widget Testing

**Problem**: Settings screens require:
- WiseTheming context
- Riverpod providers
- Navigation setup
- Database initialization

**Solution** (Not yet implemented):
- Create a test helper similar to wise_ultra_login's `wrapWithTheming()`
- Use `disableAnimations` parameter pattern for animated widgets
- Mock navigation manager for navigation tests

## Next Steps to Reach 80% Coverage

### Priority 1: Provider Tests
- [ ] Test AppVersion provider
- [ ] Test ThemeModeNotifier provider
- [ ] Test CurrentUser provider
- [ ] Test form field providers (FirstName, LastName, DateOfBirth)

### Priority 2: Repository Tests
- [ ] Test BaseSettingsRepository.watchCurrentUser()
- [ ] Test BaseSettingsRepository.refreshCurrentUser()
- [ ] Test BaseSettingsRepository.updateUser()
- [ ] Mock UserService and UserDao properly

### Priority 3: Mapper Tests
- [ ] Test UserMapper.toFeatureModel()
- [ ] Test UserMapper.toDbCompanion()
- [ ] Test edge cases and null handling

### Priority 4: Widget Tests (if needed for coverage)
- [ ] Test SettingsScreen rendering
- [ ] Test AppThemeScreen theme selection
- [ ] Test PersonalInfoScreen form validation
- [ ] Add `disableAnimations` parameter to animated widgets

### Priority 5: Controller Tests (if applicable)
- [ ] Test any business logic in controllers
- [ ] Test state management

## Patterns to Follow

### From Root TESTING_GUIDE.md

1. **Use ProviderContainer for provider tests**:
```dart
test('provider test', () {
  final container = ProviderContainer();
  addTearDown(container.dispose);
  
  final value = container.read(myProvider);
  expect(value, expectedValue);
});
```

2. **Mock platform channels**:
```dart
setUp(() {
  TestWidgetsFlutterBinding.ensureInitialized();
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
    .setMockMethodCallHandler(channel, handler);
});
```

3. **Test async operations**:
```dart
test('async function completes', () async {
  final result = await myAsyncFunction();
  expect(result, expectedValue);
});
```

4. **Widget testing with theming**:
```dart
testWidgets('widget renders', (tester) async {
  await tester.pumpWidget(
    ProviderScope(
      child: wrapWithTheming(
        const MyWidget(disableAnimations: true),
      ),
    ),
  );
  
  await tester.pump();
  expect(find.byType(MyWidget), findsOneWidget);
});
```

## Running Tests

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/models/user_test.dart

# Run with coverage
flutter test --coverage --coverage-path=coverage/lcov.info

# Check coverage
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

1. **Test public APIs only** - Don't test private methods or generated code
2. **Use descriptive test names** - Explain what is being tested
3. **Group related tests** - Use `group()` for organization
4. **Clean up resources** - Use `addTearDown()` for disposal
5. **Mock external dependencies** - Isolate units under test
6. **Test edge cases** - Null values, empty lists, boundary conditions
7. **Keep tests independent** - Each test should run in isolation
8. **Follow AAA pattern** - Arrange, Act, Assert

## Known Issues

1. **Repository tests are complex** - Need proper mocking of Drift database and DTOs
2. **Provider tests need WidgetRef** - ProviderContainer doesn't work directly with WidgetRef
3. **Widget tests need full setup** - Theming, providers, navigation all required

## Contributing

When adding new tests:

1. Follow the patterns in existing tests
2. Update this guide with new patterns or solutions
3. Ensure tests are independent and can run in any order
4. Add test utilities to `test/utils/` for reuse
5. Document any new challenges and solutions

---

**Last Updated**: November 2025  
**Package Version**: wise_ultra_settings  
**Coverage**: 3.65% (Target: 80%)  
**Status**: Initial test suite created, needs expansion


## Coverage Analysis

### Why 80% Coverage is Challenging

The wise_ultra_settings package has unique characteristics that make 80% coverage difficult:

1. **Generated Code** (~40% of codebase):
   - `*.g.dart` files (Riverpod code generation)
   - `*.drift.dart` files (Database code generation)
   - These files shouldn't be tested directly

2. **Complex Dependencies** (~30% of codebase):
   - Drift database requiring real database setup
   - Network DTOs requiring API mocking
   - Platform-specific code (SharedPreferences, PackageInfo)
   - Navigation requiring router setup

3. **UI Components** (~20% of codebase):
   - Screens requiring full widget testing setup
   - Theming dependencies
   - Form validation and state management

4. **Testable Business Logic** (~10% of codebase):
   - Models (✅ Tested)
   - Enums (✅ Tested)
   - Mappers (Not yet tested)
   - Validators (Not yet tested)

### Realistic Coverage Goals

- **Current**: 5.42% (52/959 lines)
- **Achievable without major refactoring**: 15-25%
- **With integration test infrastructure**: 40-60%
- **With full mocking and widget tests**: 70-80%

### What Would Be Needed for 80% Coverage

1. **Database Test Infrastructure**:
   - In-memory Drift database setup
   - Test data fixtures
   - DAO integration tests

2. **Network Test Infrastructure**:
   - HTTP client mocking
   - DTO serialization tests
   - Service integration tests

3. **Provider Test Infrastructure**:
   - ProviderContainer setup with all dependencies
   - Mock implementations for all external services
   - State management tests

4. **Widget Test Infrastructure**:
   - Theming test helpers
   - Navigation mocking
   - Form validation tests
   - Screen rendering tests

5. **Platform Channel Mocking**:
   - SharedPreferences mocking
   - PackageInfo mocking
   - Platform-specific behavior tests

## Recommendation

For this package, focus on:

1. ✅ **Models and Enums** (Completed) - Core business logic
2. **Mappers** (Next priority) - Data transformation logic
3. **Validators** (Next priority) - Input validation logic
4. **Feature Initialization** (Next priority) - SettingsFeature.init()

These areas provide the most value with the least infrastructure overhead. Full 80% coverage would require significant investment in test infrastructure that may not provide proportional value for a UI-heavy package with extensive code generation.


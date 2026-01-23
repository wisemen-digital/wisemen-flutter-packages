# Wise Sentry Features

This package provides advanced error filtering, enrichment, and categorization for Sentry in Flutter/Dart projects, making error triage and debugging much more actionable and maintainable.


## Features

- **Easy Sentry Initialization & Integration**
  - Simple WiseSentry.init(...) method to initialize Sentry with the correct beforeSend logic, environment, and sample rate.
  - Automatically wraps your app with SentryWidget for error tracking.
  - Provides helpers for logging errors, setting/clearing user data, and capturing HTTP/UI/business logic errors.

- **Granular Error Filtering**
  - Filters out non-actionable network and server errors (e.g., connection timeouts, 5xx responses, OSError patterns).
  - Only logs actionable HTTP errors (e.g., POST/PUT/PATCH/DELETE with user impact, GET with user params and 400/422).

- **Error Enrichment**
  - Automatically wraps FormatException and TypeError as DTOError with JSON and mapping context.
  - Utility classes for robust error wrapping:
    - `WiseDTOParser`: For DTO/model parsing errors.
    - `WiseMapperParser`: For mapping/index/detail model errors, with JSON and value context.
    - `WiseBusinessLogicParser`: For business logic/provider errors, with file and context.
    - `WiseUIErrorParser`: For UI errors (null checks, overflow, assertion errors), with widget/file context.

- **Error Categorization & Tagging**
  - Categorizes errors as `dto`, `mapper`, `business-logic`, `ui`, `network`, `flutter`, etc. for Sentry grouping.
  - Adds a `wise-type` tag for each WiseException subtype (e.g., DTOError, MapperError, UIError, BusinessLogicError) for easy filtering and prioritization in Sentry.

- **Granular Fingerprinting**
  - Custom Sentry fingerprinting for better grouping of similar errors (category, file, type, value).

- **Maintainable & Extensible**
  - All error handling logic is modular and easy to extend for new error types or business rules.
  - Utility functions and classes can be used throughout your codebase for consistent error reporting.

- **Debug Mode Awareness**
  - Optionally disables Sentry logging in debug mode to avoid noise during development.

- **Best Practices for Sentry**
  - Ensures only actionable, context-rich, and categorized errors are sent to Sentry, reducing noise and improving triage.

## Example Usage

```dart
final model = WiseDTOParser.parse(() => MyModel.fromJson(json), json: json, mapper: 'MyModel.fromJson');
final detail = WiseMapperParser.parse(() => MyModel.fromDetailJson(json), json: json, mapper: 'MyModel.fromDetailJson');
final result = WiseBusinessLogicParser.parse(() => myProviderFunction(), context: {...}, location: 'my_provider.dart');
final widget = WiseUIErrorParser.parse(() => myWidgetBuilder(), context: {...}, location: 'my_widget.dart');
```

## Sentry Dashboard Benefits
- Filter and prioritize errors by type and category.
- Quickly identify backend vs. frontend issues.
- See actionable context (JSON, file, value) for each error.
- Reduce noise from non-actionable errors.

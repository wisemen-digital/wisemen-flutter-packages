## 0.0.1

### Initial Release

**Features:**
- 🎯 Smart error filtering (network timeouts, 5xx errors, cancelled requests)
- 🏷️ Automatic error categorization (ui, dto, network, mapper)
- 🔍 Rich context extraction (API errors, JSON data, widget info)
- 🔗 Better error grouping with URL normalization
- 📊 Clean exception display in Sentry dashboard

**Error Enrichment:**
- DioException → HttpException with parsed API error details
- TypeError context detection (DTO vs UI)
- FlutterError enhancement with widget context
- Automatic fingerprinting for better grouping

**Utilities:**
- `WiseDTOParser` - DTO/model parsing with error context
- `WiseMapperParser` - Data transformation error wrapping
- `WiseUIErrorParser` - UI error enrichment
- `WiseSentryDioInterceptor` - Automatic HTTP error logging

**Dependencies:**
- Compatible with Sentry Flutter SDK 9.x only (to avoid breaking changes)
- Requires Dio 5.x
- Minimum Dart SDK: 3.6.0
- Minimum Flutter: 3.19.5

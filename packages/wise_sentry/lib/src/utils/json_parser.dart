import 'dart:io';
import 'package:stack_trace/stack_trace.dart';
import 'package:wise_sentry/wise_sentry.dart';

/// A utility function to safely parse JSON and enrich TypeErrors/FormatExceptions
/// with context, including the problematic line of code.
///
/// **NOTE**: This function is optional. TypeErrors and FormatExceptions are automatically
/// enriched in the Sentry beforeSend callback. Use this function only if you want to
/// throw a WiseTypeError or MapperError immediately with custom context.
///
/// For basic usage, you can simply use your fromJson function normally and let
/// Sentry's beforeSend handle the enrichment automatically. To provide JSON context:
/// ```dart
/// try {
///   return MyModel.fromJson(jsonMap);
/// } catch (e, st) {
///   Sentry.captureException(e, stackTrace: st, hint: Hint.withMap({'json': jsonMap}));
///   rethrow;
/// }
/// ```
///
/// [jsonMap] The JSON data as a Map<String, dynamic>.
/// [fromJson] The function to convert the JSON map into a Dart object.
/// [originalStackTrace] The original stack trace where the parsing was attempted.
///
/// Throws [WiseTypeError] or [MapperError] on parsing failures.
T safeFromJsonWithContext<T>(
  Map<String, dynamic> jsonMap,
  T Function(Map<String, dynamic>) fromJson,
  StackTrace originalStackTrace,
) {
  try {
    return fromJson(jsonMap);
  } on FormatException catch (e) {
    // Handle FormatException specifically
    throw MapperError(
      'Format error during JSON deserialization: ${e.message}',
      originalError: e,
      stackTrace: originalStackTrace,
      extras: {
        'problematic_json': jsonMap,
        'format_error_offset': e.offset,
      },
    );
  } on Object catch (e, st) {
    // Catch all other Errors and Exceptions
    if (e is TypeError) {
      // Find the relevant frame in the stack trace
      final frame = _findRelevantStackFrame(st);
      String? problematicLine;

      // Attempt to read the file and extract the problematic line.
      // This part will only work on platforms where dart:io is available (not web).
      if (frame != null && frame.uri.scheme == 'file') {
        try {
          final file = File.fromUri(frame.uri);
          if (file.existsSync()) {
            final lines = file.readAsLinesSync();
            if (frame.line != null && frame.line! > 0 && frame.line! <= lines.length) {
              problematicLine = lines[frame.line! - 1].trim();
            }
          }
        } catch (fileError) {
          // Ignore file reading errors, just don't add the line context.
          // Optionally, capture this internal error to Sentry if it's unexpected.
          WiseSentry.captureException(fileError, StackTrace.current);
        }
      }

      throw WiseTypeError(
        'Type error during JSON deserialization',
        expectedType: e.toString().contains('is not a subtype of')
            ? e.toString().split('is not a subtype of').last.split(' in type cast').first.trim()
            : 'unknown',
        actualValue: 'null', // TypeErrors often indicate a null where a non-null was expected
        originalError: e,
        stackTrace: originalStackTrace,
        extras: {
          'problematic_json': jsonMap,
          if (problematicLine != null) 'problematic_line_of_code': problematicLine,
        },
      );
    } else {
      // If it's not a TypeError, wrap it in a generic MapperError
      throw MapperError(
        'Unexpected error during JSON deserialization: $e',
        originalError: e,
        stackTrace: originalStackTrace,
        extras: {
          'problematic_json': jsonMap,
        },
      );
    }
  }
}

/// Finds the first relevant stack frame (typically the first user code frame)
/// in the stack trace, skipping framework and package internals where possible.
Frame? _findRelevantStackFrame(StackTrace stackTrace) {
  final trace = Trace.from(stackTrace);
  // Try to find the first frame that looks like user code
  // (not from dart:core or other system packages)
  for (final frame in trace.frames) {
    final uri = frame.uri;
    if (uri.scheme == 'file' || 
        (uri.scheme == 'package' && !uri.path.startsWith('flutter/') && !uri.path.startsWith('dart:'))) {
      return frame;
    }
  }
  // Fallback: return the first frame if no better option
  return trace.frames.isNotEmpty ? trace.frames.first : null;
}

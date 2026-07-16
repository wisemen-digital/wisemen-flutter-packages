// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "categoryLabel": MessageLookupByLibrary.simpleMessage("Category"),
        "fieldCurrentSituation": MessageLookupByLibrary.simpleMessage(
          "Current Situation",
        ),
        "fieldDescription": MessageLookupByLibrary.simpleMessage("Description"),
        "fieldDesiredSituation": MessageLookupByLibrary.simpleMessage(
          "Desired Situation",
        ),
        "genericError": MessageLookupByLibrary.simpleMessage(
          "Something went wrong. Please try again.",
        ),
        "priorityHigh": MessageLookupByLibrary.simpleMessage("High"),
        "priorityLabel": MessageLookupByLibrary.simpleMessage("Priority"),
        "priorityLow": MessageLookupByLibrary.simpleMessage("Low"),
        "priorityMedium": MessageLookupByLibrary.simpleMessage("Medium"),
        "priorityNone": MessageLookupByLibrary.simpleMessage("None"),
        "priorityUrgent": MessageLookupByLibrary.simpleMessage("Urgent"),
        "sheetTitle": MessageLookupByLibrary.simpleMessage("Report a bug"),
        "successMessage": MessageLookupByLibrary.simpleMessage(
          "Bug reported. Thanks!",
        ),
        "titleFieldLabel": MessageLookupByLibrary.simpleMessage("Title"),
      };
}

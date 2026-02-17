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
    "appTitle": MessageLookupByLibrary.simpleMessage("Kutbi"),
    "btnLogin": MessageLookupByLibrary.simpleMessage("Login"),
    "email": MessageLookupByLibrary.simpleMessage("Email"),
    "error_empty_email": MessageLookupByLibrary.simpleMessage(
      "Email is required",
    ),
    "error_empty_password": MessageLookupByLibrary.simpleMessage(
      "Password is required",
    ),
    "error_invalid_email": MessageLookupByLibrary.simpleMessage(
      "Enter a valid email",
    ),
    "error_invalid_password": MessageLookupByLibrary.simpleMessage(
      "Min 6 characters",
    ),
    "error_required_field": MessageLookupByLibrary.simpleMessage(
      "This field is required",
    ),
    "loginTitle": MessageLookupByLibrary.simpleMessage("Login"),
    "password": MessageLookupByLibrary.simpleMessage("Password"),
    "welcomeBack": MessageLookupByLibrary.simpleMessage("Welcome back"),
  };
}

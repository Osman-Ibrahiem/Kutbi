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
    "createAccount": MessageLookupByLibrary.simpleMessage("Create account"),
    "donotHaveAccount": MessageLookupByLibrary.simpleMessage(
      "Don\'t have an account? ",
    ),
    "email": MessageLookupByLibrary.simpleMessage("Email"),
    "error_empty_email": MessageLookupByLibrary.simpleMessage(
      "Email is required",
    ),
    "error_empty_password": MessageLookupByLibrary.simpleMessage(
      "Password is required",
    ),
    "error_invalid_credentials": MessageLookupByLibrary.simpleMessage(
      "Invalid email or password.",
    ),
    "error_invalid_email": MessageLookupByLibrary.simpleMessage(
      "The email address is not valid.",
    ),
    "error_invalid_password": MessageLookupByLibrary.simpleMessage(
      "Min 6 characters",
    ),
    "error_login_faild": MessageLookupByLibrary.simpleMessage("Login failed."),
    "error_no_internet": MessageLookupByLibrary.simpleMessage(
      "No internet connection. Please check your network.",
    ),
    "error_operation_not_allowed": MessageLookupByLibrary.simpleMessage(
      "This sign-in method is not enabled.",
    ),
    "error_required_field": MessageLookupByLibrary.simpleMessage(
      "This field is required",
    ),
    "error_too_many_requests": MessageLookupByLibrary.simpleMessage(
      "Too many attempts. Please try again later.",
    ),
    "error_unknown": MessageLookupByLibrary.simpleMessage(
      "Something went wrong. Please try again.",
    ),
    "error_user_disabled": MessageLookupByLibrary.simpleMessage(
      "This account has been disabled. Please contact support.",
    ),
    "error_user_not_found": MessageLookupByLibrary.simpleMessage(
      "No account found with this email.",
    ),
    "error_wrong_password": MessageLookupByLibrary.simpleMessage(
      "Incorrect password. Please try again.",
    ),
    "loginTitle": MessageLookupByLibrary.simpleMessage("Login"),
    "password": MessageLookupByLibrary.simpleMessage("Password"),
    "success_login": MessageLookupByLibrary.simpleMessage(
      "Logged in successfully.",
    ),
    "welcomeBack": MessageLookupByLibrary.simpleMessage("Welcome back"),
  };
}

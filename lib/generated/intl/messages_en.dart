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
        "alreadyHaveAccount":
            MessageLookupByLibrary.simpleMessage("Already have an account?"),
        "confirmPassword":
            MessageLookupByLibrary.simpleMessage("Confirm Password"),
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "googleSignUp":
            MessageLookupByLibrary.simpleMessage("Sign Up with Google"),
        "introBody1": MessageLookupByLibrary.simpleMessage(
            "Become your own money manager and make every cent count"),
        "introBody2": MessageLookupByLibrary.simpleMessage(
            "Track your transaction easily, with categories and financial report"),
        "introBody3": MessageLookupByLibrary.simpleMessage(
            "Setup your budget for each category so you are in control"),
        "introTitle1": MessageLookupByLibrary.simpleMessage(
            "Gain total control of your money"),
        "introTitle2":
            MessageLookupByLibrary.simpleMessage("Know where your money goes"),
        "introTitle3": MessageLookupByLibrary.simpleMessage("Planning ahead"),
        "invalidEmail": MessageLookupByLibrary.simpleMessage("Invalid email"),
        "invalidPassword": MessageLookupByLibrary.simpleMessage(
            "At least 8 characters, 1 number, and 1 uppercase letter"),
        "login": MessageLookupByLibrary.simpleMessage("Login"),
        "name": MessageLookupByLibrary.simpleMessage("Name"),
        "nameCannotBeEmpty":
            MessageLookupByLibrary.simpleMessage("Name cannot be empty"),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "passwordMismatch":
            MessageLookupByLibrary.simpleMessage("Passwords do not match"),
        "policy": MessageLookupByLibrary.simpleMessage(
            "I agree to the terms and conditions."),
        "signUp": MessageLookupByLibrary.simpleMessage("Sign Up")
      };
}

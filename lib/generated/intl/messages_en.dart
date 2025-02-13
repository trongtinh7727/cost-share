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

  static String m0(name, amount) =>
      "please contribute ${amount} to the budget of ${name}.";

  static String m1(name, amount) => "${name} has paid the debt of ${amount}.";

  static String m2(name, amount) => "${name} deleted an expense of ${amount}.";

  static String m3(name, amount) => "${name} added an expense of ${amount}.";

  static String m4(name) => "${name} has left the group.";

  static String m5(name) => "${name} has been added to the group.";

  static String m6(name) => "${name} has been removed from the group.";

  static String m7(name, oldAmount, newAmount) =>
      "${name} updated an expense from ${oldAmount} to ${newAmount}.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addMember": MessageLookupByLibrary.simpleMessage("Add Member"),
        "alreadyHaveAccount":
            MessageLookupByLibrary.simpleMessage("Already have an account?"),
        "april": MessageLookupByLibrary.simpleMessage("April"),
        "august": MessageLookupByLibrary.simpleMessage("August"),
        "budget": MessageLookupByLibrary.simpleMessage("Budget"),
        "budgetDetail": MessageLookupByLibrary.simpleMessage("Budget Detail"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "category": MessageLookupByLibrary.simpleMessage("Category"),
        "chooseCategory":
            MessageLookupByLibrary.simpleMessage("Choose Category"),
        "chooseGroup":
            MessageLookupByLibrary.simpleMessage("Choose your group"),
        "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
        "confirmPassword":
            MessageLookupByLibrary.simpleMessage("Confirm Password"),
        "contributeBudget":
            MessageLookupByLibrary.simpleMessage("Contribute to the budget"),
        "contributeBudgetBody": m0,
        "contributied": MessageLookupByLibrary.simpleMessage("Contribuied: "),
        "contributions": MessageLookupByLibrary.simpleMessage("Contributions"),
        "debtPaid": MessageLookupByLibrary.simpleMessage("Debt has been paid"),
        "debtPaidBody": m1,
        "december": MessageLookupByLibrary.simpleMessage("December"),
        "delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "deleteGroup": MessageLookupByLibrary.simpleMessage("Delete Group"),
        "deleteGroupDescription": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to delete this group? This action cannot be undone."),
        "deletedExpense":
            MessageLookupByLibrary.simpleMessage("An expense has been deleted"),
        "deletedExpenseMessage": m2,
        "description": MessageLookupByLibrary.simpleMessage("Description"),
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "exceedLimit":
            MessageLookupByLibrary.simpleMessage("You’ve exceed the limit"),
        "expenseDetail": MessageLookupByLibrary.simpleMessage("Expense Detail"),
        "expenseMessage": m3,
        "expenseSpliting":
            MessageLookupByLibrary.simpleMessage("Expense Spliting"),
        "february": MessageLookupByLibrary.simpleMessage("February"),
        "filterTransaction":
            MessageLookupByLibrary.simpleMessage("Filter Transaction"),
        "googleSignUp":
            MessageLookupByLibrary.simpleMessage("Sign Up with Google"),
        "groupDescription":
            MessageLookupByLibrary.simpleMessage("Group Description"),
        "groupName": MessageLookupByLibrary.simpleMessage("Group Name"),
        "groupSetting": MessageLookupByLibrary.simpleMessage("Group Setting"),
        "highest": MessageLookupByLibrary.simpleMessage("Highest"),
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "howMuch": MessageLookupByLibrary.simpleMessage("How much?"),
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
        "invalidMonth": MessageLookupByLibrary.simpleMessage("Invalid month"),
        "invalidPassword": MessageLookupByLibrary.simpleMessage(
            "At least 8 characters, 1 number, and 1 uppercase letter"),
        "inviteMemberDescription": MessageLookupByLibrary.simpleMessage(
            "Scan the QR Code or enter the email address to invite someone."),
        "january": MessageLookupByLibrary.simpleMessage("January"),
        "july": MessageLookupByLibrary.simpleMessage("July"),
        "june": MessageLookupByLibrary.simpleMessage("June"),
        "language": MessageLookupByLibrary.simpleMessage("Language"),
        "leave": MessageLookupByLibrary.simpleMessage("Leave"),
        "leaveGroup": MessageLookupByLibrary.simpleMessage("Leave Group"),
        "leaveGroupDescription": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to leave this group? This action cannot be undone."),
        "leaveGroupNotificate":
            MessageLookupByLibrary.simpleMessage("A memmer has left the group"),
        "leaveGroupNotificateBody": m4,
        "login": MessageLookupByLibrary.simpleMessage("Login"),
        "logout": MessageLookupByLibrary.simpleMessage("Logout"),
        "lowest": MessageLookupByLibrary.simpleMessage("Lowest"),
        "march": MessageLookupByLibrary.simpleMessage("March"),
        "markAsPaid": MessageLookupByLibrary.simpleMessage("Mark as paid"),
        "markAsPaidDescription": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to mark this invoice as paid?"),
        "markAsRead": MessageLookupByLibrary.simpleMessage("Mark as read"),
        "markAsUnpaid": MessageLookupByLibrary.simpleMessage("Mark as unpaid"),
        "markAsUnpaidDescription": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to mark this invoice as unpaid? This may affect the payment records."),
        "may": MessageLookupByLibrary.simpleMessage("May"),
        "member": MessageLookupByLibrary.simpleMessage("Member"),
        "name": MessageLookupByLibrary.simpleMessage("Name"),
        "nameCannotBeEmpty":
            MessageLookupByLibrary.simpleMessage("Name cannot be empty"),
        "newExpenseAdded":
            MessageLookupByLibrary.simpleMessage("New expense added"),
        "newMemberAdded":
            MessageLookupByLibrary.simpleMessage("A memmer has been added"),
        "newMemberAddedBody": m5,
        "newest": MessageLookupByLibrary.simpleMessage("Newest"),
        "november": MessageLookupByLibrary.simpleMessage("November"),
        "october": MessageLookupByLibrary.simpleMessage("October"),
        "oldest": MessageLookupByLibrary.simpleMessage("Oldest"),
        "orEnterEmail":
            MessageLookupByLibrary.simpleMessage("Or enter the email address"),
        "owedToYou": MessageLookupByLibrary.simpleMessage("Owed to you: "),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "passwordMismatch":
            MessageLookupByLibrary.simpleMessage("Passwords do not match"),
        "policy": MessageLookupByLibrary.simpleMessage(
            "I agree to the terms and conditions."),
        "remove": MessageLookupByLibrary.simpleMessage("Remove"),
        "removeBudget": MessageLookupByLibrary.simpleMessage("Remove Budget"),
        "removeExpense": MessageLookupByLibrary.simpleMessage("Remove Expense"),
        "removeExpenseDescription": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to remove this expense? This action cannot be undone."),
        "removeMember": MessageLookupByLibrary.simpleMessage("Remove Member"),
        "removeMemberDescription": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to remove this member? This action cannot be undone."),
        "removeMemberNotificate":
            MessageLookupByLibrary.simpleMessage("A memmer has been removed"),
        "removeMemberNotificateBody": m6,
        "reset": MessageLookupByLibrary.simpleMessage("Reset"),
        "scanQRCode": MessageLookupByLibrary.simpleMessage("Scan the QR Code"),
        "september": MessageLookupByLibrary.simpleMessage("September"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "signUp": MessageLookupByLibrary.simpleMessage("Sign Up"),
        "sortBy": MessageLookupByLibrary.simpleMessage("Sort by"),
        "textContinue": MessageLookupByLibrary.simpleMessage("Continue"),
        "today": MessageLookupByLibrary.simpleMessage("Today"),
        "totalBudget": MessageLookupByLibrary.simpleMessage("Total budget"),
        "totalExpense": MessageLookupByLibrary.simpleMessage("Total expense"),
        "totalRemainingBudget":
            MessageLookupByLibrary.simpleMessage("Total remaining budget"),
        "transaction": MessageLookupByLibrary.simpleMessage("Transaction"),
        "updatedExpense":
            MessageLookupByLibrary.simpleMessage("An expense has been updated"),
        "updatedExpenseMessage": m7,
        "userNotFound": MessageLookupByLibrary.simpleMessage("User not found"),
        "wellcome": MessageLookupByLibrary.simpleMessage("Wellcome Cost Share"),
        "yesterday": MessageLookupByLibrary.simpleMessage("Yesterday"),
        "youOwe": MessageLookupByLibrary.simpleMessage("You owe: ")
      };
}

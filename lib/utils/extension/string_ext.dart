import 'package:cost_share/generated/l10n.dart';
import 'package:cost_share/utils/enum/notification_type.dart';
import 'package:cost_share/utils/extension/date_ext.dart';
import 'package:intl/intl.dart';

extension StringExt on String {
  String getFileExtension() {
    try {
      return this.split('.').last;
    } catch (e) {
      return '';
    }
  }

  double thousandsToDouble() {
    try {
      return double.parse(this.replaceAll(',', ''));
    } catch (e) {
      return 0;
    }
  }

  bool isValidEmail() {
    // Regular expression pattern for a valid email
    RegExp regex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}$',
      caseSensitive: false,
      multiLine: false,
    );

    // Check if the email matches the pattern
    if (regex.hasMatch(this)) {
      return true; // Valid email
    } else {
      return false; // Invalid email
    }
  }

  bool isValidPassword() {
    return this.length >= 8 &&
        this.contains(RegExp(r'[A-Z]')) &&
        this.contains(RegExp(r'[0-9]'));
  }

  String toCustomDateString(AppLocalizations localization) {
    try {
      // Parse the string to a DateTime object
      DateTime date =
          DateFormat('yyyy-MM-dd').parse(this); // Adjust format if necessary

      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final yesterday = today.subtract(const Duration(days: 1));

      if (date.isSameDate(today)) {
        return localization.today;
      } else if (date.isSameDate(yesterday)) {
        return localization.yesterday;
      } else {
        return DateFormat('MMMM dd, yyyy').format(date);
      }
    } catch (e) {
      return 'Invalid date'; // Handle invalid date strings
    }
  }

  String toNotificationTitle(AppLocalizations localization) {
    switch (NotificationTypeExtension.fromString(this)) {
      case NotificationType.NEW_EXPENSE_ADDED:
        return localization.newExpenseAdded;
      case NotificationType.UPDATE_EXPENSE:
        return localization.updatedExpense;
      case NotificationType.DELETE_EXPENSE:
        return localization.deletedExpense;
      case NotificationType.NEW_MEMBER_ADDED:
        return localization.newMemberAdded;
      case NotificationType.REMOVE_MEMBER:
        return localization.removeMember;
      case NotificationType.DEBT_PAID:
        return localization.debtPaid;
      case NotificationType.CONTRIBUTE_BUDGET:
        return localization.contributeBudget;

      case NotificationType.LEAVE_GROUP:
      case NotificationType.DEBT_UNPAID:
        return "";
      default:
        return "";
    }
  }

  String toNotificationBody(
      AppLocalizations localization, Map<String, String> data) {
    switch (NotificationTypeExtension.fromString(this)) {
      case NotificationType.NEW_EXPENSE_ADDED:
        return localization.expenseMessage(data['name']!, data['amount']!);
      case NotificationType.UPDATE_EXPENSE:
        return localization.updatedExpenseMessage(
            data['name']!, data['oldAmount']!, data['newAmount']!);
      case NotificationType.DELETE_EXPENSE:
        return localization.deletedExpenseMessage(
            data['name']!, data['amount']!);
      case NotificationType.NEW_MEMBER_ADDED:
        return localization.newMemberAddedBody(data['name']!);
      case NotificationType.REMOVE_MEMBER:
        return localization.removeMemberNotificateBody(data['name']!);
      case NotificationType.DEBT_PAID:
        return localization.debtPaidBody(data['name']!, data['amount']!);
      case NotificationType.CONTRIBUTE_BUDGET:
        return localization.contributeBudgetBody(
            data['name']!, data['amount']!);
      default:
        return "";
    }
  }

  String toCustomTimeFormat() {
    try {
      // Parse the string to a DateTime object
      DateTime time =
          DateFormat('hh:mm a').parse(this); // Adjust format if necessary

      // Return formatted time
      return DateFormat('hh:mm a')
          .format(time); // You can customize the output format here
    } catch (e) {
      return 'Invalid time'; // Handle invalid time strings
    }
  }
}

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

  String toCustomDateString() {
    try {
      // Parse the string to a DateTime object
      DateTime date =
          DateFormat('yyyy-MM-dd').parse(this); // Adjust format if necessary

      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final yesterday = today.subtract(const Duration(days: 1));

      if (date.isSameDate(today)) {
        return 'Today';
      } else if (date.isSameDate(yesterday)) {
        return 'Yesterday';
      } else {
        return DateFormat('MMMM dd, yyyy').format(date);
      }
    } catch (e) {
      return 'Invalid date'; // Handle invalid date strings
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

import 'package:intl/intl.dart';

extension DateComparison on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  String toCustomTimeFormat({String format = 'hh:mm a'}) {
    try {
      return DateFormat(format).format(this); // Format the DateTime object
    } catch (e) {
      return 'Invalid time'; // Handle any formatting issues
    }
  }
}

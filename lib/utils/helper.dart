import 'package:cost_share/model/expense.dart';
import 'package:intl/intl.dart';

class Helper {
  static Map<String, List<Expense>> groupExpensesByDate(
      List<Expense> expenses) {
    Map<String, List<Expense>> groupedExpenses = {};

    for (var expense in expenses) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(expense.date);
      if (groupedExpenses[formattedDate] == null) {
        groupedExpenses[formattedDate] = [];
      }
      groupedExpenses[formattedDate]!.add(expense);
    }

    return groupedExpenses;
  }
}

import 'package:cost_share/model/expense.dart';
import 'package:cost_share/presentation/common/expense_card.dart';
import 'package:cost_share/utils/extension/string_ext.dart';
import 'package:flutter/material.dart';

class SectionByDate extends StatelessWidget {
  final String date;
  final List<Expense> expenses;

  const SectionByDate({required this.date, required this.expenses, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header with date
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            date.toCustomDateString(),
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        // List of expenses for the date
        ...expenses.map((expense) {
          return ExpenseCard(expense: expense);
        }).toList(),
      ],
    );
  }
}

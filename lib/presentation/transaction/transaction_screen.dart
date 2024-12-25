import 'package:cost_share/manager/group_manager.dart';
import 'package:cost_share/model/expense.dart';
import 'package:cost_share/presentation/common/app_date_picker_button.dart';
import 'package:cost_share/presentation/common/section_by_date.dart';
import 'package:cost_share/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppDatePickerButton(label: 'Month', onTap: (){}),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder<List<Expense>>(
                stream: context.read<GroupManager>().groupExpensesStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No expenses available'));
                  } else {
                    Map<String, List<Expense>> groupedExpenses =
                        Helper.groupExpensesByDate(snapshot.data!);

                    return Column(
                      children: groupedExpenses.keys.map((date) {
                        List<Expense> expenses = groupedExpenses[date]!;
                        return SectionByDate(
                          date: date,
                          expenses: expenses,
                        );
                      }).toList(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:cost_share/gen/assets.gen.dart';
import 'package:cost_share/manager/group_manager.dart';
import 'package:cost_share/model/expense.dart';
import 'package:cost_share/presentation/common/app_date_picker_button.dart';
import 'package:cost_share/presentation/common/section_by_date.dart';
import 'package:cost_share/utils/helper.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({
    Key? key,
    required this.onFilterPressed,
  }) : super(key: key);
  final VoidCallback onFilterPressed;

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppDatePickerButton(label: 'Month', onTap: () {}),
        actions: [
          IconButton(
            icon: Assets.icon.svg.iconFillter.svg(),
            onPressed: widget.onFilterPressed,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric( horizontal: 16),
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
      ),
    );
  }
}

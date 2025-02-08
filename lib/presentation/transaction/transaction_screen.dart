// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cost_share/presentation/common/filter_transaction_dialog.dart';
import 'package:cost_share/utils/app_colors.dart';
import 'package:cost_share/utils/extension/context_ext.dart';
import 'package:cost_share/utils/extension/int_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_month_picker/flutter_custom_month_picker.dart';
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
  }) : super(key: key);

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  late int month;
  late int year;

  @override
  void initState() {
    super.initState();
    final currentDate = DateTime.now();
    month = currentDate.month;
    year = currentDate.year;
    context.read<GroupManager>().filterExpensesByDate(month, year);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppDatePickerButton(
          label: '${month.toMonth(context)}, $year',
          onTap: () => showMonthPicker(context, onSelected: (m, y) {
            setState(() {
              month = m;
              year = y;
            });
            context.read<GroupManager>().filterExpensesByDate(month, year);
          },
              initialSelectedMonth: month,
              initialSelectedYear: year,
              firstYear: 2000,
              lastYear: 2025,
              firstEnabledMonth: 3,
              lastEnabledMonth: 10,
              selectButtonText: context.localization.confirm,
              cancelButtonText: context.localization.cancel,
              highlightColor: AppColors.colorViolet100,
              contentBackgroundColor: Colors.white,
              dialogBackgroundColor: Colors.grey[200]),
        ),
        actions: [
          IconButton(
            icon: Assets.icon.svg.iconFillter.svg(),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return FilterTransactionDialog(
                    groupManager: context.read<GroupManager>(),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
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

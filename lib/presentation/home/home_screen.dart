// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cost_share/manager/bottom_navigation_manager.dart';
import 'package:cost_share/manager/group_manager.dart';
import 'package:cost_share/model/expense.dart';
import 'package:cost_share/model/group_detail.dart';
import 'package:cost_share/presentation/common/app_date_picker_button.dart';
import 'package:cost_share/presentation/common/background_icon.dart';
import 'package:cost_share/presentation/common/expense_card.dart';
import 'package:cost_share/presentation/home/widgets/total_balance_card.dart';
import 'package:cost_share/utils/extension/context_ext.dart';
import 'package:cost_share/utils/extension/double_ext.dart';
import 'package:cost_share/utils/extension/int_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_month_picker/flutter_custom_month_picker.dart';

import 'package:cost_share/gen/assets.gen.dart';
import 'package:cost_share/presentation/common/avatar.dart';
import 'package:cost_share/utils/app_colors.dart';
import 'package:cost_share/utils/app_textstyle.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    Key? key,
    required this.mainScaffoldKey,
  }) : super(key: key);
  final GlobalKey<ScaffoldState> mainScaffoldKey;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int month;
  late int year;

  @override
  void initState() {
    super.initState();
    final currentDate = DateTime.now();
    month = currentDate.month;
    year = currentDate.year;
  }

  @override
  Widget build(BuildContext context) {
    GroupDetail currentGroup = context.read<GroupManager>().currentGroup!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.colorYellow10,
        leading: GestureDetector(
          onTap: () {
            widget.mainScaffoldKey.currentState?.openDrawer();
          },
          child: Avatar(
            url: currentGroup.groupPhoto,
            border: 1,
          ),
        ),
        centerTitle: true,
        title: AppDatePickerButton(
          label: '${month.toMonth(context)}, $year',
          onTap: () => showMonthPicker(context, onSelected: (m, y) {
            setState(() {
              month = m;
              year = y;
            });
            context.read<GroupManager>().filterExpensesByDate(m, y);
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
          Stack(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Assets.icon.svg.iconNotifiaction.svg(
                      colorFilter: ColorFilter.mode(
                          AppColors.colorViolet100, BlendMode.srcIn))),
              if (5 != null)
                Positioned(
                  height: 16,
                  width: 16,
                  right: 4,
                  top: 8,
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.colorRed100, shape: BoxShape.circle),
                    child: Center(
                      child: Text(
                        '${5}', // Replace this with dynamic notification count if needed
                        textAlign: TextAlign.center,
                        style: AppTextStyles.tiny
                            .copyWith(color: AppColors.colorLight100),
                      ),
                    ),
                  ),
                ),
            ],
          )
        ],
      ),
      body: Container(
          color: AppColors.colorLight60,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(bottom: 36),
                decoration: BoxDecoration(
                    color: AppColors.colorYellow10,
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(32))),
                child: Column(
                  children: [
                    Text(
                      'Total remaining budget',
                      style: AppTextStyles.body3
                          .copyWith(color: AppColors.colorLight20),
                    ),
                    StreamBuilder<List<Expense>>(
                      stream: context.read<GroupManager>().groupExpensesStream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else {
                          return Text(
                            context
                                .read<GroupManager>()
                                .totalBudgetRemaining
                                .toCommaSeparated(),
                            style: AppTextStyles.title1
                                .copyWith(color: AppColors.colorDark100),
                          );
                        }
                      },
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    StreamBuilder<List<Expense>>(
                      stream: context.read<GroupManager>().groupExpensesStream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TotalBalanceCard(
                                  icon: BackgroundIcon(
                                      icon: Assets.icon.svg.iconIncome.svg(),
                                      backgroundColor: AppColors.colorLight100),
                                  label: 'Total budget',
                                  value: context
                                      .read<GroupManager>()
                                      .totalBudget
                                      .toVND(),
                                  backgroundColor: AppColors.colorGreen100),
                              TotalBalanceCard(
                                  icon: BackgroundIcon(
                                      icon: Assets.icon.svg.iconExpense.svg(
                                          colorFilter: ColorFilter.mode(
                                              AppColors.colorRed100,
                                              BlendMode.srcIn)),
                                      backgroundColor: AppColors.colorLight100),
                                  label: 'Total Expense',
                                  value: context
                                      .read<GroupManager>()
                                      .totalExpense
                                      .toVND(),
                                  backgroundColor: AppColors.colorRed100)
                            ],
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Recent Transaction',
                          style: AppTextStyles.title3
                              .copyWith(color: AppColors.colorDark25),
                        ),
                        InkWell(
                          onTap: () {
                            Provider.of<BottomNavigationManager>(context,
                                    listen: false)
                                .updateTabIndex(1);
                            ;
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                                color: AppColors.colorViolet20,
                                borderRadius: BorderRadius.circular(40)),
                            child: Text(
                              'See All',
                              style: AppTextStyles.body3
                                  .copyWith(color: AppColors.colorViolet100),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    StreamBuilder<List<Expense>>(
                      stream: context.read<GroupManager>().groupExpensesStream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Center(child: Text('No expenses available'));
                        } else {
                          List<Expense> groupedExpenses =
                              snapshot.data!.take(4).toList();

                          return Column(
                            children: groupedExpenses.map(
                              (e) {
                                return ExpenseCard(
                                  expense: e,
                                );
                              },
                            ).toList(),
                          );
                        }
                      },
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}

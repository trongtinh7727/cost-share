import 'package:cost_share/gen/assets.gen.dart';
import 'package:cost_share/manager/group_manager.dart';
import 'package:cost_share/model/budget.dart';
import 'package:cost_share/presentation/common/budget_card.dart';
import 'package:cost_share/presentation/common/my_app_button.dart';
import 'package:cost_share/utils/app_colors.dart';
import 'package:cost_share/utils/app_textstyle.dart';
import 'package:cost_share/utils/extension/context_ext.dart';
import 'package:cost_share/utils/extension/int_ext.dart';
import 'package:cost_share/utils/route/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_month_picker/flutter_custom_month_picker.dart';
import 'package:provider/provider.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
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
    final groupManager = context.read<GroupManager>();
    final currentGroupId = groupManager.currentGroupId;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Assets.icon.svg.iconArrowLeft.svg(),
          onPressed: () {
            setState(() {
              month = month - 1;
              if (month == 0) {
                month = 12;
                year = year - 1;
              }
              groupManager.loadGroupBudget(
                  currentGroupId, month.toString(), year.toString());
            });
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                month = month + 1;
                if (month == 13) {
                  month = 1;
                  year = year + 1;
                }
                groupManager.loadGroupBudget(
                    currentGroupId, month.toString(), year.toString());
              });
            },
            icon: Assets.icon.svg.iconArrowRight.svg(),
          )
        ],
        backgroundColor: AppColors.colorGreen100,
        centerTitle: true,
        title: InkWell(
          onTap: () => showMonthPicker(context, onSelected: (m, y) {
            setState(() {
              month = m;
              year = y;
              groupManager.loadGroupBudget(
                  currentGroupId, month.toString(), year.toString());
            });
          },
              initialSelectedMonth: month,
              initialSelectedYear: year,
              firstYear: 2000,
              lastYear: year + 10,
              firstEnabledMonth: 3,
              lastEnabledMonth: 10,
              selectButtonText: context.localization.confirm,
              cancelButtonText: context.localization.cancel,
              highlightColor: AppColors.colorViolet100,
              contentBackgroundColor: Colors.white,
              dialogBackgroundColor: Colors.grey[200]),
          child: Text(
            '${month.toMonth(context)}, $year',
            style:
                AppTextStyles.title3.copyWith(color: AppColors.colorLight100),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.colorGreen100,
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: AppColors.colorLight60,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32.0),
                      topRight: Radius.circular(32.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      // ListView inside an Expanded for proper layout
                      Expanded(
                          child: StreamBuilder<List<Budget>>(
                        stream: context.read<GroupManager>().groupBudgetStream,
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
                            List<Budget> budgets = snapshot.data!;
                            return ListView.builder(
                              itemCount: budgets.length,
                              itemBuilder: (context, index) {
                                return BudgetCard(budget: budgets[index]);
                              },
                            );
                          }
                        },
                      )),
                      // Padding for the button
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0, bottom: 24),
                        child: MyAppButton(
                          onPressed: () {
                            Navigator.pushNamed(context, RouteName.addBudget);
                          },
                          message: "Add Budget",
                          isPrimary: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

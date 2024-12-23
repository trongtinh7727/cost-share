// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cost_share/presentation/common/avatar.dart';
import 'package:cost_share/presentation/common/background_icon.dart';
import 'package:cost_share/utils/app_colors.dart';
import 'package:cost_share/utils/app_textstyle.dart';
import 'package:cost_share/utils/enum/app_category.dart';
import 'package:cost_share/utils/extension/date_ext.dart';
import 'package:cost_share/utils/extension/double_ext.dart';
import 'package:flutter/material.dart';

import 'package:cost_share/model/expense.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard({
    Key? key,
    required this.expense,
  }) : super(key: key);
  final Expense expense;

  @override
  Widget build(BuildContext context) {
    AppCategory appCategory = AppCategoryExtension.fromString(expense.category);
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      decoration: BoxDecoration(
          color: AppColors.colorLight60,
          borderRadius: BorderRadius.circular(24)),
      child: Row(
        children: [
          BackgroundIcon(
              icon: appCategory.icon, backgroundColor: appCategory.color),
          SizedBox(
            width: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appCategory.name,
                style:
                    AppTextStyles.body2.copyWith(color: AppColors.colorDark25),
              ),
              Text(
                expense.description,
                style:
                    AppTextStyles.small.copyWith(color: AppColors.colorLight20),
              ),
              Row(
                children: [
                  Avatar(
                    url: expense.avatarUrl!,
                    size: 24,
                    border: 0,
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    appCategory.name,
                    style: AppTextStyles.small
                        .copyWith(color: AppColors.colorLight20),
                  ),
                ],
              ),
            ],
          ),
          Expanded(child: SizedBox()),
          Column(
            children: [
              Text(
                '- ${expense.amount.toVND()}',
                style:
                    AppTextStyles.body2.copyWith(color: AppColors.colorRed100),
              ),
              SizedBox(height: 18,),
              Text(
                expense.date.toCustomTimeFormat(),
                style:
                    AppTextStyles.small.copyWith(color: AppColors.colorDark100),
              )
            ],
          )
        ],
      ),
    );
  }
}

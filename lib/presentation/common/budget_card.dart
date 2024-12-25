// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cost_share/utils/app_colors.dart';
import 'package:cost_share/utils/app_textstyle.dart';
import 'package:cost_share/utils/enum/app_category.dart';
import 'package:cost_share/utils/extension/double_ext.dart';
import 'package:flutter/material.dart';

import 'package:cost_share/model/budget.dart';

class BudgetCard extends StatelessWidget {
  const BudgetCard({
    Key? key,
    required this.budget,
  }) : super(key: key);
  final Budget budget;

  @override
  Widget build(BuildContext context) {
    AppCategory category = AppCategoryExtension.fromString(budget.category);
    return Container(
      margin: EdgeInsets.all(4),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.colorLight100,
        borderRadius: BorderRadius.circular(32)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
                color: AppColors.colorLight40,
                borderRadius: BorderRadius.circular(32),
                border: Border.all(color: AppColors.colorLight20)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.circle,
                  color: category.colorPrimary,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  category.name,
                  style: AppTextStyles.body3
                      .copyWith(color: AppColors.colorDark50),
                )
              ],
            ),
          ),
          Text(
            'Remaining: ${budget.remainingAmount.toCommaSeparated()}',
            style: AppTextStyles.title2.copyWith(color: AppColors.colorDark100),
          ),
          SizedBox(
              height: 8), // Add space between remaining amount and progress bar
          Container(
            width: double.infinity, // Make the container take the full width
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Progress Bar
                LinearProgressIndicator(
                  value: (budget.totalAmount - budget.remainingAmount) /
                      budget.totalAmount,
                  backgroundColor: AppColors.colorLight60,
                  minHeight: 12,
                  borderRadius: BorderRadius.circular(32),
                  color: category.colorPrimary, // Progress color
                ),
                SizedBox(height: 4), // Space between the progress bar and text
                Text(
                  '${((budget.totalAmount - budget.remainingAmount)).toCommaSeparated()} of ${budget.totalAmount.toCommaSeparated()}',
                  style: AppTextStyles.body1
                      .copyWith(color: AppColors.colorLight10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

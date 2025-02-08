import 'package:cost_share/main.dart';
import 'package:cost_share/manager/group_manager.dart';
import 'package:cost_share/presentation/common/my_app_button.dart';
import 'package:cost_share/presentation/transaction/bloc/transaction_bloc.dart';
import 'package:cost_share/utils/app_colors.dart';
import 'package:cost_share/utils/app_textstyle.dart';
import 'package:cost_share/utils/enum/app_category.dart';
import 'package:cost_share/utils/enum/sort_by.dart';
import 'package:cost_share/utils/extension/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class FilterTransactionDialog extends StatefulWidget {
  const FilterTransactionDialog({super.key, required this.groupManager});

  final GroupManager groupManager;

  @override
  State<FilterTransactionDialog> createState() =>
      _FilterTransactionDialogState();
}

class _FilterTransactionDialogState extends State<FilterTransactionDialog> {
  SortBy? selectedSortBy;
  List<String> selectedCategories = [];

  @override
  void initState() {
    super.initState();
    selectedSortBy = widget.groupManager.selectedSortBy;
    selectedCategories = widget.groupManager.selectedCategories;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 12, left: 16, right: 16, bottom: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(
            color: AppColors.colorViolet40,
            height: 2,
            thickness: 5,
            endIndent: 170,
            indent: 170,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.localization.filterTransaction,
                style: AppTextStyles.body2,
              ),
              SizedBox(
                width: 80,
                height: 40,
                child: MyAppButton(
                    onPressed: () {
                      setState(() {
                        selectedSortBy = null;
                        selectedCategories = [];
                      });
                    },
                    message: context.localization.reset,
                    isPrimary: false),
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            context.localization.sortBy,
            style: AppTextStyles.body2,
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              sortByButton(SortBy.HIGHEST),
              sortByButton(SortBy.LOWEST),
              sortByButton(SortBy.NEWEST),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          sortByButton(SortBy.OLDEST),
          SizedBox(
            height: 16,
          ),
          Text(
            context.localization.category,
            style: AppTextStyles.body2,
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              categoryButton(AppCategory.SUBSCRIPTION),
              categoryButton(AppCategory.TRANSPORTATION),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              categoryButton(AppCategory.FOOD),
              categoryButton(AppCategory.SHOPPING),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          categoryButton(AppCategory.OTHER),
          SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 60,
            child: MyAppButton(
                onPressed: () {
                  setState(() {
                    widget.groupManager.filterAndSortExpenses(
                        categories: selectedCategories, sortBy: selectedSortBy);
                  });
                  context.pop();
                },
                message: context.localization.confirm,
                isPrimary: false),
          ),
        ],
      ),
    );
  }

  InkWell sortByButton(SortBy sortBy) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedSortBy = sortBy;
        });
      },
      child: Container(
        width: 120,
        decoration: BoxDecoration(
          border: Border.all(
              color: selectedSortBy == sortBy
                  ? AppColors.colorLight60
                  : AppColors.colorLight20),
          color: selectedSortBy == sortBy
              ? AppColors.colorViolet20
              : AppColors.colorLight20,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        child: Text(
          sortBy.name,
          textAlign: TextAlign.center,
          style: AppTextStyles.body3.copyWith(
              color: selectedSortBy == sortBy
                  ? AppColors.colorViolet100
                  : AppColors.colorDark50),
        ),
      ),
    );
  }

  InkWell categoryButton(AppCategory category) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedCategories.contains(category.name)
              ? selectedCategories.remove(category.name)
              : selectedCategories.add(category.name);
        });
      },
      child: Container(
        width: 180,
        decoration: BoxDecoration(
          border: Border.all(
              color: selectedCategories.contains(category.name)
                  ? AppColors.colorLight60
                  : AppColors.colorLight20),
          color: selectedCategories.contains(category.name)
              ? AppColors.colorViolet20
              : AppColors.colorLight20,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        child: Text(
          category.name,
          textAlign: TextAlign.center,
          style: AppTextStyles.body3.copyWith(
              color: selectedCategories.contains(category.name)
                  ? AppColors.colorViolet100
                  : AppColors.colorDark50),
        ),
      ),
    );
  }
}

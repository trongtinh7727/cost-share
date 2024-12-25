import 'package:cost_share/gen/assets.gen.dart';
import 'package:cost_share/utils/app_colors.dart';
import 'package:cost_share/utils/app_textstyle.dart';
import 'package:flutter/material.dart';

enum AppCategory { SHOPPING, FOOD, TRANSPORTATION, OTHER, SUBSCRIPTION, ADD }

extension AppCategoryExtension on AppCategory {
  String get name {
    switch (this) {
      case AppCategory.SHOPPING:
        return 'Shopping';
      case AppCategory.FOOD:
        return 'Food';
      case AppCategory.TRANSPORTATION:
        return 'Transportation';
      case AppCategory.OTHER:
        return 'Other';
      case AppCategory.SUBSCRIPTION:
        return 'Subscription';
      case AppCategory.ADD:
        return 'Add';
      default:
        return 'none';
    }
  }

  Color get color {
    switch (this) {
      case AppCategory.SHOPPING:
        return AppColors.colorYellow20;
      case AppCategory.FOOD:
        return AppColors.colorRed20;
      case AppCategory.TRANSPORTATION:
        return AppColors.colorBlue20;
      case AppCategory.SUBSCRIPTION:
        return AppColors.colorViolet20;
      case AppCategory.ADD:
        return AppColors.colorDark100;
      default:
        return AppColors.colorDark100;
    }
  }

  
  Color get colorPrimary {
    switch (this) {
      case AppCategory.SHOPPING:
        return AppColors.colorYellow100;
      case AppCategory.FOOD:
        return AppColors.colorRed100;
      case AppCategory.TRANSPORTATION:
        return AppColors.colorBlue100;
      case AppCategory.SUBSCRIPTION:
        return AppColors.colorViolet100;
      case AppCategory.ADD:
        return AppColors.colorDark100;
      default:
        return AppColors.colorDark100;
    }
  }

  Widget get icon {
    switch (this) {
      case AppCategory.SHOPPING:
        return Assets.icon.svg.iconShoppingBag.svg();
      case AppCategory.FOOD:
        return Assets.icon.svg.iconRestaurant.svg();
      case AppCategory.TRANSPORTATION:
        return Assets.icon.svg.iconCar.svg();
      case AppCategory.OTHER:
        return Assets.icon.svg.iconSalary.svg();
      case AppCategory.SUBSCRIPTION:
        return Assets.icon.svg.iconRecurringBill.svg();
      case AppCategory.ADD:
        return Assets.icon.svg.iconAdd.svg(height: 32, width: 32);
      default:
        return Icon(Icons.category);
    }
  }

  Widget get label {
    switch (this) {
      case AppCategory.SHOPPING:
        return Text('Shopping',
            style:
                AppTextStyles.body2.copyWith(color: AppColors.colorYellow100));
      case AppCategory.FOOD:
        return Text('Food',
            style: AppTextStyles.body2.copyWith(color: AppColors.colorRed100));
      case AppCategory.TRANSPORTATION:
        return Text('Transportation',
            style: AppTextStyles.body2.copyWith(color: AppColors.colorBlue100));
      case AppCategory.OTHER:
        return Text('Other',
            style:
                AppTextStyles.body2.copyWith(color: AppColors.colorGreen100));
      case AppCategory.SUBSCRIPTION:
        return Text('Subscription',
            style:
                AppTextStyles.body2.copyWith(color: AppColors.colorViolet100));
      case AppCategory.ADD:
        return Text('Add',
            style: AppTextStyles.body2.copyWith(color: AppColors.colorDark100));
      default:
        return Text('none');
    }
  }

  static AppCategory fromString(String category) {
    switch (category) {
      case 'Shopping':
        return AppCategory.SHOPPING;
      case 'Food':
        return AppCategory.FOOD;
      case 'Transportation':
        return AppCategory.TRANSPORTATION;
      case 'Other':
        return AppCategory.OTHER;
      case 'Subscription':
        return AppCategory.SUBSCRIPTION;
      default:
        return AppCategory.OTHER;
    }
  }

  static AppCategory fromIndex(int index) {
    switch (index) {
      case 0:
        return AppCategory.FOOD;
      case 1:
        return AppCategory.SHOPPING;
      case 2:
        return AppCategory.TRANSPORTATION;
      case 3:
        return AppCategory.SUBSCRIPTION;
      case 4:
        return AppCategory.OTHER;
      default:
        return AppCategory.ADD;
    }
  }
}

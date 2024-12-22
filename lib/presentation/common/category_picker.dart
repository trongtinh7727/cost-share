// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:cost_share/gen/assets.gen.dart';
import 'package:cost_share/presentation/common/background_icon.dart';
import 'package:cost_share/utils/app_colors.dart';
import 'package:cost_share/utils/app_textstyle.dart';
import 'package:cost_share/utils/enum/app_category.dart';

class CategoryPicker extends StatefulWidget {
  const CategoryPicker({
    Key? key,
    required this.onCategorySelected,
  }) : super(key: key);
  final Function(int) onCategorySelected;

  @override
  State<CategoryPicker> createState() => _CategoryPickerState();
}

class _CategoryPickerState extends State<CategoryPicker> {
  final icons = [
    Assets.icon.svg.iconRestaurant.svg(),
    Assets.icon.svg.iconShoppingBag.svg(),
    Assets.icon.svg.iconCar.svg(),
    Assets.icon.svg.iconRecurringBill.svg(),
    Assets.icon.svg.iconSalary.svg(),
    Assets.icon.svg.iconAdd.svg(height: 32, width: 32),
  ];
  final colors = [
    AppColors.colorRed20,
    AppColors.colorYellow20,
    AppColors.colorViolet20,
    AppColors.colorBlue20,
    AppColors.colorGreen20,
    AppColors.colorLight10
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 325,
        width: 900,
        child: Column(
          children: [
            SizedBox(
              height: 16,
            ),
            Divider(
              color: AppColors.colorViolet40,
              height: 2,
              thickness: 5,
              endIndent: 180,
              indent: 180,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "Chose category",
              style: AppTextStyles.body2,
            ),
            SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 250,
              child: GridView.builder(
                itemCount: 6,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 28,
                  mainAxisSpacing: 0,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: InkWell(
                      onTap: () {
                        widget.onCategorySelected(index);
                        Navigator.pop(context, index);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BackgroundIcon(
                              icon: icons[index],
                              backgroundColor: colors[index]),
                          Text(
                            AppCategoryExtension.fromIndex(index).name,
                            style: AppTextStyles.body1
                                .copyWith(color: AppColors.colorViolet100),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}

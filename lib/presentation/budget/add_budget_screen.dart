import 'package:cost_share/locator.dart';
import 'package:cost_share/manager/group_manager.dart';
import 'package:cost_share/manager/user_manager.dart';
import 'package:cost_share/presentation/budget/bloc/budget_bloc.dart';
import 'package:cost_share/presentation/common/app_dropdown_button.dart';
import 'package:cost_share/presentation/common/app_number_input_field.dart';
import 'package:cost_share/presentation/common/category_picker.dart';
import 'package:cost_share/presentation/common/my_app_button.dart';
import 'package:cost_share/repository/budget_repository.dart';
import 'package:cost_share/repository/group_repository.dart';
import 'package:cost_share/utils/app_colors.dart';
import 'package:cost_share/utils/app_textstyle.dart';
import 'package:cost_share/utils/enum/app_category.dart';
import 'package:cost_share/utils/extension/context_ext.dart';
import 'package:cost_share/utils/extension/int_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_month_picker/flutter_custom_month_picker.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class AddBudgetScreen extends StatefulWidget {
  const AddBudgetScreen({super.key});

  @override
  State<AddBudgetScreen> createState() => _AddBudgetScreenState();
}

class _AddBudgetScreenState extends State<AddBudgetScreen> {
  late int month;
  late int year;
  double _value = 10;
  bool isEnableAlert = false;
  late BudgetBloc bloC;

  @override
  void initState() {
    super.initState();
    final currentDate = DateTime.now();
    month = currentDate.month;
    year = currentDate.year;
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => BudgetBloc(
        locator<BudgetRepository>(),
        locator<GroupRepository>(),
        context.read<GroupManager>().currentGroupId,
        context.read<UserManager>().currentUser!.id,
      ),
      builder: (context, child) {
        bloC = context.read<BudgetBloc>();
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: AppColors.colorLight100,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: AppColors.colorGreen100,
            centerTitle: true,
            title: Text(
              'Create Budget',
              style:
                  AppTextStyles.title3.copyWith(color: AppColors.colorLight100),
            ),
          ),
          body: SafeArea(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.colorGreen100,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(context.localization.howMuch,
                        style: AppTextStyles.title3
                            .copyWith(color: AppColors.colorLight80)),
                  ),
                  AppNumberInputField(
                    onChanged: bloC.setAmount,
                    style: AppTextStyles.titleX
                        .copyWith(color: AppColors.colorLight100),
                    hintStyle: AppTextStyles.titleX
                        .copyWith(color: AppColors.colorLight100),
                    hintText: '0',
                    border: InputBorder.none,
                    textAlign: TextAlign.start,
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: AppColors.colorLight100,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(32.0),
                        topRight: Radius.circular(32.0),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AppDropdownButton(
                          label: '${month.toMonth(context)}, $year',
                          selectedLabel: Text(
                            '${month.toMonth(context)}, $year',
                            style: AppTextStyles.body2
                                .copyWith(color: AppColors.colorDark100),
                          ),
                          onTap: () {
                            showMonthPicker(context, onSelected: (m, y) {
                              setState(() {
                                month = m;
                                year = y;
                              });
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
                                dialogBackgroundColor: Colors.grey[200]);
                          },
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        StreamBuilder(
                          stream: bloC.categoryStream,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            } else {
                              AppCategory? category = snapshot.data;
                              return AppDropdownButton(
                                label: context.localization.category,
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return CategoryPicker(
                                        onCategorySelected: bloC.selectCategory,
                                      );
                                    },
                                  );
                                },
                                selectedLabel: category?.label,
                                prefixIcon: category?.icon,
                              );
                            }
                          },
                        ),

                        ListTile(
                          title: Text(
                            'Receive Alert',
                            style: AppTextStyles.body1
                                .copyWith(color: AppColors.colorDark25),
                          ),
                          subtitle: Text(
                            'Receive alert when it reaches some point.',
                            style: AppTextStyles.small
                                .copyWith(color: AppColors.colorLight10),
                          ),
                          trailing: Switch(
                            value: isEnableAlert,
                            activeColor: AppColors.colorViolet100,
                            onChanged: (value) {
                              setState(() {
                                isEnableAlert = !isEnableAlert;
                              });
                              bloC.setIsEnableAlert(isEnableAlert);
                            },
                          ),
                        ),
                        if (isEnableAlert)
                          SfSlider(
                            min: 0.0,
                            max: 100.0,
                            activeColor: AppColors.colorViolet100,
                            value: _value,
                            interval: 20,
                            showTicks: false,
                            showLabels: false,
                            enableTooltip: true,
                            minorTicksPerInterval: 1,
                            onChanged: (dynamic value) {
                              setState(() {
                                _value = value;
                              });
                              bloC.setAlertPoint(value);
                            },
                          ),
                        // Padding for the button
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0, bottom: 24),
                          child: MyAppButton(
                            onPressed: () {
                              bloC.addBudget(month, year);

                              Navigator.pop(context);
                            },
                            message: context.localization.textContinue,
                            isPrimary: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

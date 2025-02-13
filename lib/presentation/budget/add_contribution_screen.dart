// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cost_share/model/budget.dart';
import 'package:cost_share/presentation/common/avatar.dart';
import 'package:cost_share/repository/notification_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cost_share/locator.dart';
import 'package:cost_share/manager/group_manager.dart';
import 'package:cost_share/manager/user_manager.dart';
import 'package:cost_share/model/user_split.dart';
import 'package:cost_share/presentation/budget/bloc/budget_bloc.dart';
import 'package:cost_share/presentation/common/app_dropdown_button.dart';
import 'package:cost_share/presentation/common/app_number_input_field.dart';
import 'package:cost_share/presentation/common/my_app_button.dart';
import 'package:cost_share/repository/budget_repository.dart';
import 'package:cost_share/repository/group_repository.dart';
import 'package:cost_share/utils/app_colors.dart';
import 'package:cost_share/utils/app_textstyle.dart';
import 'package:cost_share/utils/enum/app_category.dart';
import 'package:cost_share/utils/extension/context_ext.dart';
import 'package:cost_share/utils/extension/int_ext.dart';

class AddContributionScreen extends StatefulWidget {
  const AddContributionScreen({
    Key? key,
    required this.userSplit,
    required this.budget,
  }) : super(key: key);
  final UserSplit userSplit;
  final Budget budget;

  @override
  State<AddContributionScreen> createState() => _AddContributionScreenState();
}

class _AddContributionScreenState extends State<AddContributionScreen> {
  late BudgetBloc bloC;
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
    return Provider(
        create: (context) => BudgetBloc(
              locator<BudgetRepository>(),
              locator<GroupRepository>(),
              locator<NotificationRepository>(),
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
              backgroundColor: AppColors.colorViolet100,
              centerTitle: true,
              title: Text(
                'Contribute',
                style: AppTextStyles.title3
                    .copyWith(color: AppColors.colorLight100),
              ),
            ),
            body: Container(
              decoration: BoxDecoration(
                color: AppColors.colorViolet100,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(context.localization.howMuch,
                      style: AppTextStyles.title3
                          .copyWith(color: AppColors.colorLight80)),
                  AppNumberInputField(
                    onChanged: bloC.setAmount,
                    style: AppTextStyles.titleX
                        .copyWith(color: AppColors.colorLight100),
                    hintStyle: AppTextStyles.titleX
                        .copyWith(color: AppColors.colorLight100),
                    hintText: '0',
                    border: InputBorder.none,
                    maxValue: (widget.budget.totalAmount /
                        widget.budget.contributions.length),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Avatar(
                              url: widget.userSplit.userAvatar!,
                              size: 48,
                              border: 0,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(widget.userSplit.userName!,
                                style: AppTextStyles.title3
                                    .copyWith(color: AppColors.colorDark100)),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        AppDropdownButton(
                          label: '${month.toMonth(context)}, $year',
                          selectedLabel: Text(
                            '${month.toMonth(context)}, $year',
                            style: AppTextStyles.body2
                                .copyWith(color: AppColors.colorDark100),
                          ),
                          onTap: () {},
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
                                onTap: () {},
                                selectedLabel: category?.label,
                                prefixIcon: category?.icon,
                              );
                            }
                          },
                        ),

                        // Padding for the button
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0, bottom: 24),
                          child: MyAppButton(
                            onPressed: () {
                              bloC.addContribution(
                                  widget.budget, widget.userSplit.userId!);
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
          );
        });
  }
}

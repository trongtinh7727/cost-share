import 'package:cost_share/locator.dart';
import 'package:cost_share/manager/group_manager.dart';
import 'package:cost_share/manager/user_manager.dart';
import 'package:cost_share/model/user_split.dart';
import 'package:cost_share/presentation/common/app_dropdown_button.dart';
import 'package:cost_share/presentation/common/app_number_input_field.dart';
import 'package:cost_share/presentation/common/app_text_input_field.dart';
import 'package:cost_share/presentation/common/avatar.dart';
import 'package:cost_share/presentation/common/category_picker.dart';
import 'package:cost_share/presentation/common/my_app_button.dart';
import 'package:cost_share/presentation/transaction/bloc/transaction_bloc.dart';
import 'package:cost_share/presentation/transaction/widgets/wallet_picker.dart';
import 'package:cost_share/repository/budget_repository.dart';
import 'package:cost_share/repository/expense_repository.dart';
import 'package:cost_share/repository/group_repository.dart';
import 'package:cost_share/utils/app_colors.dart';
import 'package:cost_share/utils/app_textstyle.dart';
import 'package:cost_share/utils/enum/app_category.dart';
import 'package:cost_share/utils/enum/app_wallet.dart';
import 'package:cost_share/utils/extension/context_ext.dart';
import 'package:cost_share/utils/extension/date_ext.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  late TransactionBloc bloC;
  DateTime selectedDate = DateTime.now();
  double totalPart = 0;

  @override
  Widget build(BuildContext context) {
    return Provider<TransactionBloc>(
      create: (context) => TransactionBloc(
        locator<BudgetRepository>(),
        locator<GroupRepository>(),
        locator<ExpenseRepository>(),
        context.read<GroupManager>().currentGroupId,
        context.read<UserManager>().currentUser!.id,
      ),
      dispose: (context, value) => value.dispose(),
      builder: (context, child) {
        bloC = context.read<TransactionBloc>();
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
            backgroundColor: AppColors.colorRed100,
            centerTitle: true,
            title: Text(
              'Expense',
              style:
                  AppTextStyles.title3.copyWith(color: AppColors.colorLight100),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.colorRed100,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
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
                    ),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: AppColors.colorLight100,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32.0),
                          topRight: Radius.circular(32.0),
                        ),
                      ),
                      child: Column(
                        children: [
                          StreamBuilder(
                            stream: bloC.categoryStream,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
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
                                          onCategorySelected:
                                              bloC.selectCategory,
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
                          SizedBox(
                            height: 18,
                          ),
                          AppTextInputField(
                            hintText: context.localization.description,
                            onChanged: bloC.setDescription,
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          AppDropdownButton(
                            label: context.localization.category,
                            onTap: () {
                              showDatePicker(
                                      context: context,
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2100),
                                      initialDate: selectedDate)
                                  .then((value) {
                                if (value != null) {
                                  setState(() {
                                    selectedDate = value;
                                  });
                                }
                              });
                            },
                            selectedLabel: Text(
                              selectedDate.toCustomTimeFormat(
                                  format: 'dd-MM-yyyy'),
                              style: AppTextStyles.body1,
                            ),
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          StreamBuilder(
                            stream: bloC.walletStream,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Center(
                                    child: Text('Error: ${snapshot.error}'));
                              } else {
                                AppWallet? wallet = snapshot.data;
                                return AppDropdownButton(
                                  label: context.localization.category,
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return WalletPicker(
                                          onWalletSelected: bloC.selectWallet,
                                          remaining: bloC.walletRemaining,
                                        );
                                      },
                                    );
                                  },
                                  selectedLabel: wallet?.label,
                                  prefixIcon: wallet?.icon,
                                );
                              }
                            },
                          ),
                          SizedBox(height: 8),
                          StreamBuilder(
                            stream: bloC.groupMembersStream,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Center(
                                    child: Text('Error: ${snapshot.error}'));
                              } else {
                                List<UserSplit> members = snapshot.data!;
                                return Column(
                                  children: members.map(
                                    (member) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Row(
                                          children: [
                                            Avatar(
                                              url: member.userAvatar!,
                                              border: 0,
                                              size: 50,
                                            ),
                                            SizedBox(width: 8),
                                            Text(member.userName!,
                                                style: AppTextStyles.body2),
                                            Expanded(child: SizedBox()),
                                            SizedBox(
                                              width: 80,
                                              child: AppNumberInputField(
                                                maxValue: 100,
                                                onChanged: (value) {
                                                  member.setWeight(
                                                      value.toDouble());
                                                  setState(() {
                                                    totalPart = members.fold(
                                                        0,
                                                        (previousValue,
                                                                element) =>
                                                            previousValue +
                                                            element.weight);
                                                    members.forEach((element) {
                                                      if (totalPart == 0) {
                                                        element.setratio(
                                                            1 / members.length);
                                                        return;
                                                      }
                                                      element.setratio(
                                                          element.weight /
                                                              totalPart);
                                                    });
                                                  });
                                                },
                                                style: AppTextStyles.body1
                                                    .copyWith(
                                                        color: AppColors
                                                            .colorGreen100),
                                                hintStyle: AppTextStyles.body1
                                                    .copyWith(
                                                        color: AppColors
                                                            .colorGreen100),
                                                hintText: '0',
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  borderSide: BorderSide(
                                                    color:
                                                        AppColors.colorLight10,
                                                    width: 1,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ).toList(),
                                );
                              }
                            },
                          ),
                          Text(totalPart.toString(),
                              style: AppTextStyles.body1
                                  .copyWith(color: AppColors.colorGreen100)),
                          MyAppButton(
                            onPressed: () => {
                              bloC.addExpense(selectedDate),
                              Navigator.pop(context),
                            },
                            message: context.localization.textContinue,
                            isPrimary: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

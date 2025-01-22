// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cost_share/locator.dart';
import 'package:cost_share/manager/group_manager.dart';
import 'package:cost_share/manager/user_manager.dart';
import 'package:cost_share/model/user_split.dart';
import 'package:cost_share/model/split.dart' as cost_share_split;
import 'package:cost_share/presentation/common/background_icon.dart';
import 'package:cost_share/presentation/common/user_transaction_status.dart';
import 'package:cost_share/presentation/transaction/bloc/transaction_bloc.dart';
import 'package:cost_share/repository/budget_repository.dart';
import 'package:cost_share/repository/expense_repository.dart';
import 'package:cost_share/repository/group_repository.dart';
import 'package:cost_share/utils/app_colors.dart';
import 'package:cost_share/utils/app_textstyle.dart';
import 'package:cost_share/utils/enum/app_category.dart';
import 'package:cost_share/utils/extension/context_ext.dart';
import 'package:cost_share/utils/extension/double_ext.dart';
import 'package:flutter/material.dart';

import 'package:cost_share/model/expense.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class ExpenseDetailScreen extends StatefulWidget {
  const ExpenseDetailScreen({
    Key? key,
    required this.expense,
  }) : super(key: key);
  final Expense expense;

  @override
  State<ExpenseDetailScreen> createState() => _ExpenseDetailScreenState();
}

class _ExpenseDetailScreenState extends State<ExpenseDetailScreen> {
  late TransactionBloc bloC;

  @override
  Widget build(BuildContext context) {
    AppCategory category =
        AppCategoryExtension.fromString(widget.expense.category);
    return Provider<TransactionBloc>(
      create: (context) => TransactionBloc(
        locator<BudgetRepository>(),
        locator<GroupRepository>(),
        locator<ExpenseRepository>(),
        context.read<GroupManager>().currentGroupId,
        context.read<UserManager>().currentUser!.id,
        expenseId: widget.expense.id,
      ),
      dispose: (context, value) => value.dispose(),
      builder: (context, child) {
        bloC = Provider.of<TransactionBloc>(context);
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(context.localization.expenseDetail,
                style: AppTextStyles.title2),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(16),
              width: context.width(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      color: AppColors.colorLight40,
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(color: AppColors.colorLight20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        BackgroundIcon(
                          icon: category.icon,
                          backgroundColor: category.color,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        category.label,
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '- ${widget.expense.amount.toCommaSeparated()}',
                    style: AppTextStyles.title1
                        .copyWith(color: AppColors.colorRed100),
                  ),
                  SizedBox(height: 8),
                  Text(
                    widget.expense.description,
                    style: AppTextStyles.body1
                        .copyWith(color: AppColors.colorDark25),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.localization.expenseSpliting,
                        style: AppTextStyles.title2
                            .copyWith(color: AppColors.colorDark25),
                      ),
                    ],
                  ),
                  StreamBuilder<List<UserSplit>>(
                    stream: bloC.groupMembersStream,
                    builder: (context, userSplitSnap) {
                      if (userSplitSnap.hasData) {
                        List<UserSplit> userSplits = userSplitSnap.data!;
                        return FutureBuilder(
                            future: bloC.getSplits(widget.expense.id),
                            builder: (context, splitSnap) {
                              if (splitSnap.hasData) {
                                List<cost_share_split.Split> split = splitSnap
                                    .data as List<cost_share_split.Split>;
                                return Column(
                                  children: userSplits.map((e) {
                                    cost_share_split.Split splitData =
                                        split.firstWhere((element) =>
                                            element.userId == e.userId);
                                    return UserTransactionStatus(
                                        userSplit: e.copyWith(
                                          amount: splitData.amount,
                                        ),
                                        label: '',
                                        amountPerPerson: splitData.isPaid
                                            ? 0
                                            : double.infinity);
                                  }).toList(),
                                );
                              } else {
                                return CircularProgressIndicator();
                              }
                            });
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
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

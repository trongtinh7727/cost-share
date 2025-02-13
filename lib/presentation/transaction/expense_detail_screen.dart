import 'package:cost_share/gen/assets.gen.dart';
import 'package:cost_share/locator.dart';
import 'package:cost_share/manager/group_manager.dart';
import 'package:cost_share/manager/user_manager.dart';
import 'package:cost_share/model/user_split.dart';
import 'package:cost_share/presentation/common/background_icon.dart';
import 'package:cost_share/presentation/common/remove_dialog.dart';
import 'package:cost_share/presentation/common/user_transaction_status.dart';
import 'package:cost_share/presentation/transaction/bloc/transaction_bloc.dart';
import 'package:cost_share/presentation/transaction/widgets/paid_expense_dialog.dart';
import 'package:cost_share/repository/budget_repository.dart';
import 'package:cost_share/repository/expense_repository.dart';
import 'package:cost_share/repository/group_repository.dart';
import 'package:cost_share/repository/notification_repository.dart';
import 'package:cost_share/utils/app_colors.dart';
import 'package:cost_share/utils/app_textstyle.dart';
import 'package:cost_share/utils/enum/app_category.dart';
import 'package:cost_share/utils/extension/context_ext.dart';
import 'package:cost_share/utils/extension/date_ext.dart';
import 'package:cost_share/utils/extension/double_ext.dart';
import 'package:cost_share/utils/route/route_name.dart';
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
        locator<NotificationRepository>(),
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
            actions: [
              InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return RemoveDialog(
                          title: context.localization.removeExpense,
                          description:
                              context.localization.removeExpenseDescription,
                          confirmText: context.localization.remove,
                          onConfirm: () {
                            String name =
                                context.read<UserManager>().currentUser!.name;
                            String title = context.localization.deletedExpense;
                            String body =
                                context.localization.deletedExpenseMessage(
                              name,
                              widget.expense.amount.toCommaSeparated(),
                            );

                            bloC.removeExpense(
                                id: widget.expense.id,
                                name: name,
                                amount: widget.expense.amount,
                                title: title,
                                body: body);
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                        );
                      },
                    );
                  },
                  child: Assets.icon.svg.iconTrash.svg()),
              SizedBox(width: 4),
              InkWell(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, RouteName.updateExpense,
                        arguments: widget.expense);
                  },
                  child: Assets.icon.svg.iconEdit.svg()),
            ],
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
                  Text(
                    widget.expense.date
                        .toCustomTimeFormat(format: 'dd MMM, yyyy'),
                    style: AppTextStyles.body3
                        .copyWith(color: AppColors.colorDark25),
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
                        return FutureBuilder(
                            future: bloC.getUserSplits(widget.expense.id),
                            builder: (context, userSplitSnap) {
                              if (userSplitSnap.hasData) {
                                List<UserSplit> userSplits =
                                    userSplitSnap.data as List<UserSplit>;
                                return Column(
                                  children: userSplits.map((userSplit) {
                                    return UserTransactionStatus(
                                      userSplit: userSplit,
                                      label: '',
                                      amountPerPerson: (userSplit.isPaid ||
                                              userSplit.amount == 0)
                                          ? 0
                                          : double.infinity,
                                      icon: userSplit.amount > 0
                                          ? InkWell(
                                              onTap: () {
                                                showModalBottomSheet(
                                                  context: context,
                                                  builder: (context) {
                                                    return PaidExpenseDialog(
                                                      userSplit: userSplit,
                                                      isPaid: userSplit.isPaid,
                                                      onPaid: () {
                                                        setState(() {
                                                          userSplit = userSplit
                                                              .copyWith(
                                                                  isPaid:
                                                                      !userSplit
                                                                          .isPaid);
                                                          bloC.updateSplit(userSplit
                                                              .toSplitWithoutAmount());
                                                        });
                                                      },
                                                    );
                                                  },
                                                );
                                              },
                                              child: userSplit.isPaid
                                                  ? Assets.icon.svg.iconSalary
                                                      .svg()
                                                  : Assets.icon.svg.iconExpense.svg(
                                                      colorFilter:
                                                          ColorFilter.mode(
                                                              AppColors
                                                                  .colorViolet100,
                                                              BlendMode.srcIn)),
                                            )
                                          : null,
                                    );
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

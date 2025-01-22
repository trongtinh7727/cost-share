import 'package:cost_share/gen/assets.gen.dart';
import 'package:cost_share/locator.dart';
import 'package:cost_share/manager/group_manager.dart';
import 'package:cost_share/manager/user_manager.dart';
import 'package:cost_share/model/budget.dart';
import 'package:cost_share/model/user_split.dart';
import 'package:cost_share/presentation/budget/bloc/budget_bloc.dart';
import 'package:cost_share/presentation/common/background_icon.dart';
import 'package:cost_share/presentation/common/user_transaction_status.dart';
import 'package:cost_share/repository/budget_repository.dart';
import 'package:cost_share/repository/group_repository.dart';
import 'package:cost_share/utils/app_colors.dart';
import 'package:cost_share/utils/app_textstyle.dart';
import 'package:cost_share/utils/enum/app_category.dart';
import 'package:cost_share/utils/extension/context_ext.dart';
import 'package:cost_share/utils/extension/double_ext.dart';
import 'package:cost_share/utils/route/route_name.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class BudgetDetailScreen extends StatefulWidget {
  const BudgetDetailScreen({required this.budget, super.key});
  final Budget budget;

  @override
  State<BudgetDetailScreen> createState() => _BudgetDetailScreenState();
}

class _BudgetDetailScreenState extends State<BudgetDetailScreen> {
  late BudgetBloc bloC;

  @override
  Widget build(BuildContext context) {
    AppCategory category =
        AppCategoryExtension.fromString(widget.budget.category);
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
            centerTitle: true,
            title: Text(context.localization.budgetDetail,
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
                    'Remaining',
                    style: AppTextStyles.title3
                        .copyWith(color: AppColors.colorDark100),
                  ),
                  Text(
                    '${widget.budget.remainingAmount.toCommaSeparated()}',
                    style: AppTextStyles.title1
                        .copyWith(color: AppColors.colorDark100),
                  ),
                  Container(
                    width: context.width() *
                        0.8, // Make the container take the full width
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Progress Bar
                        LinearProgressIndicator(
                          value: (widget.budget.totalAmount -
                                  widget.budget.remainingAmount) /
                              widget.budget.totalAmount,
                          backgroundColor: AppColors.colorLight40,
                          minHeight: 16,
                          borderRadius: BorderRadius.circular(32),
                          color: category.colorPrimary, // Progress color
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                      height: 4), // Space between the progress bar and text
                  Text(
                    'Total: ${widget.budget.totalAmount.toCommaSeparated()}',
                    style: AppTextStyles.body3,
                  ),
                  SizedBox(height: 8),
                  if (widget.budget.remainingAmount <= 0)
                    Container(
                      width: 218,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.colorRed100,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Row(
                        children: [
                          Assets.icon.svg.iconWarning.svg(),
                          SizedBox(height: 8),
                          Text(
                            context.localization.exceedLimit,
                            style: AppTextStyles.body3
                                .copyWith(color: AppColors.colorLight100),
                          ),
                        ],
                      ),
                    ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.localization.contributions,
                        style: AppTextStyles.title2
                            .copyWith(color: AppColors.colorDark25),
                      ),
                      Assets.icon.svg.iconNotifiaction.svg(
                          colorFilter: ColorFilter.mode(
                              AppColors.colorYellow100, BlendMode.srcIn)),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                          '(${(widget.budget.totalAmount / widget.budget.contributions.length).toCommaSeparated()} per person)',
                          style: AppTextStyles.body3
                              .copyWith(color: AppColors.colorDark25)),
                    ],
                  ),
                  StreamBuilder<List<UserSplit>>(
                    stream: bloC.groupMembersStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: snapshot.data!
                              .map((userSplit) => UserTransactionStatus(
                                    userSplit: userSplit.copyWith(
                                        amount: widget.budget
                                            .contributions[userSplit.userId]),
                                    amountPerPerson: widget.budget.totalAmount /
                                        widget.budget.contributions.length,
                                    label: context.localization.contributied,
                                    icon: InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                            context,
                                            RouteName.addContribute,
                                            arguments: {
                                              'budget': widget.budget,
                                              'userSplit': userSplit.copyWith(
                                                  amount: widget
                                                          .budget.contributions[
                                                      userSplit.userId]),
                                            },
                                          );
                                        },
                                        child:
                                            Assets.icon.svg.iconSalary.svg()),
                                  ))
                              .toList(),
                        );
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

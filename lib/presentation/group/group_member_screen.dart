import 'package:cost_share/gen/assets.gen.dart';
import 'package:cost_share/locator.dart';
import 'package:cost_share/manager/group_manager.dart';
import 'package:cost_share/model/user_split.dart';
import 'package:cost_share/presentation/common/add_member_dialog.dart';
import 'package:cost_share/presentation/common/avatar.dart';
import 'package:cost_share/presentation/common/leave_group_dialog.dart';
import 'package:cost_share/presentation/common/remove_dialog.dart';
import 'package:cost_share/presentation/common/user_transaction_status.dart';
import 'package:cost_share/presentation/group/bloc/group_bloc.dart';
import 'package:cost_share/presentation/transaction/widgets/paid_expense_dialog.dart';
import 'package:cost_share/repository/group_repository.dart';
import 'package:cost_share/utils/app_colors.dart';
import 'package:cost_share/utils/app_textstyle.dart';
import 'package:cost_share/utils/constant.dart';
import 'package:cost_share/utils/extension/context_ext.dart';
import 'package:cost_share/utils/extension/double_ext.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class GroupMemberScreen extends StatefulWidget {
  const GroupMemberScreen({super.key});

  @override
  State<GroupMemberScreen> createState() => _GroupMemberScreenState();
}

class _GroupMemberScreenState extends State<GroupMemberScreen> {
  late GroupManager _groupManager;
  late GroupBloc _groupBloc;

  @override
  Widget build(BuildContext context) {
    return Provider<GroupBloc>(
      create: (context) => GroupBloc(locator<GroupRepository>(),
          groupId: context.read<GroupManager>().currentGroupId),
      builder: (context, child) {
        _groupManager = context.read<GroupManager>();
        _groupBloc = context.read<GroupBloc>();
        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(),
                child: Column(
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    groupName(context),
                    SizedBox(
                      height: 16,
                    ),
                    groupBalance(context),
                    SizedBox(
                      height: 16,
                    ),
                    StreamBuilder<List<UserSplit>>(
                      stream: _groupBloc.groupMembersStream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Center(child: Text('No members available'));
                        } else {
                          return Container(
                            height: context.width() * 0.25,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.length + 1,
                              itemBuilder: (context, index) {
                                if (index >= snapshot.data!.length) {
                                  if (_groupManager.currentGroup?.authorId !=
                                      _groupManager.currentUserId) return null;
                                  return SizedBox(
                                    width: 120,
                                    child: Column(
                                      children: [
                                        Avatar(
                                          size: 50,
                                          border: 0,
                                          add: true,
                                          padding: 8,
                                          onTap: () {
                                            _groupBloc.clearError();
                                            showModalBottomSheet(
                                              context: context,
                                              builder: (context) {
                                                return AddMemberDialog(
                                                  onConfirm: () {
                                                    _groupBloc
                                                        .addMember(context);
                                                  },
                                                  errorStream:
                                                      _groupBloc.errorStream,
                                                  onChangeEmail:
                                                      _groupBloc.onChangeEmail,
                                                );
                                              },
                                            );
                                          },
                                        ),
                                        Text(
                                          context.localization.addMember,
                                          style: AppTextStyles.title3.copyWith(
                                              color: AppColors.colorDark50),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  UserSplit userSplit = snapshot.data![index];
                                  return SizedBox(
                                    width: 120,
                                    child: Column(
                                      children: [
                                        Avatar(
                                          url: userSplit.userAvatar ??
                                              AppConstant.avatarUrl,
                                          size: 50,
                                          border: 0,
                                          remove: _groupManager
                                                  .currentGroup?.authorId ==
                                              _groupManager.currentUserId,
                                          padding: 8,
                                          onTap: () {
                                            if (_groupManager
                                                    .currentGroup?.authorId ==
                                                _groupManager.currentUserId)
                                              showModalBottomSheet(
                                                context: context,
                                                builder: (context) {
                                                  return RemoveDialog(
                                                    title: context.localization
                                                        .removeExpense,
                                                    description: context
                                                        .localization
                                                        .removeExpenseDescription,
                                                    confirmText: context
                                                        .localization.remove,
                                                    onConfirm: () {
                                                      _groupBloc.removeMember(
                                                          userSplit.userId);
                                                    },
                                                  );
                                                },
                                              );
                                          },
                                        ),
                                        Text(
                                          userSplit.userName!,
                                          style: AppTextStyles.title3.copyWith(
                                              color: AppColors.colorDark100),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              },
                            ),
                          );
                        }
                      },
                    ),
                    Divider(
                      color: AppColors.colorLight20,
                      thickness: 4,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    StreamBuilder(
                      stream: _groupBloc.groupMembersStream,
                      builder: (context, snapshot) {
                        return FutureBuilder(
                            future: _groupBloc.getTotalDebt(
                                _groupManager.currentGroupId,
                                _groupManager.currentUserId),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Center(
                                    child: Text('Error: ${snapshot.error}'));
                              } else {
                                List<UserSplit> members =
                                    snapshot.data as List<UserSplit>;
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: members.length,
                                  itemBuilder: (context, index) {
                                    UserSplit userSplit = members[index];
                                    return UserTransactionStatus(
                                      label: userSplit.amount > 0
                                          ? context.localization.owedToYou
                                          : context.localization.youOwe,
                                      userSplit: userSplit,
                                      amountPerPerson: 0,
                                      icon: SizedBox(
                                        height: 24,
                                        child: InkWell(
                                          onTap: () {
                                            showModalBottomSheet(
                                              context: context,
                                              builder: (context) {
                                                return PaidExpenseDialog(
                                                  userSplit: userSplit,
                                                  isPaid: userSplit.amount == 0,
                                                  onPaid: () async {
                                                    await _groupBloc.markAsPaid(
                                                        _groupManager
                                                            .currentGroupId,
                                                        _groupManager
                                                            .currentUserId,
                                                        userSplit.userId!);
                                                    setState(() {});
                                                  },
                                                );
                                              },
                                            );
                                          },
                                          child: userSplit.amount > 0
                                              ? Assets.icon.svg.iconIncome.svg()
                                              : userSplit.amount == 0
                                                  ? SizedBox()
                                                  : Assets.icon.svg.iconExpense
                                                      .svg(
                                                      colorFilter:
                                                          ColorFilter.mode(
                                                              AppColors
                                                                  .colorViolet100,
                                                              BlendMode.srcIn),
                                                    ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                            });
                      },
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

  Widget groupBalance(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
          color: AppColors.colorLight40,
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: '${context.localization.totalRemainingBudget}:',
                style: AppTextStyles.title3
                    .copyWith(color: AppColors.colorDark50)),
            WidgetSpan(child: SizedBox(width: 80)),
            TextSpan(
                text: ' ${_groupManager.totalBudgetRemaining.toVND()}',
                style: AppTextStyles.title3
                    .copyWith(color: AppColors.colorDark100)),
          ])),
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: '${context.localization.totalBudget}:',
                style: AppTextStyles.title3
                    .copyWith(color: AppColors.colorDark50)),
            WidgetSpan(child: SizedBox(width: 166)),
            TextSpan(
                text: ' ${_groupManager.totalBudget.toVND()}',
                style: AppTextStyles.title3
                    .copyWith(color: AppColors.colorGreen100)),
          ])),
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: '${context.localization.totalExpense}:',
                style: AppTextStyles.title3
                    .copyWith(color: AppColors.colorDark50)),
            WidgetSpan(child: SizedBox(width: 156)),
            TextSpan(
                text: ' ${_groupManager.totalExpense.toVND()}',
                style: AppTextStyles.title3
                    .copyWith(color: AppColors.colorRed100)),
          ])),
        ],
      ),
    );
  }

  Widget groupName(BuildContext context) {
    return Row(
      children: [
        Avatar(
          url: _groupManager.currentGroup!.groupPhoto,
          size: 80,
          border: 0,
        ),
        SizedBox(
          width: 16,
        ),
        Flexible(
          fit: FlexFit.tight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.localization.groupName,
                style: AppTextStyles.small.copyWith(
                    fontWeight: FontWeight.w500, color: AppColors.colorLight20),
              ),
              Text(
                _groupManager.currentGroup!.groupName,
                style: AppTextStyles.title2.copyWith(
                    fontWeight: FontWeight.w500, color: AppColors.colorDark100),
              )
            ],
          ),
        ),
        _groupManager.currentGroup!.authorId != _groupManager.currentUserId
            ? InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return LeaveGroupDialog(
                        onConfirm: () {
                          _groupBloc.removeMember(_groupManager.currentUserId);
                        },
                        title: context.localization.leaveGroup,
                        description: context.localization.leaveGroupDescription,
                        confirmText: context.localization.leave,
                      );
                    },
                  );
                },
                child: Assets.icon.svg.iconLogout.svg(),
              )
            : Assets.icon.svg.iconSettings.svg()
      ],
    );
  }
}

import 'package:cost_share/gen/assets.gen.dart';
import 'package:cost_share/locator.dart';
import 'package:cost_share/manager/group_manager.dart';
import 'package:cost_share/presentation/common/remove_dialog.dart';
import 'package:cost_share/presentation/common/text_input_bottom_sheet.dart';
import 'package:cost_share/presentation/group/bloc/group_bloc.dart';
import 'package:cost_share/repository/group_repository.dart';
import 'package:cost_share/utils/app_colors.dart';
import 'package:cost_share/utils/app_textstyle.dart';
import 'package:cost_share/utils/extension/context_ext.dart';
import 'package:cost_share/utils/route/route_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroupSettingScreen extends StatefulWidget {
  const GroupSettingScreen({super.key});

  @override
  State<GroupSettingScreen> createState() => _GroupSettingScreenState();
}

class _GroupSettingScreenState extends State<GroupSettingScreen> {
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
        return Scaffold(
          appBar: AppBar(
            title: Text(
              context.localization.groupSetting,
              style: AppTextStyles.title3,
            ),
            centerTitle: true,
          ),
          backgroundColor: AppColors.colorLight80,
          body: Column(
            children: [
              ListTile(
                title: Text(
                  context.localization.groupName,
                  style: AppTextStyles.body2
                      .copyWith(color: AppColors.colorDark50),
                ),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return TextInputBottomSheet(
                        title: context.localization.groupName,
                        hintText: _groupManager.currentGroup?.groupName,
                        confirmText: context.localization.confirm,
                        onConfirm: () {
                          _groupBloc.updateGroupName(context);
                        },
                        errorStream: _groupBloc.errorStream,
                        onChangeEmail: _groupBloc.onChangeGroupName,
                      );
                    },
                  );
                },
                trailing: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    StreamBuilder(
                      stream: _groupManager.userGroupsStream,
                      builder: (context, snapshot) {
                        return Text(_groupManager.currentGroup?.groupName ?? '',
                            style: AppTextStyles.body2
                                .copyWith(color: AppColors.colorDark25));
                      },
                    ),
                    Assets.icon.svg.iconArrowRight.svg(
                      colorFilter: ColorFilter.mode(
                          AppColors.colorBlue100, BlendMode.srcIn),
                    )
                  ],
                ),
              ),
              ListTile(
                title: Text(
                  context.localization.deleteGroup,
                  style: AppTextStyles.body2
                      .copyWith(color: AppColors.colorRed100),
                ),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => RemoveDialog(
                        onConfirm: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            RouteName.wellCome,
                            (route) =>
                                route.settings.name == RouteName.wellCome,
                          );
                          _groupManager.setCurrentGroup("");
                          _groupBloc.deleteGroup();
                        },
                        title: context.localization.deleteGroup,
                        description:
                            context.localization.deleteGroupDescription,
                        confirmText: context.localization.deleteGroup),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

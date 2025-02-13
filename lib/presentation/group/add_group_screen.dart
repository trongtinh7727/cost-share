import 'package:cost_share/locator.dart';
import 'package:cost_share/manager/user_manager.dart';
import 'package:cost_share/presentation/common/app_text_input_field.dart';
import 'package:cost_share/presentation/common/avatar.dart';
import 'package:cost_share/presentation/common/my_app_button.dart';
import 'package:cost_share/presentation/group/bloc/group_bloc.dart';
import 'package:cost_share/repository/group_repository.dart';
import 'package:cost_share/repository/notification_repository.dart';
import 'package:cost_share/utils/app_colors.dart';
import 'package:cost_share/utils/app_textstyle.dart';
import 'package:cost_share/utils/extension/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddGroupScreen extends StatefulWidget {
  const AddGroupScreen({super.key});

  @override
  State<AddGroupScreen> createState() => _AddGroupScreenState();
}

class _AddGroupScreenState extends State<AddGroupScreen> {
  @override
  Widget build(BuildContext context) {
    return Provider<GroupBloc>(
      create: (context) => GroupBloc(locator<GroupRepository>(),locator<NotificationRepository>()),
      builder: (context, child) {
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
              'Add New Group',
              style:
                  AppTextStyles.title3.copyWith(color: AppColors.colorLight100),
            ),
          ),
          body: Container(
            decoration: BoxDecoration(
              color: AppColors.colorViolet100,
            ),
            child: Column(
              children: [
                Expanded(child: SizedBox()),
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
                      Avatar(
                        borderRadius: 50,
                        size: 80,
                        border: 0,
                        add: true,
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      AppTextInputField(
                        onChanged: context.read<GroupBloc>().onChangeGroupName,
                        hintText: context.localization.groupName,
                      ),
                      SizedBox(height: 18.0),
                      MyAppButton(
                        onPressed: () => {
                          context.read<GroupBloc>().createGroup(
                              context.read<UserManager>().currentUser!.id),
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
        );
      },
    );
  }
}

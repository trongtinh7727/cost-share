import 'package:cost_share/gen/assets.gen.dart';
import 'package:cost_share/manager/group_manager.dart';
import 'package:cost_share/manager/user_manager.dart';
import 'package:cost_share/model/group_detail.dart';
import 'package:cost_share/presentation/common/background_icon.dart';
import 'package:cost_share/presentation/common/group_card.dart';
import 'package:cost_share/utils/app_colors.dart';
import 'package:cost_share/utils/app_textstyle.dart';
import 'package:cost_share/utils/extension/context_ext.dart';
import 'package:cost_share/utils/route/route_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WellcomeScreen extends StatefulWidget {
  const WellcomeScreen({super.key});

  @override
  State<WellcomeScreen> createState() => _WellcomeScreenState();
}

class _WellcomeScreenState extends State<WellcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorYellow10,
      body: SafeArea(
          child: Column(
        children: [
          Text(
            context.localization.wellcome,
            style: AppTextStyles.title2.copyWith(color: AppColors.colorDark75),
          ),
          SizedBox(
            height: 72,
          ),
          Text(
            context.localization.chooseGroup,
            style: AppTextStyles.title3.copyWith(color: AppColors.colorDark50),
          ),
          SizedBox(
            height: 8,
          ),
          Expanded(
              child: StreamBuilder<List<GroupDetail>>(
            stream: context.read<GroupManager>().userGroupsStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No groups available'));
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length + 1,
                  itemBuilder: (context, index) {
                    if (index == snapshot.data!.length) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: GroupCard(
                            onTap: () {
                              Navigator.pushNamed(context, RouteName.addGroup);
                            },
                            cardState: CardState.addNew),
                      );
                    } else {
                      GroupDetail group = snapshot.data![index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: GroupCard(
                            onTap: () {
                              context
                                  .read<GroupManager>()
                                  .setCurrentGroup(group.groupId);
                              Navigator.pushReplacementNamed(
                                  context, RouteName.main);
                            },
                            groupDetail: group,
                            cardState: CardState.active),
                      );
                    }
                  },
                );
              }
            },
          )),
          SizedBox(
            height: 16,
          ),
          GestureDetector(
            onTap: () {
              context.read<UserManager>().signOut();
              Navigator.pushReplacementNamed(context, RouteName.intro);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BackgroundIcon(
                    icon: Assets.icon.svg.iconLogout.svg(),
                    backgroundColor: AppColors.colorRed20),
                SizedBox(
                  width: 8,
                ),
                Text(
                  context.localization.logout,
                  style: AppTextStyles.body1
                      .copyWith(color: AppColors.colorDark25),
                )
              ],
            ),
          ),
          SizedBox(
            height: 16,
          )
        ],
      )),
    );
  }
}

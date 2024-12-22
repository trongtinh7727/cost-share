// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cost_share/manager/group_manager.dart';
import 'package:cost_share/model/group_detail.dart';
import 'package:cost_share/presentation/common/app_date_picker_button.dart';
import 'package:cost_share/utils/extension/context_ext.dart';
import 'package:cost_share/utils/extension/int_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_month_picker/flutter_custom_month_picker.dart';

import 'package:cost_share/gen/assets.gen.dart';
import 'package:cost_share/presentation/common/avatar.dart';
import 'package:cost_share/utils/app_colors.dart';
import 'package:cost_share/utils/app_textstyle.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    Key? key,
    required this.mainScaffoldKey,
  }) : super(key: key);
  final GlobalKey<ScaffoldState> mainScaffoldKey;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    GroupDetail currentGroup = context.read<GroupManager>().currentGroup!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.colorYellow10,
        leading: GestureDetector(
          onTap: () {
            widget.mainScaffoldKey.currentState?.openDrawer();
          },
          child: Avatar(
            url: currentGroup.groupPhoto,
            border: 1,
          ),
        ),
        centerTitle: true,
        title: AppDatePickerButton(
          label: month.toMonth(context),
          onTap: () => showMonthPicker(context, onSelected: (m, y) {
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
              dialogBackgroundColor: Colors.grey[200]),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Assets.icon.svg.iconNotifiaction.svg(
                      colorFilter: ColorFilter.mode(
                          AppColors.colorViolet100, BlendMode.srcIn))),
              if (5 != null)
                Positioned(
                  height: 16,
                  width: 16,
                  right: 4,
                  top: 8,
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.colorRed100, shape: BoxShape.circle),
                    child: Center(
                      child: Text(
                        '${5}', // Replace this with dynamic notification count if needed
                        textAlign: TextAlign.center,
                        style: AppTextStyles.tiny
                            .copyWith(color: AppColors.colorLight100),
                      ),
                    ),
                  ),
                ),
            ],
          )
        ],
      ),
      body: Container(
          color: AppColors.colorBlue100,
          child: Center(child: Text("Home Screen"))),
    );
  }
}

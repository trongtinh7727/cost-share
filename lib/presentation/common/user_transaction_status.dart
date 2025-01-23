// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:cost_share/model/user_split.dart';
import 'package:cost_share/presentation/common/avatar.dart';
import 'package:cost_share/utils/app_colors.dart';
import 'package:cost_share/utils/app_textstyle.dart';
import 'package:cost_share/utils/extension/double_ext.dart';

class UserTransactionStatus extends StatelessWidget {
  const UserTransactionStatus({
    Key? key,
    required this.userSplit,
    required this.amountPerPerson,
    this.icon,
    this.label,
    this.width,
  }) : super(key: key);
  final UserSplit userSplit;
  final double amountPerPerson;
  final Widget? icon;
  final String? label;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      decoration: BoxDecoration(
        color: AppColors.colorLight40,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Avatar(
            url: userSplit.userAvatar!,
            size: 48,
            border: 0,
          ),
          SizedBox(
            width: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userSplit.userName!,
                style:
                    AppTextStyles.body2.copyWith(color: AppColors.colorDark100),
              ),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: '$label',
                  style: AppTextStyles.body2
                      .copyWith(color: AppColors.colorDark50),
                ),
                TextSpan(
                  text: userSplit.amount.toCommaSeparated(),
                  style: AppTextStyles.body2.copyWith(
                      color: userSplit.amount >= amountPerPerson
                          ? AppColors.colorGreen100
                          : AppColors.colorRed100),
                ),
              ])),
            ],
          ),
          Expanded(child: SizedBox()),
          icon ?? Container(),
        ],
      ),
    );
  }
}

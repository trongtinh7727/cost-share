// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cost_share/utils/app_colors.dart';
import 'package:cost_share/utils/app_textstyle.dart';
import 'package:flutter/material.dart';

class TotalBalanceCard extends StatelessWidget {
  const TotalBalanceCard({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
    required this.backgroundColor
  }) : super(key: key);
  final Widget icon;
  final String label;
  final String value;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32), color: backgroundColor),
      child: Row(
        children: [
          icon,
          SizedBox(
            width: 10,
          ),
          Column(
            children: [
              Text(
                label,
                style:
                    AppTextStyles.body3.copyWith(color: AppColors.colorLight80),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                value,
                style: AppTextStyles.title2
                    .copyWith(color: AppColors.colorLight80),
              )
            ],
          )
        ],
      ),
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:cost_share/gen/assets.gen.dart';
import 'package:cost_share/utils/app_colors.dart';
import 'package:cost_share/utils/app_textstyle.dart';

class AppDatePickerButton extends StatelessWidget {
  const AppDatePickerButton({
    Key? key,
    required this.label,
    required this.onTap,
    this.width,
    this.borderColor = AppColors.colorLight60,
    this.height = 40,
  }) : super(key: key);

  final String label;
  final void Function() onTap;

  final Color borderColor;
  final double? width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.only(top: 8, left: 8, right: 16, bottom: 8),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: borderColor),
            borderRadius: BorderRadius.circular(40),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Assets.icon.svg.iconArrowDown.svg(),
            SizedBox(
              width: 8,
            ),
            Text(
              label,
              textAlign: TextAlign.center,
              style: AppTextStyles.small.copyWith(color: AppColors.colorDark75),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:cost_share/gen/assets.gen.dart';
import 'package:cost_share/utils/app_colors.dart';
import 'package:cost_share/utils/app_textstyle.dart';
import 'package:flutter/material.dart';

class AppDatePickerButton extends StatelessWidget {
  const AppDatePickerButton({super.key, required this.label, required this.onTap});

  final String label;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // width: 107,
        height: 40,
        padding: const EdgeInsets.only(top: 8, left: 8, right: 16, bottom: 8),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: AppColors.colorLight60),
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

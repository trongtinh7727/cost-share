// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cost_share/gen/assets.gen.dart';
import 'package:cost_share/utils/app_colors.dart';
import 'package:cost_share/utils/app_textstyle.dart';
import 'package:flutter/material.dart';

class AppDropdownButton extends StatefulWidget {
  const AppDropdownButton({
    Key? key,
    required this.label,
    required this.onTap,
    this.prefixIcon,
    this.suffixIcon,
    this.selectedLabel,
    this.borderColor,
  }) : super(key: key);
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? selectedLabel;
  final Color? borderColor;
  final String label;
  final void Function() onTap;
  @override
  State<AppDropdownButton> createState() => _AppDropdownButtonState();
}

class _AppDropdownButtonState extends State<AppDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: 434,
        height: 56,
        padding: const EdgeInsets.only(top: 8, left: 8, right: 16, bottom: 8),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
                width: 1, color: widget.borderColor ?? AppColors.colorDark25),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widget.prefixIcon ?? SizedBox(),
            SizedBox(
              width: 8,
            ),
            widget.selectedLabel ??
                Text(
                  widget.label,
                  textAlign: TextAlign.start,
                  style: AppTextStyles.body1
                      .copyWith(color: AppColors.colorLight10),
                ),
            Expanded(
              child: SizedBox(
                width: 8,
              ),
            ),
            widget.suffixIcon ??
                Assets.icon.svg.iconArrowDown.svg(
                    colorFilter: ColorFilter.mode(
                        AppColors.colorDark25, BlendMode.srcIn)),
          ],
        ),
      ),
    );
  }
}

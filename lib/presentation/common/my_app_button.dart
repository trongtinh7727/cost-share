import 'package:cost_share/utils/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:cost_share/utils/app_textstyle.dart';

class MyAppButton extends StatelessWidget {
  const MyAppButton({
    Key? key,
    required this.onPressed,
    required this.message,
    required this.isPrimary,
  }) : super(key: key);

  final Function()? onPressed;
  final String message;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style:
            ButtonStyle(backgroundColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return AppColors.colorViolet20;
            }
            return isPrimary
                ? AppColors.colorViolet100
                : AppColors.colorViolet20;
          },
        )),
        child: Text(
          message,
          style: AppTextStyles.title3.copyWith(
              color: isPrimary
                  ? AppColors.colorLight100
                  : AppColors.colorViolet100),
        ));
  }
}

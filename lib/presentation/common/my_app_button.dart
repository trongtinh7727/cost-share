import 'package:cost_share/utils/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:cost_share/utils/app_textstyle.dart';

class MyAppButton extends StatelessWidget {
  const MyAppButton(
      {Key? key,
      required this.onPressed,
      required this.message,
      required this.isPrimary,
      this.isLoading})
      : super(key: key);

  final Function()? onPressed;
  final String message;
  final bool isPrimary;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 58,
      width: double.infinity,
      child: ElevatedButton(
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
          child: isLoading == true
              ? CircularProgressIndicator()
              : Text(
                  message,
                  style: AppTextStyles.title3.copyWith(
                      color: isPrimary
                          ? AppColors.colorLight100
                          : AppColors.colorViolet100),
                )),
    );
  }
}

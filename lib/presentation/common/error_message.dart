import 'package:cost_share/utils/app_colors.dart';
import 'package:cost_share/utils/app_textstyle.dart';
import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({required this.error, super.key});
  final Stream<String?> error;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: error,
      builder: (context, snapshot) {
        final errorMessage = snapshot.data;
        return Opacity(
          opacity: errorMessage == null ? 0 : 1,
          child: Text(
            '$errorMessage',
            style: AppTextStyles.body1.copyWith(color: AppColors.colorRed100),
          ),
        );
      },
    );
  }
}
// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:cost_share/presentation/common/my_app_button.dart';
import 'package:cost_share/utils/app_colors.dart';
import 'package:cost_share/utils/app_textstyle.dart';
import 'package:cost_share/utils/extension/context_ext.dart';

class RemoveDialog extends StatelessWidget {
  const RemoveDialog({
    Key? key,
    required this.title,
    required this.description,
    required this.confirmText,
    this.onConfirm,
  }) : super(key: key);
  final String title;
  final String description;
  final String confirmText;
  final VoidCallback? onConfirm;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(
            color: AppColors.colorViolet40,
            height: 2,
            thickness: 5,
            endIndent: 170,
            indent: 170,
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            title,
            style: AppTextStyles.title3.copyWith(color: AppColors.colorDark100),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            description,
            style: AppTextStyles.body1.copyWith(color: AppColors.colorLight10),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Flexible(
                child: MyAppButton(
                  message: context.localization.cancel,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  isPrimary: false,
                ),
              ),
              SizedBox(
                width: 16,
              ),
              MyAppButton(
                message: confirmText,
                width: 200,
                onPressed: () {
                  onConfirm!();
                },
                isPrimary: true,
              ),
            ],
          )
        ],
      ),
    );
  }
}

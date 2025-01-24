// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cost_share/presentation/common/error_message.dart';
import 'package:flutter/material.dart';

import 'package:cost_share/presentation/common/app_text_input_field.dart';
import 'package:cost_share/presentation/common/my_app_button.dart';
import 'package:cost_share/utils/app_colors.dart';
import 'package:cost_share/utils/app_textstyle.dart';
import 'package:cost_share/utils/extension/context_ext.dart';

class AddMemberDialog extends StatelessWidget {
  const AddMemberDialog({
    Key? key,
    this.onConfirm,
    this.onChangeEmail,
    required this.errorStream,
  }) : super(key: key);
  final VoidCallback? onConfirm;
  final Function(String)? onChangeEmail;
  final Stream<String?> errorStream;

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
            context.localization.orEnterEmail,
            style: AppTextStyles.title3.copyWith(color: AppColors.colorDark100),
          ),
          SizedBox(
            height: 8,
          ),
          AppTextInputField(
            hintText: context.localization.email,
            onChanged: onChangeEmail,
          ),
          ErrorMessage(error: errorStream),
          Text(
            context.localization.inviteMemberDescription,
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
                message: context.localization.addMember,
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

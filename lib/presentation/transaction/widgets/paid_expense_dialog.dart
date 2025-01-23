// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:cost_share/model/user_split.dart';
import 'package:cost_share/presentation/common/my_app_button.dart';
import 'package:cost_share/presentation/common/user_transaction_status.dart';
import 'package:cost_share/utils/app_colors.dart';
import 'package:cost_share/utils/app_textstyle.dart';
import 'package:cost_share/utils/extension/context_ext.dart';

class PaidExpenseDialog extends StatelessWidget {
  const PaidExpenseDialog({
    Key? key,
    required this.userSplit,
    required this.isPaid,
    this.onPaid,
  }) : super(key: key);
  final UserSplit userSplit;
  final bool isPaid;
  final VoidCallback? onPaid;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height() * 0.34,
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
          UserTransactionStatus(
            userSplit: userSplit,
            label: '',
            amountPerPerson: 0,
            width: 250,
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            isPaid
                ? context.localization.markAsUnpaid
                : context.localization.markAsPaid,
            style: AppTextStyles.title3.copyWith(color: AppColors.colorDark100),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            isPaid
                ? context.localization.markAsUnpaidDescription
                : context.localization.markAsPaidDescription,
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
                    Navigator.of(context).pop(isPaid);
                  },
                  isPrimary: false,
                ),
              ),
              SizedBox(
                width: 16,
              ),
              MyAppButton(
                message: isPaid
                    ? context.localization.markAsUnpaid
                    : context.localization.markAsPaid,
                width: 200,
                onPressed: () {
                  onPaid!();
                  Navigator.of(context).pop(isPaid);
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

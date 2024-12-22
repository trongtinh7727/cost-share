// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cost_share/utils/enum/app_wallet.dart';
import 'package:cost_share/utils/extension/double_ext.dart';
import 'package:flutter/material.dart';

import 'package:cost_share/utils/app_colors.dart';
import 'package:cost_share/utils/app_textstyle.dart';

class WalletPicker extends StatefulWidget {
  const WalletPicker({
    Key? key,
    required this.onWalletSelected,
    required this.remaining,
  }) : super(key: key);

  final Function(String) onWalletSelected;
  final double remaining;

  @override
  State<WalletPicker> createState() => _WalletPickerState();
}

class _WalletPickerState extends State<WalletPicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 220,
        width: 900,
        child: Column(
          children: [
            SizedBox(
              height: 16,
            ),
            Divider(
              color: AppColors.colorViolet40,
              height: 2,
              thickness: 5,
              endIndent: 180,
              indent: 180,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "Chose wallet",
              style: AppTextStyles.body2,
            ),
            SizedBox(
              height: 16,
            ),
            InkWell(
              onTap: () {
                widget.onWalletSelected(AppWallet.PERSONAL.name);
                Navigator.pop(context);
              },
              child: Container(
                height: 53,
                padding: const EdgeInsets.only(left: 8, right: 8),
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.colorLight10, width: 1),
                  borderRadius: BorderRadius.circular(32),
                  color: AppColors.colorLight60,
                ),
                child: Row(
                  children: [
                    Icon(Icons.circle, color: AppColors.colorGreen100),
                    SizedBox(
                      width: 8,
                    ),
                    Text(AppWallet.PERSONAL.name, style: AppTextStyles.body2),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: widget.remaining > 0
                  ? () {
                      widget.onWalletSelected(AppWallet.BUDGET.name);
                      Navigator.pop(context);
                    }
                  : null,
              child: Container(
                height: 53,
                padding: const EdgeInsets.only(left: 8, right: 8),
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.colorLight10, width: 1),
                  borderRadius: BorderRadius.circular(32),
                  color: AppColors.colorLight60,
                ),
                child: Row(
                  children: [
                    Icon(Icons.circle,
                        color: widget.remaining > 0
                            ? AppColors.colorYellow100
                            : AppColors.colorLight10),
                    SizedBox(
                      width: 8,
                    ),
                    Text(AppWallet.BUDGET.name, style: AppTextStyles.body2.copyWith(
                      color: widget.remaining > 0
                          ? AppColors.colorDark100
                          : AppColors.colorLight10,
                    )),
                    Expanded(child: SizedBox()),
                    Text('remaining: ${widget.remaining.toVND()}',
                        style: AppTextStyles.tiny.copyWith(
                          color: widget.remaining > 0
                              ? AppColors.colorDark25
                              : AppColors.colorLight10,
                        )),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}

import 'package:cost_share/utils/app_colors.dart';
import 'package:cost_share/utils/app_textstyle.dart';
import 'package:flutter/material.dart';

enum AppWallet { PERSONAL, BUDGET }

extension AppWalletExtension on AppWallet {
  String get name {
    switch (this) {
      case AppWallet.PERSONAL:
        return 'Personal wallet';
      case AppWallet.BUDGET:
        return 'Category Budget';
      default:
        return 'none';
    }
  }

  Widget get icon {
    switch (this) {
      case AppWallet.PERSONAL:
        return Icon(Icons.account_balance_wallet);
      case AppWallet.BUDGET:
        return Icon(Icons.account_balance);
      default:
        return Icon(Icons.account_balance_wallet);
    }
  }

  Widget get label {
    switch (this) {
      case AppWallet.PERSONAL:
        return Text('Personal wallet',
            style:
                AppTextStyles.body1.copyWith(color: AppColors.colorGreen100));
      case AppWallet.BUDGET:
        return Text('Category Budget',
            style:
                AppTextStyles.body1.copyWith(color: AppColors.colorYellow100));

      default:
        return Text('Personal wallet', style: TextStyle(color: Colors.black));
    }
  }

  static AppWallet fromString(String value) {
    switch (value) {
      case 'Personal wallet':
        return AppWallet.PERSONAL;
      case 'Category Budget':
        return AppWallet.BUDGET;
      default:
        return AppWallet.PERSONAL;
    }
  }
}

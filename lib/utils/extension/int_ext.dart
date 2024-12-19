import 'package:cost_share/utils/extension/context_ext.dart';
import 'package:flutter/material.dart';

extension IntExt on int {
  String toMonth(BuildContext context) {
    switch (this) {
      case 1:
        return context.localization.january;
      case 2:
        return context.localization.february;
      case 3:
        return context.localization.march;
      case 4:
        return context.localization.april;
      case 5:
        return context.localization.may;
      case 6:
        return context.localization.june;
      case 7:
        return context.localization.july;
      case 8:
        return context.localization.august;
      case 9:
        return context.localization.september;
      case 10:
        return context.localization.october;
      case 11:
        return context.localization.november;
      case 12:
        return context.localization.december;
      default:
        return context.localization.invalidMonth; 
    }
  }
}

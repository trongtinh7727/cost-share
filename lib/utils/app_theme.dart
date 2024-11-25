import 'package:cost_share/utils/app_colors.dart';
import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.colorLight100,
  pageTransitionsTheme: const PageTransitionsTheme(builders: {
    TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
  }),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(width: 0.5, color: AppColors.colorDark25),
    ),
    fillColor: AppColors.colorLight100,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.colorViolet20;
          }
          return AppColors.colorViolet100;
        },
      ),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      elevation: WidgetStateProperty.all(0),
      minimumSize: WidgetStateProperty.all(Size(0, 44)),
      padding: WidgetStateProperty.all(
        EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      ),
    ),
  ),
);

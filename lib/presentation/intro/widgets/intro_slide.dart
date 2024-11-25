// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cost_share/utils/app_colors.dart';
import 'package:cost_share/utils/app_textstyle.dart';

class IntroSlide extends StatelessWidget {
  const IntroSlide({
    Key? key,
    required this.title,
    required this.body,
    required this.icon,
  }) : super(key: key);
  final String title;
  final String body;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 312,
            height: 312,
            child: icon,
          ),
          SizedBox(
            height: 41.h,
          ),
          Text(
            title,
            style: AppTextStyles.title1.copyWith(color: AppColors.colorDark50),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 17.h,
          ),
          Text(
            body,
            style: AppTextStyles.body1.copyWith(color: AppColors.colorLight20),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}

import 'package:cost_share/gen/assets.gen.dart';
import 'package:cost_share/presentation/common/my_app_button.dart';
import 'package:cost_share/presentation/intro/widgets/intro_slide.dart';
import 'package:cost_share/utils/app_colors.dart';
import 'package:cost_share/utils/extension/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ImageSlideshow(
            height: 600.h,
            width: 375.w,
            initialPage: 0,
            indicatorColor: AppColors.colorBlue100,
            indicatorBackgroundColor: AppColors.colorDark25,
            isLoop: true,
            children: [
              IntroSlide(
                  icon: Assets.image.svg.intro1.svg(),
                  title: context.localization.introTitle1,
                  body: context.localization.introBody1),
              IntroSlide(
                  icon: Assets.image.svg.intro2.svg(),
                  title: context.localization.introTitle2,
                  body: context.localization.introBody2),
              IntroSlide(
                  icon: Assets.image.svg.intro3.svg(),
                  title: context.localization.introTitle3,
                  body: context.localization.introBody3)
            ],
          ),
          SizedBox(
            height: 32.h,
          ),
          SizedBox(
            width: 342.w,
            height: 56.h,
            child: MyAppButton(
              onPressed: () {},
              message: context.localization.signUp,
              isPrimary: true,
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          SizedBox(
            width: 342.w,
            height: 56.h,
            child: MyAppButton(
              onPressed: () {},
              message: context.localization.login,
              isPrimary: false,
            ),
          ),
        ],
      ),
    );
  }
}

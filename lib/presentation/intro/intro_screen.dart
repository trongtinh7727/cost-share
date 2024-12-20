import 'package:cost_share/gen/assets.gen.dart';
import 'package:cost_share/manager/user_manager.dart';
import 'package:cost_share/model/user.dart';
import 'package:cost_share/presentation/authentication/bloc/authenticate_bloc.dart';
import 'package:cost_share/presentation/common/my_app_button.dart';
import 'package:cost_share/presentation/intro/widgets/intro_slide.dart';
import 'package:cost_share/utils/app_colors.dart';
import 'package:cost_share/utils/extension/context_ext.dart';
import 'package:cost_share/utils/route/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  User? _user;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await _checkUser();
    Future.delayed(const Duration(seconds: 1), () {
      if (_user != null) {
        Navigator.pushReplacementNamed(context, RouteName.wellCome);
      }
    });
  }

  Future<void> _checkUser() async {
    final userManager = context.read<UserManager>();
    await userManager.loadUser();
    setState(() {
      _user = userManager.currentUser;
    });
  }

  @override
  Widget build(BuildContext outerContext) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 600.h,
            child: ImageSlideshow(
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
                    body: context.localization.introBody3),
              ],
            ),
          ),
          SizedBox(height: 32.h),
          SizedBox(
            width: 342.w,
            height: 56.h,
            child: MyAppButton(
              onPressed: () {
                context.read<AuthenticateBloc>().init();
                Navigator.of(context).pushNamed(RouteName.signUp);
              },
              message: context.localization.signUp,
              isPrimary: true,
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: 342.w,
            height: 56.h,
            child: MyAppButton(
              onPressed: () {
                Navigator.of(context).pushNamed(RouteName.signIn);
              },
              message: context.localization.login,
              isPrimary: false,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:cost_share/gen/assets.gen.dart';
import 'package:cost_share/manager/user_manager.dart';
import 'package:cost_share/utils/app_colors.dart';
import 'package:cost_share/utils/app_textstyle.dart';
import 'package:cost_share/utils/extension/context_ext.dart';
import 'package:cost_share/utils/extension/locale_ext.dart';
import 'package:cost_share/utils/route/route_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonalSettingScreen extends StatefulWidget {
  const PersonalSettingScreen({super.key});

  @override
  State<PersonalSettingScreen> createState() => _PersonalSettingScreenState();
}

class _PersonalSettingScreenState extends State<PersonalSettingScreen> {
  late UserManager _userManager;

  @override
  Widget build(BuildContext context) {
    _userManager = context.read<UserManager>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.localization.settings,
          style: AppTextStyles.title3,
        ),
        centerTitle: true,
      ),
      backgroundColor: AppColors.colorLight80,
      body: Column(
        children: [
          ListTile(
            title: Text(
              context.localization.language,
              style: AppTextStyles.body2.copyWith(color: AppColors.colorDark50),
            ),
            onTap: () {
              Navigator.pushNamed(context, RouteName.changeLanguage);
            },
            trailing: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                StreamBuilder(
                  stream: _userManager.localeStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    final locale = snapshot.data;
                    return Text(locale!.nameByLocale,
                        style: AppTextStyles.body2
                            .copyWith(color: AppColors.colorDark25));
                  },
                ),
                Assets.icon.svg.iconArrowRight.svg(
                  colorFilter:
                      ColorFilter.mode(AppColors.colorBlue100, BlendMode.srcIn),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

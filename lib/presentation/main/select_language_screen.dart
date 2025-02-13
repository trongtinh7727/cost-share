import 'package:cost_share/gen/assets.gen.dart';
import 'package:cost_share/manager/user_manager.dart';
import 'package:cost_share/utils/app_colors.dart';
import 'package:cost_share/utils/app_textstyle.dart';
import 'package:cost_share/utils/extension/context_ext.dart';
import 'package:cost_share/utils/extension/locale_ext.dart';
import 'package:cost_share/utils/suported_locale.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectLanguageScreen extends StatefulWidget {
  const SelectLanguageScreen({super.key});

  @override
  State<SelectLanguageScreen> createState() => _SelectLanguageScreenState();
}

class _SelectLanguageScreenState extends State<SelectLanguageScreen> {
  late UserManager _userManager;

  @override
  Widget build(BuildContext context) {
    _userManager = context.read<UserManager>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.localization.language,
          style: AppTextStyles.title3,
        ),
        centerTitle: true,
      ),
      backgroundColor: AppColors.colorLight80,
      body: Column(
        children: supportedLocales.map(
          (e) {
            return ListTile(
              title: Text(
                e.nameByLocale,
                style:
                    AppTextStyles.body2.copyWith(color: AppColors.colorDark100),
              ),
              onTap: () {
                _userManager.setLocale(e);
                Navigator.pop(context);
              },
              trailing: StreamBuilder(
                stream: _userManager.localeStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  final locale = snapshot.data;
                  return locale!.languageCode == e.languageCode
                      ? Assets.icon.svg.iconSuccess.svg()
                      : SizedBox();
                },
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}

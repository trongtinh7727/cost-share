import 'package:cost_share/firebase_options.dart';
import 'package:cost_share/generated/l10n.dart';
import 'package:cost_share/locator.dart';
import 'package:cost_share/manager/user_manager.dart';
import 'package:cost_share/presentation/intro/intro_screen.dart';
import 'package:cost_share/repository/user_repository.dart';
import 'package:cost_share/service/shared_pref_services.dart';
import 'package:cost_share/splash_creen.dart';
import 'package:cost_share/utils/app_theme.dart';
import 'package:cost_share/utils/route/app_routes.dart';
import 'package:cost_share/utils/suported_locale.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialize();
  setupLocators();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<UserManager>(
      create: (context) => UserManager(locator<UserRepository>()),
      dispose: (context, userManager) => userManager.dispose,
      builder: (context, child) {
        return ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          builder: (context, child) => FutureBuilder(
            future: Future.wait([
              Firebase.initializeApp(
                  options: DefaultFirebaseOptions.currentPlatform),
              () async {
                await SharedPrefService.instance.onInit();
              }(),
            ]),
            builder: (context, futureBuildersnapshot) {
              return StreamBuilder<Locale?>(
                stream: context.read<UserManager>().localeStream,
                builder: (context, snapshot) {
                  final locale = snapshot.data;
                  return MaterialApp(
                    locale: locale,
                    debugShowCheckedModeBanner: false,
                    onGenerateRoute: (settings) => settings.generateRoute,
                    localizationsDelegates: [
                      AppLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate
                    ],
                    supportedLocales: supportedLocales,
                    theme: appTheme,
                    home: (futureBuildersnapshot.connectionState ==
                            ConnectionState.waiting)
                        ? SplashCreen()
                        : IntroScreen(),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}

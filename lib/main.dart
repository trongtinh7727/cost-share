import 'package:cost_share/firebase_options.dart';
import 'package:cost_share/generated/l10n.dart';
import 'package:cost_share/locator.dart';
import 'package:cost_share/manager/bottom_navigation_manager.dart';
import 'package:cost_share/manager/group_manager.dart';
import 'package:cost_share/manager/notification_manager.dart';
import 'package:cost_share/manager/user_manager.dart';
import 'package:cost_share/presentation/authentication/bloc/authenticate_bloc.dart';
import 'package:cost_share/repository/budget_repository.dart';
import 'package:cost_share/repository/expense_repository.dart';
import 'package:cost_share/repository/group_repository.dart';
import 'package:cost_share/repository/notification_repository.dart';
import 'package:cost_share/repository/user_repository.dart';
import 'package:cost_share/service/firebase_messaging_service.dart';
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

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialize();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessagingService().instance.initNotification();

  setupLocators();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BottomNavigationManager()),
        Provider<UserManager>(
          create: (context) => UserManager(locator<UserRepository>()),
          dispose: (context, userManager) => userManager.dispose,
        ),
        Provider<AuthenticateBloc>(
          create: (_) =>
              AuthenticateBloc(userRepository: locator.get<UserRepository>()),
          dispose: (_, value) => value.dispose(),
        ),
        Provider<GroupManager>(
          create: (_) => GroupManager(locator<GroupRepository>(),
              locator<ExpenseRepository>(), locator<BudgetRepository>()),
          dispose: (context, value) => value.dispose(),
        ),
        Provider<NotificationManager>(
          create: (context) =>
              NotificationManager(locator<NotificationRepository>()),
          dispose: (context, value) => value.dispose(),
        )
      ],
      builder: (context, child) {
        return ScreenUtilInit(
            designSize: const Size(375, 812),
            minTextAdapt: true,
            builder: (context, child) => FutureBuilder(
                  future: Future.wait([
                    () async {
                      await SharedPrefService.instance.onInit();
                    }(),
                  ]),
                  builder: (context, snapshotSharedPrefService) {
                    return StreamBuilder<Locale?>(
                      stream: context.read<UserManager>().localeStream,
                      builder: (context, snapshot) {
                        final locale = snapshot.data;
                        return MaterialApp(
                          locale: locale,
                          debugShowCheckedModeBanner: false,
                          navigatorKey: navigatorKey,
                          onGenerateRoute: (RouteSettings settings) =>
                              settings.generateRoute,
                          localizationsDelegates: [
                            AppLocalizations.delegate,
                            GlobalMaterialLocalizations.delegate,
                            GlobalWidgetsLocalizations.delegate,
                            GlobalCupertinoLocalizations.delegate
                          ],
                          supportedLocales: supportedLocales,
                          theme: appTheme,
                          home: FutureBuilder(
                            future: Future.wait([
                              locator<UserManager>().loadUser(),
                            ]),
                            builder: (context, futureBuildersnapshot) {
                              if (snapshotSharedPrefService.connectionState !=
                                  ConnectionState.waiting) {
                                context.read<UserManager>().setLocale(
                                    Locale(SharedPrefService.instance.locate));
                              }
                              return SplashScreen();
                            },
                          ),
                        );
                      },
                    );
                  },
                ));
      },
    );
  }
}

import 'package:cost_share/presentation/authentication/signin_screen.dart';
import 'package:cost_share/presentation/authentication/signup_screen.dart';
import 'package:cost_share/splash_creen.dart';
import 'package:cost_share/utils/route/route_name.dart';
import 'package:flutter/material.dart';

extension GenerateRoute on RouteSettings {
  dynamic get generateRoute {
    switch (name) {
      case RouteName.splash:
        return MaterialPageRoute(
          builder: (context) => const SplashCreen(),
        );
      case RouteName.signUp:
        return MaterialPageRoute(
          builder: (context) =>  SignUpScreen(),
        );
      case RouteName.signIn:
        return MaterialPageRoute(
          builder: (context) =>  SignInScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text("data"),
            ),
          ),
        );
    }
  }
}

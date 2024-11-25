import 'package:cost_share/splash_creen.dart';
import 'package:cost_share/utils/route/route_name.dart';
import 'package:flutter/material.dart';

extension GenerateRoute on RouteSettings {
  dynamic get generateRoute {
    switch (name) {
      case RouteName.splash:
        return MaterialPageRoute(
          builder: (context) =>const SplashCreen(),
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

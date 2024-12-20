import 'package:cost_share/gen/assets.gen.dart';
import 'package:cost_share/manager/user_manager.dart';
import 'package:cost_share/model/user.dart';
import 'package:cost_share/utils/route/route_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User? _user;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await _checkUser();
    Future.delayed(const Duration(seconds: 3), () {
      if (_user == null) {
        Navigator.pushReplacementNamed(context, RouteName.intro);
      } else {
        Navigator.pushReplacementNamed(context, RouteName.wellCome);
      }
    });
  }

  Future<void> _checkUser() async {
    final userManager = context.read<UserManager>();
    await userManager.loadUser(); // Load user từ UserManager
    setState(() {
      _user = userManager.currentUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Assets.image.svg.launchScreen.svg();
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static final SharedPrefService _instance = SharedPrefService._();

  factory SharedPrefService() {
    return _instance;
  }

  SharedPrefService._();

  static SharedPrefService get instance => _instance;

  Future onInit() async {
    try {
      _sharedPref = await SharedPreferences.getInstance();
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
    }
  }

  late SharedPreferences _sharedPref;

  static const String _isOnBoarding = "is_on_boarding";
  static const String _locate = "locate";

  String get locate {
    return _sharedPref.getString(_locate) ?? "en";
  }

  Future<bool> setLocate({required String locate}) {
    return _sharedPref.setString(_locate, locate);
  }

  bool get isOnBoarding {
    return _sharedPref.getBool(_isOnBoarding) ?? true;
  }

  Future<bool> setIsOnBoarding({required bool isOnBoarding}) {
    return _sharedPref.setBool(_isOnBoarding, isOnBoarding);
  }
}

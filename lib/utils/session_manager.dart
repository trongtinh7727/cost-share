import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  late SharedPreferences? sharedPreferences;
  static String userId = '';
  static String accessToken = '';
  static String recipeType = '';
  static bool isLogin = false;

  Future initPref() async {
    sharedPreferences = await _pref;
  }

  void saveBoolean(String key, bool value) async {
    if (sharedPreferences != null) sharedPreferences!.setBool(key, value);
  }

  bool getBool(String key) {
    return sharedPreferences == null || sharedPreferences!.getBool(key) == null
        ? false
        : sharedPreferences!.getBool(key)!;
  }

  void saveInteger(String key, int value) async {
    if (sharedPreferences != null) {
      sharedPreferences!.setInt(key, value);
    }
  }

  int getInteger(String key) {
    return sharedPreferences == null || sharedPreferences!.getInt(key) == null
        ? 0
        : sharedPreferences!.getInt(key)!;
  }

  void clean() {
    sharedPreferences?.clear();
    userId = '';
    accessToken = '';
    recipeType = '';
    isLogin = false;
  }
}

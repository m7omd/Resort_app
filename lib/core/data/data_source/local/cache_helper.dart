import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> saveLanguageCode(String code) async {
    await _prefs.setString('language_code', code);
  }

  static String? getLanguageCode() {
    return _prefs.getString('language_code');
  }

  static Future<bool> saveData({required String key, dynamic value}) async {
    if (value is String) return _prefs.setString(key, value);
    if (value is int) return _prefs.setInt(key, value);
    if (value is bool) return _prefs.setBool(key, value);
    if (value is double) return _prefs.setDouble(key, value);
    return _prefs.setStringList(key, value);
  }

  static dynamic getData({required String? key}) {
    return _prefs.getString(key!);
  }

  static Future<bool> removeData({String? key}) async {
    return _prefs.remove(key!);
  }

  static Future<bool> clearData() async {
    return await _prefs.clear();
  }
}



import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? _prefs;

  
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }
Future<bool> put ({
    required  String  key,
    required String value ,
  }) async{
    await _prefs?.setString(key, value);
    return true;
  }
  static Future<bool> putBool({
  required String key,
  required bool value,
}) async {
  return await _prefs?.setBool(key, value) ?? false;
}

  
  /// حفظ أي نوع من البيانات (String, int, bool, double)
  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (_prefs == null) return false;

    if (value is String) return await _prefs!.setString(key, value);
    if (value is int) return await _prefs!.setInt(key, value);
    if (value is bool) return await _prefs!.setBool(key, value);
    if (value is double) return await _prefs!.setDouble(key, value);
    if (value is List<String>) return await _prefs!.setStringList(key, value);

    return false;
  }

  static Future<bool> saveUserData(
    String token, String email, String password,
    String phone, String name, int id) async {

  await CacheHelper.saveData(key: "id", value: id);
  await CacheHelper.saveData(key: "token", value: token);
  await CacheHelper.saveData(key: "email", value: email);
  await CacheHelper.saveData(key: "password", value: password);
  await CacheHelper.saveData(key: "phone", value: phone);
  await CacheHelper.saveData(key: "name", value: name);

  return true;
}


  /// قراءة البيانات من التخزين
  static dynamic getData({required String key}) => _prefs?.get(key);

  static String? getString(String key) => _prefs?.getString(key);
  static int? getInt(String key) => _prefs?.getInt(key);
  static bool? getBool(String key) => _prefs?.getBool(key);
  static double? getDouble(String key) => _prefs?.getDouble(key);
  static List<String>? getStringList(String key) => _prefs?.getStringList(key);

  /// حذف بيانات معينة
  static Future<bool> removeData({required String key}) async {
    return await _prefs!.remove(key);
  }

  /// حذف كل البيانات (مثلاً عند تسجيل الخروج)
  static Future<bool> clearAll() async {
    return await _prefs!.clear();
  }
}

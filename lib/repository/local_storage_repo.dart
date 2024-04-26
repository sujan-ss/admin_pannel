import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  late SharedPreferences _pref;

  Future<void> init() async {
    _pref = await SharedPreferences.getInstance();

    _pref = await SharedPreferences.getInstance();
  }

  Future<void> saveData(String key, String value) async {
    _pref = await SharedPreferences.getInstance();
    await _pref.setString(key, value);
  }

  Future<String?> getData(String key) async {
    _pref = await SharedPreferences.getInstance();
    return _pref.getString(key);
  }

  Future<void> removeData(String key) async {
    _pref = await SharedPreferences.getInstance();
    await _pref.remove(key);
  }

  Future<void> clearData() async {
    _pref = await SharedPreferences.getInstance();
    await _pref.clear();
  }

  Future<void> saveBool(String key, bool value) async {
    _pref = await SharedPreferences.getInstance();
    await _pref.setBool(key, value);
  }

  Future<bool?> getBool(String key) async {
    _pref = await SharedPreferences.getInstance();
    return _pref.getBool(key);
  }
}

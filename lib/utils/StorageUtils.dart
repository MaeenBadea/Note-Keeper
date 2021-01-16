import 'package:shared_preferences/shared_preferences.dart';

class StorageUtil{

  static StorageUtil _storageUtil;
  static SharedPreferences _preferences;

  static Future<StorageUtil> getInstance() async {
    if(_storageUtil==null){
        _preferences = await SharedPreferences.getInstance();
        _storageUtil = new StorageUtil();
    }
    return _storageUtil;
  }
  // put bool
  static Future<bool> putBool(String key, bool value) {
    if (_preferences == null) return null;
    return _preferences.setBool(key, value);
  }
  // get bool
  static bool getBool(String key, {bool defValue = false}) {
    if (_preferences == null) return defValue;
    return _preferences.getBool(key) ?? defValue;
  }
  // put string
  static Future<bool> putString(String key, String value) {
    if (_preferences == null) return null;
    return _preferences.setString(key, value);
  }
  // get string
  static String getString(String key, {String defValue = ''}) {
    if (_preferences == null) return defValue;
    return _preferences.getString(key) ?? defValue;
  }
  // clear string
  static Future<bool> clrPrefs() {
    SharedPreferences prefs = _preferences;
    prefs.clear();
  }
}
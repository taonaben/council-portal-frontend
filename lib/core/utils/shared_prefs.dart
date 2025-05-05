import 'package:portal/core/utils/logs.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveBool(String key, bool value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(key, value);
}

Future<int> getSPInt(String id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getInt(id) != null) {
    return prefs.getInt(id)!;
  } else {
    return 0;
  }
}

Future<void> saveInt(String key, int value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt(key, value);
}

Future<bool> getSPBoolean(String id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getBool(id) != null) {
    return prefs.getBool(id)!;
  } else {
    return false;
  }
}

Future<void> saveSP(String key, String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  DevLogs.logInfo("Saving to SP - Key: $key, Value: $token"); // Add logging
  await prefs.setString(key, token);
}

Future<String> getSP(String id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(id) ?? "";
}

Future<void> clearSP() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
  DevLogs.logInfo("Shared Preferences cleared"); // Add logging
}

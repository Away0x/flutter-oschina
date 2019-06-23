import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Storage {

  static setJSON(String key, Map<String, dynamic> val) async {
    if (val == null && val.isEmpty) return;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String str = json.encode(val);

    await prefs.setString(key, str);
  }

  static Future<Map<String, dynamic>> getJSON(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String str = prefs.getString(key);
    Map<String, dynamic> map = json.decode(str);

    return map ?? {};
  }

  static remove(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

}
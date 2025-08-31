import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/base.dart';

class LocalStorage<Model extends BaseModel> {
  Future<Model?> getValue(
    String key,
    Model Function(Map<String, dynamic>) fromJson,
  ) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? jsonValue = preferences.getString(key);
    if (jsonValue == null) return null;
    try {
      return fromJson(jsonDecode(jsonValue));
    } catch (error) {
      return null;
    }
  }

  void setValue(String key, Model? value) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    if (value == null) {
      await preferences.remove(key);
      return;
    }
    final String jsonValue = jsonEncode(value.toJson());
    await preferences.setString(key, jsonValue);
  }
}

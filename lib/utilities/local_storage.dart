import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/base.dart';

class LocalStorage<Model extends BaseModel> {
  Future<Model?> getModelValue(
    String key,
    Model Function(Map<String, dynamic>) fromJson,
  ) async {
    final String? jsonValue = await getStringValue(key);
    try {
      return jsonValue == null ? null : fromJson(jsonDecode(jsonValue));
    } catch (error) {
      return null;
    }
  }

  Future<String?> getStringValue(String key) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key);
  }

  Future<void> setModelValue(String key, Model? value) async {
    final String? jsonValue = value == null ? null : jsonEncode(value.toJson());
    await setStringValue(key, jsonValue);
  }

  Future<void> setStringValue(String key, String? value) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    if (value == null) {
      await preferences.remove(key);
      return;
    }
    await preferences.setString(key, value);
  }
}

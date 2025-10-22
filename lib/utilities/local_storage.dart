import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:wick_apps/utilities/type_converter.dart';

class WickUtilityLocalStorage<T> {
  Future<T?> getModelValue(String key) async {
    final String? jsonValue = await getStringValue(key);
    if (jsonValue == null) return null;
    try {
      return WickUtilityTypeConverter.fromJson(jsonDecode(jsonValue));
    } catch (error) {
      return null;
    }
  }

  Future<String?> getStringValue(String key) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key);
  }

  Future<void> setModelValue(String key, T? value) async {
    final String jsonValue = jsonEncode(WickUtilityTypeConverter.toJson(value));
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

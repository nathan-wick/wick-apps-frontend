import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wick_apps/providers/user.dart';

import '../controllers/preferences.dart';
import '../models/preferences.dart';
import '../models/user.dart';
import 'base.dart';

class WickProviderPreferences extends WickProviderBase<WickModelPreferences> {
  WickProviderPreferences() : super(WickModelPreferences.fromJson);

  Future<WickModelPreferences?> getUserPreferences(BuildContext context) async {
    final WickModelPreferences? preferencesFromLocalStorage = await getValue(
      context,
    );
    if (preferencesFromLocalStorage != null) {
      return preferencesFromLocalStorage;
    }
    final WickModelUser? user = (await Provider.of<WickProviderUser>(
      context,
      listen: false,
    ).getValue(context));
    if (user == null) return null;
    final WickModelPreferences? preferences = await WickControllerPreferences()
        .getByPrimaryKey(context, user.id);
    await setValue(context, preferences);
    return preferences;
  }
}

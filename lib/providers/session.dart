import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:wick_apps/providers/preferences.dart';

import '../controllers/session.dart';
import '../models/session_provider.dart';
import '../providers/user.dart';
import 'base.dart';

class WickProviderSession
    extends WickProviderBase<WickModelWickProviderSession> {
  WickProviderSession() : super(WickModelWickProviderSession.fromJson);

  Future<bool> signIn(BuildContext context, int sessionId, String code) async {
    String? sessionToken = await WickControllerSession().signIn(
      context,
      sessionId,
      code,
    );
    if (sessionToken == null) return false;
    await setValue(context, WickModelWickProviderSession(token: sessionToken));
    await Provider.of<WickProviderUser>(
      context,
      listen: false,
    ).getSessionUser(context);
    await Provider.of<WickProviderPreferences>(
      context,
      listen: false,
    ).getUserPreferences(context);
    return true;
  }

  Future<void> signOut(BuildContext context) async {
    await WickControllerSession().signOut(context);
    await setValue(context, null);
    await Provider.of<WickProviderUser>(
      context,
      listen: false,
    ).setValue(context, null);
    await Provider.of<WickProviderPreferences>(
      context,
      listen: false,
    ).setValue(context, null);
  }
}

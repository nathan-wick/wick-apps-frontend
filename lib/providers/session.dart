import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../controllers/session.dart';
import '../controllers/user.dart';
import '../models/session_provider.dart';
import '../models/user.dart';
import '../providers/user.dart';
import 'base.dart';

class WickProviderSession
    extends WickProviderBase<WickModelWickProviderSession> {
  WickProviderSession() : super(WickModelWickProviderSession.fromJson);

  Future<void> signIn(BuildContext context, int sessionId, String code) async {
    String? sessionToken = await WickControllerSession().signIn(
      context,
      sessionId,
      code,
    );
    if (sessionToken == null) return;
    setValue(WickModelWickProviderSession(token: sessionToken));
    // TODO Figure out how to include preferences, then update the preferences provider
    final WickModelUser? userFromService = await WickControllerUser()
        .getByCurrentSession(context);
    await Provider.of<WickProviderUser>(
      context,
      listen: false,
    ).setValue(userFromService);
  }

  Future<void> signOut(BuildContext context) async {
    await WickControllerSession().signOut(context);
    setValue(null);
    await Provider.of<WickProviderUser>(context, listen: false).setValue(null);
  }
}

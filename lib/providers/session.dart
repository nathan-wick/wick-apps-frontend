import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../controllers/session.dart';
import '../controllers/user.dart';
import '../models/session_provider.dart';
import '../models/user.dart';
import '../providers/user.dart';
import 'base.dart';
import 'navigation.dart';

class SessionProvider extends BaseProvider<SessionProviderModel> {
  SessionProvider() : super(SessionProviderModel.fromJson);

  Future<void> signIn(BuildContext context, int sessionId, String code) async {
    String? sessionToken = await SessionController().signIn(
      context,
      sessionId,
      code,
    );
    if (sessionToken == null) return;
    setValue(SessionProviderModel(token: sessionToken));
    // TODO Figure out how to include preferences, then update the preferences provider
    final UserModel userFromService = await UserController()
        .getByCurrentSession(context);
    await Provider.of<UserProvider>(
      context,
      listen: false,
    ).setValue(userFromService);
    Provider.of<NavigationProvider>(context, listen: false).navigate(context);
  }

  Future<void> signOut(BuildContext context) async {
    await SessionController().signOut(context);
    setValue(null);
    await Provider.of<UserProvider>(context, listen: false).setValue(null);
    Provider.of<NavigationProvider>(context, listen: false).navigate(context);
  }
}

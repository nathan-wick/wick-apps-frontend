import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../controllers/user.dart';
import '../models/user.dart';
import '../providers/session.dart';
import 'base.dart';

class WickProviderUser extends WickProviderBase<WickModelUser> {
  WickProviderUser() : super(WickModelUser.fromJson);

  Future<WickModelUser?> getSessionUser(BuildContext context) async {
    final WickModelUser? userFromLocalStorage = await getValue(context);
    if (userFromLocalStorage != null) {
      return userFromLocalStorage;
    }
    final bool signedIn =
        (await Provider.of<WickProviderSession>(
          context,
          listen: false,
        ).getValue(context))?.token !=
        null;
    if (!signedIn) return null;
    final WickModelUser? user = await WickControllerUser().getByCurrentSession(
      context,
    );
    await setValue(context, user);
    return user;
  }
}

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../controllers/user.dart';
import '../models/user.dart';
import '../providers/session.dart';
import 'base.dart';

class WickProviderUser extends WickProviderBase<WickModelUser> {
  WickProviderUser() : super(WickModelUser.fromJson);

  Future<WickModelUser?> getSessionUser(BuildContext context) async {
    final WickModelUser? userFromWickUtilityLocalStorage = await getValue();
    if (userFromWickUtilityLocalStorage != null)
      return userFromWickUtilityLocalStorage;
    final bool signedIn =
        (await Provider.of<WickProviderSession>(
              context,
              listen: false,
            ).getValue())
            ?.token !=
        null;
    if (!signedIn) return null;
    // TODO Figure out how to include preferences, then update the preferences provider
    final WickModelUser? userFromService = await WickControllerUser()
        .getByCurrentSession(context);
    setValue(userFromService);
    return userFromService;
  }
}

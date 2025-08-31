import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../controllers/user.dart';
import '../models/user.dart';
import '../providers/session.dart';
import 'base.dart';

class UserProvider extends BaseProvider<UserModel> {
  UserProvider() : super(UserModel.fromJson);

  Future<UserModel?> getSessionUser(BuildContext context) async {
    final UserModel? userFromLocalStorage = await getValue();
    if (userFromLocalStorage != null) return userFromLocalStorage;
    final bool signedIn =
        (await Provider.of<SessionProvider>(context, listen: false).getValue())
            ?.token !=
        null;
    if (!signedIn) return null;
    // TODO Figure out how to include preferences, then update the preferences provider
    final UserModel? userFromService = await UserController()
        .getByCurrentSession(context);
    setValue(userFromService);
    return userFromService;
  }
}

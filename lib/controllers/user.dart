import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../enumerations/request_method.dart';
import '../models/user.dart';
import '../providers/session.dart';
import '../utilities/request_handler.dart';
import 'base.dart';

class UserController extends BaseController<UserModel> {
  UserController() : super(UserModel.fromJson);

  Future<UserModel> getByCurrentSession(BuildContext context) async {
    final String? sessionToken =
        (await Provider.of<SessionProvider>(context, listen: false).getValue())
            ?.token;
    final Map<String, dynamic> response = await RequestHandler.sendRequest(
      RequestMethod.get,
      domain,
      '$basePath/get-by-current-session',
      sessionToken,
    );

    return fromJson(response);
  }
}

import 'package:flutter/cupertino.dart';

import '../enumerations/request_method.dart';
import '../models/user.dart';
import '../utilities/request_handler.dart';
import 'base.dart';

class UserController extends BaseController<UserModel> {
  UserController() : super(UserModel.fromJson);

  Future<UserModel?> getByCurrentSession(BuildContext context) async {
    final Map<String, dynamic>? response = await RequestHandler.sendRequest(
      context,
      RequestMethod.get,
      domain,
      '$basePath/get-by-current-session',
    );
    return response == null ? null : fromJson(response);
  }
}

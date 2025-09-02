import 'package:flutter/cupertino.dart';

import '../enums/request_method.dart';
import '../models/user.dart';
import '../utilities/request_handler.dart';
import 'base.dart';

class WickControllerUser extends WickControllerBase<WickModelUser> {
  WickControllerUser() : super(WickModelUser.fromJson);

  Future<WickModelUser?> getByCurrentSession(BuildContext context) async {
    final Map<String, dynamic>? response =
        await WickUtilityRequestHandler.sendRequest(
          context,
          WickEnumRequestMethod.get,
          domain,
          '$basePath/get-by-current-session',
        );
    return response == null ? null : fromJson(response);
  }
}

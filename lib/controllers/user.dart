import 'package:flutter/cupertino.dart';

import '../enums/request_method.dart';
import '../models/user.dart';
import '../utilities/request_handler.dart';
import 'base.dart';

class WickControllerUser extends WickControllerBase<WickModelUser> {
  Future<WickModelUser?> getByCurrentSession(BuildContext context) async {
    return await WickUtilityRequestHandler.sendRequest(
      context,
      WickEnumRequestMethod.get,
      domain,
      '$basePath/get-by-current-session',
    );
  }
}

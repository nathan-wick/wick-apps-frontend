import 'package:flutter/cupertino.dart';

import '../enums/request_method.dart';
import '../models/session.dart';
import '../utilities/request_handler.dart';
import '../utilities/type_converter.dart';
import 'base.dart';

class WickControllerSession extends WickControllerBase<WickModelSession> {
  WickControllerSession() : super(WickModelSession.fromJson);

  Future<int?> sendVerificationEmail(BuildContext context, String email) async {
    final Map<String, dynamic>? response =
        await WickUtilityRequestHandler.sendRequest(
          context,
          WickEnumRequestMethod.post,
          domain,
          '$basePath/send-verification-email',
          {email: email},
        );
    return response == null
        ? null
        : WickUtilityTypeConverter.toInt(response['sessionId']);
  }

  Future<String?> signIn(
    BuildContext context,
    int sessionId,
    String code,
  ) async {
    final Map<String, dynamic>? response =
        await WickUtilityRequestHandler.sendRequest(
          context,
          WickEnumRequestMethod.post,
          domain,
          '$basePath/sign-in',
          {sessionId: sessionId, code: code},
        );
    return response == null
        ? null
        : WickUtilityTypeConverter.describe(response['sessionToken']);
  }

  Future<bool> signOut(BuildContext context) async {
    final Map<String, dynamic>? response =
        await WickUtilityRequestHandler.sendRequest(
          context,
          WickEnumRequestMethod.post,
          domain,
          '$basePath/sign-out',
        );
    return response == null ? false : true;
  }
}

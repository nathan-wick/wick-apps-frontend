import 'package:flutter/cupertino.dart';

import '../enums/notification_type.dart';
import '../enums/request_method.dart';
import '../models/send_verification_email_response.dart';
import '../models/session.dart';
import '../models/sign_in_response.dart';
import '../utilities/notification_handler.dart';
import '../utilities/request_handler.dart';
import 'base.dart';

class WickControllerSession extends WickControllerBase<WickModelSession> {
  Future<int?> sendVerificationEmail(BuildContext context, String email) async {
    final WickModelSendVerificationEmailResponse? response =
        await WickUtilityRequestHandler.sendRequest(
          context,
          WickEnumRequestMethod.post,
          domain,
          '$basePath/send-verification-email',
          {'email': email},
        );
    if (response == null) return null;
    WickUtilityNotificationHandler.displayNotification(
      context,
      WickEnumNotificationType.success,
      'Verification code sent to $email',
    );
    return response.sessionId;
  }

  Future<String?> signIn(
    BuildContext context,
    int sessionId,
    String code,
  ) async {
    final WickModelSignInResponse? response =
        await WickUtilityRequestHandler.sendRequest(
          context,
          WickEnumRequestMethod.post,
          domain,
          '$basePath/sign-in',
          {'sessionId': sessionId, 'code': code},
        );
    if (response == null) return null;
    WickUtilityNotificationHandler.displayNotification(
      context,
      WickEnumNotificationType.success,
      'Signed in successfully',
    );
    return response.sessionToken;
  }

  Future<void> signOut(BuildContext context) async {
    await WickUtilityRequestHandler.sendRequest(
      context,
      WickEnumRequestMethod.post,
      domain,
      '$basePath/sign-out',
    );
    WickUtilityNotificationHandler.displayNotification(
      context,
      WickEnumNotificationType.success,
      'Signed out successfully',
    );
  }
}

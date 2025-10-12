import 'package:flutter/cupertino.dart';

import '../enums/notification_type.dart';
import '../enums/request_method.dart';
import '../models/session.dart';
import '../utilities/notification_handler.dart';
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
          {'email': email},
        );
    final int? sessionId =
        response == null
            ? null
            : WickUtilityTypeConverter.toInt(response['sessionId']);
    if (sessionId != null) {
      WickUtilityNotificationHandler.displayNotification(
        context,
        WickEnumNotificationType.success,
        'Verification code sent to $email',
      );
    }
    return sessionId;
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
          {'sessionId': sessionId, 'code': code},
        );
    final String? sessionToken = WickUtilityTypeConverter.describe(
      response?['sessionToken'],
    );
    if (sessionToken != null) {
      WickUtilityNotificationHandler.displayNotification(
        context,
        WickEnumNotificationType.success,
        'Signed in successfully',
      );
    }
    return sessionToken;
  }

  Future<bool> signOut(BuildContext context) async {
    final Map<String, dynamic>? response =
        await WickUtilityRequestHandler.sendRequest(
          context,
          WickEnumRequestMethod.post,
          domain,
          '$basePath/sign-out',
        );
    // TODO This may not be accurate. Need to check the response.
    final bool signedOut = response == null ? false : true;
    if (signedOut) {
      WickUtilityNotificationHandler.displayNotification(
        context,
        WickEnumNotificationType.success,
        'Signed out successfully',
      );
    }
    return signedOut;
  }
}

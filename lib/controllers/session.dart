import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../enumerations/request_method.dart';
import '../models/session.dart';
import '../providers/session.dart';
import '../utilities/request_handler.dart';
import '../utilities/type_converter.dart';
import 'base.dart';

class SessionController extends BaseController<SessionModel> {
  SessionController() : super(SessionModel.fromJson);

  Future<int?> sendVerificationEmail(BuildContext context, String email) async {
    final String? sessionToken =
        (await Provider.of<SessionProvider>(context, listen: false).getValue())
            ?.token;
    final Map<String, dynamic> response = await RequestHandler.sendRequest(
      RequestMethod.post,
      domain,
      '$basePath/send-verification-email',
      sessionToken,
      {email: email},
    );

    return TypeConverter.toInt(response['sessionId']);
  }

  Future<String?> signIn(
    BuildContext context,
    int sessionId,
    String code,
  ) async {
    final String? sessionToken =
        (await Provider.of<SessionProvider>(context, listen: false).getValue())
            ?.token;
    final Map<String, dynamic> response = await RequestHandler.sendRequest(
      RequestMethod.post,
      domain,
      '$basePath/sign-in',
      sessionToken,
      {sessionId: sessionId, code: code},
    );

    return TypeConverter.describe(response['sessionToken']);
  }

  Future<void> signOut(BuildContext context) async {
    final String? sessionToken =
        (await Provider.of<SessionProvider>(context, listen: false).getValue())
            ?.token;
    await RequestHandler.sendRequest(
      RequestMethod.post,
      domain,
      '$basePath/sign-out',
      sessionToken,
    );
  }
}

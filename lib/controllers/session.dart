import '../enumerations/request_method.dart';
import '../models/session.dart';
import '../utilities/request_handler.dart';
import '../utilities/type_converter.dart';
import 'base.dart';

class SessionController extends BaseController<SessionModel> {
  SessionController() : super(SessionModel.fromJson);

  Future<int?> sendVerificationEmail(String email) async {
    // TODO Pass in session token
    final sessionToken = '';
    final Map<String, dynamic> response = await RequestHandler.sendRequest(
      RequestMethod.post,
      domain,
      '$basePath/send-verification-email',
      sessionToken,
      {email: email},
    );

    return TypeConverter.toInt(response['sessionId']);
  }

  Future<String?> signIn(int sessionId, String code) async {
    final sessionToken = '';
    final Map<String, dynamic> response = await RequestHandler.sendRequest(
      RequestMethod.post,
      domain,
      '$basePath/sign-in',
      sessionToken,
      {sessionId: sessionId, code: code},
    );

    return TypeConverter.describe(response['sessionToken']);
  }

  Future<void> signOut() async {
    final sessionToken = '';
    await RequestHandler.sendRequest(
      RequestMethod.post,
      domain,
      '$basePath/sign-out',
      sessionToken,
    );
  }
}

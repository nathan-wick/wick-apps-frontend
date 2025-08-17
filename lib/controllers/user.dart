import '../enumerations/request_method.dart';
import '../models/user.dart';
import '../utilities/request_handler.dart';
import 'base.dart';

class UserController extends BaseController<UserModel> {
  UserController() : super(UserModel.fromJson);

  Future<UserModel> getByCurrentSession() async {
    // TODO Pass in session token
    final sessionToken = '';
    final Map<String, dynamic> response = await RequestHandler.sendRequest(
      RequestMethod.get,
      domain,
      '$basePath/get-by-current-session',
      sessionToken,
    );

    return fromJson(response);
  }
}

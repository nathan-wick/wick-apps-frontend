import '../utilities/type_converter.dart';
import 'base.dart';

class WickModelWickProviderSession extends WickModelBase {
  final String token;

  WickModelWickProviderSession({required this.token}) : super({'token': token});

  factory WickModelWickProviderSession.fromJson(Map<String, dynamic> json) {
    return WickModelWickProviderSession(
      token: WickUtilityTypeConverter.describe(json['token']) ?? '',
    );
  }
}

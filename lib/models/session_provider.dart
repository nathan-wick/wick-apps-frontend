import '../utilities/type_converter.dart';
import 'base.dart';

class SessionProviderModel extends BaseModel {
  final String token;
  
  SessionProviderModel({required this.token}) : super({'token': token});

  factory SessionProviderModel.fromJson(Map<String, dynamic> json) {
    return SessionProviderModel(
      token: TypeConverter.describe(json['token']) ?? '',
    );
  }
}

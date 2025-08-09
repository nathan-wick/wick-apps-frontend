import '../utilities/type_converter.dart';
import 'base.dart';

class SessionModel extends BaseModel<SessionModel> {
  SessionModel({
    required int id,
    required int userId,
    required String code,
    required int successfulAttempts,
    required int failedAttempts,
    required DateTime started,
    required DateTime expires,
    required String device,
    required String location,
  }) : super({
         'id': id,
         'userId': userId,
         'code': code,
         'successfulAttempts': successfulAttempts,
         'failedAttempts': failedAttempts,
         'started': started,
         'expires': expires,
         'device': device,
         'location': location,
       });

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
      id: TypeConverter.toInt(json['id']) ?? 0,
      userId: TypeConverter.toInt(json['userId']) ?? 0,
      code: TypeConverter.describe(json['code']) ?? '',
      successfulAttempts: TypeConverter.toInt(json['successfulAttempts']) ?? 0,
      failedAttempts: TypeConverter.toInt(json['failedAttempts']) ?? 0,
      started:
          TypeConverter.toDate(json['started']) ??
          DateTime.fromMillisecondsSinceEpoch(0),
      expires:
          TypeConverter.toDate(json['expires']) ??
          DateTime.fromMillisecondsSinceEpoch(0),
      device: TypeConverter.describe(json['device']) ?? '',
      location: TypeConverter.describe(json['location']) ?? '',
    );
  }
}

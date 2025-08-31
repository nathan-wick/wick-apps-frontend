import '../utilities/type_converter.dart';
import 'base.dart';

class SessionModel extends BaseModel {
  final int id;
  final int userId;
  final String code;
  final int successfulAttempts;
  final int failedAttempts;
  final DateTime started;
  final DateTime expires;
  final String device;
  final String location;

  SessionModel({
    required this.id,
    required this.userId,
    required this.code,
    required this.successfulAttempts,
    required this.failedAttempts,
    required this.started,
    required this.expires,
    required this.device,
    required this.location,
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

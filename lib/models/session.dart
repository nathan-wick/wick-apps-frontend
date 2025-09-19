import '../utilities/type_converter.dart';
import 'base.dart';

class WickModelSession extends WickModelBase<WickModelSession> {
  final int id;
  final int userId;
  final String code;
  final int successfulAttempts;
  final int failedAttempts;
  final DateTime started;
  final DateTime expires;
  final String device;
  final String location;

  WickModelSession({
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

  factory WickModelSession.fromJson(Map<String, dynamic> json) {
    return WickModelSession(
      id: WickUtilityTypeConverter.toInt(json['id']) ?? 0,
      userId: WickUtilityTypeConverter.toInt(json['userId']) ?? 0,
      code: WickUtilityTypeConverter.describe(json['code']) ?? '',
      successfulAttempts:
          WickUtilityTypeConverter.toInt(json['successfulAttempts']) ?? 0,
      failedAttempts:
          WickUtilityTypeConverter.toInt(json['failedAttempts']) ?? 0,
      started:
          WickUtilityTypeConverter.toDate(json['started']) ??
          DateTime.fromMillisecondsSinceEpoch(0),
      expires:
          WickUtilityTypeConverter.toDate(json['expires']) ??
          DateTime.fromMillisecondsSinceEpoch(0),
      device: WickUtilityTypeConverter.describe(json['device']) ?? '',
      location: WickUtilityTypeConverter.describe(json['location']) ?? '',
    );
  }

  @override
  WickModelSession newInstance(Map<String, dynamic> newAttributes) =>
      WickModelSession.fromJson(newAttributes);
}

import 'annotations/primary_key.dart';

class WickModelSession {
  @WickModelAnnotationPrimaryKey()
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
  });
}

import 'annotations/primary_key.dart';

class WickModelUser {
  @WickModelAnnotationPrimaryKey()
  final int id;
  final String email;
  final String? picture;
  final String? firstName;
  final String? lastName;
  final DateTime? birthday;

  WickModelUser({
    required this.id,
    required this.email,
    this.picture,
    this.firstName,
    this.lastName,
    this.birthday,
  });
}
